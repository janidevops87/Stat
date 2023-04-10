using System;

namespace Statline.StatTrac.StatFax.Infrastructure.FaxSender
{
    public class RingCentralFaxSenderOptions
    {
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string Extension { get; set; }
        public TimeSpan PauseFax { get; set; } = TimeSpan.Zero;
    }
}
