using System;
using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTrac.Admin;
using Statline.StatTrac.Data.Types;
using Infragistics.WebUI.WebCombo;
using Statline.StatTrac;
using Statline.StatTrac.Person;

namespace Statline.StatTrac.Web.UI.Controls.Admin
{
	/// <summary>
	///		Summary description for UserAdminControl.
	/// </summary>
	public partial class UserAdminControl : BaseUserControlSecure
	{
		protected Statline.StatTrac.Data.Types.UserData dsUserData;
		protected Statline.StatTrac.Data.Types.ReportReferenceData dsReportReferenceData;
		
		
		protected void Page_Load(object sender, System.EventArgs e)
		{
            Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
            if (IsPostBack)
				return;
		    
			DataBind();
		}

		public override void DataBind()
		{
			int reportGroupID = 0;

			//call GetUserAllReferralsReportGroup to obtain reportgroupID
            try
            {
                AdminReferenceManager.GetUserAllReferralsReportGroup(
                    Page.Cookies.UserOrgID,
                     out reportGroupID);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);                

            }

			Page.Cookies.ReportGroupID = reportGroupID;

			
			

			
		}
		private void FillGridPersonList()
		{
            if (Convert.ToInt32(ddlOrganization.DataValue) < 1 && Convert.ToInt32(txtHiddenOrganizationID.Value) < 1)
				return;
            if (Convert.ToInt32(ddlOrganization.DataValue) > 0)
                txtHiddenOrganizationID.Value = ddlOrganization.DataValue.ToString();
            try
            {
                AdminReferenceManager.FillUserList(
                    dsUserData,
                    Convert.ToInt32(txtHiddenOrganizationID.Value),
                    Convert.ToInt32(chkBoxInactive.Checked));
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

            }
			try
            {
			gridPersonList.DataBind();
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

            }
			
			
		}
		private void CallUserAdminEdit(int webPersonId)
		{
			QueryStringManager manager = new QueryStringManager(PageName.UserAdminEdit);
			manager.AddWebPersonId(Convert.ToInt32(webPersonId));
			if(txtHiddenOrganizationID.Value != "")
			manager.AddOrganizationId(Convert.ToInt32(txtHiddenOrganizationID.Value));
		
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
			this.dsUserData = new Statline.StatTrac.Data.Types.UserData();
			this.dsReportReferenceData = new Statline.StatTrac.Data.Types.ReportReferenceData();
			((System.ComponentModel.ISupportInitialize)(this.dsUserData)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.dsReportReferenceData)).BeginInit();
			this.ddlOrganization.SelectedRowChanged += new Infragistics.WebUI.WebCombo.SelectedRowChangedEventHandler(this.ddlOrganization_SelectedRowChanged);
			this.ddlOrganization.InitializeDataSource += new Infragistics.WebUI.WebCombo.InitializeDataSourceEventHandler(this.ddlOrganization_InitializeDataSource);
			this.gridPersonList.ActiveRowChange += new Infragistics.WebUI.UltraWebGrid.ActiveRowChangeEventHandler(this.gridPersonList_ActiveRowChange);
			// 
			// dsUserData
			// 
			this.dsUserData.DataSetName = "UserData";
			this.dsUserData.Locale = new System.Globalization.CultureInfo("en-US");
			// 
			// dsReportReferenceData
			// 
			this.dsReportReferenceData.DataSetName = "ReportReferenceData";
			this.dsReportReferenceData.Locale = new System.Globalization.CultureInfo("en-US");
			((System.ComponentModel.ISupportInitialize)(this.dsUserData)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.dsReportReferenceData)).EndInit();

		}
		#endregion


		protected void chkBoxInactive_CheckedChanged(object sender, System.EventArgs e)
		{   
			//try catch is in  the method    
            FillGridPersonList();
		}
		

		private void ddlOrganization_SelectedIndexChanged(object sender, System.EventArgs e)
		{
            //try catch is in  the method
			FillGridPersonList();
		}

		private void gridPersonList_ActiveRowChange(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
		{
			CallUserAdminEdit(Convert.ToInt32(e.Row.Cells[0].Value.ToString()));
		}

		protected void btnAddUser_Click(object sender, System.EventArgs e)
		{
			CallUserAdminEdit(ConstHelper.NEWUSER);
		}

		private void ddlOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
		{
            //try catch is in  the method
		    FillGridPersonList();
		}

		private void ddlOrganization_InitializeDataSource(object sender, Infragistics.WebUI.WebCombo.WebComboEventArgs e)
		{
			//ddlOrganization.ReportGroupID = reportGroupID;
            try
            {
			Statline.StatTrac.Report.ReportReferenceManager.FillOrganizationList(
				dsReportReferenceData, 
				Page.Cookies.ReportGroupID);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

            }
	        
			ddlOrganization.DataBind();
			/*
			for(int loop = 0;loop<ddlOrganization.Rows.Count;loop++ )
			{
				if(Convert.ToInt32(ddlOrganization.Rows[loop].Cells[1].Value) == 194)
				{
					ddlOrganization.SelectedIndex = loop;
				}
			}
			if(ddlOrganization.FindByValue(194) != null)
			{
				ddlOrganization.SelectedRow = ddlOrganization.FindByValue(194).Row;
			}
			*/
			
		}
             
              
	}
}
