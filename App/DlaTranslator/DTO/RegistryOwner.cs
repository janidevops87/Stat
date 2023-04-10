using System.Collections.Generic;

namespace Registry.Common.DTO
{
    public class RegistryOwner
    {
        public RegistryOwner()
        {
            Emails = new List<RegistryOwnerEmail>();
        }
        public int RegistryOwnerId { get; set; }
        public string RegistryOwnerName { get; set; }
        public string RegistryOwnerRouteName { get; set; }
        public bool AllowDisplayNoDonors { get; set; }
		public int IDologyActive { get; set; }
		public string IDologyLogin { get; set; }
		public string IDologyPassword { get; set; }
		public string IDologySpLogin { get; set; }
		public string IDologySpPassword { get; set; }
        public bool CaptchaOn { get; set; }

        public IList<RegistryOwnerEmail> Emails { get; set; }
        public IList<string> DMVStates { get; set; }
    }
}
