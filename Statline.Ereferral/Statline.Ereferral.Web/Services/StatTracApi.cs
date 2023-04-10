using IdentityModel.Client;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Statline.Ereferral.Models;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Reflection;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Statline.Ereferral.Web.Services
{
    public class StatTracApi : IStattracApi
    {
        private readonly EreferralSettings _setting;
        private readonly IDistributedCache _distributedCache;

        public StatTracApi(IOptions<EreferralSettings> setting, IDistributedCache distributedCache)
        {
            _setting = setting.Value;
            _distributedCache = distributedCache;
        }

        public async Task<bool> IsIdentityServerAvailableAsync()
        {
            var client = new HttpClient();
            var discoveryClient = await client.GetDiscoveryDocumentAsync(_setting.IdentityServer.Uri);
            if (string.IsNullOrWhiteSpace(discoveryClient.TokenEndpoint))
                return false;
            return true;
        }

        public async Task<bool> IsStatTracApiAvailableAsync()
        {
            var client = await GetStatTracHttpClient();
            try
            {
                var content = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/heartbeat");
                if (content.StatusCode == System.Net.HttpStatusCode.InternalServerError)
                    return false;
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }

        public async Task<bool> IsValidOpoCode(string opoCode)
        {
            var content  = await RetryHttpRequest($"{_setting.StatTracApi}/api/v1/IsValidOpoCode?opoCode={opoCode}");
            return JsonConvert.DeserializeObject<bool>(content);
        }

        public async Task<bool> IsEmailValid(string opoCode, string email)
        {
            var content = await RetryHttpRequest($"{_setting.StatTracApi}/api/v1/ereferral/isEmailValid?opoCode={opoCode}&email={email}");
            return JsonConvert.DeserializeObject<bool>(content);
        }

        public async Task<bool> UnosIdExists(string unosid)
        {
            var content = await RetryHttpRequest($"{_setting.StatTracApi}/api/v1.0/UnosIdExists?unosid={unosid}");
            return JsonConvert.DeserializeObject<bool>(content);
        }

        public async Task<string> GetVersion()
        {
            var version = "";
            var task = Task.Run(() => version = _setting.Version);
            return await task;
        }
        public async Task<string> GetFacilityCodes(string sourceCode)
        {
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/facilitycodes?sourcecode={sourceCode}");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/facilitycodes?sourcecode={sourceCode}");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<string> GetSourceCodeId(string sourceCode)
        {
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/GetSourceCodeId?sourcecode={sourceCode}");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError || response.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/GetSourceCodeId?sourcecode={sourceCode}");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<bool> IsMedicalRecordDuplicate(string sourceCode, string facilityCode, string medicalRecord)
        {
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/IsMedicalRecordDuplicate?sourcecode={sourceCode}&facilityCode={facilityCode}&medicalRecord={medicalRecord}");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError || response.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/IsSourceCodeValid?sourcecode={sourceCode}");
            }
            return JsonConvert.DeserializeObject<bool>(await response.Content.ReadAsStringAsync());
        }
        public async Task<string> GetFacilityInfo(string sourceCode, string facilityCode, string contactFirstName, string contactLastName)
        {
            contactFirstName = contactFirstName == null ? "" : "&contactFirstName="+ contactFirstName;
            contactLastName = contactLastName == null ? "" : "&contactLastName=" + contactLastName;
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/facilityinfo?sourcecode={sourceCode}&facilityCode={facilityCode}{contactFirstName}{contactLastName}");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError || response.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/facilityinfo?sourcecode={sourceCode}&facilityCode={facilityCode}{contactFirstName}{contactLastName}");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<string> GetHospitalUnitAndFloor(string sourceCode, string facilityCode, string phone)
        {
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/hospitalunitandfloor?sourcecode={sourceCode}&facilityCode={facilityCode}&phone={phone}");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError || response.StatusCode == System.Net.HttpStatusCode.BadRequest)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/hospitalunitandfloor?sourcecode={sourceCode}&facilityCode={facilityCode}&phone={phone}");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<string> States()
        {
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/states");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1/states");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<string> Titles()
        {
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/contacttitlelist");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/contacttitlelist");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<string> Races()
        {
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/racelist");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/racelist");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<string> HospitalUnits()
        {
            var client = await GetStatTracHttpClient();
            var response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/hospitalunitlist");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1.0/referrals/hospitalunitlist");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<string> SubmitEreferral(ReferralModel referralModel)
        {
            var client = await GetStatTracHttpClient();
            var modelStr = new StringContent(JsonConvert.SerializeObject(referralModel), Encoding.UTF8, "application/json");
            var response = await client.PostAsync($"{_setting.StatTracApi}/api/v1.0/referrals/submitereferral", modelStr);
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
            {
                Thread.Sleep(2000);
                response = await client.PostAsync($"{_setting.StatTracApi}/api/v1.0/referrals/submitereferral", modelStr);
            }
            var ret = await response.Content.ReadAsStringAsync();
            var retArr = ret.Split(',');
            if (response.StatusCode != System.Net.HttpStatusCode.OK)
                return "An error occured, please check the logs";
            else
                return "{\"RuleOut\":\"" + retArr[0] + "\",\"CaseId\":\"" + retArr[1] + "\"}";
        }

        public async Task<string> OfferedOrganTissue()
        {
            var client = await GetStatTracHttpClient();
            var response =  await client.GetAsync($"{_setting.StatTracApi}/api/v1/organtissuetypes");
            if (response.StatusCode == System.Net.HttpStatusCode.InternalServerError)
            {
                Thread.Sleep(2000);
                response = await client.GetAsync($"{_setting.StatTracApi}/api/v1/organtissuetypes");
            }
            return await response.Content.ReadAsStringAsync();
        }

        public async Task<HttpResponseMessage> FileUpload(IFormFile file)
        {
            var client = await GetStatTracHttpClient();
            var content = new MultipartFormDataContent();
            content.Add(new StreamContent(file.OpenReadStream()), file.Name, file.FileName);
            return await client.PostAsync($"{_setting.StatTracApi}/api/v1/uploadFile", content);
        }

        public async Task<bool> IsCaptchaValid(string api, string secret, string response)
        {
            var result = await new HttpClient().PostAsync(api, new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("secret", secret),
                new KeyValuePair<string, string>("response", response),
            }));
            var content = await result.Content.ReadAsStringAsync();
            var captchaModel = JsonConvert.DeserializeObject<CaptchaModel>(content);
            return captchaModel.success;
        }

        private async Task<HttpClient> GetStatTracHttpClient()
        {
            var client = new HttpClient();
            client.Timeout = TimeSpan.FromSeconds(240);
            string TokenKey = $"tcrt";
            string RenewKey = $"txpt";
            var renewTime = await _distributedCache.GetStringAsync(RenewKey).ConfigureAwait(false);
            var accessToken = string.Empty;
            if (string.IsNullOrEmpty(renewTime) || (long.Parse(renewTime) < DateTime.Now.Ticks))
            {
                var discoveryClient = await client.GetDiscoveryDocumentAsync(_setting.IdentityServer.Uri);
                // request token
                var tokenRequest = new ClientCredentialsTokenRequest
                {
                    Address = discoveryClient.TokenEndpoint,
                    ClientId = _setting.IdentityServer.ClientId,
                    ClientSecret = _setting.IdentityServer.ClientSecret,
                    Scope = _setting.IdentityServer.ApiScope
                };
                var tokenResponse = await client.RequestClientCredentialsTokenAsync(tokenRequest);
                await _distributedCache.SetStringAsync(RenewKey, DateTime.Now.AddSeconds(tokenResponse.ExpiresIn).Ticks.ToString());
                await _distributedCache.SetStringAsync(TokenKey, tokenResponse.AccessToken);
                accessToken = tokenResponse.AccessToken;
            }
            else
            {
                accessToken = await _distributedCache.GetStringAsync(TokenKey).ConfigureAwait(false);
            }

            client.SetBearerToken(accessToken);
            return client;
        }

        private async Task<string> RetryHttpRequest(string url, int delay = 2000, int maxRetry = 3)
        {
            var client = await GetStatTracHttpClient();
            var content = await client.GetStringAsync(url);
            var retry = 0;
            while (content.ToLower() == "\"false\"" && maxRetry - 1 > retry)
            {
                Thread.Sleep(delay);
                content = await client.GetStringAsync(url);
                retry++;
            }
            return content;
        }
    }
}