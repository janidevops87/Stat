using System.Globalization;
using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTrac.Admin;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Controls.Admin
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
    using Statline.StatTrac.Web.Security;

    /// <summary>
    ///		Summary description for UserAdminEditControl.
    /// </summary>
    public partial class UserAdminEditControl : BaseUserControlSecure
	{
		protected System.Web.UI.WebControls.Button btnRemoveAllRoles;
		protected System.Web.UI.WebControls.Button btnRemoveSelectedRoles;
		protected Statline.StatTrac.Data.Types.UserData dsUserData;
		private bool anyChanges;
		protected void Page_Load(object sender, System.EventArgs e)
		{
			AnyChanges = false;
            
			if(IsPostBack) 
				return;
			//data bind if not postback
			DataBind();
		}
	protected void Validate()
		{
            int webPersonUserNameCount = 0;

            try
            {
                Statline.StatTrac.Admin.AdminReferenceManager.GetWebPersonUserNameCount(
                        txtBoxUserName.Text,
                        Convert.ToInt32(chkBoxInactive.Checked),
                        QueryStringManager.WebPersonId,
                        out webPersonUserNameCount);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "The System was unable to validate the page due to a database error.");
                validatorUserNameRequired.IsValid = false;
                return;
            }            
            
            if (webPersonUserNameCount > 1)
            {
                validatorUserNameRequired.IsValid = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "User Name can only be used once, please choose a new UserName.");                
            }
            
			if(txtBoxPassword.Text == "" && QueryStringManager.WebPersonId < 1 )
			{
				validatorPasswordLength.IsValid = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "Password is required for new users.");
			}
            try
            {
                if (txtBoxPassword.Text != txtBoxPasswordConfirm.Text)
                {
                    validatorPasswordMatch.IsValid = false;
                    //DisplayMessages.Add(MessageType.ErrorMessage, "Password and Confirm Password must match.");
                }
            }
            catch
            {
                validatorPasswordMatch.IsValid = false;
                //DisplayMessages.Add(MessageType.ErrorMessage, "Password and Confirm Password must match.");

            }
		}
    public override void DataBind()
		{
			#region Organization Drop Down ddlOrganization
			ddlOrganization.ReportGroupID = Page.Cookies.ReportGroupID;
			//set value currently set in previous screen.
            try
            {
                ddlOrganization.DataBind(QueryStringManager.OrganizationId.ToString());
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");
                QueryStringManager.Redirect(PageName.UserAdmin);
            }
			#endregion

			#region Available Roles Grid
            try
            {
                AdminReferenceManager.FillAvailableRolesList(
                    dsUserData,
                    QueryStringManager.WebPersonId, // user to edit
                    Page.Cookies.UserId);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");
                QueryStringManager.Redirect(PageName.UserAdmin);

            }

			gridAvailableRoles.DataBind();

			#endregion
			
			#region set hidden WebpersonID		
				txtHiddenWebPersonID.Value = QueryStringManager.WebPersonId.ToString();
			#endregion

            #region load UserData
                // if the user is a new user do not query for existing data
			if (QueryStringManager.WebPersonId == ConstHelper.NEWUSER)
			{

			#region Person Type Drop Down ddlPersonType new user
			//load title information
			ddlPersonType.DataBind();

			#endregion

			}
			else
			{

				

				#region load Person WebPersonDetail
                try
                {
                    AdminReferenceManager.FillUserDetail(dsUserData, QueryStringManager.WebPersonId);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");
                    QueryStringManager.Redirect(PageName.UserAdmin);
                }

				#endregion

				#region load UserRoles
                try
                {
                    LoadData();
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");
                    QueryStringManager.Redirect(PageName.UserAdmin);
                }
				gridSelectedRoles.DataBind();
				#endregion

				if(dsUserData.Person.Rows.Count == 1 )
				{
					txtBoxFirstName.Text = dsUserData.Person[0].PersonFirst;
					txtBoxLastName.Text = dsUserData.Person[0].PersonLast;
					chkBoxInactive.Checked = Convert.ToBoolean((dsUserData.Person[0].Inactive));

					#region Person Type Drop Down ddlPersonType existing user
					//load title information
                    try
                    {
                        ddlPersonType.DataBind(dsUserData.Person[0].PersonTypeID.ToString());
                    }
                    catch
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                        QueryStringManager.Redirect(PageName.UserAdmin);

                    }


					#endregion
				}
				if(dsUserData.WebPerson.Rows.Count == 1)
				{
					txtBoxUserName.Text = dsUserData.WebPerson[0].WebPersonUserName;
				}
            }
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
			this.dsUserData = new Statline.StatTrac.Data.Types.UserData();
			((System.ComponentModel.ISupportInitialize)(this.dsUserData)).BeginInit();
			this.gridSelectedRoles.DeleteRowBatch += new Infragistics.WebUI.UltraWebGrid.DeleteRowBatchEventHandler(this.gridSelectedRoles_DeleteRowBatch);
			this.gridSelectedRoles.UpdateRowBatch += new Infragistics.WebUI.UltraWebGrid.UpdateRowBatchEventHandler(this.gridSelectedRoles_UpdateRowBatch);
			// 
			// dsUserData
			// 
			this.dsUserData.DataSetName = "UserData";
			this.dsUserData.Locale = new System.Globalization.CultureInfo("en-US");
			((System.ComponentModel.ISupportInitialize)(this.dsUserData)).EndInit();

		}
        #endregion

        protected void btnSave_Click(object sender, System.EventArgs e)
        {
            Validate();
            if (!Page.IsValid)
                return;

            //set row index
            int rowIndex = 0;

            //need to reload the dataset
            #region load Person WebPersonDetail
            LoadData();
            #endregion

            //update Person Row	
            if (dsUserData.Person.Rows.Count == 1)
            {
                if (dsUserData.Person[rowIndex].PersonFirst != txtBoxFirstName.Text)
                {
                    dsUserData.Person[rowIndex].PersonFirst = txtBoxFirstName.Text;
                    UpdatePerson(rowIndex, (int)ConstHelper.AuditLogType.MODIFY);
                    AnyChanges = true;
                }
                if (dsUserData.Person[rowIndex].PersonLast != txtBoxLastName.Text)
                {
                    dsUserData.Person[rowIndex].PersonLast = txtBoxLastName.Text;
                    UpdatePerson(rowIndex, (int)ConstHelper.AuditLogType.MODIFY);
                    AnyChanges = true;
                }
                if (dsUserData.Person[rowIndex].PersonTypeID != Convert.ToInt32(ddlPersonType.SelectedValue))
                {
                    dsUserData.Person[rowIndex].PersonTypeID = Convert.ToInt32(
                        ddlPersonType.SelectedValue);
                    UpdatePerson(rowIndex, (int)ConstHelper.AuditLogType.MODIFY);
                    AnyChanges = true;
                }
                if (dsUserData.Person[rowIndex].OrganizationID != Convert.ToInt32(
                                                              ddlOrganization.SelectedValue))
                {
                    dsUserData.Person[rowIndex].OrganizationID = Convert.ToInt32(
                        ddlOrganization.SelectedValue);
                    UpdatePerson(rowIndex, (int)ConstHelper.AuditLogType.MODIFY);
                    AnyChanges = true;
                }
                if (dsUserData.Person[rowIndex].Inactive != Convert.ToInt16(
                                                        chkBoxInactive.Checked))
                {
                    dsUserData.Person[rowIndex].Inactive = Convert.ToInt16(
                        chkBoxInactive.Checked);
                    UpdatePerson(rowIndex, (int)ConstHelper.AuditLogType.MODIFY);

                    AnyChanges = true;
                }

                //update WebPerson Row

                if (dsUserData.WebPerson[rowIndex].WebPersonUserName != txtBoxUserName.Text)
                {
                    dsUserData.WebPerson[rowIndex].WebPersonUserName = txtBoxUserName.Text;
                    UpdateWebPerson(rowIndex, (int)ConstHelper.AuditLogType.MODIFY);
                    AnyChanges = true;
                }

                if (txtBoxPassword.Text != "")
                {
                    var saltValue = SecurityHelper.GenerateSaltValue(txtBoxPassword.Text);
                    dsUserData.WebPerson[rowIndex].SaltValue = saltValue;
                    dsUserData.WebPerson[rowIndex].HashedPassword = SecurityHelper.CreatePasswordHash(txtBoxPassword.Text, saltValue);


                    UpdateWebPerson(rowIndex, (int)ConstHelper.AuditLogType.MODIFY);
                    AnyChanges = true;
                }

            }

            if (AnyChanges)
            {
                try
                {
                    Person.PersonManager.UpdatePerson(dsUserData, Page.Cookies.StatEmployeeID);
                    QueryStringManager.Redirect(PageName.UserAdmin);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
                }
            }
        }

		private void gridSelectedRoles_UpdateRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
		{
			
			LoadData();
			UserData.UserRolesRow row; 
			
			if (e.Row.DataChanged == DataChanged.Added) 
			{
				// if it's a new row, create a new dataset row
				row = dsUserData.UserRoles.NewUserRolesRow();
				row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
				row["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
			} 
			else 
			{
				// else get a reference to the existing row in the dataset
				row = dsUserData.UserRoles.FindByWebPersonIDRoleID(
					(int)e.Row.Cells[0].Value, //webPersonID
					(int)e.Row.Cells[1].Value); //RoleID
				row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
				row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;

			}

			foreach (UltraGridCell cell in e.Row.Cells)
			{
				// update each data row with the grid row values 
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
				dsUserData.UserRoles.AddUserRolesRow(row);
			}
			AnyChanges = true;
		}
		private void LoadData()
		{
			//get the person data first. Person is the parent row

			if(dsUserData.Person.Rows.Count <= 0)
			{
				if (QueryStringManager.WebPersonId == -1)
				{
					UserData.PersonRow personRow;
					UserData.WebPersonRow webPersonRow;
					//build a person row with default values
					personRow = dsUserData.Person.AddPersonRow(
						"",
						"",
						"",
						-1,
						-1,
						"",
						0,
						1, //isverified
						1,
						DateTime.Now,
						0,
						DateTime.Now,
						"",
						"",
						0,
						0,
						0,
						-1,
						Convert.ToInt32(ConstHelper.AuditLogType.CREATE));
					//build a webperson row with default values
					webPersonRow = 	dsUserData.WebPerson.AddWebPersonRow(
						"",
						personRow,
						0,
						0,
						0,
						DateTime.Now,
						"",					
						"",
						0,
						0,
						Convert.ToInt32(ConstHelper.AuditLogType.CREATE),
                        "",
                        "");
				}
				else 
				{
					// fill dataset with server data
					try
					{
						AdminReferenceManager.FillUserDetail(
							dsUserData, 
							QueryStringManager.WebPersonId);
					}
					catch
					{
						DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data table from being loaded");
				    }
				}
			}
		

			// retrieve dataset from server if not already available
			if (dsUserData.UserRoles.Rows.Count <= 0)
			{
				if (QueryStringManager.WebPersonId != -1)
				{
					
					// fill dataset with server data
					try
					{
						//load selected Roles after webperson data is loaded
						AdminReferenceManager.FillUserRolesList(
							dsUserData, 
							QueryStringManager.WebPersonId);
					
					}
					catch
					{
						DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data table from being loaded");
					}
				}
			}
		}


		protected void btnCancel_Click(object sender, System.EventArgs e)
		{
			QueryStringManager.Redirect(PageName.UserAdmin);
		}

		private void gridSelectedRoles_DeleteRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
		{
			LoadData();
			UserData.UserRolesRow row; 
			
				// else get a reference to the existing row in the dataset
				row = dsUserData.UserRoles.FindByWebPersonIDRoleID(
					(int)e.Row.Cells[0].Value, //webPersonID
					(int)e.Row.Cells[1].Value); //RoleID
				if (row == null)
					return; 
				row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
				row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;
				row.AcceptChanges();
				row.Delete();
				//dsUserData.UserRoles.RemoveUserRolesRow(row);

				AnyChanges = true;
		
		}

		private void UpdateWebPerson(int rowIndex, int auditLogTypeID )
		{
			dsUserData.WebPerson[rowIndex].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
			dsUserData.WebPerson[rowIndex].AuditLogTypeID = Convert.ToInt32(auditLogTypeID);
			
		}
		private void UpdatePerson(int rowIndex, int auditLogTypeID )
		{
			dsUserData.Person[rowIndex].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
			dsUserData.Person[rowIndex].AuditLogTypeID = Convert.ToInt32(auditLogTypeID);

		}
		#region Properties

		public bool AnyChanges
		{
			get { return anyChanges; }
			set { anyChanges = value; }
		}

		#endregion

        protected void chkBoxInactive_CheckedChanged(object sender, EventArgs e)
        {

        }
	}
}
