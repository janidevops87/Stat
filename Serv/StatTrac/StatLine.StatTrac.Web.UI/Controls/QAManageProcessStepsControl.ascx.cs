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
    public partial class QAManageProcessSteps : BaseUserControlSecure
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
                Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
                QAUpdateManager.FillQAProcessStep(dsQAUpdateData, OrgID, Convert.ToInt16(cbxDisplayAll.Checked));
                gridProcessSteps.DataBind();
            } 
            if (!SecurityChecker.CheckAccessToRule(AuthRule.QAViewOtherOrgs))
            {
                ddlOrganization.Visible = false;
                lblOrganization.Visible = false;
            }
        }

        protected void ddlOrganization_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlOrganization.Columns[ddlOrganization.Columns.IndexOf("OrganizationID")].Hidden = true;
        }
        protected void ddlOrganization_SelectedRowChanged(object sender, SelectedRowChangedEventArgs e)
        {
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            QAUpdateManager.FillQAProcessStep(dsQAUpdateData, Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value), Convert.ToInt16(cbxDisplayAll.Checked));
            gridProcessSteps.DataBind();
        }

        protected void gridProcessSteps_InitializeLayout(object sender, LayoutEventArgs e)
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
            Response.Redirect("~/QAManageProcessSteps.aspx?OrgID=" + orgID + "&OrgName=" + ddlOrganization.DisplayValue);
        }

        protected void gridProcessSteps_InitializeDataSource(object sender, UltraGridEventArgs e)
        {
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

            QAUpdateManager.FillQAProcessStep(dsQAUpdateData, OrgID, Convert.ToInt16(cbxDisplayAll.Checked));
            gridProcessSteps.DataBind();
        }

        protected void gridProcessSteps_UpdateRowBatch(object sender, RowEventArgs e)
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
            if (String.IsNullOrEmpty(gridProcessSteps.Rows[e.Row.Index].Cells[1].Text))
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "You must enter a description");
                return;
            }
            
            QAUpdateData.QAProcessStepRow row;
            row = dsQAUpdateData.QAProcessStep.NewQAProcessStepRow();
            if (e.Row.DataChanged == DataChanged.Added)
            {
                // if it's a new row, create a new dataset row
                row = dsQAUpdateData.QAProcessStep.NewQAProcessStepRow();
                row["OrganizationID"] = orgID;
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
            }
            else
            {

                QAUpdateManager.FillQAProcessStep(dsQAUpdateData, orgID, Convert.ToInt16(cbxDisplayAll.Checked));
                // else get a reference to the existing row in the dataset
                string test = gridProcessSteps.Rows[e.Row.Index].Cells[0].Text;
                row = dsQAUpdateData.QAProcessStep.FindByQAProcessStepID(
                (int)e.Row.Cells[gridProcessSteps.Columns.IndexOf("QAProcessStepID")].Value);             
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;
            }

            foreach (UltraGridCell cell in e.Row.Cells)
            {

                // update each data row with the grid row values 
                if (cell.Key == "QAProcessStepID")
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
                row["QAProcessStepActive"] = 1;
                // if the row is a new row, add the row to the dataset
                dsQAUpdateData.QAProcessStep.AddQAProcessStepRow(row);
            }
            
            try
            {
                QAUpdateDB.UpdateQAProcessStep(dsQAUpdateData);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
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
    }
}