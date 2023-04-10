using System;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Statline.Common.AppModel.Host
{
    public interface IAppHostBuilder
    {
        IAppHost Build();
        IAppHostBuilder ConfigureAppConfiguration(Action<AppHostBuilderContext, IConfigurationBuilder> configureDelegate);
        IAppHostBuilder ConfigureServices(Action<AppHostBuilderContext, IServiceCollection> configureServices);
    }
}
