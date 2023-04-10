using Statline.Common.Utilities;
using Statline.StatTrac.StatFax.Application.FaxSender;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Infrastructure.FaxSender
{
    public class RingCentralFaxSender : IFaxSender
    {
        private readonly RingCentralFaxSenderOptions options;

        public RingCentralFaxSender(RingCentralFaxSenderOptions options)
        {
            Check.NotNull(options, nameof(options));
            this.options = options;
        }

        public async Task<string> SendAsync(
            string toName, 
            string toNumber,
            FaxBody body)
        {
            Check.NotEmpty(toNumber, nameof(toNumber));
            Check.NotNull(body, nameof(body));

            byte[] bodyBytes = await body.Content.ReadAllBytesAsync().ConfigureAwait(false);

            var fax = new FaxRequest(options);

            fax.FileName = body.FileName;
            fax.To = toName;
            fax.FaxNumber = toNumber;
            fax.FileInBytes = bodyBytes;

            var faxJobId = await fax.SendRequestAsync().ConfigureAwait(false);

            // Giving time between faxes for ringcentral
            await Task.Delay(options.PauseFax).ConfigureAwait(false);

            // Clear data for next loop
            fax.Clear();

            return faxJobId;
        }
    }
}
