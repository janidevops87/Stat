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

namespace Statline.Registry.Web.UI.Controls
{
    public partial class LoginFailureControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Int32 FailedCount;

                if (Session["FailedCount"] != null) FailedCount = (Int32)(Session["FailedCount"]);
                else { FailedCount = 0; }

                    if (FailedCount > 2) 
                    {
                        Session.Add("FailedCount", 0);
                    }

            }
        }
    }
}