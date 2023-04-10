using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Schedule;
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class ScheduleCreateUpdateShiftControl : BaseUserControlSecure
    {
        protected ScheduleData dsScheduleData;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (dsScheduleData == null) dsScheduleData = new ScheduleData();
            ScheduleManager.LockSchedule(dsScheduleData, Convert.ToInt32(Request.QueryString["SchedGroupID"]), Convert.ToInt32(Page.Cookies.StatEmployeeID), false);
            if (dsScheduleData.ScheduleLock[0].Lock == "1")
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Schedules Are Locked for Changes");
                btnDelete.Enabled = false;
                btnRemoveShift.Enabled = false;
                btnSave.Enabled = false;
                btnSplitShift.Enabled = false;
                return;
            }
            if (!String.IsNullOrEmpty(Request.QueryString["OrgGroup"]))
            {
                this.lblSchedGroup1.Text = Request.QueryString["OrgGroup"];
                Page.Cookies.ScheduleGroupID = Convert.ToInt32(Request.QueryString["SchedGroupID"]);
                //Page.Cookies.ScheduleItemID = Convert.ToInt32(Request.QueryString["ScheduleItemID"]);
            }
            this.lblSchedOrg1.Text = Page.Cookies.OrganizationName;
            odsPerson.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.OrganizationID.ToString();
            //if this is a call from create or update
            if (!String.IsNullOrEmpty(Request.QueryString["ShowCreate"]))
            {
                if (Request.QueryString["ShowCreate"].ToString() == "1")
                {
                    if (IsPostBack) return;
                    pnlCreateShift.Visible = true;
                    btnSplitShift.Visible = false;
                    btnRemoveShift.Visible = false;
                    startDateTime.Value = System.DateTime.Today.ToString(ConstHelper.MILITARYDATETIME);
                    endDateTime.Value = System.DateTime.Today.AddDays(7).ToString(ConstHelper.MILITARYDATETIME);
                    
                }
                else
                {
                    //user got here by clicking link from search
                    LoadUpdateData();
                    //if they have create authority, but can't save an existing schedule
                    if (SecurityChecker.CheckAccessToRule(AuthRule.ScheduleShiftCreate))
                    {
                        btnSave.Visible = false;
                        btnDelete.Visible = false;
                    }
                    if (SecurityChecker.CheckAccessToRule(AuthRule.ScheduleShiftUpdate))
                    {
                        btnSave.Visible = true;
                        btnDelete.Visible = true;
                    }
                }
            }
            
            lblTZ.Text = Page.Cookies.TimeZone;
            lblTZ1.Text = Page.Cookies.TimeZone;    
            // REMOVE COMMENTS AND SET webDateTimeEditClientID FOR EACHE WEBDATETIMEEDIT CONTROL
            //string[] webDateTimeEditClientID = { webDateTimeEditStart.ClientID, webDateTimeEditEnd.ClientID };
            //WebDateTimeHelper.webDateTimeEdit_LoadJavaScript(webCalendar.ClientID, webDateTimeEditClientID, Page);
            if (IsPostBack) return;
            if (!SecurityChecker.CheckAccessToRule(AuthRule.ScheduleShiftDelete))
                btnRemoveShift.Visible = false;
            
            //if (!SecurityChecker.CheckAccessToRule(AuthRule.ScheduleShiftCreate))
            //    btnSave.Visible = false;
            if (!SecurityChecker.CheckAccessToRule(AuthRule.ScheduleShiftUpdate))
                btnSplitShift.Visible = false;
            
        }
        private void LoadUpdateData()
        {
            if (dsScheduleData == null) dsScheduleData = new ScheduleData();
            try
            {
                ScheduleManager.FillSchedule(dsScheduleData, Convert.ToInt32(Request.QueryString["SchedGroupID"]), Convert.ToInt32(Request.QueryString["ScheduleItemID"]), Page.Cookies.TimeZone, Page.Cookies.UserOrgID);
                if (!IsPostBack)
                {
                    this.startDateTime.Value = Convert.ToDateTime(dsScheduleData.ScheduleList[0].ShiftStart).ToString(ConstHelper.MILITARYDATETIME);
                    this.endDateTime.Value = Convert.ToDateTime(dsScheduleData.ScheduleList[0].ShiftEnd).ToString(ConstHelper.MILITARYDATETIME);
                    this.txtName.Text = dsScheduleData.ScheduleList[0].ScheduleItemName;
                }
                //odsPerson.DataBind();
            }
            catch (Exception ex)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (this.cbxPerson1.Checked == true)
            {
                ScheduleManager.DeleteSchedulePerson(Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleItemID), 1);
            }
            if (this.cbxPerson2.Checked == true)
            {
                ScheduleManager.DeleteSchedulePerson(Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleItemID), 2);
            }
            if (this.cbxPerson3.Checked == true)
            {
                ScheduleManager.DeleteSchedulePerson(Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleItemID), 3);
            }
            if (this.cbxPerson4.Checked == true)
            {
                ScheduleManager.DeleteSchedulePerson(Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleItemID), 4);
            }
            if (this.cbxPerson5.Checked == true)
            {
                ScheduleManager.DeleteSchedulePerson(Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleItemID), 5);
            }
            QueryStringManager.Redirect(PageName.ScheduleSearch);
        }
        
        protected void btnRemoveShift_Click(object sender, EventArgs e)
        {
            try
            {
                if (dsScheduleData.ScheduleList.Rows.Count != 0)
                {
                    ScheduleManager.DeleteSchedule(Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleItemID));
                    //Response.Redirect("~/ScheduleSearch.aspx");
                    QueryStringManager.Redirect(PageName.ScheduleSearch);
                }
                else
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "Database Error");
                }

            }
            catch (Exception ex)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
            }
        }

        protected void btnSplitShift_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ScheduleSplitShift.aspx?OrgName=" + lblSchedOrg1.Text + "&OrgGroup=" + lblSchedGroup1.Text + "&SchedGroupID=" + Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleGroupID) + "&ScheduleItemID=" + Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleItemID));
        }

        protected void btnCanel_Click(object sender, EventArgs e)
        {
            //ScheduleManager.LockSchedule(Convert.ToInt32(Page.Cookies.UserOrgID), Convert.ToInt32(Page.Cookies.StatEmployeeID), true);
            Response.Redirect("~/ScheduleSearch.aspx?FromSave=Y" + "&OrgGroup=" + lblSchedGroup1.Text);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                //if showcreate=1 it is new, otherwise its an update
                if (Request.QueryString["ShowCreate"].ToString() == "1")
                {
                    //new multiple shifts
                    if (cbxRepeatShift.Checked == true)
                    {
                        string dayschecked = FindDaysChecked();
                        TimeSpan ts = Convert.ToDateTime(repeatDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
                        int loopto = Convert.ToInt32(ts.Days);
                        for (int loop = 0; loop < loopto; loop++)
                        {
                            DateTime startDT = Convert.ToDateTime(startDateTime.Value).AddDays(loop);
                            //string testdayofweek = startDT.DayOfWeek.ToString();
                            if (dayschecked.Contains(startDT.DayOfWeek.ToString()))
                            {
                                DateTime endDT = Convert.ToDateTime(endDateTime.Value).AddDays(loop);
                                int newStartScheduleItemID = ScheduleManager.InsertSchedule(Convert.ToInt32(Request.QueryString["SchedGroupID"]), this.txtName.Text, startDT.ToString(), endDT.ToString(), 0, Page.Cookies.TimeZone);
                                //create ds for start shift persons with new schedule item id
                                LoadPersonData(newStartScheduleItemID);
                                ScheduleManager.UpdateSchedule(dsScheduleData);
                            }
                        }
                    }
                    else
                    {
                        int overlap = ScheduleManager.OverlapSchedule(Convert.ToInt32(Request.QueryString["SchedGroupID"]), Convert.ToInt32(Request.QueryString["ScheduleItemID"]),startDateTime.Text, endDateTime.Text, 0, Page.Cookies.TimeZone);
                        if (overlap > 0)
                        {
                            DisplayMessages.Add(MessageType.ErrorMessage, "You are trying to create an overlapping schedule...please adjust the dates.");
                            return;
                        }
                        //new one shift
                        int newStartScheduleItemID = ScheduleManager.InsertSchedule(Convert.ToInt32(Request.QueryString["SchedGroupID"]), this.txtName.Text, startDateTime.Value.ToString(), endDateTime.Value.ToString(), 0, Page.Cookies.TimeZone);
                        ////create ds for start shift persons with new schedule item id
                        LoadPersonData(newStartScheduleItemID);
                        ScheduleManager.UpdateSchedule(dsScheduleData);
                    }
                }
                else
                {
                    int overlap = ScheduleManager.OverlapSchedule(Convert.ToInt32(Request.QueryString["SchedGroupID"]),Convert.ToInt32(Request.QueryString["ScheduleItemID"]), startDateTime.Text, endDateTime.Text, 0, Page.Cookies.TimeZone);
                    if (overlap > 0)
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, "You are trying to create an overlapping schedule...please adjust the dates.");
                        return;
                    }
                    //update shift
                    ScheduleManager.UpdateSchedule(dsScheduleData);
                    ScheduleManager.UpdateItemSchedule(Convert.ToInt32(Request.QueryString["ScheduleItemID"]), txtName.Text, startDateTime.Value.ToString(), endDateTime.Value.ToString(), Page.Cookies.TimeZone);
                }
                Response.Redirect("~/ScheduleSearch.aspx?FromSave=Y" + "&OrgGroup=" + lblSchedGroup1.Text);
                //QueryStringManager.Redirect(PageName.ScheduleSearch);
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

        #region Populate DropDown Data
        //try catch in case there isn't persons 1 - 5
        protected void GetPerson1(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try { ddlPerson1.Items.Insert(0, dsScheduleData.ScheduleList[0].Person1); }
            catch 
            {
                ddlPerson1.Items.Insert(0, "-");
                cbxPerson1.Enabled = false;
            }
        }

        protected void GetPerson2(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try { ddlPerson2.Items.Insert(0, dsScheduleData.ScheduleList[0].Person2); }
            catch 
            { 
                ddlPerson2.Items.Insert(0, "-");
                cbxPerson2.Enabled = false;
            }
        }

        protected void GetPerson3(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try { ddlPerson3.Items.Insert(0, dsScheduleData.ScheduleList[0].Person3); }
            catch 
            { 
                ddlPerson3.Items.Insert(0, "-");
                cbxPerson3.Enabled = false;
            }
        }

        protected void GetPerson4(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try { ddlPerson4.Items.Insert(0, dsScheduleData.ScheduleList[0].Person4); }
            catch 
            { 
                ddlPerson4.Items.Insert(0, "-");
                cbxPerson4.Enabled = false;
            }
        }

        protected void GetPerson5(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try { ddlPerson5.Items.Insert(0, dsScheduleData.ScheduleList[0].Person5); }
            catch 
            { 
                ddlPerson5.Items.Insert(0, "-");
                cbxPerson5.Enabled = false;
            }
        }
        #endregion

        #region Get DropDown Data
        protected void GetPerson1Changed(object sender, EventArgs e)
        {
            if (Request.QueryString["ShowCreate"].ToString() != "1") LoadPersonData(sender, "1");
        }
        protected void GetPerson2Changed(object sender, EventArgs e)
        {
            if (Request.QueryString["ShowCreate"].ToString() != "1") LoadPersonData(sender, "2");
        }
        protected void GetPerson3Changed(object sender, EventArgs e)
        {
            if (Request.QueryString["ShowCreate"].ToString() != "1") LoadPersonData(sender, "3");
        }
        protected void GetPerson4Changed(object sender, EventArgs e)
        {
            if (Request.QueryString["ShowCreate"].ToString() != "1") LoadPersonData(sender, "4");
        }
        protected void GetPerson5Changed(object sender, EventArgs e)
        {
            if (Request.QueryString["ShowCreate"].ToString() != "1") LoadPersonData(sender, "5");
        }

        protected void LoadPersonData(object sent, string priority)
        {
            ScheduleData.ScheduleUpdatePersonRow schedUpdatePersonRow;
            if (dsScheduleData == null) dsScheduleData = new ScheduleData();
            schedUpdatePersonRow = dsScheduleData.ScheduleUpdatePerson.NewScheduleUpdatePersonRow();
            DropDownList dropdownlist = (DropDownList)sent;
            schedUpdatePersonRow.ScheduleItemID = dsScheduleData.ScheduleList[0].ScheduleItemID;
            schedUpdatePersonRow.NewScheduleItemID = dsScheduleData.ScheduleList[0].ScheduleItemID;
            schedUpdatePersonRow.PersonID = dropdownlist.SelectedItem.Value;
            schedUpdatePersonRow.Priority = priority;
            dsScheduleData.ScheduleUpdatePerson.AddScheduleUpdatePersonRow(schedUpdatePersonRow);
        }

        #endregion

        protected void cbxRepeatShift_CheckedChanged(object sender, EventArgs e)
        {
            if (cbxRepeatShift.Checked == true)
            {
                cbxFriday.Enabled = true;
                cbxMonday.Enabled = true;
                cbxSaturday.Enabled = true;
                cbxSunday.Enabled = true;
                cbxThursday.Enabled = true;
                cbxTuesday.Enabled = true;
                cbxWednesday.Enabled = true;
                repeatDateTime.Enabled = true;
            }
            else
            {
                cbxFriday.Enabled = false;
                cbxMonday.Enabled = false;
                cbxSaturday.Enabled = false;
                cbxSunday.Enabled = false;
                cbxThursday.Enabled = false;
                cbxTuesday.Enabled = false;
                cbxWednesday.Enabled = false;
                repeatDateTime.Enabled = false;
            }

        }
        protected string FindDaysChecked()
        {
            StringBuilder builder = new StringBuilder();
            if (cbxSaturday.Checked == true) builder.Append("Saturday").AppendLine();
            if (cbxSunday.Checked == true) builder.Append("Sunday").AppendLine();
            if (cbxMonday.Checked == true) builder.Append("Monday").AppendLine();
            if (cbxTuesday.Checked == true) builder.Append("Tuesday").AppendLine();
            if (cbxWednesday.Checked == true) builder.Append("Wednesday").AppendLine();
            if (cbxThursday.Checked == true) builder.Append("Thursday").AppendLine();
            if (cbxFriday.Checked == true) builder.Append("Friday").AppendLine();
            string daysChecked = builder.ToString();
            return daysChecked;
        }

        #region Get Person Data

        protected void LoadPersonData(int newEndScheduleItemID)
        {
            for (int loop = 1; loop < 6; loop++)
            {
                ScheduleData.ScheduleUpdatePersonRow schedUpdatePersonRow;
                if (dsScheduleData == null) dsScheduleData = new ScheduleData();
                schedUpdatePersonRow = dsScheduleData.ScheduleUpdatePerson.NewScheduleUpdatePersonRow();
                switch (loop)
                {
                    case 1:
                        if (ddlPerson1.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson1.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 2:
                        if (ddlPerson2.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson2.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 3:
                        if (ddlPerson3.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson3.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 4:
                        if (ddlPerson4.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson4.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 5:
                        if (ddlPerson5.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson5.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                }
                try { schedUpdatePersonRow.ScheduleItemID = dsScheduleData.ScheduleList[0].ScheduleItemID; }
                catch { schedUpdatePersonRow.ScheduleItemID = "0"; }
                
                schedUpdatePersonRow.NewScheduleItemID = newEndScheduleItemID.ToString();
                schedUpdatePersonRow.Priority = loop.ToString();
                dsScheduleData.ScheduleUpdatePerson.AddScheduleUpdatePersonRow(schedUpdatePersonRow);
            }
        }
        #endregion

        public bool IsValid()
        {
            bool returnValue = true;
            if (cbxRepeatShift.Checked == true)
            {
                string dayschecked = FindDaysChecked();
                if (string.IsNullOrEmpty(dayschecked))
                {
                    returnValue = false;
                    DisplayMessages.Add(MessageType.ErrorMessage, "No Days Checked");
                }
            }
            if (cbxRepeatShift.Checked == true)
            {
                DateTime testStartDate = Convert.ToDateTime(startDateTime.Value).AddYears(1);
                TimeSpan ts = Convert.ToDateTime(repeatDateTime.Value) - testStartDate;
                
                if (ts.Days > 0)
                {
                    returnValue = false;
                    DisplayMessages.Add(MessageType.ErrorMessage, "Repeat Date Can't be More Than a Year From Start Date");
                }
            }
            if (cbxRepeatShift.Checked == true)
            {
                TimeSpan ts = Convert.ToDateTime(repeatDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
                if (ts.TotalDays < 0)
                {
                    returnValue = false;
                    DisplayMessages.Add(MessageType.ErrorMessage, "Repeat Date Can't be Less Than Start Date");
                }
            }
            if (string.IsNullOrEmpty(txtName.Text))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "No Name For Shift");
                return returnValue;
            }
            if (string.IsNullOrEmpty(endDateTime.Text))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "No Date for End Shift");
                return returnValue;
            }
            if (string.IsNullOrEmpty(startDateTime.Text))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "No Date for Start Shift");
                return returnValue;
            }
            TimeSpan ts1 = Convert.ToDateTime(endDateTime.Value) - Convert.ToDateTime(startDateTime.Value);
            if (ts1.TotalDays < 0)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "End Date Can't be Less than Start Date");
            }
        return returnValue;
        }
    }
}