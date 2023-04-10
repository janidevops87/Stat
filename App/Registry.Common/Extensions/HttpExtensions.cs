using System;
using System.Web;

namespace Registry.Common.Extensions
{
    public static class HttpExtensions
    {
        public static Uri AddQuery(this Uri uri, string name, string value)
        {
            //There is the difference between null and empty string. Empty string will be passed, while null parameter will be skipped at all
            if (value == null)
                return uri;

            var ub = new UriBuilder(uri);
            var httpValueCollection = HttpUtility.ParseQueryString(uri.Query);
            httpValueCollection.Add(name, value);
            ub.Query = httpValueCollection.ToString();

            return ub.Uri;
        }
    }
}
