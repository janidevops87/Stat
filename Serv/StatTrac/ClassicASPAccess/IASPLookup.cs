using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace Statline.Stattrac.ClassicASPAccess
{
    [ComVisible(true), GuidAttribute("65409C54-857F-4b23-AD0C-380A6ABC3F10")]
    [InterfaceType(ComInterfaceType.InterfaceIsDual)]
    public interface IASPLookup
    {
        string ReportUser();
        string ReportAuthenticate();
    }
    
}
