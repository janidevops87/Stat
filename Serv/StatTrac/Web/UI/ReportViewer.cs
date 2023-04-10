using System;
using System.Collections.Generic;
using System.IO;
using Microsoft.Reporting.WebForms;


namespace Statline.StatTrac.Web.UI
{
    class StatlineReportViewer : Microsoft.Reporting.WebForms.ReportViewer
    {
        protected override void Render(System.Web.UI.HtmlTextWriter writer)
        {
            
            base.Render(writer);
        }
        
    }
}
