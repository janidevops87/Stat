using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Text;

namespace Statline.Common.Infrastructure.Azure.ApplicationIsights
{
    public static class ServiceCollectionExtensions
    {
        public static void AddUserNameTelemetry(this IServiceCollection services)
        {
            services.AddSingleton<ITelemetryInitializer, UserNameTelemetryInitializer>();
        }
    }
}
