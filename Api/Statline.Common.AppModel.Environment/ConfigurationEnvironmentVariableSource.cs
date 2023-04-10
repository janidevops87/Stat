using Microsoft.Extensions.Configuration;
using Statline.Common.Utilities;
using System;

namespace Statline.Common.AppModel.Environment
{
    public class ConfigurationEnvironmentVariableSource : IEnvironmentVariableSource
    {
        private readonly IConfiguration config;

        public static ConfigurationEnvironmentVariableSource Build(
            Action<IConfigurationBuilder> buildAction)
        {
            var builder = new ConfigurationBuilder();
            buildAction(builder);  
            var config = builder.Build();

            return new ConfigurationEnvironmentVariableSource(config);
        }

        public ConfigurationEnvironmentVariableSource(
            IConfiguration config)
        {
            Check.NotNull(config, nameof(config));
            this.config = config;
        }

        public string GetValue(string key)
        {
            return config[key];
        }
    }
}
