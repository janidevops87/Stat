using Statline.StatTracUploader.Domain.Common;

namespace Statline.StatTracUploader.Domain.Main.Persons
{
    public class PersonFilterCriteria
    {
        public PersonName? Name { get; set; }
        public int? OrganizationId { get; set; }
        public bool? Inactive { get; set; }
    }
}
