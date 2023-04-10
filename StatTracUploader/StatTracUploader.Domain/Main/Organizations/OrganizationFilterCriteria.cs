namespace Statline.StatTracUploader.Domain.Main.Organizations
{
    public class OrganizationFilterCriteria
    {
        public string? PhoneNumber { get; }

        public OrganizationFilterCriteria(string? phoneNumber)
        {
            PhoneNumber = phoneNumber;
        }
    }
}