using System;
using System.Data;
using System.Drawing;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.UI;
using Statline.StatTrac.Web.UI.Controls;
using Statline.StatTrac.Report;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class CallHeaderControl : BaseUserControlSecure
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            if (Page.Cookies.CallNumber != null)
            {
                //this.lblCallDT1.Text = Session["CallDT"].ToString();
                //this.lblCallNo1.Text = Session["CallNumber"].ToString();
                //this.lblCallID.Text = Session["CallID"].ToString();
                //this.lblPatientInfo.Text = Session["PatientInfo"].ToString();
                //this.lblRefFac1.Text = Session["OrganizationName"].ToString();
                //this.lblASR.Text = Session["ASR"].ToString();
                //this.lblCallOrgID.Text = Session["OrganizationID"].ToString();

                this.lblCallNo1.Text = Page.Cookies.CallNumber.ToString();
                this.lblCallID.Text = Page.Cookies.CallID.ToString();
                this.lblPatientInfo.Text = Page.Cookies.PatientInfo.ToString();
                this.lblRefFac1.Text = Page.Cookies.OrganizationName.ToString();
                this.lblASR.Text = Page.Cookies.PatientDemographics.ToString();
                this.lblCallOrgID.Text = Page.Cookies.OrganizationID.ToString();
            }
        }
       protected void UltraWebGrid1_DataBound(object sender, EventArgs e)
        {
            //have to get the data this way, because the date wouldn't come over as query string
           //this.lblCallDT1.Text = gridAppropriate.Rows[0].Cells[0].Text;
        }

        public void lblCallNo1_Click(object sender, EventArgs e)
        {
            Hashtable reportParams = new Hashtable();
            //DateTime fakeDate = System.DateTime.Today;
            reportParams.Add(ReportParams.DisplayMT, false);
            reportParams.Add(ReportParams.DisplayMedicalRecord, true);
            //reportParams.Add(ReportParams.ReferralStartDateTime,fakeDate);
            reportParams.Add(ReportParams.DisplayReferralName, true);
            reportParams.Add(ReportParams.DisplaySSN, true);
            reportParams.Add(ReportParams.CallID.ToString(), this.lblCallID.Text);
            reportParams.Add(ReportParams.ReportGroupID, Page.Cookies.ReportGroupID);
            //reportParams.Add(ReportParams.ReferralEndDateTime, fakeDate);
            reportParams.Add(ReportParams.DisplayEventLog, "True");
            reportParams.Add(ReportParams.UserOrgID, Page.Cookies.UserOrgID);
            reportParams.Add(ReportParams.UserID, Page.Cookies.UserId);
            reportParams.Add(ReportParams.UserDisplayName, Page.Cookies.UserDisplayName);

            Page.Cookies.ReportDisplayName = "Referral Detail";
            int reportID = 0;
            ReportReferenceData ds = new ReportReferenceData();
            try
            {
                ReportReferenceManager.FillUserReportList(ds, Page.Cookies.UserId, reportID, Page.Cookies.ReportDisplayName);

                if (ds.UserReportList != null)
                    Page.Cookies.ReportName = ds.UserReportList[ConstHelper.DEFAULTFIRSTRECORD].ReportVirtualURL;

            }
            catch 
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);

            }
            

            Page.Cookies.ReportParameters = reportParams;
            QueryStringManager.Redirect(PageName.ReportDisplay);
        }
    }
}