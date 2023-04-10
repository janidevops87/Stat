using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Person;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAManageQualityMonitoringForms : BaseUserControlSecure
    {
        protected Statline.StatTrac.Data.Types.QAUpdateData dsQAUpdateData;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            odsOrgs.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            if (!this.IsPostBack)
            {
                this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
                int OrgID = new int();
                if (ddlOrganization.SelectedRow != null)
                {
                    OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
                }
                else
                {
                    if (!String.IsNullOrEmpty(Request.QueryString["OrgID"]))
                        OrgID = Convert.ToInt32(Request.QueryString["OrgID"]);
                    else
                    {
                        OrgID = Page.Cookies.UserOrgID;
                    }
                }
                QAUpdateManager.FillQAGridManageQualityMonitoringForm(dsQAUpdateData, OrgID, Convert.ToInt16(cbxDisplayAll.Checked));
                gridQAMonitoringForms.DataSource = dsQAUpdateData;
                gridQAMonitoringForms.DataMember = "GridManageQualityMonitoringForms";
                gridQAMonitoringForms.DataBind();
                Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
            }
            if (!SecurityChecker.CheckAccessToRule(AuthRule.QAViewOtherOrgs))
            {
                ddlOrganization.Visible = false;
                lblOrganization.Visible = false;
            }
        }

        protected void gridQAMonitoringForms_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int orgID = new int();
            if (ddlOrganization.SelectedRow != null)
            {
                orgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }
            else
            {
                if (!String.IsNullOrEmpty(Request.QueryString["OrgID"]))
                    orgID = Convert.ToInt32(Request.QueryString["OrgID"]);
                else
                {
                    orgID = Page.Cookies.UserOrgID;
                }
            }
            Response.Redirect("~/QAManageQualityMonitoringForms.aspx?OrgID=" + orgID + "&OrgName=" + ddlOrganization.DisplayValue);
        }

        protected void ddlOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            QAUpdateManager.FillQAGridManageQualityMonitoringForm(dsQAUpdateData, Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value), Convert.ToInt16(cbxDisplayAll.Checked));
            gridQAMonitoringForms.DataSource = dsQAUpdateData;
            gridQAMonitoringForms.DataMember = "GridManageQualityMonitoringForms";
            gridQAMonitoringForms.DataBind();
        }

        protected void ddlOrganization_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlOrganization.Columns[ddlOrganization.Columns.IndexOf("OrganizationID")].Hidden = true;
        }

        protected void gridQAMonitoringForms_UpdateRowBatch(object sender, RowEventArgs e)
        {
            int orgID = 0;
            if (ddlOrganization.SelectedRow != null)
            {
                orgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }
            else
            {
                if (!String.IsNullOrEmpty(Request.QueryString["OrgID"]))
                    orgID = Convert.ToInt32(Request.QueryString["OrgID"]);
                else
                {
                    orgID = Page.Cookies.UserOrgID;
                }
            }

            QAUpdateData dsQAUpdateData = new QAUpdateData();
            QAUpdateData.QAMonitoringFormRow row;
            row = dsQAUpdateData.QAMonitoringForm.NewQAMonitoringFormRow();
            //this is code to prevent add when add button is clicked...the tracking type drop down is causing the updaterowbatch to fire
            if (String.IsNullOrEmpty(gridQAMonitoringForms.Rows[e.Row.Index].Cells[0].Text))
            {
                row = dsQAUpdateData.QAMonitoringForm.NewQAMonitoringFormRow();
                //row["QATrackingTypeID"] = 1; don't default this any longer 12/12/12...when used by outside orgs
                row["OrganizationID"] = orgID;
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
                dsQAUpdateData.QAMonitoringForm.AddQAMonitoringFormRow(row);
            }
            else
            {
               QAUpdateManager.FillQAMonitoringForm(dsQAUpdateData, orgID, Convert.ToInt16(cbxDisplayAll.Checked));
               row = dsQAUpdateData.QAMonitoringForm.FindByQAMonitoringFormID(
                   (int)e.Row.Cells[gridQAMonitoringForms.Columns.IndexOf("QAMonitoringFormID")].Value);
               row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
               row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;
            }
            foreach (UltraGridCell cell in e.Row.Cells)
            {

                // update each data row with the grid row values 
                if (cell.Key == "QAMonitoringFormID")
                    continue;
                
                if (cell.DataChanged)
                {//its in the grid, but don't update
                    if (cell.Column.BaseColumnName != "QATrackingTypeDescription" && cell.Column.BaseColumnName != "ImageName" && cell.Column.BaseColumnName != "QATrackingTypeID" && cell.Column.BaseColumnName != "QAMonitoringFormActive") row[cell.Column.BaseColumnName] = cell.Value;
                }
                if (String.IsNullOrEmpty(gridQAMonitoringForms.Rows[e.Row.Index].Cells[0].Text) && cell.Column.BaseColumnName == "QAMonitoringFormActive")
                {
                    row[cell.Column.BaseColumnName] = 1;
                }
                else
                {
                    if (cell.Column.BaseColumnName == "QAMonitoringFormActive") 
                        row[cell.Column.BaseColumnName] = cell.Value;
                }
            }
            
            try
            {
                QAUpdateDB.UpdateQAMonitoringForm(dsQAUpdateData);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
            //add template if not found
            QAUpdateManager.FillQAMonitoringForm(dsQAUpdateData,orgID, 1);
            int qmfid = Convert.ToInt32(dsQAUpdateData.QAMonitoringForm.Compute("Max(QAMonitoringFormID)", ""));
            QAUpdateManager.FillQAMonitoringFormTemplate(dsQAUpdateData, qmfid);
            if (dsQAUpdateData.QAMonitoringFormTemplate.Count == 0)
            {
                QAUpdateData.QAMonitoringFormTemplateRow row1;
                row1 = dsQAUpdateData.QAMonitoringFormTemplate.NewQAMonitoringFormTemplateRow();
                row1["QAMonitoringFormID"] = qmfid;
                row1["QAMonitoringFormTemplateActive"] = 1;//active
                row1["QAErrorTypeID"] = 3;//add default error type, since table requires the field...this is "default error type" and is inactive
                row1["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row1["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
                dsQAUpdateData.QAMonitoringFormTemplate.AddQAMonitoringFormTemplateRow(row1);
                try
                {
                    QAUpdateDB.UpdateQAMonitoringFormTemplate(dsQAUpdateData);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                }
            }
        }

        protected void cbxDisplayAll_CheckedChanged(object sender, EventArgs e)
        {
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            int OrgID = new int();
            if (ddlOrganization.SelectedRow != null)
            {
                OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }
            else
            {
                if (!String.IsNullOrEmpty(Request.QueryString["OrgID"]))
                    OrgID = Convert.ToInt32(Request.QueryString["OrgID"]);
                else
                {
                    OrgID = Page.Cookies.UserOrgID;
                }
            }
            QAUpdateManager.FillQAGridManageQualityMonitoringForm(dsQAUpdateData, OrgID, Convert.ToInt16(cbxDisplayAll.Checked));
            gridQAMonitoringForms.DataSource = dsQAUpdateData;
            gridQAMonitoringForms.DataMember = "GridManageQualityMonitoringForms";
            gridQAMonitoringForms.DataBind();
        }
        protected void GetTrackingType(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            dropdownlist.DataSourceID = "odsTrackingTypes";
            //if statline then use org id value selected from dropdown, if outside org, use cookie since they don't see dropdown
            if (ddlOrganization.SelectedRow == null)
              odsTrackingTypes.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            else
              odsTrackingTypes.SelectParameters["OrganizationID"].DefaultValue = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value).ToString();
        }

        protected void PopulateDropDown(object sender, EventArgs e)
        {
            int i = gridQAMonitoringForms.Rows.Count;
            DropDownList dropdownlist = (DropDownList)sender;
            try
            {
                dropdownlist.Items.Remove(dropdownlist.Items.FindByText(gridQAMonitoringForms.Rows[i - 1].Cells[3].Text));
            }
            catch
            {
            }
            dropdownlist.Items.Insert(0, new ListItem(gridQAMonitoringForms.Rows[i - 1].Cells[3].Text, gridQAMonitoringForms.Rows[i - 1].Cells[7].Text));
        }

        protected void odsTrackingTypes_Selected1(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void Status_Changed(object sender, EventArgs e)
        {
            if (dsQAUpdateData == null) dsQAUpdateData = new QAUpdateData();
            DropDownList dropdownlist = (DropDownList)sender;
            CellItem ci = (CellItem)dropdownlist.Parent;
            int rownumber = ci.Cell.Row.Index;
            QAUpdateManager.FillQAMonitoringForm(dsQAUpdateData, Convert.ToInt32(gridQAMonitoringForms.Rows[rownumber].Cells[0].Text));
            dsQAUpdateData.QAMonitoringForm[0].QATrackingTypeID = Convert.ToInt32(dropdownlist.SelectedItem.Value);
            dsQAUpdateData.QAMonitoringForm[0].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
            dsQAUpdateData.QAMonitoringForm[0].AuditLogTypeID = 3;
            QAUpdateDB.UpdateQAMonitoringForm(dsQAUpdateData);
        }

        protected void ddlOrganization_PreRender(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["OrgName"]))
                    ddlOrganization.DisplayValue = Request.QueryString["OrgName"];
                else
                {
                    ddlOrganization.DisplayValue = Page.Cookies.UserOrganizationName;
                }
            }
        }

        protected void gridQAMonitoringForms_DataBound(object sender, EventArgs e)
        {
            int loop1 = gridQAMonitoringForms.Rows.Count;
            for (int loop = 0; loop < loop1; loop++)
            {
                if (String.IsNullOrEmpty(gridQAMonitoringForms.Rows[loop].Cells[1].Text))
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "You must enter a description");
                }
                if (String.IsNullOrEmpty(gridQAMonitoringForms.Rows[loop].Cells[3].Text))
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "You must have a tracking type");
                }
            }
        }
    }
}