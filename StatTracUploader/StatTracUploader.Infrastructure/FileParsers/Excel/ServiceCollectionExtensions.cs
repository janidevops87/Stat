using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Statline.StatTracUploader.App.Uploader.ReferralFileParser;
using Statline.Common.Utilities;

namespace Statline.StatTracUploader.Infrastructure.FileParsers.Excel
{
    public static class ServiceCollectionExtensions
    {
        public static void AddExcelReferralFileParser(
            this IServiceCollection services,
            IConfiguration config)
        {
            Check.NotNull(services, nameof(services));
            Check.NotNull(config, nameof(config));
            services.Configure<ExcelReferralFileParserOptions>(config);
            services.AddTransient<IReferralFileParser, ExcelReferralFileParser>();
        }
    }
}
