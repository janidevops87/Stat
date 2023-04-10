namespace Statline.StatTracUploader.Domain.Main.Organizations
{
    public class PhoneFilterCriteria
    {
        public string? PhoneNumber { get; }

        public PhoneFilterCriteria(string? phoneNumber)
        {
            PhoneNumber = phoneNumber;
        }
    }
}