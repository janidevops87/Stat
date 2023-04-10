using System;

namespace Emailer.LegacyBridge.Infrastructure.EmailMessageQueue.LegacyQueue
{
    public class AlphaPage
    {
        public int AlphaPageId { get; set; }
        public int? CallId { get; set; }
        public string? AlphaPageRecipient { get; set; }
        public string? AlphaPageSender { get; set; }
        public string? AlphaPageBc { get; set; }
        public string? AlphaPageCc { get; set; }
        public string? AlphaPageSubject { get; set; }
        public string? AlphaPageBody { get; set; }
        public DateTime AlphaPageCreated { get; set; }
        public DateTime? AlphaPageSent { get; set; }
        public int? AlphaPageComplete { get; set; }
    }
}
