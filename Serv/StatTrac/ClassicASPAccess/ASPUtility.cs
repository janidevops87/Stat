using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace Statline.Stattrac.ClassicASPAccess
{
    [ComVisible(true), GuidAttribute("2AAA63E8-0268-4d0b-B339-9D85C6992587")]    
    [ClassInterface(ClassInterfaceType.None)]
    public class ASPLookup : IASPLookup
    {
        #region IASPLookup Members

        public string ReportUser()
        {
            return "streportClassicAspUser";
        }

        public string ReportAuthenticate()
        {
            return "4xJAsG0FMw81GDnZHS7K";
        }

        #endregion
    }
}
