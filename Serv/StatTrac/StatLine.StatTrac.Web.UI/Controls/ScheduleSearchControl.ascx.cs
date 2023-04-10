using System;
using System.Drawing;
using System.Web.UI.WebControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Schedule;
using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Person;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class ScheduleSearchControl : BaseUserControlSecure
    {
        protected ScheduleData dsScheduleData;
        TimeSpan ts;
        protected void Page_Load(object sender, EventArgs e)
        {
            DateTime dtStartDate;
            DateTime dtEndDate;
            dtStartDate = new DateTime(System.DateTime.Now.Year, (int)System.DateTime.Now.Month, 1, 0, 0, 0, 0);
            dtEndDate = new DateTime(System.DateTime.Now.Year, (int)System.DateTime.Now.Month, DateTime.DaysInMonth(System.DateTime.Now.Year, (int)System.DateTime.Now.Month), 23, 59, 59, 999);

            if (!this.IsPostBack)
            {
                Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
                startDateTime.Value = dtStartDate.ToString(ConstHelper.MILITARYDATETIME);
                endDateTime.Value = dtEndDate.ToString(ConstHelper.MILITARYDATETIME);
                lblTZ.Text = Page.Cookies.TimeZone;
                lblTZ1.Text = Page.Cookies.TimeZone;
                if (Page.Cookies.ScheduleGroupID != 0 && Request.QueryString["FromSave"] == "Y")
                {
                    odsSchedList.SelectParameters["scheduleGroupID"].DefaultValue = Page.Cookies.ScheduleGroupID.ToString();
                    odsSchedList.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.OrganizationID.ToString();
                    odsSchedOrgs.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                    odsSchedOrgGroups.SelectParameters["OrgID"].DefaultValue = Page.Cookies.OrganizationID.ToString();
                    odsPerson.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.OrganizationID.ToString();
                    odsPerson.SelectParameters["ScheduleGroupID"].DefaultValue = Page.Cookies.ScheduleGroupID.ToString();
                    ddlScheduleOrgs.DisplayValue = Page.Cookies.OrganizationName.ToString();
                    ddlScheduleGroup.DisplayValue = Request.QueryString["OrgGroup"];
                    lblSchedOrg1.Text = Page.Cookies.OrganizationName.ToString();
                    lblSchedGroup1.Text = Request.QueryString["OrgGroup"];
                    startDateTime.Value = Page.Cookies.StartDate;
                    endDateTime.Value = Page.Cookies.EndDate;
                    btnSearch.Enabled = true;
                    btnSave.Enabled = true;
                    btnCreateShift.Enabled = true;
                }
                else
                {
                    Page.Cookies.OrganizationID = Page.Cookies.UserOrgID;
                    odsSchedOrgs.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                    odsSchedOrgGroups.SelectParameters["OrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                    odsPerson.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                    ddlScheduleOrgs.DisplayValue = Page.Cookies.UserOrganizationName.ToString();
                }
                //Page.Cookies.OrganizationID = Convert.ToInt32(Page.Cookies.UserOrgID);
                
                if (!SecurityChecker.CheckAccessToRule(AuthRule.ScheduleShiftCreate))
                    btnCreateShift.Visible = false;
                if (!SecurityChecker.CheckAccessToRule(AuthRule.ScheduleShiftUpdate))
                    btnSave.Visible = false;
            }
        }

        //protected void Page_Disposed(object sender, EventArgs e)
        //{
        //    if (!this.IsPostBack)
        //    {
        //        ScheduleManager.LockSchedule(dsScheduleData, Convert.ToInt32(Page.Cookies.UserOrgID), Convert.ToInt32(Page.Cookies.StatEmployeeID), true);
        //    }
        //}

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                if (ddlScheduleOrgs.SelectedRow != null)
                {
                    odsSchedList.SelectParameters["userOrgID"].DefaultValue = ddlScheduleOrgs.SelectedRow.Cells[1].Value.ToString();
                    lblSchedOrg1.Text = ddlScheduleOrgs.SelectedRow.Cells[0].Text.ToString();
                    Page.Cookies.OrganizationName = ddlScheduleOrgs.SelectedRow.Cells[0].Text.ToString();
                }
                else
                {
                    odsSchedList.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                    lblSchedOrg1.Text = ddlScheduleOrgs.DisplayValue;
                    Page.Cookies.OrganizationName = ddlScheduleOrgs.DisplayValue;
                }

                if (ddlScheduleGroup.SelectedRow != null)
                {
                    odsSchedList.SelectParameters["scheduleGroupID"].DefaultValue = ddlScheduleGroup.SelectedRow.Cells[1].Value.ToString();
                    odsPerson.SelectParameters["ScheduleGroupID"].DefaultValue = ddlScheduleGroup.SelectedRow.Cells[1].Value.ToString();
                }
                else
                {
                    odsSchedList.SelectParameters["scheduleGroupID"].DefaultValue = Page.Cookies.ScheduleGroupID.ToString();
                    odsPerson.SelectParameters["ScheduleGroupID"].DefaultValue = Page.Cookies.ScheduleGroupID.ToString();
                }
                
                
                //lblSchedGroup1.Text = ddlScheduleGroup.SelectedRow.Cells[0].Text.ToString();
                Page.Cookies.StartDate = Convert.ToDateTime(startDateTime.Value);
                Page.Cookies.EndDate = Convert.ToDateTime(endDateTime.Value);
            }
        }

        #region Populate DropDowns
        protected void GetCurrentPerson1(object sender, EventArgs e)
        {
            PopulateDropDown(sender, 5);
        }
        protected void GetCurrentPerson2(object sender, EventArgs e)
        {
            PopulateDropDown(sender, 7);
        }
        protected void GetCurrentPerson3(object sender, EventArgs e)
        {
            PopulateDropDown(sender, 9);
        }
        protected void GetCurrentPerson4(object sender, EventArgs e)
        {
            PopulateDropDown(sender, 11);
        }
        protected void GetCurrentPerson5(object sender, EventArgs e)
        {
            PopulateDropDown(sender, 13);
        }

        protected void PopulateDropDown(object sent, int cell)
        {
            int i = gridSchedule.Rows.Count;
            DropDownList dropdownlist = (DropDownList)sent;
            //row is always one less than the count
            dropdownlist.Items.Insert(0, gridSchedule.Rows[i - 1].Cells[cell].Text);
        }

        #endregion

        #region Get DropDown Data
        protected void GetCurrentPerson1Changed(object sender, EventArgs e)
        {
            LoadData(sender, "1");
        }
        protected void GetCurrentPerson2Changed(object sender, EventArgs e)
        {
            LoadData(sender, "2");
        }
        protected void GetCurrentPerson3Changed(object sender, EventArgs e)
        {
            LoadData(sender, "3");
        }
        protected void GetCurrentPerson4Changed(object sender, EventArgs e)
        {
            LoadData(sender, "4");
        }
        protected void GetCurrentPerson5Changed(object sender, EventArgs e)
        {
            LoadData(sender, "5");
        }

        protected void LoadData(object sent, string priority)
        {
            ScheduleData.ScheduleUpdatePersonRow schedUpdateRow;
            if (dsScheduleData == null) dsScheduleData = new ScheduleData();
            schedUpdateRow = dsScheduleData.ScheduleUpdatePerson.NewScheduleUpdatePersonRow();
            DropDownList dropdownlist = (DropDownList)sent;
            CellItem ci = (CellItem)dropdownlist.Parent;
            int rownumber = ci.Cell.Row.Index;
            schedUpdateRow.ScheduleItemID = gridSchedule.Rows[rownumber].Cells[0].Text;
            schedUpdateRow.PersonID = dropdownlist.SelectedItem.Value;
            schedUpdateRow.Priority = priority;
            dsScheduleData.ScheduleUpdatePerson.AddScheduleUpdatePersonRow(schedUpdateRow);
        }

        #endregion

        protected void odsSchedOrgs_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsSchedOrgGroups_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsSchedList_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }

        }

        protected void odsPerson_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (dsScheduleData != null)
                {
                    if (dsScheduleData.ScheduleUpdatePerson.Rows.Count != 0)
                    {
                        string schedgrpID;
                        if (ddlScheduleGroup.SelectedRow == null)
                        {
                            schedgrpID = Page.Cookies.ScheduleGroupID.ToString();
                        }
                        else
                        {
                            schedgrpID = ddlScheduleGroup.SelectedRow.Cells[1].Value.ToString();
                        }
                        ScheduleManager.UpdateSchedule(dsScheduleData);
                        ScheduleManager.LockSchedule(dsScheduleData, Convert.ToInt32(schedgrpID), Convert.ToInt32(Page.Cookies.StatEmployeeID), true);
                        //QueryStringManager.Redirect(PageName.ScheduleSearch);
                        Response.Redirect("~/ScheduleSearch.aspx?FromSave=Y" + "&OrgGroup=" + lblSchedGroup1.Text);
                    }
                    else
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, "You have not changed any data to save");
                    }
                }
                else
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "You have not changed any data to save");
                }
            }
            catch (Exception ex)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
            }

        }

        protected void btnCreateShift_Click(object sender, EventArgs e)
        {
            Page.Cookies.StartDate = Convert.ToDateTime(startDateTime.Value);
            Page.Cookies.EndDate = Convert.ToDateTime(endDateTime.Value);
            string schedgrpID;
            if (ddlScheduleGroup.SelectedRow == null)
            {
                schedgrpID = Page.Cookies.ScheduleGroupID.ToString();
            }
            else
            {
                schedgrpID = ddlScheduleGroup.SelectedRow.Cells[1].Value.ToString();
            }
            Response.Redirect("~/ScheduleCreateUpdateShift.aspx?OrgName=" + lblSchedOrg1.Text + "&OrgGroup=" + lblSchedGroup1.Text + "&SchedGroupID=" + schedgrpID + "&ShowCreate=" + 1);
        }

        protected void ddlScheduleGroup_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
        //    lblSchedOrg1.Text = ddlScheduleOrgs.DisplayValue.ToString();
        //    lblSchedGroup1.Text = ddlScheduleGroup.SelectedRow.Cells[0].Text.ToString();
            //if (ddlScheduleOrgs.SelectedRow != null)
            //{
            //    odsSchedOrgs.SelectParameters["userOrgID"].DefaultValue = ddlScheduleOrgs.SelectedRow.Cells[1].Value.ToString();
            //    odsSchedOrgs.DataBind();
            //}
            if (dsScheduleData == null) dsScheduleData = new ScheduleData();
            try
            {
                ScheduleManager.LockSchedule(dsScheduleData, Convert.ToInt32(ddlScheduleGroup.SelectedRow.Cells[1].Value.ToString()), Convert.ToInt32(Page.Cookies.StatEmployeeID), false);
                if (dsScheduleData.ScheduleLock[0].Lock == "1")
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "Schedules Are Locked for Changes by " + ddlScheduleGroup.DisplayValue);
                    btnCreateShift.Enabled = false;
                    btnSearch.Enabled = false;
                    btnSave.Enabled = false;
                    return;

                }
                else
                {
                    ScheduleManager.LockSchedule(dsScheduleData, Convert.ToInt32(ddlScheduleGroup.SelectedRow.Cells[1].Value.ToString()), Convert.ToInt32(Page.Cookies.StatEmployeeID), false);
                }
            }
            catch
            {
            }
            
            lblSchedGroup1.Text = ddlScheduleGroup.DisplayValue;
            lblSchedOrg1.Text = ddlScheduleOrgs.DisplayValue;
            Page.Cookies.OrganizationName = ddlScheduleOrgs.DisplayValue;
            btnCreateShift.Enabled = true;
            btnSearch.Enabled = true;
            btnSave.Enabled = true;
        }

        protected void ddlScheduleOrgs_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            ddlScheduleGroup.DisplayValue = null;
            try
            {
                //if (ddlScheduleOrgs.SelectedRow != null)
                //{
                    odsSchedOrgGroups.SelectParameters["OrgID"].DefaultValue = ddlScheduleOrgs.SelectedRow.Cells[1].Value.ToString();
                    odsPerson.SelectParameters["OrganizationID"].DefaultValue = ddlScheduleOrgs.SelectedRow.Cells[1].Value.ToString();
                    Page.Cookies.OrganizationID = Convert.ToInt32(ddlScheduleOrgs.SelectedRow.Cells[1].Value);
                //}
            }
            catch { }
        }

        protected void gridSchedule_DataBound(object sender, EventArgs e)
        {
            //finds and highlights gaps in schedules
            if (gridSchedule.Rows.Count > 0)
            {
                for (int loop = 0; loop < gridSchedule.Rows.Count - 1; loop++)
                {
                    TimeSpan ts = Convert.ToDateTime(gridSchedule.Rows[loop + 1].Cells[3].Value) - Convert.ToDateTime(gridSchedule.Rows[loop].Cells[4].Value);
                    if (ts.TotalDays != 0)
                    {
                        gridSchedule.Rows[loop].Cells[3].Style.BackColor = Color.Red;
                        gridSchedule.Rows[loop].Cells[4].Style.BackColor = Color.Red;
                        gridSchedule.Rows[loop + 1].Cells[3].Style.BackColor = Color.Red;
                        gridSchedule.Rows[loop + 1].Cells[4].Style.BackColor = Color.Red;
                    }
                }
            }
        }
        public bool IsValid()
        {
            //Validations here
            bool returnValue = true;
            {
                ts = Convert.ToDateTime(endDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
                if (ts.Days > 365)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "Date range can not be longer than 365 days.");
                    return false;
                }
                
                return returnValue;
            }
        }

        protected void odsSchedOrgs_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (odsSchedOrgs.SelectParameters["userOrgID"].ToString() == "0")
                e.Cancel = true;
        }

        protected void odsSchedList_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (odsSchedList.SelectParameters["scheduleGroupID"].DefaultValue == null) e.Cancel = true;
            //if (ddlScheduleOrgs.SelectedRow == null) e.Cancel = true;

            //unfortunately, i have to test the dates here, because the ods is doing the selecting before the click
            ts = Convert.ToDateTime(endDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
            if (ts.Days > 365) e.Cancel = true;
        }

        protected void ddlScheduleOrgs_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlScheduleOrgs.DropDownLayout.BaseTableName = "OrganizationList";
            ddlScheduleOrgs.Columns[ddlScheduleOrgs.Columns.IndexOf("OrganizationID")].Hidden = true;
        }

        protected void ddlScheduleGroup_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlScheduleGroup.DropDownLayout.BaseTableName = "ScheduleGroup";
            ddlScheduleGroup.Columns[ddlScheduleGroup.Columns.IndexOf("ScheduleGroupID")].Hidden = true;

        }
    }
}