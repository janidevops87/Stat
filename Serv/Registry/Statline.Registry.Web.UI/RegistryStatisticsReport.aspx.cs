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
using Statline.StatTrac.Web.UI;
using Statline.StatTrac.Web.Security;

namespace Statline.Registry.Web.UI
{
    public partial class RegistryStatisticsReport : BasePageSecure
    {
        public RegistryStatisticsReport() : base(PageName.RegistryStatisticsReport)
        {
            BaseMenuControl.MainMenu = MenuName.Registry;
            BaseMenuControl.SubMenu = MenuName.RegistryReport;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = "Registry Statistics Report";

            RuleName = AuthRule.Search;

        }
    }
}
