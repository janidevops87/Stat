using System;
using Registry.Common.Attributes;

namespace Registry.Common.DTO
{
    public class SearchRequest
    {
        public static SearchRequest GetDefaultSearchRequest()
        {
            //Magic values are taken from the SQL profiler
            return new SearchRequest
            {
                State = "*",
                WebRegistryID = -1,
                DOB = new DateTime(1900, 1, 1),
                DisplayDMVDonors = true,
                DisplayDMVDonorsYesOnly = false,
                DisplayNoDonors = true,
                DisplayWebDonors = true,
                DisplayWebPendingSignature = false,
                DisplayDLADonors = true
            };
        }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public string License { get; set; }
        public int? WebRegistryID { get; set; }
        public DateTime? DOB { get; set; }
        public bool? DisplayWebDonors { get; set; }
        public bool? DisplayDMVDonors { get; set; }
        [IgnoreProcedureParameterAttibute]
        public bool? DisplayDLADonors { get; set; }
        public bool? DisplayWebPendingSignature { get; set; }
        public bool? DisplayDMVDonorsYesOnly { get; set; }
        public bool? DisplayNoDonors { get; set; }
        public string StateSelection { get; set; }
        public int? RegistryOwnerID { get; set; }
    }
}