using System;
using System.Web.UI;
using System.Web;
using System.Web.Security;

using Statline.Configuration;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Admin;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAMonitoringControl : BaseUserControlSecure
    {
        protected QAUpdateData dsQAData;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.IsPostBack)
            {
                btnAdd.Enabled = false;
                Session.Add("ValidTracking", "NO");
                int reportGroupID = 0;
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

                //Display QA Module Version text
                string QAModuleVersion = String.Empty;
                try
                {
                    QAModuleVersion = ApplicationSettings.GetSetting(SettingName.QAModuleVersion);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORQAModuleVersionDisplay);
                }
                finally
                {
                    divQAModuleVersion.InnerHtml = QAModuleVersion.ToString();
                }

            }
            if (!SecurityChecker.CheckAccessToRule(AuthRule.QAViewOtherOrgs))
            {
                ddlOrganization.Visible = false;
                lblOrganization.Visible = false;
            }
            odsOrg.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsForms.SelectParameters["OrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsEmployee.SelectParameters["OrganizationId"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            Application["OrgID"] = Page.Cookies.UserOrgID.ToString();
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
           
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int newTrackingID;
            newTrackingID = 0;
            dsQAData = new QAUpdateData();
            QAUpdateManager.FillQATracking(dsQAData, txtTrackingNumber.Text, Page.Cookies.UserOrgID);

            try
            {
                QAUpdateManager.FillQARefInfo(dsQAData, txtTrackingNumber.Text, Page.Cookies.ReportGroupID);
            }
            catch
            {

            }
            if (dsQAData.QATracking.Count == 0 && dsQAData.QARefInfo.Count != 0)
            {
                newTrackingID = QAUpdateDB.InsertTrackingNumber(txtTrackingNumber.Text, Page.Cookies.UserOrgID, Page.Cookies.StatEmployeeID, dsQAData.QARefInfo[0].SourceCodeName, dsQAData.QARefInfo[0].CallDateTime, Convert.ToInt32(dsQAData.QARefInfo[0].ReferralTypeID1), Convert.ToInt32(ddlQAFormType.SelectedRow.Cells[0].Value),1);
                Label1.Text = newTrackingID.ToString();
            }
            
            if (!String.IsNullOrEmpty(txtTrackingNumber.Text) && ddlQAFormType.SelectedIndex != -1 && ddlEmployee.SelectedIndex != -1)
            {
                 int trackingFormID = CreateErrorLog();
                 Response.Redirect("~/QAAddEditError.aspx?TrackingNumber=" + txtTrackingNumber.Text + "&EmployeeID=" + ddlEmployee.SelectedRow.Cells[0].Value + "&FormID=" + ddlQAFormType.SelectedRow.Cells[0].Value + "&EmployeeName=" + ddlEmployee.DisplayValue + "&TrackingFormID=" + trackingFormID + "&New=" + 1);
             }
             else
             {
                 DisplayMessages.Add(MessageType.ErrorMessage, "Valid tracking number, Form and Employee are required.");
             }
        }

        protected void ddlOrganization_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlOrganization.Columns[ddlOrganization.Columns.IndexOf("OrganizationID")].Hidden = true;
        }

        protected void ddlEmployee_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlEmployee.DropDownLayout.BaseTableName = "PersonbyOrg";
            ddlEmployee.Columns[ddlEmployee.Columns.IndexOf("PersonID")].Hidden = true;
        }

        protected void ddlQAFormType_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlQAFormType.DropDownLayout.BaseTableName = "DdlQAForms";
            ddlQAFormType.Columns[ddlQAFormType.Columns.IndexOf("QAMonitoringFormID")].Hidden = true;
            ddlQAFormType.Columns[ddlQAFormType.Columns.IndexOf("TrackingDesc")].Hidden = true;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtTrackingNumber.Text)  || ddlQAFormType.SelectedIndex == -1 || ddlEmployee.SelectedIndex == -1)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Valid tracking number, organization, form and employee are required.");
                return;
            }

            if (ddlOrganization.SelectedRow != null)
            {
                odsGrid.SelectParameters["OrganizationID"].DefaultValue = ddlOrganization.SelectedRow.Cells[1].Value.ToString();
            }
            else
            {
                odsGrid.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            }
            if (ddlEmployee.SelectedRow != null)
            {
                odsGrid.SelectParameters["EmployeeID"].DefaultValue = ddlEmployee.SelectedRow.Cells[0].Value.ToString();
            }
            if (ddlQAFormType.SelectedRow != null)
            {
                odsGrid.SelectParameters["QAMonitoringFormID"].DefaultValue = ddlQAFormType.SelectedRow.Cells[0].Value.ToString();
            }
            if (String.IsNullOrEmpty(txtTrackingNumber.Text))
            {
                odsGrid.SelectParameters["TrackingNumber"].DefaultValue = null;
            }
            gridForms.DataBind();
            //see if its in the QA system
            dsQAData = new QAUpdateData();
            try
            {
                QAUpdateManager.FillQARefInfo(dsQAData, txtTrackingNumber.Text, Page.Cookies.ReportGroupID);
            }
            catch
            {

            }
            Int32 testStatTrac = 0;
            try
            {
                if (ddlQAFormType.SelectedRow.Cells[2].Value.ToString() == "StatTrac")
                {
                    testStatTrac = QAUpdateManager.GetValidTrackingNumber(Convert.ToInt32(txtTrackingNumber.Text), Page.Cookies.ReportGroupID, 0);
                }
            }
            catch
            {

            }
            QAUpdateManager.FillQATracking(dsQAData, txtTrackingNumber.Text, Page.Cookies.UserOrgID);
            if (gridForms.Rows.Count > 0)
            {
                btnAdd.Enabled = true;
                Label1.Text = dsQAData.QATracking[0].QATrackingID.ToString();
                return;
            }
            
            if (dsQAData.QATracking.Count != 0 && dsQAData.QARefInfo.Count != 0)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "No results from search parameters but tracking number found.");
                btnAddTrackingNumber.Enabled = false;
                btnAdd.Enabled = true;
                Label1.Text = dsQAData.QATracking[0].QATrackingID.ToString();
                return;
            }
            if (dsQAData.QATracking.Count == 0 && dsQAData.QARefInfo.Count == 0)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "No results from search parameters and tracking number not found.");
                btnAddTrackingNumber.Enabled = true;
                btnAdd.Enabled = false;
                return;
            }
            if (dsQAData.QATracking.Count != 0 && dsQAData.QARefInfo.Count == 0)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "No results from search parameters but tracking number found.");
                btnAddTrackingNumber.Enabled = false;
                btnAdd.Enabled = true;
                Label1.Text = dsQAData.QATracking[0].QATrackingID.ToString();
                return;
            }
            if (dsQAData.QATracking.Count == 0 && dsQAData.QARefInfo.Count != 0)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "No results from search parameters but tracking number found.");
                btnAddTrackingNumber.Enabled = false;
                btnAdd.Enabled = true;
                return;
            }
        }

        protected void btnAddTrackingNumber_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {//see if its in the QA system
                Int32 testStatTrac = 0;
                try
                {
                    if (ddlQAFormType.SelectedRow.Cells[2].Value.ToString() == "StatTrac")
                    {
                        testStatTrac = QAUpdateManager.GetValidTrackingNumber(Convert.ToInt32(txtTrackingNumber.Text), Page.Cookies.ReportGroupID, 0);
                    }
                }
                catch
                {

                }
                odsGrid.SelectParameters["OrganizationID"].DefaultValue = null;
                odsGrid.SelectParameters["EmployeeID"].DefaultValue = null;
                odsGrid.SelectParameters["QAMonitoringFormID"].DefaultValue = null;
               
                //see if in stattrac
                dsQAData = new QAUpdateData();
                try
                {
                    QAUpdateManager.FillQARefInfo(dsQAData, txtTrackingNumber.Text, Page.Cookies.ReportGroupID);
                }
                catch
                {

                }

                QAUpdateManager.FillQATracking(dsQAData, txtTrackingNumber.Text, Page.Cookies.UserOrgID);

                //if (testStatTrac != 0)
                //{
                    if (dsQAData.QATracking.Count == 0)
                    {//non-dupe tracking number
                        int newTrackingID;
                        newTrackingID = 0;
                        DisplayMessages.Add(MessageType.ErrorMessage, "This tracking number will not display StatTrac details.");
                        //Button1_Click(sender, e);
                        if (testStatTrac != 0 && dsQAData.QARefInfo.Count > 0)
                        {
                            newTrackingID = QAUpdateDB.InsertTrackingNumber(txtTrackingNumber.Text, Page.Cookies.UserOrgID, Page.Cookies.StatEmployeeID, dsQAData.QARefInfo[0].SourceCodeName, dsQAData.QARefInfo[0].CallDateTime, Convert.ToInt32(dsQAData.QARefInfo[0].ReferralTypeID1), Convert.ToInt32(ddlQAFormType.SelectedRow.Cells[0].Value),1);
                        }
                        else
                        {
                            newTrackingID = QAUpdateDB.InsertTrackingNumber(txtTrackingNumber.Text, Page.Cookies.UserOrgID, Page.Cookies.StatEmployeeID, null, System.DateTime.Now, 0, Convert.ToInt32(ddlQAFormType.SelectedRow.Cells[0].Value),1);
                        }
                        Label1.Text = newTrackingID.ToString();
                    }
                    else
                    {//dupe tracking number
                        DisplayMessages.Add(MessageType.ErrorMessage, "Cannot add a Duplicate Tracking Number");
                        Label1.Text = dsQAData.QATracking[0].QATrackingID.ToString();
                    }
               
                btnAdd.Enabled = true;
            }
        }

        protected void ddlOrganization_PreRender(object sender, EventArgs e)
        {
            if (!this.Page.IsPostBack)
            {
                ddlOrganization.DisplayValue = Page.Cookies.UserOrganizationName.ToString();
            }
        }
        
        private int CreateErrorLog()
        {
            dsQAData = new QAUpdateData();
            
            int QMFID = new int();
            int OrgID = new int();
            if (ddlQAFormType.SelectedRow != null)
            {
                QMFID = Convert.ToInt32(ddlQAFormType.SelectedRow.Cells[0].Value);
            }
            if (ddlOrganization.SelectedRow != null)
            {
                OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }
            else
            {
                OrgID = Page.Cookies.UserOrgID;
            }
            Int32 test = 0;
            try
            {
                test = Convert.ToInt32(txtTrackingNumber.Text);
                QAUpdateManager.FillQARefInfo(dsQAData, txtTrackingNumber.Text, Page.Cookies.ReportGroupID);
            }
            catch (Exception ex)
            {
            }
            int newTrackingFormID;
            newTrackingFormID = 0;
            newTrackingFormID = QAUpdateDB.InsertTrackingForm(Page.Cookies.StatEmployeeID, Convert.ToInt32(ddlEmployee.SelectedRow.Cells[0].Value.ToString()));
            QAUpdateManager.FillQAGridManageErrorLists(dsQAData, OrgID, QMFID, 0);
            int newTrackingID;
            newTrackingID = 0;
            //if (String.IsNullOrEmpty(Label1.Text))
            //{
            //    newTrackingID = QAUpdateDB.InsertTrackingNumber(txtTrackingNumber.Text, Page.Cookies.UserOrgID, Page.Cookies.StatEmployeeID, dsQAData.QARefInfo[0].SourceCodeName, dsQAData.QARefInfo[0].CallDateTime, Convert.ToInt32(dsQAData.QARefInfo[0].ReferralTypeID1));
            //}
            //else
            //{
                newTrackingID = Convert.ToInt32(Label1.Text);
            //}
            int statEmployeeID;
            statEmployeeID = 0;
            statEmployeeID = QAUpdateManager.GetPersonID(Page.Cookies.UserId, 0); 
            for (int loop = 0; loop < dsQAData.GridManageErrorLists.Count; loop++)
            {
                QAUpdateData.QAErrorLogRow row;
                row = dsQAData.QAErrorLog.NewQAErrorLogRow();
                row["QATrackingID"] = newTrackingID;
                try
                {
                    row["QAErrorLocationID"] = dsQAData.GridManageErrorLists[loop].QAErrorLocationID;
                }
                catch
                {
                    row["QAErrorLocationID"] = DBNull.Value;
                }
                try
                {
                    row["QAErrorTypeID"] = dsQAData.GridManageErrorLists[loop].QAErrorTypeID;
                }
                catch
                {
                    row["QAErrorTypeID"] = DBNull.Value;
                }
                try
                {
                    row["QAMonitoringFormTemplateID"] = dsQAData.GridManageErrorLists[loop].QAMonitoringFormTemplateID;
                }
                catch
                {
                    row["QAMonitoringFormTemplateID"] = DBNull.Value;
                }
                row["StatEmployeeID"] = statEmployeeID; 
                row["QAErrorLogNumberOfErrors"] = 0;
                row["QAErrorLogPointsYes"] = 0;
                row["QAErrorStatusID"] = 1;
                row["QAErrorLogPointsNo"] = 0;
                row["QAErrorLogPointsNA"] = 0;
                if (dsQAData.QARefInfo.Rows.Count > 0)
                {
                    row["QAErrorLogDateTime"] = dsQAData.QARefInfo[0].CallDateTime;
                }
                else
                {
                    row["QAErrorLogDateTime"] = DateTime.Now;
                }
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = 1;
                dsQAData.QAErrorLog.AddQAErrorLogRow(row);
                //add trackingform row
                QAUpdateData.QATrackingFormErrorsRow row1;
                row1 = dsQAData.QATrackingFormErrors.NewQATrackingFormErrorsRow();
                row1["QAErrorLogID"] = row.QAErrorLogID;
                row1["QATrackingFormID"] = newTrackingFormID;
                row1["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row1["AuditLogTypeID"] = 1;
                dsQAData.QATrackingFormErrors.AddQATrackingFormErrorsRow(row1);
            }
            if (dsQAData.GridManageErrorLists.Count > 0)
                QAUpdateManager.UpdateErrorLog(dsQAData);
            return newTrackingFormID;
        }
        public bool IsValid()
        {
            bool returnValue = true;
            if (String.IsNullOrEmpty(txtTrackingNumber.Text))
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "You must enter a tracking number");
                return false;
            }
            if (ddlQAFormType.SelectedIndex == -1 && ddlQAFormType.DisplayValue == null)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "You must select a form");
                return returnValue;
            }
            return returnValue;
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = false;
            txtTrackingNumber.Text = null;
            txtTrackingNumber.Focus();
            odsGrid.SelectParameters["OrganizationID"].DefaultValue = null;
            odsGrid.SelectParameters["EmployeeID"].DefaultValue = null;
            odsGrid.SelectParameters["QAMonitoringFormID"].DefaultValue = null;
        }

        protected void ddlOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            if (Page.Cookies.UserOrgID == 194)
                odsEmployee.SelectParameters["OrganizationID1"].DefaultValue = ddlOrganization.SelectedRow.Cells[1].Value.ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Button1.Click+=new EventHandler(Button1_Click); 
        }
    }
}