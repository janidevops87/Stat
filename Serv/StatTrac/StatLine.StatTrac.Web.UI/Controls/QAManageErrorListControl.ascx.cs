using System;
using System.Web.UI;
using Infragistics.WebUI.WebCombo;
using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Person;
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.UI.Controls
{

    public partial class QAErrorListControl : BaseUserControlSecure
    {
        protected Statline.StatTrac.Data.Types.QAUpdateData dsQAUpdateData;
        protected void Page_Load(object sender, EventArgs e)
        {
            odsOrgs.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            
            if (!this.IsPostBack)
            {
                odsForms.SelectParameters["OrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
                int OrgID = new int();
                int QMFID = new int();
                if (ddlOrganization.SelectedRow != null)
                {
                    OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
                }
                else
                {
                    OrgID = Page.Cookies.UserOrgID;
                }
                Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
                QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, OrgID, QMFID, Convert.ToInt16(cbxDisplayAll.Checked));
                gridErrorLists.DataBind();
            }
            if (!SecurityChecker.CheckAccessToRule(AuthRule.QAViewOtherOrgs))
            {
                //btnAdd.Visible = false;
                ddlOrganization.Visible = false;
                lblOrganization.Visible = false;
            }
        }

        protected void gridErrorLists_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            gridErrorLists.Columns.Band.BaseTableName = "GridManageErrorLists";
            gridErrorLists.Rows.Band.BaseTableName = "GridManageErrorLists";
            gridErrorLists.Rows.Band.Key = "GridManageErrorLists";
        }

        protected void ddlOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            int QMFID = new int();
            int OrgID = new int();
            if (ddlQMF.SelectedRow != null)
            {
                QMFID = Convert.ToInt32(ddlQMF.SelectedRow.Cells[0].Value);
            }
            if (ddlOrganization.SelectedRow != null)
            {
                OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }
            else
            {
                OrgID = Page.Cookies.UserOrgID;
            }
            ddlQMF.DisplayValue = null;
            odsForms.SelectParameters["OrgID"].DefaultValue = OrgID.ToString();
            QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, OrgID, QMFID, Convert.ToInt16(cbxDisplayAll.Checked));
            gridErrorLists.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            QueryStringManager.Redirect(PageName.QAAddEditErrorType);
        }

        protected void ddlOrganization_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlOrganization.Columns[ddlOrganization.Columns.IndexOf("OrganizationID")].Hidden = true;
        }

        protected void ddlQMF_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlQMF.DropDownLayout.BaseTableName = "DdlQAForms";
            ddlQMF.Columns[ddlQMF.Columns.IndexOf("QAMonitoringFormID")].Hidden = true;
            ddlQMF.Columns[ddlQMF.Columns.IndexOf("TrackingDesc")].Hidden = true;
            
        }

        protected void ddlQMF_SelectedRowChanged(object sender, SelectedRowChangedEventArgs e)
        {
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            int QMFID = new int();
            int OrgID = new int();
            if (ddlQMF.SelectedRow != null)
            {
                QMFID = Convert.ToInt32(ddlQMF.SelectedRow.Cells[0].Value);
            }
            if (ddlOrganization.SelectedRow != null)
            {
                OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }
            else
            {
                OrgID = Page.Cookies.UserOrgID;
            }
            QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, OrgID, QMFID, Convert.ToInt16(cbxDisplayAll.Checked));
            gridErrorLists.DataBind();
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            int QMFID = new int();
            int OrgID = new int();
            if (ddlQMF.SelectedRow != null)
            {
                QMFID = Convert.ToInt32(ddlQMF.SelectedRow.Cells[0].Value);
            }
            if (ddlOrganization.SelectedRow != null)
            {
                OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }
            else
            {
                OrgID = Page.Cookies.UserOrgID;
            }
            QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, OrgID, QMFID, Convert.ToInt16(cbxDisplayAll.Checked));
            gridErrorLists.DataBind();
        }

        protected void ddlOrganization_PreRender(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                ddlOrganization.DisplayValue = Page.Cookies.UserOrganizationName;
            }
        }

        protected void gridErrorLists_UpdateRowBatch(object sender, RowEventArgs e)
        {
            int qmfID = 0;
            if (ddlQMF.SelectedRow != null)
            {
                qmfID = Convert.ToInt32(ddlQMF.SelectedRow.Cells[0].Value);
            }
            else
            {
                qmfID = Convert.ToInt32(gridErrorLists.Rows[e.Row.Index].Cells[4].Value);
            }

            QAUpdateData dsQAUpdateData = new QAUpdateData();
            QAUpdateData.QAMonitoringFormTemplateRow row;
            row = dsQAUpdateData.QAMonitoringFormTemplate.NewQAMonitoringFormTemplateRow();
            

                QAUpdateManager.FillQAMonitoringFormTemplate(dsQAUpdateData, qmfID);
                row = dsQAUpdateData.QAMonitoringFormTemplate.FindByQAMonitoringFormTemplateID(
                    (int)e.Row.Cells[gridErrorLists.Columns.IndexOf("QAMonitoringFormTemplateID")].Value);
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;
            

            foreach (UltraGridCell cell in e.Row.Cells)
            {

                // update each data row with the grid row values 
                if (cell.Key == "QAErrorTypeID")
                    continue;
                if (cell.Value != null)
                {//its in the grid, but don't update
                    if (cell.Column.BaseColumnName == "QAMonitoringFormTemplateOrder") row[cell.Column.BaseColumnName] = cell.Value;
                }
                else
                {
                    row[cell.Column.BaseColumnName] = DBNull.Value;
                }
            }
            if (e.Row.DataChanged == DataChanged.Added)
            {
                // if the row is a new row, add the row to the dataset
                dsQAUpdateData.QAMonitoringFormTemplate.AddQAMonitoringFormTemplateRow(row);
            }
            
            try
            {
                QAUpdateDB.UpdateQAMonitoringFormTemplate(dsQAUpdateData);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            QueryStringManager.Redirect(PageName.QAManageErrorList);
        }
    }
}