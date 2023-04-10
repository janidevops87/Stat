using System.Net;
using Statline.Common.Utilities;

namespace Statline.Common.Configuration.Email.Smtp
{
    public class SmtpServerSettings
    {
        private const int MinSeverPort = 0;

        public string ServerName { get; set; }
        public int ServerPort { get; set; }
        public NetworkCredential Credential { get; set; }

        public void Validate(string referencingPath)
        {
            Check.NotEmpty(referencingPath, nameof(referencingPath));
            Check.NotEmpty(ServerName, referencingPath + "." + nameof(ServerName));
            Check.BiggerOrEqual(ServerPort, MinSeverPort, referencingPath + "." + nameof(ServerPort));
            Check.NotNull(Credential, referencingPath + "." + nameof(Credential));
        }
    }
}
