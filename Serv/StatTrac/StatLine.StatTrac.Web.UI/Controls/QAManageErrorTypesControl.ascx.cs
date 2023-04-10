using System;
using System.Web.UI;
using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAManageErrorTypes : BaseUserControlSecure
    {
        protected Statline.StatTrac.Data.Types.QAUpdateData dsQAUpdateData;
        protected void Page_Load(object sender, EventArgs e)
        {
            odsOrgs.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            
            if (!this.IsPostBack)
            {
                odsTrackingType.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
                int OrgID = new int();
                if (ddlOrganization.SelectedRow != null)
                {
                    OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
                }
                else
                {
                    OrgID = Page.Cookies.UserOrgID;
                }
                QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, OrgID, Convert.ToInt16(cbxDisplayAll.Checked), Convert.ToInt32(null));
                gridManageErrorTypes.DataBind();
            }
            if (!SecurityChecker.CheckAccessToRule(AuthRule.QAViewOtherOrgs))
            {
                ddlOrganization.Visible = false;
                lblOrganization.Visible = false;
            }
        }

        protected void gridManageErrorTypes_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            gridManageErrorTypes.Columns.Band.BaseTableName = "GridManageErrorLists";
            gridManageErrorTypes.Rows.Band.BaseTableName = "GridManageErrorLists";
            gridManageErrorTypes.Rows.Band.Key = "GridManageErrorLists";
        }
        protected void ddlOrganization_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlOrganization.Columns[ddlOrganization.Columns.IndexOf("OrganizationID")].Hidden = true;
        }

        protected void ddlTrackingType_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlTrackingType.DropDownLayout.BaseTableName = "QATrackingType";
            ddlTrackingType.Columns[ddlTrackingType.Columns.IndexOf("QATrackingTypeID")].Hidden = true;
        }

        protected void ddlTrackingType_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            int OrgID;
            if (ddlOrganization.SelectedRow != null)
            {
                OrgID = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value);
            }
            else
            {
                OrgID = Page.Cookies.UserOrgID;
            }
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, OrgID, Convert.ToInt16(cbxDisplayAll.Checked),Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value));
            gridManageErrorTypes.DataBind();
        }

        protected void ddlOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            int qaTrackingTypeID;
            if (ddlTrackingType.SelectedRow != null)
            {
                qaTrackingTypeID = Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaTrackingTypeID = Convert.ToInt32(null);
            }
            ddlTrackingType.DisplayValue = null;
            odsTrackingType.SelectParameters["OrganizationID"].DefaultValue = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value).ToString();
            this.dsQAUpdateData = new Statline.StatTrac.Data.Types.QAUpdateData();
            QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value), Convert.ToInt16(cbxDisplayAll.Checked), qaTrackingTypeID);
            gridManageErrorTypes.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            QueryStringManager.Redirect(PageName.QAAddEditErrorType);
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
                OrgID = Page.Cookies.UserOrgID;
            }
            int qaTrackingTypeID;
            if (ddlTrackingType.SelectedRow != null)
            {
                qaTrackingTypeID = Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaTrackingTypeID = Convert.ToInt32(null);
            }
            QAUpdateManager.FillQAGridManageErrorLists(dsQAUpdateData, OrgID, Convert.ToInt16(cbxDisplayAll.Checked), qaTrackingTypeID);
            gridManageErrorTypes.DataBind();

        }

        protected void ddlOrganization_PreRender(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                ddlOrganization.DisplayValue = Page.Cookies.UserOrganizationName;
            }
        }
    }
}