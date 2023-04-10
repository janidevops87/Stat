using System;

namespace Statline.Stattrac.DlaTranslator
{
    public class RegistryDlaRequest
    {
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public DateTime DOB { get; set; }
    }
}
