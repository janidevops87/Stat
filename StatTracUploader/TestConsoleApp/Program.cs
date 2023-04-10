using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Statline.StatTracUploader.Infrastructure.Services.StatTracApi;
using System;
using System.Text.Json;
using System.Threading.Tasks;

namespace TestConsoleApp
{
    class Program
    {
        static async Task Main()
        {
            //var documentPath = @"C:\Users\andsav.work\Documents\Statline\Referral Offline Forms\Latest\Triage Electronic Referral - With Data.xlsx";

            //var parser = new ExcelReferralFileParser(
            //    Options.Create(new ExcelReferralFileParserOptions()));

            //var referral = await parser.ParseAsync(
            //    new Statline.StatTracUploader.App.Uploader.InputReferralInfo(
            //        new GenericStreamReference(() => File.OpenRead(documentPath)),
            //        "FileName"));

            IServiceCollection services = new ServiceCollection();

            services.AddLogging(b => b.AddConsole().SetMinimumLevel(LogLevel.Debug));

            var configBuilder = new ConfigurationBuilder();
            configBuilder.AddJsonFile("appsettings.json", optional: false);
            var config = configBuilder.Build();

            services.AddStatTracApiClient(
                clientConfig: config.GetSection("StatTracApiClient"));

            using var sp = services.BuildServiceProvider();

            var client = sp.GetRequiredService<IStatTracApiClient>();

            Console.WriteLine("================================================");

            var healthReport = await client.GetApiHealthReportAsync(cancellationToken: default);

            Console.WriteLine(FormatToJson(healthReport));

            var sourceCodeId = await client.GetSourceCodeIdAsync("STAT", cancellationToken: default);

            Console.WriteLine(FormatToJson(sourceCodeId));
        }

        private static readonly JsonSerializerOptions jsonSerializerOptions = new() { WriteIndented = true };

        static string FormatToJson(object obj)
        {
            return JsonSerializer.Serialize(obj, jsonSerializerOptions);
        }
    }
}
