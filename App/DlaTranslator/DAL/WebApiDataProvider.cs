using Newtonsoft.Json;
using Registry.Common.Constants;
using Registry.Common.DTO;
using Registry.Common.Enums;
using Registry.Web.UI.ViewModels;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Registry.Web.UI.DAL
{
    public class WebApiDataProvider : IApiDataProvider
    {
        // Creating and disposing HttpClient for each request is 
        // a well known bad practice and leads to performance and scalability issues:
        // https://aspnetmonsters.com/2016/08/2016-08-27-httpclientwrong/
        // https://docs.microsoft.com/en-us/aspnet/web-api/overview/advanced/calling-a-web-api-from-a-net-client#create-and-initialize-httpclient
        // So we use shared client. Ideally, it should be an instance field and
        // this class should be injected via DI as a singleton. But since we don't
        // use this class with DI, the client is just static.
        private static HttpClient client = new HttpClient();
        private static string DefaultConnectionLeaseTimeoutSetting = "00:05:00";

        private const string WrapperExceptionType = "System.AggregateException";
        //todo: need standard answer wrapper for any request (post/put/get)

        static WebApiDataProvider()
        {
            // Beware of DNS updates issue with singleton client approach:
            // http://byterot.blogspot.com/2016/07/singleton-httpclient-dns.html
            // https://github.com/dotnet/runtime/issues/18348
            // This closes connections periodically to force new connections
            // to query DNS.
            var timeout = TimeSpan.Parse(GetSetting("ApiConnectionLeaseTimeout") ?? DefaultConnectionLeaseTimeoutSetting);
            var sp = ServicePointManager.FindServicePoint(new Uri(GetSetting("ApiUrl")));
            sp.ConnectionLeaseTimeout = (int)timeout.TotalMilliseconds;
            
            // NOTE: Configuration update won't be 
            // applied until app restart (app domain reload).
            SetupDefaultRequestHeaders();
        }

        private static void SetupDefaultRequestHeaders()
        {
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            string encoded = Convert.ToBase64String(Encoding.GetEncoding("ISO-8859-1").GetBytes(GetSetting("ApiUser") + ":" + GetSetting("ApiPassword")));
            client.DefaultRequestHeaders.Add("Authorization", "Basic " + encoded);
        }

        private static string GetSetting(string setting)
        {
            return ConfigurationManager.AppSettings[setting];
        }

        private static string SerializeToQueryString(object obj)
        {
            var properties = obj.GetType().GetProperties()
                    .Where(p => p.GetValue(obj, null) != null)
                    .Select(p => p.Name + "=" + HttpUtility.UrlEncode(p.GetValue(obj, null).ToString()));

            return string.Join("&", properties);
        }

        private static async Task<TResult> GetResponse<TResult, TModel>(string apiMethod, TModel data = null)
            where TModel : class
        {
            var requestString = $"{GetSetting("ApiUrl")}{apiMethod}";

            if (data != null)
                requestString += $"?{SerializeToQueryString(data)}";

            var response = await client.GetAsync(requestString);

            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadAsAsync<TResult>();
            }

            return default(TResult);
        }

        private static async Task<AjaxResponseViewModel<TResult>> GetWrappedResponse<TResult, TModel>(string apiMethod, TModel data = null)
            where TModel : class where TResult : class
        {
            var requestString = $"{GetSetting("ApiUrl")}{apiMethod}";

            if (data != null)
                requestString += $"?{SerializeToQueryString(data)}";

            var result = new AjaxResponseViewModel<TResult>();
            try
            {
                var response = await client.GetAsync(requestString);

                if (response.IsSuccessStatusCode)
                {
                    result.Item = await response.Content.ReadAsAsync<TResult>();
                }
                else
                {
                    result.Item = default(TResult);

                    if (response.Content?.Headers.ContentType?.MediaType == "text/json")
                    {
                        var errorList = UnwrapErrors(await response.Content.ReadAsStringAsync());
                        result.Errors.AddRange(errorList);
                    }

                    if (result.Errors.Count == 0 && !String.IsNullOrEmpty(response.ReasonPhrase))
                    {
                        result.Errors.Add(response.ReasonPhrase);
                    }
                }
            }
            catch (Exception ex)
            {
                result.Item = default(TResult);
                result.Errors.Add(ex.Message);
            }

            result.Success = !result.Errors.Any();
            return result;
        }

        private static IList<string> UnwrapErrors(string serializedErrors)
        {
            var result = new List<string>();

            var exception = JsonConvert.DeserializeObject<ExceptionMimic>(serializedErrors);

            while (exception != null)
            {
                //skip aggregate exception for async wrappers etc.
                if (!exception.ExceptionType.Equals(WrapperExceptionType, StringComparison.InvariantCultureIgnoreCase))
                    result.Add(JsonConvert.SerializeObject(exception));

                exception = exception.InnerException;
            }

            return result;
        }

        #region IApiDataProvider
        #region GetResponse

        public async Task<AjaxResponseViewModel<List<SearchResult>>> SearchRegistry(SearchRequest registrySearchParams)
        {
            return await GetWrappedResponse<List<SearchResult>, SearchRequest>("search", registrySearchParams);
        }

        public async Task<AjaxResponseViewModel<SearchResult>> SearchDlaRegistry(int id)
        {
            return await GetWrappedResponse<SearchResult, IdWrapperModel>("get-dla", new IdWrapperModel { Id = id });
        }

        public async Task<UserAuthenticationTicket> Login(string userName, string password)
        {
            return await GetResponse<UserAuthenticationTicket, object>($"login?userName={userName}&password={password}");
        }

        public async Task<List<EventCategorySelect>> GetEventCategories(GetEventCategoryRequest getEventCategoryRequest)
        {
            return await GetResponse<List<EventCategorySelect>, GetEventCategoryRequest>("categories", getEventCategoryRequest);
        }

        public async Task<EventCategoryInsertUpdate> GetEventCategory(int id)
        {
            return await GetResponse<EventCategoryInsertUpdate, object>($"category?id={id}");
        }

        public async Task<List<EventSubCategorySelect>> GetEventSubCategories(GetEventSubCategoryRequest getEventSubCategoryRequest)
        {
            return await GetResponse<List<EventSubCategorySelect>, GetEventSubCategoryRequest>("subcategories", getEventSubCategoryRequest);
        }

        public async Task<EventSubCategoryInsertUpdate> GetEventSubCategory(int id)
        {
            return await GetResponse<EventSubCategoryInsertUpdate, object>($"subcategory?id={id}");
        }

        public async Task<List<string>> GetClientStates(GetClientStateRequest request)
        {
            return await GetResponse<List<string>, GetClientStateRequest>("clientstates", request);
        }

        public async Task<List<RegistryEventCategory>> GetRegistryEventCategories(int registryOwnerID)
        {
            return await GetResponse<List<RegistryEventCategory>, object>($"registrycategories?registryOwnerID={registryOwnerID}");
        }

        public async Task<List<EditCategoryModel>> GetEditCategories(int registryOwnerID)
        {
            return await GetResponse<List<EditCategoryModel>, object>($"editcategories?registryOwnerID={registryOwnerID}");
        }

        public async Task<RegistrySignature> GetRegistrationSignature(int id)
        {
            return await GetResponse<RegistrySignature, object>($"enrollment/signature?registryID={id}");
        }

        public async Task<Common.DTO.Registry> GetRegistration(int id)
        {
            return await GetResponse<Common.DTO.Registry, object>($"enrollment?registryID={id}");
        }

        public async Task<RegistryVerification> GetRegistrationVerification(RegistryVerificationRequest request)
        {
            return await GetResponse<RegistryVerification, RegistryVerificationRequest>("enrollment/verification", request);
        }

        public async Task<IList<RegistryOwner>> GetRegistryOwners()
        {
            return await GetResponse<IList<RegistryOwner>, object>("owners");
        }
        #endregion

        public async Task<int> InsertEventCategory(EventCategoryInsertUpdate eventCategory)
        {
            var response = await client.PostAsJsonAsync($"{GetSetting("ApiUrl")}category", eventCategory);

            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadAsAsync<int>();
            }

            return 0;
        }

        public async Task<bool> UpdateEventCategory(EventCategoryInsertUpdate eventCategory)
        {
            var response = await client.PutAsJsonAsync($"{GetSetting("ApiUrl")}category?id={eventCategory.EventCategoryID.Value}", eventCategory);

            return (response.IsSuccessStatusCode);
        }

        public async Task<int> InsertEventSubCategory(EventSubCategoryInsertUpdate eventSubCategory)
        {
            var response = await client.PostAsJsonAsync($"{GetSetting("ApiUrl")}subcategory", eventSubCategory);

            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadAsAsync<int>();
            }

            return 0;
        }

        public async Task<bool> UpdateEventSubCategory(EventSubCategoryInsertUpdate eventSubCategory)
        {
            var response = await client.PutAsJsonAsync($"{GetSetting("ApiUrl")}subcategory?id={eventSubCategory.EventSubCategoryID.Value}", eventSubCategory);

            return (response.IsSuccessStatusCode);
        }

        public async Task<PostRegistryResponse> AddRegistration(Common.DTO.Registry registry, bool isDonor)
        {
            var response = await client.PostAsJsonAsync($"{GetSetting("ApiUrl")}{(isDonor ? Routes.RouteEnrollment : Routes.RouteRemoval)}", registry);

            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadAsAsync<PostRegistryResponse>();
            }

            return null;
        }

        public async Task<RegistryApiError?> SignRegistration(int id, bool isDonor)
        {
            var response = await client.PutAsync($"{GetSetting("ApiUrl")}{(isDonor ? Routes.RouteEnrollmentSignature : Routes.RouteRemovalSignature)}?registryID={id}", null);

            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadAsAsync<RegistryApiError?>();
            }

            return null;
        }

        public async Task<bool> SaveCategories(EditCategorySaveModel model)
        {
            var response = await client.PutAsJsonAsync($"{GetSetting("ApiUrl")}categories-save", model);

            return response.IsSuccessStatusCode;
        }

        public async Task<PostRegistryResponse> IDologyVerification(IDologyAnswersRequest request)
        {
            var response = await client.PostAsJsonAsync($"{GetSetting("ApiUrl")}idology/answers", request);

            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadAsAsync<PostRegistryResponse>();
            }

            return null;
        }

        public async Task<IList<ReportDbEntity>> GetReportData(string states)
        {
            return await GetResponse<IList<ReportDbEntity>, object>($"report?states={HttpUtility.UrlEncode(states)}"); ;
        }

        #endregion
    }
}
