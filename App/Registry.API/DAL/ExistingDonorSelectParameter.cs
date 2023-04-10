using System;

namespace Registry.API.DAL
{
    public class ExistingDonorSelectParameter
    {
        public int RegistryID { get; set; }
        public int RegistryOwnerID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string LastFourSSN { get; set; }
        public string License { get; set; }
        public DateTime DOB { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public int? ReturnVal { get; set; }
    }
}
