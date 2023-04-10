using System;
using System.Web.UI.WebControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Schedule;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class ScheduleSplitShiftControl : BaseUserControlSecure
    {
        protected ScheduleData dsScheduleData;

        protected void Page_Load(object sender, EventArgs e)
        {
            //always call
            webCalendar.Style.Add("display", "none");
            this.lblSchedOrg1.Text = Page.Cookies.OrganizationName;
            this.lblSchedGroup1.Text = Request.QueryString["OrgGroup"];
            odsPerson.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.OrganizationID.ToString();
            this.lblTZ.Text = Page.Cookies.TimeZone;
            
            if (dsScheduleData == null) dsScheduleData = new ScheduleData();
            try
            {
                ScheduleManager.FillSchedule(dsScheduleData, Convert.ToInt32(Request.QueryString["SchedGroupID"]), Convert.ToInt32(Request.QueryString["ScheduleItemID"]), Page.Cookies.TimeZone, Page.Cookies.UserOrgID);
                if (!IsPostBack)
                {
                    this.startDateTimeStartShift.Text = Convert.ToDateTime(dsScheduleData.ScheduleList[0].ShiftStart).ToString(ConstHelper.MILITARYDATETIME);
                    this.endDateTimeEndShift.Text = Convert.ToDateTime(dsScheduleData.ScheduleList[0].ShiftEnd).ToString(ConstHelper.MILITARYDATETIME);
                    this.txtNameStart.Text = dsScheduleData.ScheduleList[0].ScheduleItemName;
                    this.txtNameEnd.Text = dsScheduleData.ScheduleList[0].ScheduleItemName;
                }
            }
            catch (Exception ex)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the data from being loaded.");
            }
        }

        #region Populate DropDown Data
        //try catch in case there isn't persons 1 - 5
        protected void GetPerson1(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson1Start.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person1, dsScheduleData.ScheduleList[0].PersonID1));
                ddlPerson1Start.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson1Start.Items.Insert(0, "-");
            }
        }

        protected void GetPerson2(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson2Start.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person2, dsScheduleData.ScheduleList[0].PersonID2));
                ddlPerson2Start.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson2Start.Items.Insert(0, "-");
            }
        }

        protected void GetPerson3(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson3Start.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person3, dsScheduleData.ScheduleList[0].PersonID3));
                ddlPerson3Start.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson3Start.Items.Insert(0, "-");
            }
        }

        protected void GetPerson4(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson4Start.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person4, dsScheduleData.ScheduleList[0].PersonID4));
                ddlPerson4Start.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson4Start.Items.Insert(0, "-");
            }
        }

        protected void GetPerson5(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson5Start.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person5, dsScheduleData.ScheduleList[0].PersonID5));
                ddlPerson5Start.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson5Start.Items.Insert(0, "-");
            }
        }

        protected void GetPerson1End(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson1End.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person1, dsScheduleData.ScheduleList[0].PersonID1));
                ddlPerson1End.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson1End.Items.Insert(0, "-");
            }
        }

        protected void GetPerson2End(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson2End.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person2, dsScheduleData.ScheduleList[0].PersonID2));
                ddlPerson2End.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson2End.Items.Insert(0, "-");
            }
        }

        protected void GetPerson3End(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson3End.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person3, dsScheduleData.ScheduleList[0].PersonID3));
                ddlPerson3End.Items.Insert(1, "-"); 
            }
            catch
            {
                ddlPerson3End.Items.Insert(0, "-");
            }
        }

        protected void GetPerson4End(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson4End.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person4, dsScheduleData.ScheduleList[0].PersonID4));
                ddlPerson4End.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson4End.Items.Insert(0, "-");
            }
        }

        protected void GetPerson5End(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            try 
            {
                ddlPerson5End.Items.Insert(0, new ListItem(dsScheduleData.ScheduleList[0].Person5, dsScheduleData.ScheduleList[0].PersonID5));
                ddlPerson5End.Items.Insert(1, "-");
            }
            catch
            {
                ddlPerson5End.Items.Insert(0, "-");
            }
        }
        #endregion

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsValid())
                {
                    int overlap = ScheduleManager.OverlapSchedule(Convert.ToInt32(Request.QueryString["SchedGroupID"]), Convert.ToInt32(Request.QueryString["ScheduleItemID"]), startDateTimeStartShift.Text, endDateTimeStartShift.Text, 0, Page.Cookies.TimeZone);
                    if (overlap > 0)
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, "You are trying to create an overlapping schedule...please adjust the dates.");
                        return;
                    }
                    int overlap1 = ScheduleManager.OverlapSchedule(Convert.ToInt32(Request.QueryString["SchedGroupID"]), Convert.ToInt32(Request.QueryString["ScheduleItemID"]), startDateTimeEndShift.Text, endDateTimeEndShift.Text, 0, Page.Cookies.TimeZone);
                    if (overlap1 > 0)
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, "You are trying to create an overlapping schedule...please adjust the dates.");
                        return;
                    }
                    //delete item
                    ScheduleManager.DeleteSchedule(Convert.ToInt32(dsScheduleData.ScheduleList[0].ScheduleItemID));

                    //insert start shift
                    int newStartScheduleItemID = ScheduleManager.InsertSchedule(Convert.ToInt32(Request.QueryString["SchedGroupID"]), this.txtNameStart.Text, this.startDateTimeStartShift.Text, this.endDateTimeStartShift.Text, 0, Page.Cookies.TimeZone);
                    //create ds for start shift persons with new schedule item id
                    LoadStartPersonData(newStartScheduleItemID);
                    ScheduleManager.UpdateSchedule(dsScheduleData);

                    //insert end shift
                    int newEndScheduleItemID = ScheduleManager.InsertSchedule(Convert.ToInt32(Request.QueryString["SchedGroupID"]), this.txtNameEnd.Text, this.startDateTimeEndShift.Text, this.endDateTimeEndShift.Text, 0, Page.Cookies.TimeZone);
                    //create ds for end shift persons with new schedule item id
                    LoadEndPersonData(newEndScheduleItemID);
                    //update persons
                    ScheduleManager.UpdateSchedule(dsScheduleData);
                    Response.Redirect("~/ScheduleSearch.aspx?FromSave=Y" + "&OrgGroup=" + lblSchedGroup1.Text);
                }
            }
            catch (Exception ex)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
            }
        }

        #region Get Person Data
        protected void LoadStartPersonData(int newStartScheduleItemID)
        {
            for (int loop = 1; loop < 6; loop++)
            {
                ScheduleData.ScheduleUpdatePersonRow schedUpdatePersonRow;
                if (dsScheduleData.ScheduleUpdatePerson == null) dsScheduleData = new ScheduleData();
                schedUpdatePersonRow = dsScheduleData.ScheduleUpdatePerson.NewScheduleUpdatePersonRow();
                switch(loop)
				{
                    case 1:
                        if (ddlPerson1Start.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson1Start.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 2:
                        if (ddlPerson2Start.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson2Start.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 3:
                        if (ddlPerson3Start.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson3Start.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 4:
                        if (ddlPerson4Start.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson4Start.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 5:
                        if (ddlPerson5Start.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson5Start.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
				}
                //DropDownList dropdownlist = new DropDownList();
                //dropdownlist.ID = "ddlPerson" + Convert.ToString(loop) + "Start";
                //string test = "ddlPerson" + Convert.ToString(loop) + "Start"; 
                //DropDownList dropdownlist = (DropDownList)"ddlPerson"+loop.ToString()+"Start";
                schedUpdatePersonRow.ScheduleItemID = dsScheduleData.ScheduleList[0].ScheduleItemID;
                schedUpdatePersonRow.NewScheduleItemID = newStartScheduleItemID.ToString();
                schedUpdatePersonRow.Priority = loop.ToString();
                dsScheduleData.ScheduleUpdatePerson.AddScheduleUpdatePersonRow(schedUpdatePersonRow);
            }
        }

        protected void LoadEndPersonData(int newEndScheduleItemID)
        {
            for (int loop = 1; loop < 6; loop++)
            {
                ScheduleData.ScheduleUpdatePersonRow schedUpdatePersonRow;
                if (dsScheduleData.ScheduleUpdatePerson == null) dsScheduleData = new ScheduleData();
                schedUpdatePersonRow = dsScheduleData.ScheduleUpdatePerson.NewScheduleUpdatePersonRow();
                switch (loop)
                {
                    case 1:
                        if (ddlPerson1End.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson1End.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 2:
                        if (ddlPerson2End.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson2End.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 3:
                        if (ddlPerson3End.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson3End.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 4:
                        if (ddlPerson4End.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson4End.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                    case 5:
                        if (ddlPerson5End.SelectedItem.Value != "-")
                        {
                            schedUpdatePersonRow.PersonID = ddlPerson5End.SelectedItem.Value;
                        }
                        else
                        {
                            continue;
                        }
                        break;
                }
                schedUpdatePersonRow.ScheduleItemID = dsScheduleData.ScheduleList[0].ScheduleItemID;
                schedUpdatePersonRow.NewScheduleItemID = newEndScheduleItemID.ToString();
                schedUpdatePersonRow.Priority = loop.ToString();
                dsScheduleData.ScheduleUpdatePerson.AddScheduleUpdatePersonRow(schedUpdatePersonRow);
            }
        }
        #endregion

        protected void btnCanel_Click(object sender, EventArgs e)
        {
            //ScheduleManager.LockSchedule(Convert.ToInt32(Page.Cookies.UserOrgID), Convert.ToInt32(Page.Cookies.StatEmployeeID), true);
            Response.Redirect("~/ScheduleSearch.aspx?FromSave=Y" + "&OrgGroup=" + lblSchedGroup1.Text);
        }

        protected void odsPerson_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        public bool IsValid()
        {
            bool returnValue = true;
               
            if (string.IsNullOrEmpty(txtNameStart.Text))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "No Name For Start Shift");
            }
            if (string.IsNullOrEmpty(txtNameEnd.Text))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "No Name For End Shift");
            }
            TimeSpan ts1 = Convert.ToDateTime(endDateTimeEndShift.Value) - Convert.ToDateTime(startDateTimeEndShift.Value);
            if (ts1.TotalDays < 0)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "End Date Can't be Less than Start Date for End Shift");
            }
            if (ts1.Days > 365)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "End Date Can't be More Than a Year for End Shift");
            }
            TimeSpan ts2 = Convert.ToDateTime(endDateTimeStartShift.Value) - Convert.ToDateTime(startDateTimeStartShift.Value);
            if (ts2.TotalDays < 0)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "End Date Can't be Less than Start Date for Start Shift");
            }
            if (ts2.Days > 365)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "End Date Can't be More Than a Year for Start Shift");
            }
            TimeSpan ts3 = Convert.ToDateTime(startDateTimeEndShift.Value) - Convert.ToDateTime(endDateTimeStartShift.Value);
            if (ts3.TotalDays < 0)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "You can't Create an Overlapping Shift");
            }
            return returnValue;
        }

        protected void endDateTimeEndShift_ValueChange(object sender, Infragistics.WebUI.WebDataInput.ValueChangeEventArgs e)
        {

        }
    }
}