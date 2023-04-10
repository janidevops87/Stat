using System;
using System.Collections.Generic;
using System.Text;
using Infragistics.WebUI.WebDataInput;
using Statline.StatTrac.Data.Types;
using System.Web.UI;
using System.ComponentModel;
using Infragistics.WebUI.WebSchedule;

namespace Statline.StatTrac.Web.UI.WebControls
{
    public class WebDateTime : WebDateTimeEdit
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            EditModeFormat = ConstHelper.MILITARYDATETIME;
            SpinButtons.Display = ButtonDisplay.OnRight;
            ButtonsAppearance.CustomButtonDisplay = ButtonDisplay.OnRight;
            ButtonsAppearance.CustomButtonImageUrl = "./Images/cal.gif";
            EnableAppStyling =  Infragistics.WebUI.Shared.DefaultableBoolean.True;
            //ClientSideEvents.
        }
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            System.Globalization.CultureInfo ci = new System.Globalization.CultureInfo(ConstHelper.CULTUREINFOENUS);
            Culture = ci;
        }
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            WebCalendar calendar = (WebCalendar)Parent.FindControl(WebCalendarID);
            if (calendar == null)
                return;
            calendar.Style.Add("display", "none");
            webDateTimeEdit_LoadJavaScript(calendar); 
            
        }

        private string webCalendarID;
        [Bindable(true),
        Category("Misc"),
        DefaultValue(true),
        Description("Get or set a value indicating the webCalendar Server side ID. The control requires this ID if the calendar is use on the client.")]

        public string WebCalendarID
        {
            get { return webCalendarID; }
            set { webCalendarID = value; }
        }

        /// <summary>
        /// loads java script to use caledar client side
        /// </summary>                
        /// <seealso cref="http://community.infragistics.com/articles/make-webdatetimeedit-dropdown-webcalendar.aspx#MakeWebDateTimeEditDropDownaWebCalendar"/>
        public void webDateTimeEdit_LoadJavaScript(WebCalendar calendar)
        //string webCalendarClientID, string[] webDateTimeClientID, System.Web.UI.Page page)
        {
            string functionName = ID.ToString() + "_pageLoad";
            StringBuilder buildInit = new StringBuilder();

            buildInit.Append(@" function ");
            buildInit.Append(functionName);
            buildInit.Append(@"(object, eventArgs){");
            buildInit.Append(@"ig_initDropCalendar('");
            buildInit.Append(calendar.ClientID);
            buildInit.Append(@" ");
            buildInit.Append(ClientID);
            buildInit.Append(@"'); ");
            buildInit.Append(@"} ");
            buildInit.Append(@"Sys.Application.add_load( " + functionName + "); ");

            // change this to RegisterClientScriptInclude
            //Parent.Page.ClientScript.RegisterStartupScript(Parent.Page.GetType(), "ig_dropCalendar", "<script type='text/javascript' src='" + this.Parent.Page.ResolveUrl("~/scripts/ig_dropCalendar.js") + "'></script>");
            Parent.Page.ClientScript.RegisterClientScriptInclude("ig_dropCalendar", this.Parent.Page.ResolveUrl("~/scripts/ig_dropCalendar.js"));
            Parent.Page.ClientScript.RegisterStartupScript(Parent.Page.GetType(), ID.ToString(),
                buildInit.ToString(),
                true
                );
        }
    }
}
