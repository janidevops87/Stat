namespace Statline.StatTracUploader.Domain.Main.Organizations
{
    public class SubLocationFilterCriteria
    {
        public string? PhoneNumber { get;}

        public SubLocationFilterCriteria(string? phoneNumber)
        {
            PhoneNumber = phoneNumber;
        }
    }
}