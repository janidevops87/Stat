using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Referral;
using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTrac.Person;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class EventLogUpdateControl : BaseUserControlSecure
    {
        protected ReferralData dsReferralData;

        protected void Page_Load(object sender, EventArgs e)
        {
            //always call
            if (IsPostBack) return;
            // REMOVE COMMENTS AND SET webDateTimeEditClientID FOR EACHE WEBDATETIMEEDIT CONTROL
            //string[] webDateTimeEditClientID = { webDateTimeEditStart.ClientID, webDateTimeEditEnd.ClientID };
            //WebDateTimeHelper.webDateTimeEdit_LoadJavaScript(webCalendar.ClientID, webDateTimeEditClientID, Page);
            Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
            odsPersonList.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.OrganizationID.ToString();
            odsLogEvents.SelectParameters["CallID"].DefaultValue = Page.Cookies.CallID.ToString();
            odsLogEvents.SelectParameters["timeZone"].DefaultValue = Page.Cookies.TimeZone.ToString();
            DateTime dtStartDate;
            double tzOffSet = Statline.StatTrac.TimeZoneOffSet.MountainTimeZoneOffSet(Page.Cookies.TimeZone, System.DateTime.Now);
            dtStartDate = System.DateTime.Now.AddHours(tzOffSet);
            logDateTime.Value = dtStartDate.ToString(ConstHelper.MILITARYDATETIME);
            this.txtOrganization.Text = Page.Cookies.OrganizationName;
            this.lblTZ.Text = Page.Cookies.TimeZone;
            this.lblCallDT1.Text = Page.Cookies.CallDate.ToString();
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                try
                {
                    ReferralData.LogEventInsertRow logEventRow;
                    if (dsReferralData == null)
                    {
                        dsReferralData = new ReferralData();
                        logEventRow = dsReferralData.LogEventInsert.NewLogEventInsertRow();
                    }
                    //build a logevent row with default values
                    string eventName;
                    if (string.IsNullOrEmpty(txtName1.Text))
                    {
                        eventName = ddlName.SelectedItem.Text.ToString();
                    }
                    else
                    {
                        eventName = txtName1.Text.ToString();
                    }
                    DateTime dtStartDate;
                    double tzOffSet = Statline.StatTrac.TimeZoneOffSet.MountainTimeZoneOffSet(Page.Cookies.TimeZone, Convert.ToDateTime(this.logDateTime.Text));
                    dtStartDate = Convert.ToDateTime(this.logDateTime.Text).AddHours(-tzOffSet);
                    logEventRow = dsReferralData.LogEventInsert.AddLogEventInsertRow(
                        Page.Cookies.CallID,
                        1,//Event type...in this case note only
                        dtStartDate,
                        //Convert.ToDateTime(this.logDateTime.Text),//Event Date/Time
                        0,//Event Number
                        eventName,//Event Name
                        null,//Event Phone
                        txtOrganization.Text,//Event Org
                        txtNoteDescription.Text,//Description
                        Page.Cookies.StatEmployeeID,//StatEmployeeID
                        0,//Callback Pending
                        DateTime.Now,//LastModified
                        -1,//ScheduleGroupID
                        -1,//PersonID
                        Page.Cookies.UserOrgID,//OrganizationID
                        -1,//PhoneID
                        0,//LogEventContactConfirmed
                        0,//UpdatedFlag
                        DateTime.Now,//LogEventCalloutDateTime
                        Page.Cookies.StatEmployeeID,
                        "1",//Audit Log Type
                        Page.Cookies.TimeZone);//Time Zone

                    ReferralManager.InsertReferralReportLogEvent(dsReferralData);
                    QueryStringManager.Redirect(PageName.EventLogUpdate);
                }
                catch (Exception ex)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
                }
            }
        }


        protected void odsPersonList_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void odsLogEvents_Selected(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

                e.ExceptionHandled = true;
            }
        }

        protected void gridLogEventsList_InitializeRow(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
        {
            //e.Row.
           //gridLogEventsList.DisplayLayout.Bands[0].Columns[1].
        }

        public bool IsValid()
        {
            bool returnValue = true;
            if (txtOrganization.Text.Length > 80)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Organization is longer than 80 characters you have entered " + txtOrganization.Text.Length + " characters.");
                return false;
            }
            if (txtNoteDescription.Text.Length > 1000)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Note description is longer than 1000 characters you have entered " + txtNoteDescription.Text.Length + " characters.");
                txtNoteDescription.Focus();
                return false;
            }
            if (txtName1.Text.Length > 50)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "Name is longer than 50 characters you have entered " + txtName1.Text.Length + " characters.");
                txtName1.Focus();
                return false;
            }
            return returnValue;
        }

        protected void gridLogEventsList_DataBound(object sender, EventArgs e)
        {
            ddlName.Items.Insert(0, gridLogEventsList.Rows[0].Cells[5].Text);
        }
    }
}