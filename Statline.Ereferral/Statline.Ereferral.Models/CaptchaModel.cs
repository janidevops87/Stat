namespace Statline.Ereferral.Models
{
    public class CaptchaModel
    {
        public bool success { get; set; }

        public string challenge_ts { get; set; }

        public string hostname { get; set; }
    }
}