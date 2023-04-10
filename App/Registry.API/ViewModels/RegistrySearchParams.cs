using System;

namespace Registry.API.ViewModels
{
    public class RegistrySearchParams
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string ZipCode { get; set; }
        public string StateLicenseId { get; set; }
        public string WebRegistryNo { get; set; }
        public DateTime DateOfBirth { get; set; }
        public bool InWebRegistry { get; set; }
        public bool InDmvRegistry { get; set; }
        public string SortBy { get; set; }
        public string ThenBy1 { get; set; }
        public string ThenBy2 { get; set; }

    }
}