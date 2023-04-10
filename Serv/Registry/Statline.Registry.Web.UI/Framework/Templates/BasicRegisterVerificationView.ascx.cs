using System;
using Statline.StatTrac.Web.UI;
using Statline.StatTrac;
using Statline.Configuration;

namespace Statline.Registry.Web.UI.Framework.Templates
{
	/// <summary>
	///		Summary description for BasicRegisterView.
	/// </summary>
    public partial class BasicRegisterVerificationView : BaseUserControl
	{
		protected Statline.StatTrac.Web.UI.MasterPages.Region loginRegion;
		protected int currentYear;

		protected void Page_Load(object sender, System.EventArgs e)
		{		    
            this.currentYear = DateTime.Now.Year;
            if (IsPostBack)
                return;

		    string applicationTitle = 
			    ApplicationSettings.GetSetting( SettingName.ApplicationTitle );

		    //this.titleLabel.Text = applicationTitle;
            //set the currentTime
            DateTime currentTime = DateTime.Now;
            //determine
            double timeOffSet = TimeZoneOffSet.MountainTimeZoneOffSet(Page.Cookies.TimeZone, currentTime);
            currentTime = currentTime.AddHours(timeOffSet);

            //this.dateTimeLabel.Text = currentTime.ToLongDateString() + ' ' + currentTime.ToShortTimeString() + ' ' + Page.Cookies.TimeZone;
		}

        protected void Page_PreRender(object sender, EventArgs e)
        {
            try
            {
                Response.AddHeader("p3p", "CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
            }
            catch
            {

            }

        }

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
		}
		#endregion

	}
}