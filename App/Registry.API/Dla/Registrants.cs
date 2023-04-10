namespace Registry.API.Dla
{
    public class Registrants
    {
        public string Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string Suffix { get; set; }
        public string Dob { get; set; }
        public string Gender { get; set; }
        public string Email { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public string Last4SSN { get; set; }
        public bool CanContact { get; set; }
        public string Organization_Source { get; set; }
        public string Drivers_lic { get; set; }
        public string State_Id { get; set; }
        public string Modify_Date { get; set; }
        public string Last_Modified_Date { get; set; }
    }
}
