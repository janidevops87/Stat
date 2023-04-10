using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.UI;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CustomParamsFSSummaryControl : Statline.StatTrac.Web.UI.BaseUserControl, Statline.StatTrac.Web.UI.IBaseParameters
    {
        string appoacherList = "";
        protected ReportReferenceData dsReportReferenceData = new ReportReferenceData();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Visible || IsPostBack)
                return;

            DataBind();
            
        }
        public override void DataBind()
        {
            ddlAppoacherOrganization_DataBind();            
        }
        protected void ddlAppoacherOrganization_DataBind()
        {
            Statline.StatTrac.Web.UI.WebControls.DropDownReportGroup localddlReportGroup = (Statline.StatTrac.Web.UI.WebControls.DropDownReportGroup)Parent.FindControl("ddlReportGroup");
            if (localddlReportGroup != null)
                odsApproacherOrganization.SelectParameters["reportGroupID"].DefaultValue = Convert.ToString(localddlReportGroup.SelectedValue.ToString());

        }
        protected void gridApproachPerson_DataBind()
        {
            if (dsReportReferenceData.ApproachPersonList.Count > 0)
                return;
            int organizationId = 0;

            if (ddlApproacherOrganization.SelectedRow != null)
                organizationId = Convert.ToInt32(ddlApproacherOrganization.SelectedRow.Cells[1].Value);
            else
                organizationId = Page.Cookies.UserOrgID;
            try
            {
                Statline.StatTrac.Report.ReportReferenceManager.FillFSConversionRateApproachPerson(dsReportReferenceData, organizationId);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
            gridApproachPerson.DataBind();

        }
        #region IBaseParameters Members

        public void BuildParams(Hashtable parameters)
        {
            if (ddlApproacherOrganization.SelectedRow != null)
                parameters.Add(ReportParams.ApproacherOrganization, ddlApproacherOrganization.SelectedRow.Cells.FromKey("OrganizationID").Value);
            else
                parameters.Add(ReportParams.ApproacherOrganization, Page.Cookies.UserOrgID);

            if(ddlPersonType.SelectedRow != null)
                parameters.Add(ReportParams.ApproahcerTitle, ddlPersonType.SelectedRow.Cells.FromKey("PersonTypeID").Value);
            
            if (appoacherList.Length > 0)
                parameters.Add(ReportParams.ApproacherData, appoacherList);
       
                parameters.Add(ReportParams.DisplayTotalConsentRate, radioButtonListConsentRate.Items.FindByText("Display Total Consent Rate").Value);
        }

        #endregion


         protected void gridApproachPerson_UpdateRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
        {
            if(Convert.ToBoolean(e.Row.Cells.FromKey("Checked").Value) == true)
            {
                if (appoacherList.Length > 0)
                    appoacherList = appoacherList + ",";
                appoacherList = appoacherList + e.Row.Cells.FromKey("PersonID").Value.ToString();
            }

        }

        protected void gridApproachPerson_InitializeDataSource(object sender, Infragistics.WebUI.UltraWebGrid.UltraGridEventArgs e)
        {
            if(Visible)
                gridApproachPerson_DataBind();
        }

        protected void odsPersonType_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            ddlPersonType.Columns.FromKey("PersonTypeId").Hidden = true;
            ddlPersonType.DropDownLayout.BaseTableName = "PersonType";
            ddlPersonType.DataValue = 0;
            ddlPersonType.DisplayValue = "...";

        }

        protected void odsApproacherOrganization_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            ddlApproacherOrganization.Columns.FromKey("OrganizationID").Hidden = true;
            ddlApproacherOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlApproacherOrganization.DisplayValue = "Default Organization: " + Page.Cookies.UserOrganizationName;

        }

        protected void ddlApproacherOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            dsReportReferenceData.ApproachPersonList.Clear();
            gridApproachPerson_DataBind();

        }

        protected void odsPersonType_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

        protected void odsApproacherOrganization_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (!Visible)
                e.Cancel = true;
        }

         
    }
}