using Microsoft.Extensions.Configuration;
using Statline.Common.Services.Email.DonorTracApi.Compatibility;
using Statline.Framework;
using Statline.StatTrac.StatFax.Application;
using Statline.StatTrac.StatFax.Infrastructure.EmailSender.EmailService;
using Statline.StatTrac.StatFax.Infrastructure.FaxSender;
using Statline.StatTrac.StatFax.Infrastructure.WordToPdfConverter;
using System.Configuration;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Host.WebJob
{
    class Program
    {
        static async Task Main()
        {
            // For legacy parts.
            BaseIdentity.ApplicationSecrets = System.Configuration.ConfigurationManager.AppSettings.GetDbPasswords();

            // For modern configuration.
            // NOTE: This is a very basic configuration usage.
            // The next step could be adding dependency injection
            // and utilizing IOptions and friends.
            IConfigurationRoot configuration = new Microsoft.Extensions.Configuration.ConfigurationBuilder()
                .AddConfigurationManager()
                .Build();

            var emailSenderSettings = configuration
                .GetSection("EmailSender")
                .Get<EmailServiceEmailSenderOptions>();

            var faxSenderOptions = configuration
                .GetSection("FaxSender:RingCentral")
                .Get<RingCentralFaxSenderOptions>();

            var statFaxAppOptions = configuration
                .GetSection("Application")
                .Get<StatFaxAppOptions>();

            var wordToPdfConverterOptions = configuration
                .GetSection("WordToPdfConverter")
                .Get<GemBoxWordToPdfConverterOptions>();

            using var emailServiceFactory = new DonorTracApiEmailServiceFactory(
                "DonorTracApiClient",
                "DonorTracApiClient:Authentication");

            var emailService = emailServiceFactory.CreateEmailService();

            var app = new StatFaxApp(
                emailSender: new EmailServiceEmailSender(emailService, emailSenderSettings),
                faxSender: new RingCentralFaxSender(faxSenderOptions),
                wordToPdfConverter: new GemBoxWordToPdfConverter(wordToPdfConverterOptions),
                statFaxAppOptions);

            await app.ProcessAsync();
        }
    }
}
