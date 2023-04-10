using System.Collections.Generic;

namespace Registry.Common.EmailService
{
    public class Email
    {
        public Dictionary<string, object> KeyValuePairs { get; set; }
        public string TemplateName { get; set; }
        public string EmailFromAddress { get; set; }
        public string EmailToAddress { get; set; }
        public string Subject { get; set; }

        public Email()
        {
            KeyValuePairs = new Dictionary<string, object>();
        }
    }
}
