using System;

namespace Registry.API.DAL
{
    public class RegistryInsertUpdateParameter
    {
        public int? RegistryID { get; set; }
        public int? RegistryOwnerID { get; set; }
        public string SSN { get; set; }
        public DateTime? DOB { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Suffix { get; set; }
        public string Gender { get; set; }
        public int? Race { get; set; }
        public string EyeColor { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Comment { get; set; }
        public string Limitations { get; set; }
        public string LimitationsOther { get; set; }
        public string License { get; set; }
        public bool Donor { get; set; }
        public bool DonorConfirmed { get; set; }
        public DateTime? OnlineRegDate { get; set; }
        public DateTime? SignatureDate { get; set; }
        public DateTime? MailerDate { get; set; }
        public bool DeleteFlag { get; set; }
        public DateTime? DeceaseDate { get; set; }
        public bool? PreviousDonor { get; set; }
        public bool? PreviousDonorConfirmed { get; set; }
        public int? LastStatEmployeeID { get; set; }
        public int? RegisteredByID { get; set; }
    }
}
