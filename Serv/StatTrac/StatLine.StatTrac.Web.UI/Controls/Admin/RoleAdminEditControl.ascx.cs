namespace Statline.StatTrac.Web.UI.Controls.Admin
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
    using Statline.StatTrac.Data.Types;
    using Statline.StatTrac.Security;
using System.Web.UI;
    using Infragistics.WebUI.UltraWebGrid;
    using System.Data.SqlClient;

	/// <summary>
	///		Summary description for RoleAdminEditControl.
	/// </summary>
	public partial class RoleAdminEditControl : BaseUserControlSecure
	{
		protected Statline.StatTrac.Web.UI.WebControls.SectionHeader addEditUserDetail;
        private bool anyChanges;
        protected SecurityData dsSecurityData;     
        private int webPersonId;
        private int roleId;
        protected DataView newView;        
	 
        protected void Page_Load(object sender, System.EventArgs e)
		{
            AnyChanges = false;
            WebPersonId = Page.Cookies.UserId;
            RoleId = QueryStringManager.RoleId;

            if (Page.IsPostBack)
                return;
                        
            DataBind();
		}
        public override void DataBind()
        {

            dsSecurityData = new SecurityData();

            #region set hidden RoleId
            //load role data
                txtHiddenFieldRoleId.Value = RoleId.ToString();
            #endregion
            #region Load Reports      
            
            #region Load Role Data
            if (QueryStringManager.RoleId != ConstHelper.NEWROLE)
            {
                try
                {
                    LoadData();
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                }

                if (dsSecurityData.Roles.Rows.Count == 1)
                {
                    chkBoxInactive.Checked = Convert.ToBoolean(dsSecurityData.Roles[0].Inactive);
                    txtBoxRoleName.Text = dsSecurityData.Roles[0].RoleName;
                    txtBoxRoleDescription.Text = dsSecurityData.Roles[0].RoleDescription;
                }

                gridSelectedReports.DataBind();
            }

            #endregion

            #region Load Available Reports
            try
            {
                Statline.StatTrac.Security.RolesManager.FillAvailableReports(dsSecurityData, WebPersonId, RoleId);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
            gridAvailableReports.DataBind();
            #endregion

            #region Load Associated Users
            try
            {
                Statline.StatTrac.Security.RolesManager.FillRoleUsers(dsSecurityData, webPersonId, RoleId);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
            gridAssociatedUsers.DataBind();
            #endregion
           
            #endregion

            
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
        
        #region Properties
        public bool AnyChanges
        {
            get { return anyChanges; }
            set { anyChanges = value; }
        }
        #endregion

        protected void odsAvailableReports_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            //catch any errors from the data source
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");

                e.ExceptionHandled = true;
            }

        }
        #region properties
        protected int WebPersonId
        {
            get { return webPersonId; }
            set { webPersonId = value; }
        }
        protected int RoleId
        {
            get { return roleId; }
            set { roleId = value; }
        }

        #endregion

        protected void gridAvailableReports_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            dsSecurityData = new SecurityData();
            ((System.ComponentModel.ISupportInitialize)(this.dsSecurityData)).BeginInit();
            this.gridSelectedReports.DeleteRowBatch += new Infragistics.WebUI.UltraWebGrid.DeleteRowBatchEventHandler(this.gridSelectedReports_DeleteRowBatch);
            this.gridSelectedReports.UpdateRowBatch += new Infragistics.WebUI.UltraWebGrid.UpdateRowBatchEventHandler(this.gridSelectedReports_UpdateRowBatch);
            // 
            // dsSecurityData
            // 
            this.dsSecurityData.DataSetName = "SecurityData";
            this.dsSecurityData.Locale = new System.Globalization.CultureInfo("en-US");
            ((System.ComponentModel.ISupportInitialize)(this.dsSecurityData)).EndInit();

        }
        protected void Validate()
        {
        }
        private void LoadData()
        {
            //get the person data first. Person is the parent row
            if(dsSecurityData == null)
                dsSecurityData = new SecurityData();

            if (dsSecurityData.Roles.Rows.Count <= 0)
            {
                if (QueryStringManager.RoleId == -1)
                {
                    SecurityData.RolesRow rolesRow;
                    //build role Row with default values
                    rolesRow = dsSecurityData.Roles.AddRolesRow(
                        "",
                        "",
                        1
                        );
                }
                else
                {
                    // fill dataset with server data
                    try
                    {
                        RolesManager.GetRole(
                            dsSecurityData,
                            RoleId);
                    }
                    catch
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data table from being loaded");
                    }
                }
            }

             
            // retrieve dataset from server if not already available
            if (dsSecurityData.ReportRule.Rows.Count <= 0)
            {
                if (QueryStringManager.RoleId != -1)
                {

                    // fill dataset with server data
                    try
                    {
                        //load selected Roles after webperson data is loaded
                        RolesManager.FillSelectedReports(
                            dsSecurityData,
                            webPersonId,
                            RoleId);

                    }
                    catch
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data table from being loaded");
                    }
                }
            }
        }

        protected void gridSelectedReports_UpdateRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
        {
            LoadData();
            SecurityData.ReportRuleRow row;

            if (e.Row.DataChanged == DataChanged.Added)
            {
                // if it's a new row, create a new dataset row
                row = dsSecurityData.ReportRule.NewReportRuleRow();                
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
            }
            else
            {
                // else get a reference to the existing row in the dataset
                row = dsSecurityData.ReportRule.FindByReportRuleID(
                    (int)e.Row.Cells[gridSelectedReports.Columns.IndexOf("ReportRuleID")].Value); //ReportRuleID
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;                
            }

            foreach (UltraGridCell cell in e.Row.Cells)
            {
                
                // update each data row with the grid row values 
                if (cell.Key == "ReportRuleID")
                    continue;
                if (cell.Value != null)
                {
                    row[cell.Column.BaseColumnName] = cell.Value;
                }
                else
                {
                    row[cell.Column.BaseColumnName] = DBNull.Value;
                }
            }

            if (e.Row.DataChanged == DataChanged.Added)
            {
                // if the row is a new row, add the row to the dataset
                dsSecurityData.ReportRule.AddReportRuleRow(row);                
            }
            AnyChanges = true;

        }

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            Validate();
            if (!Page.IsValid)
                return;

            //set row index
            int rowIndex = 0;
            int rowsChanged = -1;

            //need to reload the dataset
            #region load Role 
                LoadData();
            #endregion

            //update Role Row	
            if (dsSecurityData.Roles.Rows.Count == 1)
            {
                if (dsSecurityData.Roles[rowIndex].RoleName != txtBoxRoleName.Text)
                {
                    dsSecurityData.Roles[rowIndex].RoleName = txtBoxRoleName.Text;
                    AnyChanges = true;
                }
                if (dsSecurityData.Roles[rowIndex].RoleDescription != txtBoxRoleDescription.Text)
                {
                    dsSecurityData.Roles[rowIndex].RoleDescription = txtBoxRoleDescription.Text;
                    AnyChanges = true;
                }
                if (dsSecurityData.Roles[rowIndex].Inactive != Convert.ToInt16(chkBoxInactive.Checked))
                {
                    dsSecurityData.Roles[rowIndex].Inactive = Convert.ToInt16(chkBoxInactive.Checked);
                    AnyChanges = true;
                }
             }
            if (AnyChanges)
            {
                try
                {
                    rowsChanged = RolesManager.UpdateRoles(dsSecurityData, Page.Cookies.StatEmployeeID);
                    QueryStringManager.Redirect(PageName.RoleAdmin);
                }
                catch (SqlException sex)
                {
                    if(sex.Number == Convert.ToInt32(ConstHelper.SQLException.PrimaryKeyViolation))
                        DisplayMessages.Add(MessageType.WarningMessage, "The Role was not saved. The RoleName must be unique");                   
                    else
                        DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                }
            }



        }

        protected void gridSelectedReports_DeleteRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
        {
            LoadData();
            SecurityData.ReportRuleRow row;

            
            // else get a reference to the existing row in the dataset
            row = dsSecurityData.ReportRule.FindByReportRuleID(
                (int)e.Row.Cells[gridSelectedReports.Columns.IndexOf("ReportRuleID")].Value); //ReportRuleID
            if (row == null)
                return;
            row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
            row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;
            row.AcceptChanges();
            row.Delete();
            AnyChanges = true;

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            QueryStringManager.Redirect(PageName.RoleAdmin);
        }


    }
}
