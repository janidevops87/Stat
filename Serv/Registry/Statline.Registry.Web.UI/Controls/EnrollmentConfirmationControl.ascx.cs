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

namespace Statline.Registry.Web.UI.Controls
{
    public partial class EnrollmentConfirmationControl : BaseUserControl
    {
        string DonorRegistrationRequest;
        
        protected void Page_Load(object sender, EventArgs e)
        {
           GetSessionInfo();

            if (!this.IsPostBack)
            {
                    if (DonorRegistrationRequest == "Add")
                    {
                        this.PanelAdd.Visible = true;
                        this.PanelRemove.Visible = false;
                    }

                    if (DonorRegistrationRequest == "Remove")
                    {
                        this.PanelAdd.Visible = false;
                        this.PanelRemove.Visible = true;
                    }
            }
        }
            private void GetSessionInfo()
            {
                if (Session["DonorRegistrationRequest"] != null) DonorRegistrationRequest = (string)(Session["DonorRegistrationRequest"].ToString());
                else { DonorRegistrationRequest = "Remove"; } //set default
            }
    }
}