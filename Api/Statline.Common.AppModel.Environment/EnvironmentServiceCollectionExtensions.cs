using Statline.Common.AppModel.Environment;

namespace Microsoft.Extensions.DependencyInjection
{
    public static class EnvironmentServiceCollectionExtensions
    {
        public static void AddEnvironment(this IServiceCollection services, IEnvironment env)
        {
            services.AddSingleton(env);
        }
    }
}
