using System.IO;
using System.Text;
using System.Web;

namespace Registry.Common.EmailService
{
    public static class TemplateHelper
    {
        public static string ApplyTemplate(Email email, string templateDir)
        {
            var templateSource = Path.Combine(templateDir, email.TemplateName + ".html");
            var tamplateText = File.ReadAllText(templateSource);
            var sb = new StringBuilder(tamplateText);

            foreach (var valuePair in email.KeyValuePairs)
            {
                sb.Replace("{" + valuePair.Key + "}", valuePair.Value.ToString());
            }

            return sb.ToString();
        }
    }
}
