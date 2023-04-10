using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.UI
{
    public partial class QAManageQualityMonitoringForms : Statline.StatTrac.Web.UI.BasePageSecure
    {
        public QAManageQualityMonitoringForms() : base(PageName.QAManageQualityMonitoringForms)
		{
            Title = "Manage Quality Monitoring Forms";

		}
        protected void Page_Load(object sender, EventArgs e)
        {
            BaseMenuControl.MainMenu = MenuName.QAConfig;
            BaseMenuControl.SubMenu = MenuName.QAManageQualityMonitoringForms;
        }
    }
}
