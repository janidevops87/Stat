using System;
using System.Web.UI;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Person;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAPendingReviewControl : BaseUserControlSecure
    {
        protected QAUpdateData dsQAData;
        protected ReferralData dsRefData;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.dsRefData = new Statline.StatTrac.Data.Types.ReferralData();
                this.dsRefData.DataSetName = "ReferralData";
                QAUpdateManager.FillPersonListQA(dsRefData, Page.Cookies.UserOrgID);
                gridEmployees.DataBind();
                Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
            }
        }

        protected void gridErrorsPendingReview_DataBound(object sender, EventArgs e)
        {
            for (int loop = 0; loop < gridErrorsPendingReview.Rows.Count; loop++)
            {
                if (dsQAData.GridPendingReview[loop].TrackingType == "QM Form")
                {
                    gridErrorsPendingReview.Rows[loop].Cells[0].Text = "QM Form";
                    gridErrorsPendingReview.Rows[loop].Cells[0].TargetURL = string.Format("@[]QAAddEditError.aspx?TrackingNumber={0}&FormID={1}&TrackingFormID={2}&EmployeeName={3}&CompletedBy={4}&EmployeeID={5}&TrackingID={6}", dsQAData.GridPendingReview[loop].QATrackingNumber, dsQAData.GridPendingReview[loop].QAMonitoringFormID, dsQAData.GridPendingReview[loop].QATrackingFormID, dsQAData.GridPendingReview[loop].Employee, dsQAData.GridPendingReview[loop].StatEmployeeName, dsQAData.GridPendingReview[loop].QAErrorLogPersonID, dsQAData.GridPendingReview[loop].QATrackingID);
                }
                else
                {
                    gridErrorsPendingReview.Rows[loop].Cells[0].Text = "Error Type";
                    gridErrorsPendingReview.Rows[loop].Cells[0].TargetURL = string.Format("@[]QAErrorDetail.aspx?ErrorLogID={0}&Location={1}&LocationID={2}&New={3}&ErrorName={4}&ProcessStepName={5}&HowIdentified={6}&TrackingNumber={7}&Employee={8}&PersonID={9}&TrackingID={10}&TrackingDesc={11}", dsQAData.GridPendingReview[loop].QAErrorLogID, dsQAData.GridPendingReview[loop].LocationDesc, dsQAData.GridPendingReview[loop].LocationID, 0, null, dsQAData.GridPendingReview[loop].QAProcessStepDescription, dsQAData.GridPendingReview[loop].QAErrorLogHowIdentifiedDescription, dsQAData.GridPendingReview[loop].QATrackingNumber, dsQAData.GridPendingReview[loop].Employee, dsQAData.GridPendingReview[loop].PersonID, dsQAData.GridPendingReview[loop].QATrackingID, dsQAData.GridPendingReview[loop].TrackingDesc);
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string Personids;
            Personids = null;
            
            for (int loop = 0; loop < gridEmployees.Rows.Count - 1; loop++)
            {
                if (Convert.ToBoolean(gridEmployees.Rows[loop].Cells[0].Value) == true)
                {
                    if (!String.IsNullOrEmpty(Personids))
                    {
                         Personids = Personids + "," + gridEmployees.Rows[loop].Cells[2].Text.ToString();
                    }
                    else
                    {
                        Personids = gridEmployees.Rows[loop].Cells[2].Text.ToString();
                    }
                }
            }
            UpdatePendingGrid(Personids);
        }

        protected void UpdatePendingGrid(string Personids)
        {
            this.dsQAData = new Statline.StatTrac.Data.Types.QAUpdateData();
            this.dsQAData.DataSetName = "QAUpdateData";
            DateTime fromDate;
            DateTime toDate;
            if (string.IsNullOrEmpty(dateFrom.Text))
            {
                fromDate = System.DateTime.Now.AddYears(-2);
                toDate = System.DateTime.Now.AddYears(2);
            }
            else
            {
                fromDate = Convert.ToDateTime(dateFrom.Value);
                toDate = Convert.ToDateTime(dateTo.Value);
            }
            QAUpdateManager.FillQAGridPendingReview(dsQAData, Page.Cookies.UserOrgID, Personids, fromDate, toDate);
            gridErrorsPendingReview.DataBind();
        }
    }
}