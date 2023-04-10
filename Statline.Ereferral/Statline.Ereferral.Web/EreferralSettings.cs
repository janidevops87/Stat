namespace Statline.Ereferral.Web
{
    public class EreferralSettings
    {
        public double CookieTimeout { get; set; }
        public string StatTracApi { get; set; }
        public string RecaptchaApi { get; set; }
        public string RecaptchaSecret { get; set; }

        public EmailSetting Email { get; set; }
        public int StattracUserId { get; set; }
        public string Version { get; set; }
        public ConnectionString ConnectionStrings { get; set; }
        public class EmailSetting
        {
            public string Host { get; set; }
            public string UserName { get; set; }
            public string Password { get; set; }
            public int Port { get; set; }
            public string ITOPS { get; set; }
            public string Client { get; set; }
        }

        public IdentityServerSetting IdentityServer { get; set; }

        public class IdentityServerSetting
        {
            public string Uri { get; set; }
            public string ApiScope { get; set; }
            public string ClientId { get; set; }
            public string ClientSecret { get; set; }
        }

        public class ConnectionString
        {
            public string Ereferral { get; set; }

        }
    }
}