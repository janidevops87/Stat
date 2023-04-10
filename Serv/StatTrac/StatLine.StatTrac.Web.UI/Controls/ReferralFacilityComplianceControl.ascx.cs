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
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Referral;
using Infragistics.WebUI.UltraWebGrid;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class ReferralFacilityComplianceControl : BaseUserControlSecure
    {
        protected Statline.StatTrac.Data.Types.ReferralData dsReferralData;

        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime dtStartDate;
            
            ajaxPanelOrganizationSource.AddRefreshTarget(gridReferralFacilityList);
            if (!this.IsPostBack)
            {
                odsReportGroup.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                dtStartDate = System.DateTime.Today.AddDays(- (System.DateTime.Today.Day -1));
                startDateTime.Value = dtStartDate.ToString();
            }
            
        }

        
        protected void ddlReportGroup_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            reportGroupRowSet();
        }

        private void reportGroupRowSet()
        {
            btnSearch.Enabled = true;
            ddlRefFacility.Rows.Clear();
            ddlSourceCode.Rows.Clear();
            odsOrganization.SelectParameters["ReportGroupID"].DefaultValue = ddlReportGroup.SelectedRow.Cells[1].Value.ToString();
            odsSourceCode.SelectParameters["ReportGroupID"].DefaultValue = ddlReportGroup.SelectedRow.Cells[1].Value.ToString();
            ddlSourceCodeHideColumns();
        }

        protected void odsSourceCode_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
          if ( odsSourceCode.SelectParameters["reportGroupID"].DefaultValue == "0")
           e.Cancel = true;
        }
        private void ddlSourceCodeHideColumns()
        {
            ddlSourceCode.DropDownLayout.BaseTableName = "SourceCodeNameList";
            ddlSourceCode.Columns[ddlSourceCode.Columns.IndexOf("SourceCodeID")].Hidden = true;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            
            if (ddlReportGroup.SelectedRow != null)
            {
                //odsReferralFacilityCompliance.SelectParameters["ReferralStartDateTime"].DefaultValue = startDateTime.Text;
                //odsReferralFacilityCompliance.SelectParameters["ReferralEndDateTime"].DefaultValue = Convert.ToDateTime(startDateTime.Text).AddMonths(1).AddSeconds(-1).ToString();

                //odsReferralFacilityCompliance.SelectParameters["ReportGroupID"].DefaultValue = ddlReportGroup.SelectedRow.Cells[ddlReportGroup.Columns.IndexOf("WebReportGroupID")].Value.ToString();

                //if (ddlRefFacility.SelectedRow != null)
                //    odsReferralFacilityCompliance.SelectParameters["OrganizationID"].DefaultValue = ddlRefFacility.SelectedRow.Cells[ddlRefFacility.Columns.IndexOf("OrganizationID")].Value.ToString();
                //else
                //    odsReferralFacilityCompliance.SelectParameters["OrganizationID"].DefaultValue = ConstHelper.DEFAULTDROPDOWNVALUE.ToString();

                //if (ddlSourceCode.SelectedRow != null)
                //    odsReferralFacilityCompliance.SelectParameters["SourceCodeName"].DefaultValue = ddlSourceCode.SelectedCell.Value.ToString();
                //else  odsReferralFacilityCompliance.SelectParameters["SourceCodeName"].DefaultValue = "";
                int orgID;
                int displayMT;
                string sourceCodeName;
                if (ddlRefFacility.SelectedRow != null)
                    orgID = Convert.ToInt32(ddlRefFacility.SelectedRow.Cells[ddlRefFacility.Columns.IndexOf("OrganizationID")].Value.ToString());
                else
                    orgID = ConstHelper.DEFAULTDROPDOWNVALUE;

                if (ddlSourceCode.SelectedRow != null)
                    sourceCodeName = ddlSourceCode.SelectedCell.Value.ToString();
                else sourceCodeName = null;
                int userOrgID = Page.Cookies.UserOrgID;
                if (userOrgID == 194)
                {
                   displayMT = 1;
                }
                else
                {
                   displayMT = 0;
                }

                ReferralManager.FillReferralFacilityCompliance(dsReferralData, Convert.ToDateTime(startDateTime.Text), Convert.ToDateTime(startDateTime.Text).AddMonths(1).AddSeconds(-1), Convert.ToInt32(ddlReportGroup.SelectedRow.Cells[ddlReportGroup.Columns.IndexOf("WebReportGroupID")].Value.ToString()), orgID, sourceCodeName, displayMT);
                gridReferralFacilityList.DataBind();
            }
        }

        //protected void odsReferralFacilityCompliance_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        //{
        //    if (odsReferralFacilityCompliance.SelectParameters["reportGroupID"].DefaultValue == "0")
        //        e.Cancel = true;
        //}

        protected void ddlReportGroup_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
           ddlReportGroup.Columns[ddlReportGroup.Columns.IndexOf("WebReportGroupID")].Hidden = true;

        }

        protected void gridReferralFacilityList_UpdateRow(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
        {
            ReferralData ds = new ReferralData();
            DateTime dt = Convert.ToDateTime(startDateTime.Text);
            if (e.Row.Cells[e.Row.Band.Columns.IndexOf("ClientReportedDeaths")].Value != null)
            {
                ds.UpdateOrganizationDeaths.AddUpdateOrganizationDeathsRow(
                  dt.Year.ToString(),
                  dt.Month.ToString(),
                  e.Row.Cells[e.Row.Band.Columns.IndexOf("OrganizationID")].Value.ToString(),
                  e.Row.Cells[e.Row.Band.Columns.IndexOf("SourceCodeList")].Value.ToString(),
                  e.Row.Cells[e.Row.Band.Columns.IndexOf("ClientReportedDeaths")].Value.ToString());
            }
            else
            {
                ds.UpdateOrganizationDeaths.AddUpdateOrganizationDeathsRow(
                  dt.Year.ToString(),
                  dt.Month.ToString(),
                  e.Row.Cells[e.Row.Band.Columns.IndexOf("OrganizationID")].Value.ToString(),
                  e.Row.Cells[e.Row.Band.Columns.IndexOf("SourceCodeList")].Value.ToString(),
                  "0"); //null); //e.Row.Cells[e.Row.Band.Columns.IndexOf("ClientReportedDeaths")].Value.ToString());
            }
            try
            {
                ReferralManager.UpdateOrganizationDeaths(ds);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }

        }

        protected void ddlRefFacility_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlRefFacility.DropDownLayout.BaseTableName = "OrganizationList";
            ddlRefFacility.Columns[ddlRefFacility.Columns.IndexOf("OrganizationID")].Hidden = true;
        }
        protected void ddlSourceCode_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlSourceCodeHideColumns();
        }

        protected void odsReferralFacilityCompliance_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }

        }

        protected void odsReportGroup_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }

           
        }

        protected void odsOrganization_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsSourceCode_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }
        private void InitializeComponent()
        {
            this.dsReferralData = new Statline.StatTrac.Data.Types.ReferralData();
            ((System.ComponentModel.ISupportInitialize)(this.dsReferralData)).BeginInit();
            // 
            // dsReportReferenceData
            // 
            this.dsReferralData.DataSetName = "ReferralData";
            this.dsReferralData.Locale = new System.Globalization.CultureInfo("en-US");
            ((System.ComponentModel.ISupportInitialize)(this.dsReferralData)).EndInit();

        }
        override protected void OnInit(EventArgs e)
        {
            //
            // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            //
            InitializeComponent();
            base.OnInit(e);
        }

        protected void ddlReportGroup_DataBound(object sender, EventArgs e)
        {
            String allReferrals;

            if (Page.Cookies.UserOrgID.Equals(194))
            {
                allReferrals = Statline.Configuration.ApplicationSettings.GetSetting(Statline.Configuration.SettingName.StatlineAllReferrals);
                object[] rowObject = { allReferrals, 37 };
                UltraGridRow statlineRow = new UltraGridRow(rowObject);
                ddlReportGroup.Rows.Add(statlineRow);
            }
            else
            {
                allReferrals = "All Referrals";
            }
            UltraGridCell allReferralCell = ddlReportGroup.FindByText(allReferrals);

            if (allReferralCell != null && !this.IsPostBack)
            {
                ddlReportGroup.SelectedRow = allReferralCell.Row;
                reportGroupRowSet();
            }
        }

        protected void gridReferralFacilityList_UpdateCell(object sender, CellEventArgs e)
        {

        }

             
    }
}