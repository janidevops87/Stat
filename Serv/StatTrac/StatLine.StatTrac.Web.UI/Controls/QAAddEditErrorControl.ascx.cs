using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Person;
using Statline.StatTrac.Admin;
using Statline.StatTrac.Web.Security;
using Infragistics.WebUI.UltraWebGrid;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAAddEditErrorControl : BaseUserControlSecure
    {
        protected QAUpdateData dsQAData;
         
        protected void Page_Load(object sender, EventArgs e)
        {
            if (dsQAData == null) dsQAData = new QAUpdateData();
            Parent.Page.ClientScript.RegisterClientScriptInclude("CharactersRemaining", this.Parent.Page.ResolveUrl("~/scripts/CharactersRemaining.js"));
            odsCompletedBy.SelectParameters["OrganizationId"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsProcessStep.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
            
            if (!this.IsPostBack)
            {
                Application.Add("ValidPoints", "YES");
                int reportGroupID = 0;
                try
                {
                    AdminReferenceManager.GetUserAllReferralsReportGroup(
                        Page.Cookies.UserOrgID,
                         out reportGroupID);
                }
                catch
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                }
                Page.Cookies.ReportGroupID = reportGroupID;
                DateTime dtStartDate;
                dtStartDate = System.DateTime.Today;
                lblTrackingNumberData.Text = Request.QueryString["TrackingNumber"];
                Int32 test = 0;
                try
                {
                    test = Convert.ToInt32(Request.QueryString["TrackingNumber"]);
                    QAUpdateManager.FillQARefInfo(dsQAData, Request.QueryString["TrackingNumber"], reportGroupID); 
                }
                catch
                {
                }
                                
                if (dsQAData.QARefInfo.Count != 0)
                {
                    lblRefDateTime.Text = dsQAData.QARefInfo[0].CallTypeName + " " + "d/t:";
                    lblRefDateTimeData.Text = dsQAData.QARefInfo[0].CallDateTime.ToString(ConstHelper.MILITARYDATETIME);
                    lblRefTypeData.Text = dsQAData.QARefInfo[0].ReferralTypeName;
                    lblSourceCodeData.Text = dsQAData.QARefInfo[0].SourceCodeName;
                    lblTypeData.Text = dsQAData.QARefInfo[0].CallTypeName;
                    lblRefTypeID.Text = dsQAData.QARefInfo[0].ReferralTypeID1;
                    dateEvent.Value = dsQAData.QARefInfo[0].CallDateTime.ToString(ConstHelper.MILITARYDATETIME);
                }
                QAUpdateManager.FillQATracking(dsQAData, Request.QueryString["TrackingNumber"], Page.Cookies.UserOrgID);
                QAUpdateManager.FillQATrackingForm(dsQAData, Convert.ToInt32(Request.QueryString["TrackingFormID"]));
                Panel2.Visible = true;
                Panel3.Visible = false;
                if (dsQAData.QATracking.Count != 0)
                {
                    txtComments.Text = dsQAData.QATrackingForm[0].QATrackingFormComments;
                    txtCAPA.Text = dsQAData.QATrackingForm[0].QATrackingCAPANumber;
                    cbxQAApproved.Checked = Convert.ToBoolean(dsQAData.QATrackingForm[0].QATrackingApproved);
                    dateEvent.Value = dsQAData.QATrackingForm[0].QATrackingEventDateTime.ToString(ConstHelper.MILITARYDATETIME);
                       
                        if (dsQAData.QARefInfo.Count == 0)
                       
                        {
                            txtNotes.Text = dsQAData.QATracking[0].QATrackingNotes;
                           
                            Panel2.Visible = false;
                            Panel3.Visible = true;
                        }
                        else
                        {
                            
                            Panel2.Visible = true;
                            Panel3.Visible = false;
                        }
                   
                }
                QAUpdateManager.FillQAGridAddEditQualityMonitoringForm(dsQAData, Convert.ToInt32(Request.QueryString["FormID"]), Convert.ToInt32(Request.QueryString["TrackingFormID"]));
                gridErrorsbyLocation.DataBind();

                // Set Reviewed status checkbox
                if (!SecurityChecker.CheckAccessToRule(AuthRule.QAPendingReview))
                {
                    cbxReviewed.Visible = false;
                }
                else
                {
                    if (Request.QueryString["New"] == "1")
                    {
                        cbxReviewed.Visible = false;
                    }
                    else
                    {
                        cbxReviewed.Visible = true;
                        double pendingReview;
                        pendingReview = 0;
                        pendingReview = QAUpdateDB.GetPendingReview(Page.Cookies.UserOrgID, Convert.ToInt32(Request.QueryString["TrackingID"]), Convert.ToInt32(Request.QueryString["TrackingFormID"]));
                        if (pendingReview == 0)
                        {
                            cbxReviewed.Checked = true;
                        }
                    }
                }

            } // End not postback

            // Page Load events
            Application["ValidPoints"] = "Yes";
            lblEmployeeData.Text = Request.QueryString["EmployeeName"];
            if (Request.QueryString["New"] != "1")
            {
                ddlCompletedBy.Enabled = false;
            }
            //QA permission...update or delete
            if (!SecurityChecker.CheckAccessToRule(AuthRule.QAUpdate))
            {
                if (Request.QueryString["New"] != "1")
                {
                    btnDelete.Visible = false;
                    btnSave.Visible = false;
                }
                cbxQAApproved.Visible = false;
            }

            // ccarroll 04/11/2012 Bug 1190 CCRST143
            // Set Reviewed status checkbox moved to !postback area
            
            if (Request.QueryString["New"] != "1")
            {
                btnCancel.Visible = true;
            }
            else
            {
                btnCancel.Visible = false;
            }

            if (Request.QueryString["Save"] == "1" && Request.QueryString["New"] == "1")
            {
                btnCancel.Visible = true;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (gridErrorsbyLocation.Rows.Count!=0)
            {
                int loop1 = gridErrorsbyLocation.Rows.Count;
                for (int loop = 0; loop < loop1; loop++)
                {
                    QAUpdateDB.UpdateQAErrorLogDelete(Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[0].Text), Page.Cookies.StatEmployeeID);
                }
            }
            else
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "No locations/errorlog to delete.");
            }
            QueryStringManager.Redirect(PageName.QAMonitoring);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            
            if (IsValid())
            {
                btnCancel.Visible = true;
                try
                {
                    LoadTrackingData();
                    Response.Redirect("~/QAAddEditError.aspx?TrackingNumber=" + Request.QueryString["TrackingNumber"] + "&FormID=" + Convert.ToInt32(Request.QueryString["FormID"]) + "&TrackingFormID=" + Convert.ToInt32(Request.QueryString["TrackingFormID"]) + "&CompletedBy=" + Request.QueryString["CompletedBy"] + "&EmployeeName=" + Request.QueryString["EmployeeName"] + "&New=" + Request.QueryString["New"] + "&TrackingID=" + Request.QueryString["TrackingID"] + "&EmployeeID=" + Request.QueryString["EmployeeID"] + "&Save=1");
                    //LoadTrackingData();
                }

                catch (Exception ex)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
                }
            }
            
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["New"] == "1" || Request.QueryString["New"] == "2")
            {
                QueryStringManager.Redirect(PageName.QAMonitoring);
            }
            else
            {
                QueryStringManager.Redirect(PageName.QAPendingReview);
            }
        }

        public bool IsValid()
        {
            bool returnValue = true;
            if (Application["ValidPoints"].ToString() == "NO")
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "You must fill out the point values");
                returnValue = false;
                return returnValue;
            }
            if (ddlCompletedBy.SelectedIndex == -1)
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "You must select completed by");
                returnValue = false;
                return returnValue;
            }
            
            if (ddlProcessStep.SelectedIndex == -1 || ddlProcessStep.SelectedValue == "-1")
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "You must select a process step");
                returnValue = false;
                return returnValue;
            }
            return returnValue;
        }

        protected void gridErrorsbyLocation_DataBound(object sender, EventArgs e)
        {
            if (gridErrorsbyLocation.Rows.Count > 0)
            {
                lblFormName.Text = gridErrorsbyLocation.Rows[0].Cells[15].Value.ToString();
                decimal ptsAvail;
                ptsAvail = 0;
                decimal ptsEarned;
                ptsEarned = 0;
                bool showScore;
                showScore = true;
                ArrayList headerRows = new ArrayList();
                ArrayList headerLocations = new ArrayList();
                //the first row always has a header
                headerLocations.Add(gridErrorsbyLocation.Rows[0].Cells[14].Value.ToString());
                headerRows.Add(0);
                int loop1 = gridErrorsbyLocation.Rows.Count;
                for (int loop = 0; loop < loop1; loop++)
                {
                    
                    if (gridErrorsbyLocation.Rows[loop].Cells[0].Value.ToString() != "0")
                    {
                        if (gridErrorsbyLocation.Rows[loop].Cells[11].Value.ToString() == "0")
                        {
                            gridErrorsbyLocation.Columns[3].Hidden = true;
                            lblPointsAvailable.Visible = false;
                            lblPointsAvailableData.Visible = false;
                            lblPointsEarned.Visible = false;
                            lblPointsEarnedData.Visible = false;
                            lblScore.Visible = false;
                            lblScoreData.Visible = false;
                        }
                        
                        //display comments
                        if (gridErrorsbyLocation.Rows[loop].Cells[10].Value.ToString() == "0")
                        {
                            gridErrorsbyLocation.Rows[loop].Cells[8].AllowEditing = Infragistics.WebUI.UltraWebGrid.AllowEditing.No;
                        }
                        //points
                        if (gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString() != "N/A")
                        {
                            if (Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString()) > 0)
                                ptsAvail = ptsAvail + Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString());
                            if (gridErrorsbyLocation.Rows[loop].Cells[5].Value.ToString() == "1")
                            {
                                ptsEarned = ptsEarned + Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString());
                            }

                            if (gridErrorsbyLocation.Rows[loop].Cells[7].Value.ToString() == "1")
                            {
                                if (Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString()) > 0)
                                    ptsAvail = ptsAvail - Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString());
                            }
                            if (gridErrorsbyLocation.Rows[loop].Cells[12].Value.ToString() == "1" && gridErrorsbyLocation.Rows[loop].Cells[6].Value.ToString() == "1")
                                showScore = false;
                        }
                        if (loop+1 < loop1)
                        {
                            if (gridErrorsbyLocation.Rows[loop].Cells[14].Value.ToString() != gridErrorsbyLocation.Rows[loop + 1].Cells[14].Value.ToString())
                            {
                                headerLocations.Add(gridErrorsbyLocation.Rows[loop+1].Cells[14].Value.ToString());
                                headerRows.Add(loop+1);
                            }
                        }
                    }
                }
                lblPointsAvailableData.Text = ptsAvail.ToString();
                lblPointsEarnedData.Text = ptsEarned.ToString();
                if (showScore)
                {
                    decimal score;
                    score = 0;
                    if (ptsAvail != 0)
                    {
                        if (ptsEarned < 0)
                        {
                            ptsEarned = 0;
                        }
                        score = (ptsEarned / ptsAvail);
                    }
                    lblScoreData.Text = String.Format("{0:#0.0%}", score);
                }
                else
                {
                    lblScoreData.Text = Convert.ToString(0);
                }
                for (int i = headerLocations.Count - 1; i >= 0; i--)
                {
                    int rowNum = Convert.ToInt32(headerRows[i]);
                    object[] rowObject = { 0, "", "Location - " + headerLocations[i] };
                    UltraGridRow row = new UltraGridRow(rowObject);
                    gridErrorsbyLocation.Rows.Insert(rowNum, row);
                    gridErrorsbyLocation.Rows[rowNum].Style.BackColor = Color.LightGray;
                    gridErrorsbyLocation.Rows[rowNum].Cells[2].Style.Font.Underline = true;
                    gridErrorsbyLocation.Rows[rowNum].Cells[8].AllowEditing = Infragistics.WebUI.UltraWebGrid.AllowEditing.No; 
                }
                if (!string.IsNullOrEmpty(gridErrorsbyLocation.Rows[1].Cells[16].Text))
                  imgLogo.ImageUrl = "~/controls/images/logos/qa/" + gridErrorsbyLocation.Rows[1].Cells[16].Value.ToString();
            }
        }
        protected void GetPointsTest(object sender, EventArgs e)
        {
            RadioButtonList radiobuttonlist = (RadioButtonList)sender;
            CellItem ci = (CellItem)radiobuttonlist.Parent;
            int rownumber = ci.Cell.Row.Index;
            if (gridErrorsbyLocation.Rows[rownumber].Cells[0].Value.ToString() != "0")
            {
                if (radiobuttonlist.SelectedItem == null)
                {
                    Application["ValidPoints"] = "NO";
                }
            }
        }
        protected void GetPointsType(object sender, EventArgs e)
        {
            int i = gridErrorsbyLocation.Rows.Count;
            RadioButtonList radiolist = (RadioButtonList)sender;
            ListItem rblist;
            CellItem ci = (CellItem)radiolist.Parent;
            int rownumber = ci.Cell.Row.Index;
            if (gridErrorsbyLocation.Rows[rownumber].Cells[0].Value.ToString() != "0")
            {
                
                //display n/a
                if (gridErrorsbyLocation.Rows[rownumber].Cells[9].Value.ToString() != "0")
                {
                    rblist = new ListItem();
                    rblist.Text = "N/A";
                    rblist.Value = "-1";
                    if (gridErrorsbyLocation.Rows[rownumber].Cells[7].Value.ToString() == "1") rblist.Selected = true;
                    radiolist.Items.Insert(0, rblist);
                }

                rblist = new ListItem();
                rblist.Text = "N";
                rblist.Value = "0";
                rblist.Selected = false;
                if (gridErrorsbyLocation.Rows[rownumber].Cells[6].Value.ToString() == "1") rblist.Selected = true;
                radiolist.Items.Insert(0, rblist);

                rblist = new ListItem();
                rblist.Text = "Y";
                rblist.Value = "1";
                rblist.Selected = false;
                if (gridErrorsbyLocation.Rows[rownumber].Cells[5].Value.ToString() == "1") rblist.Selected = true;
                radiolist.Items.Insert(0, rblist);
            }
        }

        protected void gridErrorsbyLocation_UpdateRowBatch(object sender, RowEventArgs e)
        {
            Control postbackControlInstance = null;
            string postbackControlName = Page.Request.Params.Get("__EVENTTARGET");
            if (postbackControlName != null && postbackControlName != string.Empty)
            {
                postbackControlInstance = Page.FindControl(postbackControlName);
                if (postbackControlInstance.ID == "btnSave")
                {
                    QAUpdateData dsQAUpdateData = new QAUpdateData();
                    QAUpdateData.QAErrorLogRow row;
                    if (e.Row.DataChanged == DataChanged.Added)
                    {
                        // if it's a new row, create a new dataset row
                        row = dsQAUpdateData.QAErrorLog.NewQAErrorLogRow();
                        row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                        row["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
                    }
                    else
                    {
                        //int rowx = gridErrorsbyLocation.Columns.IndexOf();
                        QAUpdateManager.FillQAErrorLog(dsQAUpdateData, Convert.ToInt32(gridErrorsbyLocation.Rows[e.Row.Index].Cells[0].Value));
                        // else get a reference to the existing row in the dataset
                        row = dsQAUpdateData.QAErrorLog.FindByQAErrorLogID(
                            (int)e.Row.Cells[gridErrorsbyLocation.Columns.IndexOf("QAErrorLogID")].Value);
                        row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                        row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;
                    }

                    foreach (UltraGridCell cell in e.Row.Cells)
                    {

                        // update each data row with the grid row values 
                        if (cell.Key == "QAErrorLogID")
                            continue;
                        if (cell.DataChanged)
                        {
                            if (cell.Value != null)
                            {
                                row[cell.Column.BaseColumnName] = cell.Value;
                            }
                            else
                            {
                                row[cell.Column.BaseColumnName] = DBNull.Value;
                            }
                        }
                    }
                    if (e.Row.DataChanged == DataChanged.Added)
                    {
                        // if the row is a new row, add the row to the dataset
                        dsQAUpdateData.QAErrorLog.AddQAErrorLogRow(row);
                    }
                    try
                    {
                        QAUpdateDB.UpdateQAErrorLog(dsQAUpdateData);
                    }
                    catch
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                    }
                }
            }
        }
        protected void Status_Changed(object sender, EventArgs e)
        {
            Control postbackControlInstance = null;
            string postbackControlName = Page.Request.Params.Get("__EVENTTARGET");
            if (postbackControlName != null && postbackControlName != string.Empty)
            {
                postbackControlInstance = Page.FindControl(postbackControlName);
                if (postbackControlInstance.ID == "btnSave")
                {
                    int score = 0;
                    int score1 = 0;
                    dsQAData = new QAUpdateData();
                    QAUpdateData.QAErrorLogRow qaUpdateRow;
                    qaUpdateRow = dsQAData.QAErrorLog.NewQAErrorLogRow();
                    RadioButtonList radiobuttonlist = (RadioButtonList)sender;
                    CellItem ci = (CellItem)radiobuttonlist.Parent;
                    int rownumber = ci.Cell.Row.Index;
                    qaUpdateRow.QAErrorLogID = Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[0].Text);
                    if (radiobuttonlist.SelectedItem.Value == "1")
                    {
                        qaUpdateRow.QAErrorLogPointsYes = Convert.ToInt16(1);
                        qaUpdateRow.QAErrorLogPointsNo = Convert.ToInt16(0);
                        qaUpdateRow.QAErrorLogPointsNA = Convert.ToInt16(0);
                            // If QAErrorTypeGenerateLogIfNo = True
                            // Then saving Yes will remove errors
                            if (Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[18].Text) == 1)
                            {
                                score = Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[19].Text);
                                score1 = score - 1;
                                // if score goes negative default is zero
                                qaUpdateRow.QAErrorLogNumberOfErrors = score1 < 0 ? 0 : score1;
                            }
                            else
                                // If QAErrorTypeGenerateLogIfNo = False
                                // Then saving Yes will add errors
                            {
                                score = Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[19].Text);
                                score1 = score + 1;
                                qaUpdateRow.QAErrorLogNumberOfErrors = score1;
                            }
                        }
                    if (radiobuttonlist.SelectedItem.Value == "0")
                    {
                        qaUpdateRow.QAErrorLogPointsYes = Convert.ToInt16(0);
                        qaUpdateRow.QAErrorLogPointsNo = Convert.ToInt16(1);
                        qaUpdateRow.QAErrorLogPointsNA = Convert.ToInt16(0);
                        
                        // If QAErrorTypeGenerateLogIfNo = True
                        // Then saving No will add errors
                        if (Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[18].Text) == 1)
                        {
                            score = Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[19].Text);
                            score1 = score + 1;
                            qaUpdateRow.QAErrorLogNumberOfErrors = score1;
                        }
                        else
                        {   // If QAErrorTypeGenerateLogIfNo = True
                            // Then saving No will remove errors
                            score = Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[19].Text);
                            score1 = score - 1;
                            // if score goes negative default is zero
                            qaUpdateRow.QAErrorLogNumberOfErrors = score1 < 0 ? 0 : score1;
                        }
                    }
                    if (radiobuttonlist.SelectedItem.Value == "-1")
                    {
                        qaUpdateRow.QAErrorLogPointsYes = Convert.ToInt16(0);
                        qaUpdateRow.QAErrorLogPointsNo = Convert.ToInt16(0);
                        qaUpdateRow.QAErrorLogPointsNA = Convert.ToInt16(1);
                        if (Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[5].Text) == 1 || Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[6].Text) == 1 || Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[7].Text) == 1)
                        {
                            if (Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[18].Text) == 1)
                            {
                                score = Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[19].Text);
                                score1 = score - 1;
                                qaUpdateRow.QAErrorLogNumberOfErrors = score1;
                            }
                            if (Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[20].Text) == 1)
                            {
                                score = Convert.ToInt32(gridErrorsbyLocation.Rows[rownumber].Cells[19].Text);
                                score1 = score - 1;
                                qaUpdateRow.QAErrorLogNumberOfErrors = score1;
                            }
                        }
                    }
                    if (Request.QueryString["New"] == "1")
                    {
                        qaUpdateRow.StatEmployeeID = Convert.ToInt32(ddlCompletedBy.SelectedItem.Value);
                    }
                    qaUpdateRow.QAErrorLogPersonID = Convert.ToInt32(Request.QueryString["EmployeeID"]);
                    qaUpdateRow.QAErrorLogComments = gridErrorsbyLocation.Rows[rownumber].Cells[8].Text;
                    qaUpdateRow.LastStatEmployeeID = Page.Cookies.StatEmployeeID;
                    qaUpdateRow.AuditLogTypeID = 3;
                    dsQAData.QAErrorLog.AddQAErrorLogRow(qaUpdateRow);
                    QAUpdateDB.UpdateQAErrorLog(dsQAData);
                }
            }
        }
        protected void ddlCompletedBy_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["Save"] == "1" && Request.QueryString["New"] == "1")
                {
                    ListItem completedBy = ddlCompletedBy.Items.FindByValue(gridErrorsbyLocation.Rows[1].Cells[17].Text);
                    ddlCompletedBy.Items.Insert(0, new ListItem(completedBy.Text, completedBy.Value));
                }
                else
                    if (Request.QueryString["New"] == "1")
                    {
                        try
                        {
                            //ListItem personListItem = ddlCompletedBy.Items.FindByText(Page.Cookies.UserDisplayName);
                            int personID;
                            personID = QAUpdateManager.GetPersonID(Page.Cookies.UserId, 0);
                            ddlCompletedBy.Items.Insert(0, new ListItem(Page.Cookies.UserDisplayName, personID.ToString()));
                        }
                        catch
                        {
                        }
                    }
                    else
                    {
                        ddlCompletedBy.Items.Insert(0, new ListItem(Request.QueryString["CompletedBy"], "-1"));
                    }
            }
            catch
            {
                ddlCompletedBy.Items.Insert(0, new ListItem("", "-1"));
            }
        }

        protected void ddlProcessStep_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["Save"] == "1" && Request.QueryString["New"] == "1")
                {
                    ListItem processStep = ddlProcessStep.Items.FindByValue(dsQAData.QATrackingForm[0].QAProcessStepID.ToString());
                    ddlProcessStep.Items.Insert(0, new ListItem(processStep.Text, processStep.Value));
                }
                else
                {
                    if (!this.IsPostBack)
                    {
                        if (Request.QueryString["New"] == "1")
                        {
                            ddlProcessStep.Items.Insert(0, new ListItem("", "-1"));
                        }
                        else
                        {
                            ListItem processStep = ddlProcessStep.Items.FindByValue(dsQAData.QATrackingForm[0].QAProcessStepID.ToString());
                            ddlProcessStep.Items.Insert(0, new ListItem(processStep.Text, processStep.Value));
                        }
                    }
                }
            }
            catch
            {
                ddlProcessStep.Items.Insert(0, new ListItem("", "-1"));
            }
        }


        private void LoadTrackingData()
        {
            if (dsQAData == null) dsQAData = new QAUpdateData();
            QAUpdateManager.FillQATracking(dsQAData, Request.QueryString["TrackingNumber"], Page.Cookies.UserOrgID);
            dsQAData.QATracking[0].QATrackingNumber = Request.QueryString["TrackingNumber"];
            dsQAData.QATracking[0].QATrackingNotes = txtNotes.Text;
            if (!String.IsNullOrEmpty(lblRefTypeID.Text.ToString())) 
                dsQAData.QATracking[0].QATrackingReferralTypeID = Convert.ToInt32(lblRefTypeID.Text.ToString());
            dsQAData.QATracking[0].QATrackingSourceCode = lblSourceCodeData.Text;
            if (!String.IsNullOrEmpty(lblRefDateTimeData.Text.ToString()))
                dsQAData.QATracking[0].QATrackingReferralDateTime = Convert.ToDateTime(lblRefDateTimeData.Text.ToString());
            dsQAData.QATracking[0].OrganizationID = Page.Cookies.UserOrgID;
            dsQAData.QATracking[0].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
            dsQAData.QATracking[0].AuditLogTypeID = 3;
            //}
            try
            {
                QAUpdateDB.UpdateQATracking(dsQAData);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
            //do form update
            QAUpdateManager.FillQATrackingForm(dsQAData, Convert.ToInt32(Request.QueryString["TrackingFormID"]));
            dsQAData.QATrackingForm[0].QAProcessStepID = Convert.ToInt32(ddlProcessStep.SelectedItem.Value);
            dsQAData.QATrackingForm[0].QATrackingCAPANumber = txtCAPA.Text;
            dsQAData.QATrackingForm[0].QATrackingFormComments = txtComments.Text;
            dsQAData.QATrackingForm[0].QATrackingEventDateTime = Convert.ToDateTime(dateEvent.Text);
            dsQAData.QATrackingForm[0].QATrackingApproved = Convert.ToInt16(cbxQAApproved.Checked);
            //populate score in tracking form
            double points;
            points = 0;
            points = QAUpdateDB.GetPoints(Convert.ToInt32(Request.QueryString["FormID"]), Convert.ToInt32(Request.QueryString["TrackingFormID"]));
            dsQAData.QATrackingForm[0].QATrackingFormPoints = Convert.ToDecimal(points);
           
            try
            {
                QAUpdateDB.UpdateQATrackingForm(dsQAData);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
            //do error update if review checked
            QAUpdateManager.FillQAErrorLogTrackingNumber(dsQAData, Request.QueryString["TrackingNumber"], Convert.ToInt32(Request.QueryString["TrackingFormID"]));
            if (cbxReviewed.Checked == true)
            {
                for (int loop = 0; loop < dsQAData.QAErrorLog.Rows.Count; loop++)
                {//Reviewed
                    dsQAData.QAErrorLog[loop].QAProcessStepID = Convert.ToInt32(ddlProcessStep.SelectedItem.Value);
                    dsQAData.QAErrorLog[loop].QAErrorStatusID = 2;//Set to Reviewed
                    dsQAData.QAErrorLog[loop].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
                    dsQAData.QAErrorLog[loop].AuditLogTypeID = 3;
                    dsQAData.QAErrorLog[loop].QAErrorLogPersonID = Convert.ToInt32(Request.QueryString["EmployeeID"]);
                    dsQAData.QAErrorLog[loop].QAErrorLogDateTime = Convert.ToDateTime(dateEvent.Text);
                }
            }
            else
            {
                for (int loop = 0; loop < dsQAData.QAErrorLog.Rows.Count; loop++)
                {//not Reviewed
                    dsQAData.QAErrorLog[loop].QAErrorStatusID = 1;//Set to Not Reviewed
                    dsQAData.QAErrorLog[loop].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
                    dsQAData.QAErrorLog[loop].AuditLogTypeID = 3;
                    dsQAData.QAErrorLog[loop].QAProcessStepID = Convert.ToInt32(ddlProcessStep.SelectedItem.Value);
                    dsQAData.QAErrorLog[loop].QAErrorLogPersonID = Convert.ToInt32(Request.QueryString["EmployeeID"]);
                    dsQAData.QAErrorLog[loop].QAErrorLogDateTime = Convert.ToDateTime(dateEvent.Text);
                }
            }
            try
            {
                QAUpdateDB.UpdateQAErrorLog(dsQAData);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
        }





        private decimal CalculatePoints()
        {
            decimal returnValue = 0;
            decimal ptsAvail;
            ptsAvail = 0;
            decimal ptsEarned;
            ptsEarned = 0;
            bool showScore;
            showScore = true;
            int loop1 = gridErrorsbyLocation.Rows.Count;
            for (int loop = 0; loop < loop1; loop++)
            {
                if (gridErrorsbyLocation.Rows[loop].Cells[0].Value.ToString() != "0")
                {
                    //points
                    if (gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString() != "N/A")
                    {
                        if (Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString()) > 0)
                            ptsAvail = ptsAvail + Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString());
                        if (gridErrorsbyLocation.Rows[loop].Cells[5].Value.ToString() == "1")
                        {
                            ptsEarned = ptsEarned + Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString());
                        }

                        if (gridErrorsbyLocation.Rows[loop].Cells[7].Value.ToString() == "1")
                        {
                            if (Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString()) > 0)
                                ptsAvail = ptsAvail - Convert.ToInt32(gridErrorsbyLocation.Rows[loop].Cells[3].Value.ToString());
                        }
                        if (gridErrorsbyLocation.Rows[loop].Cells[12].Value.ToString() == "1" && gridErrorsbyLocation.Rows[loop].Cells[6].Value.ToString() == "1")
                            showScore = false;
                    }
                }
            }

            if (showScore)
            {
                decimal score;
                score = 0;
                if (ptsAvail != 0)
                {
                    if (ptsEarned < 0)
                    {
                        ptsEarned = 0;
                    }
                    score = (ptsEarned / ptsAvail);
                }
                returnValue = score;
            }
            else
            {
                returnValue = 0;
            }
            return returnValue;
        }
    }
}