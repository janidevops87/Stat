using System;

namespace Stattrac.Reporting
{
    public class Settings
    {
        public EmailSetting Email { get; set; }

        public class EmailSetting
        {
            public string Host { get; set; }
            public string UserName { get; set; }
            public string StatServicePassword { get; set; }
            public int Port { get; set; }
        }

        public ConnectionString ConnectionStrings { get; set; }

        public class ConnectionString
        {
            public string Stattrac { get; set; }
            public string Registry { get; set; }
        }
        public int PasswordExpiration { get; set; }
        public int PasswordExpirationWarning { get; set; }
        public DateTime OldSiteExpiration { get; set; }
        public int AutoLogOut { get; set; }
        public int AutoLogOutWarning { get; set; }

        public SsrsSettings Ssrs { get; set; }
        public class SsrsSettings
        {
            public string EndPoint { get; set; }
            public string UserName { get; set; }
            public string Password { get; set; }
            public string Domain { get; set; }
        }
    }
}