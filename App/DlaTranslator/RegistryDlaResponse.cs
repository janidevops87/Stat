using System;
using System.Collections.Generic;

namespace Statline.Stattrac.DlaTranslator
{
    public class RegistryDlaResponse
    {
        public DateTime? RequestDOB { get; set; }
        public string RequestFirstName { get; set; }
        public string RequestMiddleName { get; set; }
        public string RequestLastName { get; set; }
        public string RequestCity { get; set; }
        public string RequestState { get; set; }
        public string RequestZip { get; set; }
        public List<RegistryDlaResponseItem> Items { get; set; }
        public int ItemCount { get; set; }
        public int ErrorCount { get; set; }
        public string ErrorDescription { get; set; }
        public DateTime RequestDateTime { get; set; }
        public DateTime ResponseDateTime { get; set; }

        public RegistryDlaResponse()
        {
            RequestFirstName = string.Empty;
            RequestMiddleName = string.Empty;
            RequestLastName = string.Empty;
            RequestCity = string.Empty;
            RequestState = string.Empty;
            RequestZip = string.Empty;
            Items = new List<RegistryDlaResponseItem>();
            ItemCount = 0;
            ErrorCount = 0;
            ErrorDescription = string.Empty;
        }
    }
}
