using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Report;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Web.UI.MasterPages;
using System.Web.Security;
using System.Security.Principal;
using System.Web.Configuration;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for ReportPassThroughLogin.
	/// </summary>
	public partial class ReportPassThroughLogin  : Statline.StatTrac.Web.UI.BasePageSecure
	{
		
		public ReportPassThroughLogin() : base(PageName.ReportPassThroughLogin)
		{
			Title = "ReportPassThroughLogin";


		}

        protected void Page_Load(object sender, System.EventArgs e)
        {
            BaseMenuControl.MainMenu = MenuName.Reports;
            BaseMenuControl.SubMenu = MenuName.ReportParams;
            RuleName = AuthRule.User;

            string session = string.Empty;
            foreach (var key in Request.Cookies.AllKeys)
            {
                if (key.ToUpper().StartsWith("ASPSESSIONID")) //find existing session cookie from old vb site
                {
                    session = Request.Cookies.Get(key).Value;
                    break;
                }
            }

            if (!string.IsNullOrEmpty(session))
            {

                int userId = Convert.ToInt32(Request.QueryString["userID"]);
                int userOrgId = Convert.ToInt32(Request.QueryString["userOrgID"]);
                int reportId = Convert.ToInt32(Request.QueryString["reportID"]);
                string userName = Convert.ToString(Request.QueryString["userName"]);
                string userDisplayName = Convert.ToString(Request.QueryString["userDisplayName"]);

                string userOrganizationName = Convert.ToString(Request.QueryString["userOrganizationName"]);
                //get ReportName
                ReportReferenceData reportListDS = new ReportReferenceData();
                try
                {
                    ReportReferenceManager.FillUserReportList(reportListDS, userId, reportId);
                }
                catch
                {

                    FormsAuthentication.SignOut();
                    TicketManager.DestroyTicket();
                    QueryStringManager.Redirect(PageName.Login);
                }

                //set the report information
                Cookies.ReportDisplayName = reportListDS.UserReportList[0].ReportDisplayName;
                Cookies.ReportName = Convert.ToString(reportListDS.UserReportList[0].ReportVirtualURL);
                Cookies.ReportID = reportId;
                Cookies.SessionID = Convert.ToString(Request.QueryString["sid"]);
                //set the users cookies
                CookieManager.SetUserCookies(userName, userOrgId, Cookies);

                if (Cookies.UserId == 0) {
                    FormsAuthentication.SignOut();
                    TicketManager.DestroyTicket();
                    QueryStringManager.Redirect(PageName.Login);
                }
                   
                //rediret to the report params page
                QueryStringManager.Redirect(PageName.ReportParams);
            }
            else
            {
                //when session not exist user will be redirected to the Login page
                FormsAuthentication.SignOut();
                TicketManager.DestroyTicket();
                QueryStringManager.Redirect(PageName.Login);
            }
        }

        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
		}
		#endregion
	}
}



		


