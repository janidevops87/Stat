using System;
using System.Web.UI;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Person;
using Statline.StatTrac.Web.Security;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAErrorLogControl : BaseUserControlSecure
    {
        protected QAUpdateData dsQAData;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["LocationID"]))
                {
                    btnAddError.Enabled = true;
                    odsGrid.SelectParameters["QAErrorLocationID"].DefaultValue = Request.QueryString["LocationID"];
                }
                if (!String.IsNullOrEmpty(Request.QueryString["PersonID"]))
                {
                    odsGrid.SelectParameters["PersonID"].DefaultValue = Request.QueryString["PersonID"];
                }
                if (!String.IsNullOrEmpty(Request.QueryString["TrackingID"]))
                {
                    odsGrid.SelectParameters["QATrackingID"].DefaultValue = Request.QueryString["TrackingID"];
                }
                odsErrorLocation.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                odsErrorLocation.SelectParameters["QATrackingTypeID"].DefaultValue = Request.QueryString["TrackingTypeID"];
                odsEmployee.SelectParameters["OrganizationId"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            }
            lblTrackingNumberData.Text = Request.QueryString["TrackingNumber"];
            if (!SecurityChecker.CheckAccessToRule(AuthRule.QAUpdate))
            {
                //btnAddError.Visible = false;
                btnDelete.Visible = false;
                btnSave.Visible = false;
            }
            Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
        }

        protected void ddlEmployee_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            if (ddlErrorLocation.SelectedRow != null)
            {
                btnAddError.Enabled = true;
                odsGrid.SelectParameters["QAErrorLocationID"].DefaultValue = ddlErrorLocation.SelectedRow.Cells[0].Value.ToString();
            }
            odsGrid.SelectParameters["PersonID"].DefaultValue = ddlEmployee.SelectedRow.Cells[0].Value.ToString();
        }

        protected void ddlErrorLocation_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            if (ddlEmployee.SelectedRow != null)
            {
                btnAddError.Enabled = true;
                odsGrid.SelectParameters["PersonID"].DefaultValue = ddlEmployee.SelectedRow.Cells[0].Value.ToString();
            }
            odsGrid.SelectParameters["QAErrorLocationID"].DefaultValue = ddlErrorLocation.SelectedRow.Cells[0].Value.ToString();
        }

        protected void ddlEmployee_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlEmployee.DropDownLayout.BaseTableName = "PersonbyOrg";
            ddlEmployee.Columns[ddlEmployee.Columns.IndexOf("PersonID")].Hidden = true;
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int qaErrorLocationID;
            int qaStatEmployeeID;
            if (ddlErrorLocation.SelectedIndex != -1)
            {
                qaErrorLocationID = Convert.ToInt32(ddlErrorLocation.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaErrorLocationID = Convert.ToInt32(Request.QueryString["LocationID"]);
            }
            if (ddlEmployee.SelectedIndex != -1)
            {
                qaStatEmployeeID = Convert.ToInt32(ddlEmployee.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaStatEmployeeID = Convert.ToInt32(Request.QueryString["PersonID"]);
            }
            QAUpdateDB.UpdateQAErrorLogDeleteMulti(qaErrorLocationID,qaStatEmployeeID, Page.Cookies.StatEmployeeID);
            Response.Redirect("~/QAReview.aspx?TrackingNumber=" + lblTrackingNumberData.Text);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (dsQAData == null) dsQAData = new QAUpdateData();
            int qaErrorLocationID;
            int qaStatEmployeeID;
            if (ddlErrorLocation.SelectedIndex != -1)
            {
                qaErrorLocationID = Convert.ToInt32(ddlErrorLocation.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaErrorLocationID = Convert.ToInt32(Request.QueryString["LocationID"]);
            }
            if (ddlEmployee.SelectedIndex != -1)
            {
                qaStatEmployeeID = Convert.ToInt32(ddlEmployee.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaStatEmployeeID = Convert.ToInt32(Request.QueryString["PersonID"]);
            }
            QAUpdateManager.FillQAGridErrorTypeLog(dsQAData, Convert.ToInt32(Request.QueryString["TrackingID"]), Convert.ToInt32(Request.QueryString["LocationID"]), Convert.ToInt32(Request.QueryString["PersonID"]));
            QAUpdateManager.FillQAErrorLog(dsQAData, Convert.ToInt32(Request.QueryString["PersonID"]), Convert.ToInt32(Request.QueryString["LocationID"]));
            if (dsQAData.QAErrorLog.Count > 0)
            {
                for (int loop = 0; loop < dsQAData.QAErrorLog.Rows.Count; loop++)
                {
                    dsQAData.QAErrorLog[loop].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
                    dsQAData.QAErrorLog[loop].AuditLogTypeID = 3;
                    if (cbxNoErrors.Checked == true) dsQAData.QAErrorLog[loop].QAErrorLogNumberOfErrors = 0;
                }
                QAUpdateDB.UpdateQAErrorLog(dsQAData);
                Response.Redirect("~/QAReview.aspx?TrackingNumber=" + lblTrackingNumberData.Text);
            }
            else
            {
                if (ddlEmployee.DisplayValue == null || ddlErrorLocation.DisplayValue == null)
                {
                    //do nothing
                }
                else
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "No Error Logs for " + ddlEmployee.DisplayValue.ToString() + " and/or " + ddlErrorLocation.DisplayValue.ToString());
                }
            }
            
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/QAReview.aspx?TrackingNumber=" + lblTrackingNumberData.Text);
        }

        protected void btnAddError_Click(object sender, EventArgs e)
        {
            int qaErrorLocationID;
            int qaStatEmployeeID;
            if (ddlErrorLocation.SelectedIndex != -1)
            {
                qaErrorLocationID = Convert.ToInt32(ddlErrorLocation.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaErrorLocationID = Convert.ToInt32(Request.QueryString["LocationID"]);
            }
            if (ddlEmployee.SelectedIndex != -1)
            {
                qaStatEmployeeID = Convert.ToInt32(ddlEmployee.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaStatEmployeeID = Convert.ToInt32(Request.QueryString["PersonID"]);
            }
            Response.Redirect("~/QAErrorDetail.aspx?Employee=" + ddlEmployee.DisplayValue + "&Location=" + ddlErrorLocation.DisplayValue + "&LocationID=" + qaErrorLocationID + "&PersonID=" + qaStatEmployeeID + "&TrackingNumber=" + lblTrackingNumberData.Text + "&TrackingID=" + Request.QueryString["TrackingID"] + "&TrackingTypeID=" + Request.QueryString["TrackingTypeID"] + "&Add=" + 0 + "&TrackingDesc=" + Request.QueryString["TrackingDesc"]);
        }

        protected void ddlEmployee_PreRender(object sender, EventArgs e)
        {
            if (!this.Page.IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["PersonName"]))
                {
                    ddlEmployee.DisplayValue = Request.QueryString["PersonName"];
                }
            }
        }

        protected void ddlErrorLocation_PreRender(object sender, EventArgs e)
        {
            if (!this.Page.IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["Location"]))
                {
                    ddlErrorLocation.DisplayValue = Request.QueryString["Location"];
                }
            }
        }

        protected void btnAddPerson_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/PersonData.aspx");
        }

        protected void gridErrorLog_DataBound(object sender, EventArgs e)
        {
            int qaStatEmployeeID;
           
            if (ddlEmployee.SelectedIndex != -1)
            {
                qaStatEmployeeID = Convert.ToInt32(ddlEmployee.SelectedRow.Cells[0].Value);
            }
            
            else
            {
            try
                {
                    qaStatEmployeeID = Convert.ToInt32(Request.QueryString["PersonID"]);
                }
            catch
                {
                    qaStatEmployeeID = 0;
                }
            }
            for (int loop = 0; loop < gridErrorLog.Rows.Count; loop++)
            {
                gridErrorLog.Rows[loop].Cells[2].Text = gridErrorLog.Rows[loop].Cells[2].Value.ToString();
                gridErrorLog.Rows[loop].Cells[2].TargetURL = string.Format("@[]QAErrorDetail.aspx?ErrorLogID={0}&Location={1}&LocationID={2}&New={3}&ErrorName={4}&ProcessStepName={5}&HowIdentified={6}&TrackingNumber={7}&Employee={8}&PersonID={9}&TrackingID={10}&TrackingDesc={11}&TrackingFormID={12}&TrackingTypeID={13}", gridErrorLog.Rows[loop].Cells[0].Value, gridErrorLog.Rows[loop].Cells[17].Value, gridErrorLog.Rows[loop].Cells[16].Value, 0, null, gridErrorLog.Rows[loop].Cells[5].Value, gridErrorLog.Rows[loop].Cells[9].Value, lblTrackingNumberData.Text, ddlEmployee.DisplayValue, qaStatEmployeeID, Request.QueryString["TrackingID"], gridErrorLog.Rows[loop].Cells[18].Value, gridErrorLog.Rows[loop].Cells[19].Value, Request.QueryString["TrackingTypeID"]);
            }
        }
    }
}