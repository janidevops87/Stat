namespace Statline.StatTracUploader.Infrastructure.Services.StatTracApi.Model.Persons
{
    internal class PersonFilterCriteria
    {
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public int? OrganizationId { get; set; }
        public bool? Inactive { get; set; }
    }
}
