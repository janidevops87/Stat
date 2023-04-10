using MimeKit;
using RingCentral;
using Statline.Common.Utilities;
using System;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Infrastructure.FaxSender
{
    public class FaxRequest
    {
        private string ClientId;
        private string ClientSecret;
        private string UserName;
        private string Password;
        private string Extension;
        private RestClient rc;
        public string To { get; set; }
        public string FileName { get; set; }
        public string FaxNumber { get; set; }
        public string CoverPageText { get; set; }
        public byte[] FileInBytes { get; set; }

        public FaxRequest(RingCentralFaxSenderOptions options)
        {
            Check.NotNull(options, nameof(options));
            ClientId = options.ClientId;
            ClientSecret = options.ClientSecret;
            UserName = options.UserName;
            Password = options.Password;
            Extension = options.Extension;
            rc = new RestClient(ClientId, ClientSecret, true);
        }

        public async Task<string> SendRequestAsync()
        {
            await AuthorizeRingCentral().ConfigureAwait(false);
            return await send_fax().ConfigureAwait(false);
        }

        public void Clear()
        {
            To = String.Empty;
            FileName = String.Empty;
            FaxNumber = String.Empty;
            CoverPageText = String.Empty;
            FileInBytes = new byte[] { };
        }

        private async Task AuthorizeRingCentral()
        {
            await rc.Authorize(UserName, Extension, Password).ConfigureAwait(false);
        }

        private async Task<string> send_fax()
        {
            if (rc.token.access_token.Length > 0)
            {
                string fileType = MimeTypes.GetMimeType(FileName);

                var requestParams = new RingCentral.CreateFaxMessageRequest();  //SendFaxMessageRequest();
                //var attachment = new Attachment { fileName = FileName, contentType = fileType, bytes = System.IO.File.ReadAllBytes(FileLocation) };
                var attachment = new Attachment { fileName = FileName, contentType = fileType, bytes = FileInBytes };
                var attachments = new Attachment[] { attachment };
                requestParams.attachments = attachments;
                requestParams.to = new MessageStoreCallerInfoRequest[] { new MessageStoreCallerInfoRequest { phoneNumber = FaxNumber } };
                requestParams.faxResolution = "High";
                requestParams.coverPageText = CoverPageText;
                requestParams.coverIndex = 0;
                FaxResponse resp = await rc.Restapi().Account().Extension().Fax().Post(requestParams).ConfigureAwait(false);
                return resp.id.ToString();
            }

            // TODO: Maybe, it's better to fail in this case?
            return null;
        }

        public async Task CheckStatus(long conversationId)
        {

            // OPTIONAL QUERY PARAMETERS
            ListMessagesParameters listMessagesParameters = new ListMessagesParameters
            {
                //availability = new[] { "Alive", "Deleted", "Purged" },
                conversationId = conversationId,
                //dateFrom = "<ENTER VALUE>",
                //dateTo = "<ENTER VALUE>",
                //direction = new[] { "Inbound", "Outbound" },
                //distinctConversations = true,
                //messageType = new[] { "Fax" }//{ "Fax", "SMS", "VoiceMail", "Pager", "Text" },
                //readStatus = new[] { "Read", "Unread" },
                //page = 1,
                //perPage = 100,
                //phoneNumber = "<ENTER VALUE>"
            };

            var r = await rc.Restapi().Account().Extension().MessageStore().List(listMessagesParameters);
        }
    }
}
