using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Person;

namespace Statline.StatTrac.Web.UI.Controls.Admin
{

	/// <summary>
	///		Summary description for RoleAdminControl.
	/// </summary>
	public partial class RoleAdminControl : BaseUserControlSecure
	{
		protected Statline.StatTrac.Web.UI.WebControls.SectionHeader addEditUserDetail;
        protected Statline.StatTrac.Data.Types.UserData dsUserData;
        private int webPersonId;

	    public int WebPersonID
	    {
		    get { return webPersonId;}
		    set { webPersonId = value;}
	    }
    
		protected void Page_Load(object sender, System.EventArgs e)
		{
            Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);

            WebPersonID = Page.Cookies.UserId;
            odsRoles.SelectParameters.Clear();
            odsRoles.SelectParameters.Add(new Parameter("webPersonID", TypeCode.Int32, WebPersonID.ToString()));
            //gridRoleList.DataBind();
            
		}
        private void CallRoleAdminEdit(int roleId)
        {
            QueryStringManager manager = new QueryStringManager(PageName.RoleAdminEdit);
            manager.AddRoleId(Convert.ToInt32(roleId));
            manager.Redirect();
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
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		}
		#endregion

        protected void odsRoles_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            //if (WebPersonID == 0)
              //  e.Cancel = true;

        }

        protected void btnAddRole_Click(object sender, EventArgs e)
        {
            CallRoleAdminEdit(ConstHelper.NEWROLE);
        }

        protected void gridRoleList_ActiveRowChange(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
        {
            CallRoleAdminEdit(Convert.ToInt32(e.Row.Cells[0].Value.ToString()));
        }

        protected void odsRoles_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            //catch any errors from the data source
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");

                e.ExceptionHandled = true;
            }
        }

	}
}
