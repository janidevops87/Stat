using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using Registry.Common.Enums;

namespace Registry.Common.DTO
{
    public class Registry
    {
        public int? RegistryID { get; set; }
        public int? RegistryOwnerID { get; set; }
        [StringLength(11)]
        public string SSN { get; set; }
        public DateTime? DOB { get; set; }
        [StringLength(20)]
        public string FirstName { get; set; }
        [StringLength(20)]
        public string MiddleName { get; set; }
        [StringLength(25)]
        public string LastName { get; set; }
        [StringLength(4)]
        public string Suffix { get; set; }
        [StringLength(1)]
        public string Gender { get; set; }
        public int? Race { get; set; }
        [StringLength(5)]
        public string EyeColor { get; set; }
        [StringLength(10)]
        public string Phone { get; set; }
        [StringLength(100)]
        public string Email { get; set; }
        [StringLength(200)]
        public string Comment { get; set; }
        [StringLength(1000)]
        public string Limitations { get; set; }
        [StringLength(1000)]
        public string LimitationsOther { get; set; }
        [StringLength(20)]
        public string License { get; set; }
        public DateTime? OnlineRegDate { get; set; }
        public int? RegistryAddrID { get; set; }
        public int? AddressTypeID { get; set; }
        [StringLength(40)]
        public string Address1 { get; set; }
        [StringLength(20)]
        public string Address2 { get; set; }
        [StringLength(25)]
        public string City { get; set; }
        [StringLength(2)]
        public string State { get; set; }
        [StringLength(10)]
        public string Zip { get; set; }
        public int? EventRegistryID { get; set; }
        public int? EventCategoryID { get; set; }
        public int? EventSubCategoryID { get; set; }
        [StringLength(255)]
        public string EventCategorySpecifyText { get; set; }
        [StringLength(255)]
        public string EventSubCategorySpecifyText { get; set; }
        public LanguagesEnum Language { get; set; }
        public bool IsInternalEnrollment { get; set; }

        private static string GetFillQualidier(string separator, params string[] items)
        {
            return string.Join(separator, items.Where(x => !string.IsNullOrEmpty(x)));
        }

        public string GetFullName()
        {
            return GetFillQualidier(" ", FirstName, MiddleName, LastName);
        }

        public string GetFullAddress()
        {
            return GetFillQualidier(", ", Address1, Address2, City, State, Zip);
        }

        public string GetCityStateZip()
        {
            return GetFillQualidier(", ", City, State, Zip);
        }
    }
}
