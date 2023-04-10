using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Person;
using Infragistics.WebUI.UltraWebGrid;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAAddEditErrorTypeControl : BaseUserControlSecure
    {
        protected QAUpdateData dsQAData;

        protected void Page_Load(object sender, EventArgs e)
        {
            odsTrackingTypes.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            odsErrorLocation.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            if (!this.IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["ErrorID"]))
                {
                    if (dsQAData == null) dsQAData = new QAUpdateData();
                    QAUpdateManager.FillQAForm(dsQAData, Page.Cookies.UserOrgID, Convert.ToInt32(Request.QueryString["ErrorID"]), Convert.ToInt32(Request.QueryString["TrackingTypeID"]));
                    gridForms.DataSource = dsQAData;
                    gridForms.DataMember = "DdlQAForms";
                    gridForms.DataBind();
                    QAUpdateManager.FillQAErrorType(dsQAData, Convert.ToInt32(Request.QueryString["ErrorID"]));
                    txtError.Text = dsQAData.QAErrorType[0].QAErrorTypeDescription;
                    cbxActive.Checked = Convert.ToBoolean(dsQAData.QAErrorType[0].QAErrorTypeActive);
                    cbxRequireReview.Checked = Convert.ToBoolean(dsQAData.QAErrorType[0].QAErrorRequireReview);
                    cbxAutoZeroScore.Checked = Convert.ToBoolean(dsQAData.QAErrorType[0].QAErrorTypeAutomaticZeroScore);
                    cbxDisplayNA.Checked = Convert.ToBoolean(dsQAData.QAErrorType[0].QAErrorTypeDisplayNA);
                    cbxDisplayComments.Checked = Convert.ToBoolean(dsQAData.QAErrorType[0].QAErrorTypeDisplayComments);
                    cbxGenerateErrorLog.Checked = Convert.ToBoolean(dsQAData.QAErrorType[0].QAErrorTypeGenerateLogIfNo);
                    cbxGenerateErrorLogYes.Checked = Convert.ToBoolean(dsQAData.QAErrorType[0].QAErrorTypeGenerateLogIfYes);
                    Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
                    if (dsQAData.QAErrorType[0].QAErrorTypeAssignedPoints == 0)
                    {
                        ddlAssignPts1.Items.Insert(0, new ListItem("N/A", dsQAData.QAErrorType[0].QAErrorTypeAssignedPoints.ToString()));
                    }
                    else
                    {
                        ddlAssignPts1.Items.Insert(0, new ListItem(dsQAData.QAErrorType[0].QAErrorTypeAssignedPoints.ToString(), dsQAData.QAErrorType[0].QAErrorTypeAssignedPoints.ToString()));
                    }
                    ddlErrorLocation.DisplayValue = Request.QueryString["LocationDesc"];
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                try
                {
                    LoadData();
                    QueryStringManager.Redirect(PageName.QAManageErrorTypes);
                }

                catch (Exception ex)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            QueryStringManager.Redirect(PageName.QAManageErrorTypes);
        }

        public bool IsValid()
        {
            bool returnValue = true;
            if (ddlTrackingType.SelectedIndex == -1 && ddlTrackingType.DisplayValue == null)
            {
                returnValue = false;
                ddlTrackingType.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must select a tracking type");
            }
            if (ddlErrorLocation.SelectedIndex == -1 && ddlErrorLocation.DisplayValue == null)
            {
                returnValue = false;
                ddlErrorLocation.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must select a error location");
            }
            if (cbxActive.Checked == false && String.IsNullOrEmpty(txtReason.Text))
            {
                returnValue = false;
                txtReason.Focus();
                DisplayMessages.Add(MessageType.ErrorMessage, "You must enter a reason for making this error type inactive");
            }
            return returnValue;
        }

        private void LoadData()
        {
            QAUpdateData dsQAData = new QAUpdateData();
            if (String.IsNullOrEmpty(Request.QueryString["ErrorID"]))
            {
                QAUpdateData.QAErrorTypeRow row;
                row = dsQAData.QAErrorType.NewQAErrorTypeRow();
                row["QATrackingTypeID"] = Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value);
                row["QAErrorLocationID"] = Convert.ToInt32(ddlErrorLocation.SelectedRow.Cells[0].Value);
                row["QAErrorTypeDescription"] = txtError.Text;
                row["QAErrorRequireReview"] = Convert.ToInt16(cbxRequireReview.Checked);
                row["QAErrorTypeActive"] = Convert.ToInt16(cbxActive.Checked);
                row["QAErrorTypeDisplayNA"] = Convert.ToInt16(cbxDisplayNA.Checked);
                row["QAErrorTypeDisplayComments"] = Convert.ToInt16(cbxDisplayComments.Checked);
                row["QAErrorTypeGenerateLogIfNo"] = Convert.ToInt16(cbxGenerateErrorLog.Checked);
                row["QAErrorTypeGenerateLogIfYes"] = Convert.ToInt16(cbxGenerateErrorLogYes.Checked);
                row["QAErrorTypeAutomaticZeroScore"] = Convert.ToInt16(cbxAutoZeroScore.Checked);
                row["QAErrorTypeAssignedPoints"] = Convert.ToInt32(ddlAssignPts1.SelectedValue);
                row["OrganizationID"] = Page.Cookies.UserOrgID;
                row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                row["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
                dsQAData.QAErrorType.AddQAErrorTypeRow(row);
                QAUpdateDB.UpdateQAErrorType(dsQAData);
                QAUpdateDB.FillErrorType(dsQAData,Page.Cookies.UserOrgID,0,0 );
                for (int loop = 0; loop < gridForms.Rows.Count; loop++)
                {
                    if (Convert.ToBoolean(gridForms.Rows[loop].Cells[2].Value)==true)
                    {
                        QAUpdateData.QAMonitoringFormTemplateRow row1;
                        row1 = dsQAData.QAMonitoringFormTemplate.NewQAMonitoringFormTemplateRow();
                        row1["QAMonitoringFormID"] = gridForms.Rows[loop].Cells[0].Value;
                        row1["QAMonitoringFormTemplateActive"] = 1;
                        int errortypeid = Convert.ToInt32(dsQAData.DdlErrorType.Compute("Max(QAErrorTypeID)", ""));
                        row1["QAErrorTypeID"] = errortypeid;
                        row1["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                        row1["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
                        dsQAData.QAMonitoringFormTemplate.AddQAMonitoringFormTemplateRow(row1);
                    }
                }
                if (dsQAData.QAMonitoringFormTemplate.Count > 0)
                {
                    try
                    {
                        QAUpdateDB.UpdateQAMonitoringFormTemplate(dsQAData);
                    }
                    catch
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                    }
                }
            }
            else
            {
                QAUpdateManager.FillQAErrorType(dsQAData, Convert.ToInt32(Request.QueryString["ErrorID"]));
                if (ddlTrackingType.SelectedRow == null)
                {
                    //dsQAData.QAErrorType[0].QATrackingTypeID = Convert.ToInt32(Request.QueryString["TrackingTypeID"]);
                }
                else
                {
                    dsQAData.QAErrorType[0].QATrackingTypeID = Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value);
                }
                if (ddlErrorLocation.SelectedRow == null)
                {
                    dsQAData.QAErrorType[0].QAErrorLocationID = Convert.ToInt32(Request.QueryString["LocationID"]);
                }
                else
                {
                    dsQAData.QAErrorType[0].QAErrorLocationID = Convert.ToInt32(ddlErrorLocation.SelectedRow.Cells[0].Value);
                }
                dsQAData.QAErrorType[0].QAErrorTypeAssignedPoints = Convert.ToInt32(ddlAssignPts1.SelectedValue);
                dsQAData.QAErrorType[0].QAErrorTypeDescription = txtError.Text;
                dsQAData.QAErrorType[0].QAErrorRequireReview = Convert.ToInt16(cbxRequireReview.Checked);
                dsQAData.QAErrorType[0].QAErrorTypeActive = Convert.ToInt16(cbxActive.Checked);
                dsQAData.QAErrorType[0].QAErrorTypeDisplayNA = Convert.ToInt16(cbxDisplayNA.Checked);
                dsQAData.QAErrorType[0].QAErrorTypeDisplayComments = Convert.ToInt16(cbxDisplayComments.Checked);
                dsQAData.QAErrorType[0].QAErrorTypeGenerateLogIfNo = Convert.ToInt16(cbxGenerateErrorLog.Checked);
                dsQAData.QAErrorType[0].QAErrorTypeGenerateLogIfYes = Convert.ToInt16(cbxGenerateErrorLogYes.Checked);
                dsQAData.QAErrorType[0].QAErrorTypeAutomaticZeroScore = Convert.ToInt16(cbxAutoZeroScore.Checked);
                dsQAData.QAErrorType[0].QAErrorTypeInactiveComments = txtReason.Text;
                QAUpdateDB.UpdateQAErrorType(dsQAData, Convert.ToInt32(Request.QueryString["ErrorID"]));
            }
        }

        protected void ddlTrackingType_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlTrackingType.DropDownLayout.BaseTableName = "QATrackingType";
            ddlTrackingType.Columns[ddlTrackingType.Columns.IndexOf("QATrackingTypeID")].Hidden = true;
        }

        protected void ddlErrorLocation_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlErrorLocation.DropDownLayout.BaseTableName = "QAErrorLocation";
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("QAErrorLocationID")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("OrganizationID")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("QAErrorLocationActive")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("LastModified")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("LastStatEmployeeID")].Hidden = true;
            ddlErrorLocation.Columns[ddlErrorLocation.Columns.IndexOf("AuditLogTypeID")].Hidden = true;
        }

        protected void ddlErrorLocation_PreRender(object sender, EventArgs e)
        {
            ddlErrorLocation.DisplayValue = Request.QueryString["LocationDesc"];
        }

        protected void cbxGenerateErrorLog_CheckedChanged(object sender, EventArgs e)
        {
            if (cbxGenerateErrorLogYes.Checked == true)
            {
                cbxGenerateErrorLogYes.Checked = false; 
            }
        }

        protected void cbxGenerateErrorLogYes_CheckedChanged(object sender, EventArgs e)
        {
            if (cbxGenerateErrorLog.Checked == true)
            {
                cbxGenerateErrorLog.Checked = false;
            }

        }

        protected void ddlTrackingType_PreRender(object sender, EventArgs e)
        {
            ddlTrackingType.DisplayValue = Request.QueryString["TrackingDesc"];
        }

        protected void gridForms_UpdateRowBatch(object sender, RowEventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["ErrorID"]))
            {
                foreach (UltraGridCell cell in e.Row.Cells)
                {
                    int qmfid = 0;
                    // update each data row with the grid row values 
                    if (cell.Key == "QAMonitoringFormID")
                    {
                        qmfid = Convert.ToInt32(cell.Value);
                        continue;
                    }
                    if (cell.Key == "QAMonitoringFormName")
                        continue;

                    if (cell.Key == "QAMonitoringFormTemplateID")
                        continue;
                    QAUpdateData dsQAUpdateData = new QAUpdateData();

                    if (String.IsNullOrEmpty(gridForms.Rows[e.Row.Index].Cells[3].Text) && cell.Column.BaseColumnName == "QAMonitoringFormTemplateActive")
                    {
                        QAUpdateData.QAMonitoringFormTemplateRow row1;
                        row1 = dsQAUpdateData.QAMonitoringFormTemplate.NewQAMonitoringFormTemplateRow();
                        row1["QAMonitoringFormID"] = Convert.ToInt32(gridForms.Rows[e.Row.Index].Cells[0].Text);
                        //row1["QAMonitoringFormTemplateActive"] = 1;
                        row1["QAMonitoringFormTemplateActive"] = Convert.ToInt16(gridForms.Rows[e.Row.Index].Cells[2].Text);
                        row1["QAErrorTypeID"] = Convert.ToInt32(Request.QueryString["ErrorID"]);
                        row1["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                        row1["AuditLogTypeID"] = ConstHelper.AuditLogType.CREATE;
                        dsQAUpdateData.QAMonitoringFormTemplate.AddQAMonitoringFormTemplateRow(row1);
                    }
                    else
                    {
                        QAUpdateData.QAMonitoringFormTemplateRow row;
                        qmfid = Convert.ToInt32(gridForms.Rows[e.Row.Index].Cells[0].Text);
                        QAUpdateManager.FillQAMonitoringFormTemplate(dsQAUpdateData, qmfid);
                        row = dsQAUpdateData.QAMonitoringFormTemplate.NewQAMonitoringFormTemplateRow();
                        row = dsQAUpdateData.QAMonitoringFormTemplate.FindByQAMonitoringFormTemplateID(
                            (int)e.Row.Cells[gridForms.Columns.IndexOf("QAMonitoringFormTemplateID")].Value);
                        row["QAMonitoringFormTemplateActive"] = Convert.ToInt16(gridForms.Rows[e.Row.Index].Cells[2].Text);
                        row["LastStatEmployeeID"] = Page.Cookies.StatEmployeeID;
                        row["AuditLogTypeID"] = ConstHelper.AuditLogType.MODIFY;
                    }
                    try
                    {
                        QAUpdateDB.UpdateQAMonitoringFormTemplate(dsQAUpdateData);
                    }
                    catch
                    {
                        DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
                    }
                }
            }
        }

        protected void gridForms_DataBound(object sender, EventArgs e)
        {
            int loop1 = gridForms.Rows.Count;
            for (int loop = 0; loop < loop1; loop++)
            {
                if (gridForms.Rows[loop].Cells[2].Value.ToString() == "1")
                    gridForms.Rows[loop].Cells[2].AllowEditing = Infragistics.WebUI.UltraWebGrid.AllowEditing.No;
            }
        }
    }
}