using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;

namespace System.Configuration
{
    public static class AppSettingsNameValueCollectionExtensions
    {
        private const string LegacyNamePrefix = "StatTracWeb--";

        public static Dictionary<string, string> GetDbPasswords(
            this NameValueCollection appSettings)
        {
            if (appSettings is null)
            {
                throw new ArgumentNullException(nameof(appSettings));
            }

            // DB password names have well-known prefix.
            return appSettings
                .WithNamePrefix("connectionStrings--")
                .Cast<string>()
                // To preserve backward compatibility with
                // applications which don't use this method
                // we retain secret names in Constants class in form of 
                // "StatTracWeb--connectionStrings--...". 
                // But in the app configuration (and in key vault)
                // there won't be this legacy prefix in secret name.
                // After loading secrets we put the prefix back, so all 
                // works everywhere.
                .ToDictionary(key => LegacyNamePrefix + key, appSettings.Get);
        }

        public static NameValueCollection WithNamePrefix(
            this NameValueCollection appSettings,
            string prefix)
        {
            if (appSettings is null)
            {
                throw new ArgumentNullException(nameof(appSettings));
            }

            if (prefix is null)
            {
                throw new ArgumentNullException(nameof(prefix));
            }

            var prefixedKeys = appSettings.AllKeys.Where(
                key => key.StartsWith(prefix, StringComparison.OrdinalIgnoreCase));

            var resultCollection = new NameValueCollection();

            foreach (var key in prefixedKeys)
            {
                resultCollection.Add(key, appSettings.Get(key));
            }

            return resultCollection;
        }
    }
}
