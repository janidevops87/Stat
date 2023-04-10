using System;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Person;
using System.Web.UI;
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAErrorDetailControl : BaseUserControlSecure
    {
        protected  QAUpdateData dsQAData;

        protected void Page_Load(object sender, EventArgs e)
        {
            Parent.Page.ClientScript.RegisterClientScriptInclude("CharactersRemaining", this.Parent.Page.ResolveUrl("~/scripts/CharactersRemaining.js"));
            lblEmployeeData.Text = Request.QueryString["Employee"];
            lblErrorLocationData.Text = Request.QueryString["Location"];
            lblTrackingNumberData.Text = Request.QueryString["TrackingNumber"];
            odsTrackingType.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsProcessStep.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsErrorType.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsErrorType.SelectParameters["QAErrorLocationID"].DefaultValue = Request.QueryString["LocationID"];
            odsErrorType.SelectParameters["QATrackingTypeID"].DefaultValue = Request.QueryString["TrackingTypeID"];
            if (!this.IsPostBack)
            {//what to do if this already exists or is new
                if (Request.QueryString["New"] == "0")
                {
                    if (dsQAData == null) dsQAData = new QAUpdateData();
                    ddlTrackingType.Enabled = false;
                    QAUpdateManager.FillQAErrorLog(dsQAData, Convert.ToInt32(Request.QueryString["ErrorLogID"]));
                    Application["ErrorTypeID"] = dsQAData.QAErrorLog[0].QAErrorTypeID.ToString();
                    txtNumberofErrors.Text = dsQAData.QAErrorLog[0].QAErrorLogNumberOfErrors.ToString();
                    if (!String.IsNullOrEmpty(dsQAData.QAErrorLog[0].QAErrorLogDateTime.ToString()))
                    {
                        dateErrorDateTime.Text = dsQAData.QAErrorLog[0].QAErrorLogDateTime.ToString(ConstHelper.MILITARYDATETIME);
                    }
                    txtTicketNumber.Text = dsQAData.QAErrorLog[0].QAErrorLogTicketNumber;
                    txtComment.Text = dsQAData.QAErrorLog[0].QAErrorLogComments;
                    txtCorrection.Text = dsQAData.QAErrorLog[0].QAErrorLogCorrection;
                    lblLastPersonSaved.Text = dsQAData.QAErrorLog[0].lastmod;
                    if (!String.IsNullOrEmpty(dsQAData.QAErrorLog[0].lastmod))
                    {
                        lblLastDateSaved.Text = dsQAData.QAErrorLog[0].QAErrorLogCorrectionLastModified.ToString(ConstHelper.MILITARYDATETIME);
                    }
                    btnDelete.Enabled = true;
                    if (!SecurityChecker.CheckAccessToRule(AuthRule.QAPendingReview))
                    {
                        cbxReviewed.Visible = false;
                    }
                    else
                    {
                        cbxReviewed.Visible = true;
                        double pendingReview;
                        pendingReview = 0;
                        int trackingformID;
                        trackingformID = 0;
                        if (!String.IsNullOrEmpty(Request.QueryString["TrackingFormID"]))
                        {
                            trackingformID = Convert.ToInt32(Request.QueryString["TrackingFormID"]);
                            cbxReviewed.Visible = false;
                        }
                        else
                        {
                            trackingformID = 0;
                        }
                        pendingReview = QAUpdateDB.GetPendingReview(Page.Cookies.UserOrgID, Convert.ToInt32(Request.QueryString["TrackingID"]), trackingformID);
                        if (pendingReview == 0)
                            cbxReviewed.Checked = true;
                    }
                    if (!SecurityChecker.CheckAccessToRule(AuthRule.QAUpdate))
                    {
                        btnDelete.Visible = false;
                        btnSave.Visible = false;
                    }
                }
                else
                {
                    if (Request.QueryString["Add"] == "0")
                    {
                        ddlTrackingType.Enabled = false;
                    }
                    else
                    {
                        ddlTrackingType.Enabled = true;
                    }

                    cbxReviewed.Visible = false;
                    try
                    {
                        if (dsQAData == null) dsQAData = new QAUpdateData();
                        QAUpdateManager.FillQATracking(dsQAData, Request.QueryString["TrackingNumber"], Page.Cookies.UserOrgID);
                        dateErrorDateTime.Text = dsQAData.QATracking[0].QATrackingReferralDateTime.ToString(ConstHelper.MILITARYDATETIME);
                    }
                    catch
                    {
                        dateErrorDateTime.Text = DateTime.Now.ToString(ConstHelper.MILITARYDATETIME);
                    }
                }
                Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/QAErrorLog.aspx?PersonName=" + Request.QueryString["Employee"] + "&Location=" + Request.QueryString["Location"] + "&LocationID=" + Request.QueryString["LocationID"] + "&PersonID=" + Request.QueryString["PersonID"] + "&TrackingNumber=" + lblTrackingNumberData.Text + "&TrackingID=" + Request.QueryString["TrackingID"]);
        }

        protected void ddlHowIndentified_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlHowIndentified.DropDownLayout.BaseTableName = "QAErrorLogHowIdentified";
            ddlHowIndentified.Columns[ddlHowIndentified.Columns.IndexOf("QAErrorLogHowIdentifiedID")].Hidden = true;
        }

        protected void ddlProcessStep_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlProcessStep.DropDownLayout.BaseTableName = "DdlProcessStep";
            ddlProcessStep.Columns[ddlProcessStep.Columns.IndexOf("QAProcessStepID")].Hidden = true;
        }

        protected void ddlError_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlError.DropDownLayout.BaseTableName = "DdlErrorType";
            ddlError.Columns[ddlError.Columns.IndexOf("QAErrorTypeID")].Hidden = true;
            ddlError.Columns[ddlError.Columns.IndexOf("QAErrorTypeGenerateLogIfNo")].Hidden = true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            QAUpdateDB.UpdateQAErrorLogDelete(Convert.ToInt32(Request.QueryString["ErrorLogID"]),Page.Cookies.StatEmployeeID);
            Response.Redirect("~/QAErrorLog.aspx?PersonName=" + Request.QueryString["Employee"] + "&Location=" + Request.QueryString["Location"] + "&LocationID=" + Request.QueryString["LocationID"] + "&PersonID=" + Request.QueryString["PersonID"] + "&TrackingNumber=" + lblTrackingNumberData.Text + "&TrackingID=" + Request.QueryString["TrackingID"]);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {   //save tracking type change
                try
                {
                    if (dsQAData == null) dsQAData = new QAUpdateData();
                    QAUpdateManager.FillQATracking(dsQAData, lblTrackingNumberData.Text, Page.Cookies.UserOrgID);
                    if (dsQAData.QATracking.Count != 0)
                    {
                        if (ddlTrackingType.SelectedIndex != -1)
                        {
                            dsQAData.QATracking[0].QATrackingTypeID = Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value);
                        }
                        else
                        {
                            //dsQAData.QATracking[0].QATrackingTypeID = 1; no longer can default to statrac tracking type if not previously set up
                        }
                        dsQAData.QATracking[0].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
                        dsQAData.QATracking[0].AuditLogTypeID = 3;
                        QAUpdateDB.UpdateQATracking(dsQAData);
                    }
                }

                catch (Exception ex)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
                }
            //save error
                try
                {
                    LoadData();
                    Response.Redirect("~/QAErrorLog.aspx?PersonName=" + Request.QueryString["Employee"] + "&Location=" + Request.QueryString["Location"] + "&LocationID=" + Request.QueryString["LocationID"] + "&PersonID=" + Request.QueryString["PersonID"] + "&TrackingNumber=" + lblTrackingNumberData.Text + "&TrackingID=" + Request.QueryString["TrackingID"]);
                }
            
                catch (Exception ex)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
                }
               
            }
        }
        public bool IsValid()
        {
            bool returnValue = true;
            
            if (ddlError.SelectedIndex == -1 && ddlError.DisplayValue == null)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "You must select an error type");
                return returnValue;
            }
            
            if (ddlProcessStep.SelectedIndex == -1 && ddlProcessStep.DisplayValue == null)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "You must select a process step");
                return returnValue;
            }
            
            if (string.IsNullOrEmpty(txtNumberofErrors.Text))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "You must enter a number of errors");
                return returnValue;
            }
            if (Convert.ToInt32(txtNumberofErrors.Text) <= 0)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "Number of errors must be greater than 0");
                return returnValue;
            }
            if (string.IsNullOrEmpty(dateErrorDateTime.Text))
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "No date entered");
                return returnValue;
            }
            TimeSpan ts = Convert.ToDateTime(dateErrorDateTime.Value) - System.DateTime.Now;
            if (ts.Minutes > 0)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "Date beyond current date/time");
                return returnValue;
            }
            return returnValue;
        }
        private void LoadData()
        {
            QAUpdateData dsQAData = new QAUpdateData();
            if (String.IsNullOrEmpty(Request.QueryString["ErrorLogID"]))
            {
                QAUpdateData.QAErrorLogRow row;
                row = dsQAData.QAErrorLog.NewQAErrorLogRow();
                QAUpdateManager.FillQATracking(dsQAData, lblTrackingNumberData.Text, Page.Cookies.UserOrgID);
                row["QATrackingID"] = dsQAData.QATracking[0].QATrackingID;
                row["QAErrorTypeID"] = Convert.ToInt32(ddlError.SelectedRow.Cells[0].Value);
                row["QAProcessStepID"] = Convert.ToInt32(ddlProcessStep.SelectedRow.Cells[0].Value);
                row["QAErrorLogNumberOfErrors"] = Convert.ToInt32(txtNumberofErrors.Text);
                row["QAErrorLogDateTime"] = Convert.ToDateTime(dateErrorDateTime.Text);
                //pending status default to 1
                row["QAErrorStatusID"] = 1;
                if (ddlHowIndentified.SelectedRow != null)
                {
                    row["QAErrorLogHowIdentifiedID"] = Convert.ToInt32(ddlHowIndentified.SelectedRow.Cells[0].Value);
                }
                row["QAErrorLogTicketNumber"] = txtTicketNumber.Text;
                row["QAErrorLogComments"] = txtComment.Text;
                row["QAErrorLocationID"] = Convert.ToInt32(Request.QueryString["LocationID"]);
                row["StatEmployeeID"] = Convert.ToInt32(Request.QueryString["PersonID"]);
                row["QAErrorLogPersonID"] = Convert.ToInt32(Request.QueryString["PersonID"]);
                if (txtCorrection.Text.Length > 0)
                {
                    row["QAErrorLogCorrection"] = txtCorrection.Text;
                    row["QAErrorLogCorrectionPersonID"] = Page.Cookies.StatEmployeeID;
                    row["QAErrorLogCorrectionLastModified"] = System.DateTime.Now;
                }
                row["QAErrorLogCorrectionPersonID"] = Page.Cookies.StatEmployeeID; 
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = 1;
                dsQAData.QAErrorLog.AddQAErrorLogRow(row);
                QAUpdateDB.UpdateQAErrorLogInsert(dsQAData);
            }
            else
            {
                if (dsQAData == null) dsQAData = new QAUpdateData();
                QAUpdateManager.FillQAErrorLog(dsQAData, Convert.ToInt32(Request.QueryString["ErrorLogID"]));
                if (ddlError.SelectedIndex != -1)
                {
                    dsQAData.QAErrorLog[0].QAErrorTypeID = Convert.ToInt32(ddlError.SelectedRow.Cells[0].Value);
                }
                
                if (ddlProcessStep.SelectedIndex != -1)
                {
                    dsQAData.QAErrorLog[0].QAProcessStepID = Convert.ToInt32(ddlProcessStep.SelectedRow.Cells[0].Value);
                }
                
                dsQAData.QAErrorLog[0].QAErrorLogNumberOfErrors = Convert.ToInt32(txtNumberofErrors.Text);
                dsQAData.QAErrorLog[0].QAErrorLogDateTime = Convert.ToDateTime(dateErrorDateTime.Text);
                if (ddlHowIndentified.SelectedRow != null)
                {
                    dsQAData.QAErrorLog[0].QAErrorLogHowIdentifiedID = Convert.ToInt32(ddlHowIndentified.SelectedRow.Cells[0].Value);
                }
                dsQAData.QAErrorLog[0].QAErrorLogTicketNumber = txtTicketNumber.Text;
                dsQAData.QAErrorLog[0].QAErrorLogComments = txtComment.Text;
                if (txtCorrection.Text.Length > 0)
                {
                    dsQAData.QAErrorLog[0].QAErrorLogCorrection = txtCorrection.Text;
                    dsQAData.QAErrorLog[0].QAErrorLogCorrectionPersonID = Page.Cookies.StatEmployeeID;
                    dsQAData.QAErrorLog[0].QAErrorLogCorrectionLastModified = System.DateTime.Now;
                }
                dsQAData.QAErrorLog[0].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
                dsQAData.QAErrorLog[0].AuditLogTypeID = 3;
                try
                {
                    string test = dsQAData.QAErrorLog[0].QAMonitoringFormTemplateID.ToString();
                }
                catch
                {
                    if (cbxReviewed.Checked == true)
                    {
                        dsQAData.QAErrorLog[0].QAErrorStatusID = 2;//Set to Reviewed
                    }
                    else
                    {
                        dsQAData.QAErrorLog[0].QAErrorStatusID = 1;//Set to Not Reviewed
                    }
                }
                QAUpdateDB.UpdateQAErrorLog(dsQAData);
            }
        }

        protected void ddlError_PreRender(object sender, EventArgs e)
        {
            if (Request.QueryString["New"] == "0")
            {
                if (!String.IsNullOrEmpty(Request.QueryString["ErrorName"]))
                {
                    ddlError.DisplayValue = Request.QueryString["ErrorName"];
                }
                else
                {
                    try
                    {
                        QAUpdateManager.FillQAErrorType(dsQAData, Convert.ToInt32(Application["ErrorTypeID"]));
                        if (dsQAData.QAErrorType.Count > 0)
                            ddlError.DisplayValue = dsQAData.QAErrorType[0].QAErrorTypeDescription;
                    }
                    catch
                    {
                    }
                }
            }
        }

        protected void ddlProcessStep_PreRender(object sender, EventArgs e)
        {
            if (Request.QueryString["New"] == "0")
            {
                if (!String.IsNullOrEmpty(Request.QueryString["ProcessStepName"]))
                    ddlProcessStep.DisplayValue = Request.QueryString["ProcessStepName"];
                
            }
        }

        protected void ddlHowIndentified_PreRender(object sender, EventArgs e)
        {
            if (Request.QueryString["New"] == "0")
            {
                if (!String.IsNullOrEmpty(Request.QueryString["HowIdentified"]))
                    ddlHowIndentified.DisplayValue = Request.QueryString["HowIdentified"];
                
            }
        }

        protected void ddlTrackingType_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlTrackingType.DropDownLayout.BaseTableName = "QATrackingType";
            ddlTrackingType.Columns[ddlTrackingType.Columns.IndexOf("QATrackingTypeID")].Hidden = true;
        }

        protected void ddlTrackingType_PreRender(object sender, EventArgs e)
        {
            if (Request.QueryString["New"] == "0" || Request.QueryString["Add"] == "0")
            {
                if (!String.IsNullOrEmpty(Request.QueryString["TrackingDesc"]))
                    ddlTrackingType.DisplayValue = Request.QueryString["TrackingDesc"];

            }
        }
           
    }
}