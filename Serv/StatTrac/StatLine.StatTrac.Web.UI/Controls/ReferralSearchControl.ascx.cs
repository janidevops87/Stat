using System;
using System.Web.UI.WebControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Referral;
using Statline.StatTrac.Person;
using Infragistics.WebUI.UltraWebGrid;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class ReferralSearchControl : BaseUserControlSecure
    {
        int numRefCount;
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime dtStartDate;
            DateTime dtEndDate;
            if (!this.IsPostBack)
            {
                Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
                odsWebReportGroup.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                dtStartDate = System.DateTime.Today.AddDays(-1);
                startDateTime.Value = dtStartDate.ToString(ConstHelper.MILITARYDATETIME);
                dtEndDate = System.DateTime.Today.AddMinutes(-1);
                endDateTime.Value = dtEndDate.ToString(ConstHelper.MILITARYDATETIME);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                if (ddlReportGroup.SelectedRow != null)
                {
                    odsRefList.SelectParameters["ReportGroupID"].DefaultValue = ddlReportGroup.SelectedRow.Cells[1].Value.ToString();
                    Page.Cookies.ReportGroupID = Convert.ToInt32(ddlReportGroup.SelectedRow.Cells[1].Value);
                }
                else
                {
                    odsRefList.SelectParameters["ReportGroupID"].DefaultValue = Page.Cookies.ReportGroupID.ToString();
                }
                if (ddlRefFacility.SelectedRow != null)
                {
                    odsRefList.SelectParameters["OrganizationID"].DefaultValue = ddlRefFacility.SelectedRow.Cells[1].Value.ToString();
                }
                else
                {
                    odsRefList.SelectParameters["OrganizationID"].DefaultValue = "0";
                }
                if (ddlSpecCriteria.SelectedRow != null)
                {
                    odsRefList.SelectParameters["SpecialSearchCriteria"].DefaultValue = ddlSpecCriteria.SelectedRow.Cells[1].Value.ToString();
                }
                else
                {
                    odsRefList.SelectParameters["SpecialSearchCriteria"].DefaultValue = "1";
                }
                if (ddlBasedOnDT.SelectedRow != null)
                {
                    odsRefList.SelectParameters["BasedOnDT"].DefaultValue = ddlBasedOnDT.SelectedRow.Cells[0].Value.ToString();
                }
                else
                {
                    odsRefList.SelectParameters["BasedOnDT"].DefaultValue = "Referral";
                }
                odsRefList.SelectParameters["timeZone"].DefaultValue = Page.Cookies.TimeZone;
            }
        }
                              
        protected void ddlReportGroup_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            //btnSearch.Enabled = true;
            ddlRefFacility.DisplayValue = "";
            if (ddlReportGroup.SelectedRow != null)
            {
                //odsRefList.SelectParameters["ReportGroupID"].DefaultValue = ddlReportGroup.SelectedRow.Cells[1].Value.ToString();
                odsRefFacility.SelectParameters["ReportGroupID"].DefaultValue = ddlReportGroup.SelectedRow.Cells[1].Value.ToString();
                Page.Cookies.ReportGroupID = Convert.ToInt32(ddlReportGroup.SelectedRow.Cells[1].Value);
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

        protected void odsRefFacility_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsRefList_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }

        }

        public bool IsValid()
        {
            //Validations here
            bool returnValue = true;
            if (!string.IsNullOrEmpty(txtCallNumber.Text))
            {
                try
                {
                    int test = Convert.ToInt32(txtCallNumber.Text);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "You can't enter anythng but a number for the call number");
                    return false;
                }
            }
            //if Convert.ToInt32(txtCallNumber.Text)
            if (ddlRefFacility.SelectedRow == null && ddlSpecCriteria.SelectedRow == null && string.IsNullOrEmpty(txtPatientLastName.Text) &&
                string.IsNullOrEmpty(txtPatientFirstName.Text))
            {
                TimeSpan ts;
                ts = Convert.ToDateTime(endDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
                if (ts.TotalDays > 7)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "Date range can not be longer than one week, with no other search criteria");
                    return false;
                }
            }
            if (ddlRefFacility.SelectedRow != null || ddlSpecCriteria.SelectedRow != null || !string.IsNullOrEmpty(txtPatientLastName.Text) ||
                !string.IsNullOrEmpty(txtPatientFirstName.Text))
            {
                TimeSpan ts;
                ts = Convert.ToDateTime(endDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
                if (ts.TotalDays > 30)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "Date range can not be longer than 30 days, with no other search criteria");
                    return false;
                }
            }
            return returnValue;
        }

        

        protected void odsRefFacility_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (odsRefFacility.SelectParameters["ReportGroupID"].DefaultValue == "0")
                e.Cancel = true;
        }

        protected void odsRefList_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (odsRefList.SelectParameters["ReportGroupID"].DefaultValue == "0")
            {
                e.Cancel = true;
                return;
            }
            else
            {
               if (string.IsNullOrEmpty(ddlRefFacility.DisplayValue) && string.IsNullOrEmpty(ddlSpecCriteria.DisplayValue) && string.IsNullOrEmpty(txtPatientLastName.Text) &&
               string.IsNullOrEmpty(txtPatientFirstName.Text))
                {
                    TimeSpan ts;
                    ts = Convert.ToDateTime(endDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
                    if (ts.TotalDays > 7)
                    {
                        e.Cancel = true;
                        return;
                    }
                }
                if (!string.IsNullOrEmpty(ddlRefFacility.DisplayValue) || !string.IsNullOrEmpty(ddlRefFacility.DisplayValue) || !string.IsNullOrEmpty(txtPatientLastName.Text) ||
                    !string.IsNullOrEmpty(txtPatientFirstName.Text))
                {
                    TimeSpan ts;
                    ts = Convert.ToDateTime(endDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
                    if (ts.TotalDays > 30)
                    {
                        e.Cancel = true;
                        return;
                    }
                }
                int countSpecialSearchCriteria = 1;
                int countOrgID = 0;
                string countBasedOnDT = "Referral";
                string countFirstName = null;
                string countLastName = null;
                string countCallNumber = null;
                if (ddlRefFacility.SelectedRow != null)
                {
                    countOrgID = Convert.ToInt32(ddlRefFacility.SelectedRow.Cells[1].Value);
                }
                else
                {
                    countOrgID = 0;
                }
                if (ddlSpecCriteria.SelectedRow != null)
                {
                    countSpecialSearchCriteria = Convert.ToInt32(ddlSpecCriteria.SelectedRow.Cells[1].Value);
                }
                else
                {
                    countSpecialSearchCriteria = 1;
                }
                if (ddlBasedOnDT.SelectedRow != null)
                {
                    countBasedOnDT = ddlBasedOnDT.SelectedRow.Cells[0].Value.ToString();
                }
                else
                {
                    countBasedOnDT = "Referral";
                }
                if (!string.IsNullOrEmpty(txtCallNumber.Text))
                {
                    countCallNumber = txtCallNumber.Text;
                }
                if (!string.IsNullOrEmpty(txtPatientFirstName.Text))
                {
                    countFirstName = txtPatientFirstName.Text;
                }
                if (!string.IsNullOrEmpty(txtPatientLastName.Text))
                {
                    countLastName = txtPatientLastName.Text;
                }
                DisplayMessages.Clear();
                if (ddlReportGroup.SelectedRow != null)
                {
                    numRefCount = ReferralManager.FillReferralListCount(countCallNumber, countFirstName, countLastName, Convert.ToDateTime(startDateTime.Value), Convert.ToDateTime(endDateTime.Value), countOrgID, Convert.ToInt32(ddlReportGroup.SelectedRow.Cells[1].Value.ToString()), countSpecialSearchCriteria, countBasedOnDT, Page.Cookies.TimeZone.ToString(), 0);
                    if (numRefCount > 1500)
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, "You have selected " + numRefCount + " records, please narrow your search criteria.");
                        e.Cancel = true;
                        return;
                    }
                }
                else
                {
                    numRefCount = ReferralManager.FillReferralListCount(countCallNumber, countFirstName, countLastName, Convert.ToDateTime(startDateTime.Value), Convert.ToDateTime(endDateTime.Value), countOrgID, Convert.ToInt32(Page.Cookies.ReportGroupID), countSpecialSearchCriteria, countBasedOnDT, Page.Cookies.TimeZone.ToString(), 0);
                    if (numRefCount > 1500)
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, "You have selected " + numRefCount + " records, please narrow your search criteria.");
                        e.Cancel = true;
                        return;
                    }
                }
            }
        }

        protected void ddlReportGroup_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlReportGroup.DropDownLayout.BaseTableName = "WebReportGroup";
            ddlReportGroup.Columns[ddlReportGroup.Columns.IndexOf("WebReportGroupID")].Hidden = true;
        }

        protected void ddlRefFacility_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlRefFacility.DropDownLayout.BaseTableName = "OrganizationList";
            ddlRefFacility.Columns[ddlRefFacility.Columns.IndexOf("OrganizationID")].Hidden = true;
        }

        protected void gridReferralList_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
        }
       
        protected void ddlReportGroup_DataBound(object sender, EventArgs e)
        {
            String allReferrals;
            allReferrals = null;
            if (!this.IsPostBack)
            {
                if (Page.Cookies.UserOrgID.Equals(194))
                {
                    allReferrals = Statline.Configuration.ApplicationSettings.GetSetting(Statline.Configuration.SettingName.StatlineAllReferrals);
                    object[] rowObject = { allReferrals, 37 };
                    UltraGridRow statlineRow = new UltraGridRow(rowObject);
                    ddlReportGroup.Rows.Add(statlineRow);
                    ddlReportGroup.SelectedRow = statlineRow;
                }
                else
                {
                    allReferrals = "All Referrals";
                }
                UltraGridCell allReferralCell = ddlReportGroup.FindByText(allReferrals);

                if (allReferralCell != null )
                {
                    ddlReportGroup.SelectedRow = allReferralCell.Row;
                }
                try
                {
                    odsRefFacility.SelectParameters["ReportGroupID"].DefaultValue = ddlReportGroup.SelectedRow.Cells[1].Value.ToString();
                }
                catch
                {//hopefully this never happens, but if "All Referrals" is spelled wrong, the program won't blow up
                    odsRefFacility.SelectParameters["ReportGroupID"].DefaultValue = "37";
                }
                try
                {
                    Page.Cookies.ReportGroupID = Convert.ToInt32(ddlReportGroup.SelectedRow.Cells[1].Value);
                }
                catch
                {//hopefully this never happens, but if "All Referrals" is spelled wrong, the program won't blow up
                    Page.Cookies.ReportGroupID = 37;
                }

            }
            UltraGridCell allReferralCell1 = ddlReportGroup.FindByText(allReferrals);

            if (allReferralCell1 != null && !this.IsPostBack)
            {
                ddlReportGroup.SelectedRow = allReferralCell1.Row;
            }
        }
    }
}
