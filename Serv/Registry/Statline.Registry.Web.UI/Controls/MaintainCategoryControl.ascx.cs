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
using Statline.Registry.Common;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;

namespace Statline.Registry.Web.UI.Controls
{
    public partial class MaintainCategoryControl : BaseUserControlSecure
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gridMaintainCategoryLists_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            
        }

        protected void btnCategoryAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("CategoryEdit.aspx");
        }
    }
}