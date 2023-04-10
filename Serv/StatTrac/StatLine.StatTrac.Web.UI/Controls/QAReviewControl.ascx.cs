using System;
using System.Data;
using System.Web.UI;
using Statline.StatTrac.Data.QAUpdate;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.QAUpdate;
using Statline.StatTrac.Person;
using Statline.StatTrac.Admin;
using Statline.StatTrac.Web.Security;
using Infragistics.WebUI.UltraWebGrid;

namespace Statline.StatTrac.Web.UI.Controls
{
    public partial class QAReviewControl : BaseUserControlSecure
    {
        protected QAUpdateData dsQAData;
        protected DataView trackingTypedv;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!SecurityChecker.CheckAccessToRule(AuthRule.QAViewOtherOrgs))
            {
                ddlOrganization.Visible = false;
                lblOrganization.Visible = false;
            }
            Parent.Page.ClientScript.RegisterClientScriptInclude("CharactersRemaining", this.Parent.Page.ResolveUrl("~/scripts/CharactersRemaining.js"));
            odsOrg.SelectParameters["userOrgID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
            
            Page.Cookies.StatEmployeeID = PersonManager.CheckStatEmployee(Page.Cookies.StatEmployeeID, Page.Cookies.UserId);
            btnAddTracking.Enabled = false;
            if (!this.Page.IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["TrackingNumber"]))
                {
                    if (dsQAData == null) dsQAData = new QAUpdateData();
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
                        Panel3.Visible = false;
                        Panel2.Visible = true;
                        btnSave.Visible = false;
                        webCalendar.Visible = false;
                        lblRefDateTime.Text = dsQAData.QARefInfo[0].CallTypeName + " " + "d/t:";
                        lblRefDateTimeData.Text = dsQAData.QARefInfo[0].CallDateTime.ToString(ConstHelper.MILITARYDATETIME);
                        lblRefTypeData.Text = dsQAData.QARefInfo[0].ReferralTypeName;
                        lblSourceCodeData.Text = dsQAData.QARefInfo[0].SourceCodeName;
                        lblTypeData.Text = dsQAData.QARefInfo[0].CallTypeName;
                    }
                    txtTrackingNumber.Text = Request.QueryString["TrackingNumber"];
                }
                odsGrid.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                odsTrackingType.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                if (!String.IsNullOrEmpty(Request.QueryString["TrackingNumber"]))
                {
                    odsGrid.SelectParameters["QATrackingNumber"].DefaultValue = Request.QueryString["TrackingNumber"];
                }
                else
                {
                    odsGrid.SelectParameters["QATrackingNumber"].DefaultValue = txtTrackingNumber.Text.ToString();
                }
            }
        }
        
        protected void ddlOrganization_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
        {
            ddlOrganization.DropDownLayout.BaseTableName = "OrganizationList";
            ddlOrganization.Columns[ddlOrganization.Columns.IndexOf("OrganizationID")].Hidden = true;
        }

        protected void ddlOrganization_SelectedRowChanged(object sender, Infragistics.WebUI.WebCombo.SelectedRowChangedEventArgs e)
        {
            int qaTrackingTypeID;
            if (ddlTrackingType.SelectedRow != null)
            {
                qaTrackingTypeID = Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value);
            }
            else
            {
                qaTrackingTypeID = Convert.ToInt32(null);
            }
            ddlTrackingType.DisplayValue = null;
            odsTrackingType.SelectParameters["OrganizationID"].DefaultValue = Convert.ToInt32(ddlOrganization.SelectedRow.Cells[1].Value).ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                if (ddlOrganization.SelectedRow != null)
                {
                    odsGrid.SelectParameters["OrganizationID"].DefaultValue = ddlOrganization.SelectedRow.Cells[1].Value.ToString();
                }
                else
                {
                    odsGrid.SelectParameters["OrganizationID"].DefaultValue = Page.Cookies.UserOrgID.ToString();
                }
                odsGrid.SelectParameters["QATrackingNumber"].DefaultValue = txtTrackingNumber.Text.ToString();
                odsGrid.SelectParameters["TrackingTypeID"].DefaultValue = ddlTrackingType.SelectedRow.Cells[0].Value.ToString();
                if (dsQAData == null) dsQAData = new QAUpdateData();
                try
                {
                    Int32 test1 = Convert.ToInt32(txtTrackingNumber.Text);
                    QAUpdateManager.FillQARefInfo(dsQAData, txtTrackingNumber.Text, Page.Cookies.ReportGroupID);
                }
                catch
                {

                }
                if (dsQAData.QARefInfo.Count != 0)
                {
                    Panel3.Visible = false;
                    Panel2.Visible = true;
                    btnSave.Visible = false;
                    webCalendar.Visible = false;
                    lblRefDateTime.Text = dsQAData.QARefInfo[0].CallTypeName + " " + "d/t:";
                    lblRefDateTimeData.Text = dsQAData.QARefInfo[0].CallDateTime.ToString(ConstHelper.MILITARYDATETIME);
                    lblRefTypeData.Text = dsQAData.QARefInfo[0].ReferralTypeName;
                    lblSourceCodeData.Text = dsQAData.QARefInfo[0].SourceCodeName;
                    lblTypeData.Text = dsQAData.QARefInfo[0].CallTypeName;
                    btnAdd.Enabled = true;
                    QAUpdateManager.FillQATracking(dsQAData, txtTrackingNumber.Text, Page.Cookies.UserOrgID);
                    if (dsQAData.QATracking.Count == 0)
                    {
                        int newTrackingID;
                        newTrackingID = 0;
                        newTrackingID = QAUpdateDB.InsertTrackingNumber(txtTrackingNumber.Text, Page.Cookies.UserOrgID, Page.Cookies.StatEmployeeID, dsQAData.QARefInfo[0].SourceCodeName, dsQAData.QARefInfo[0].CallDateTime, Convert.ToInt32(dsQAData.QARefInfo[0].ReferralTypeID1), Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value),0);
                        Label1.Text = newTrackingID.ToString();
                    }
                    else
                    {
                        Label1.Text = dsQAData.QATracking[0].QATrackingID.ToString();
                    }
                }
                else
                {
                    if (dsQAData == null) dsQAData = new QAUpdateData();
                    QAUpdateManager.FillQATracking(dsQAData, txtTrackingNumber.Text, Page.Cookies.UserOrgID);
                    if (dsQAData.QATracking.Rows.Count != 0)
                    {
                        txtNotes.Text = dsQAData.QATracking[0].QATrackingNotes;
                        try
                        {//fix to catch old tracking numbers with null
                            dateEventDateTime.Text = dsQAData.QATracking[0].QATrackingReferralDateTime.ToString();
                        }
                        catch
                        {
                            dateEventDateTime = null;
                        }
                        btnAdd.Enabled = true;
                        Label1.Text = dsQAData.QATracking[0].QATrackingID.ToString();
                    }
                    else
                    {
                        dateEventDateTime.Text = System.DateTime.Now.ToString(ConstHelper.MILITARYDATETIME);
                        txtNotes.Text = null;
                        DisplayMessages.Add(MessageType.ErrorMessage, "Tracking Number Not Found");
                    }
                    webCalendar.Visible = true;
                    Panel3.Visible = true;
                    Panel2.Visible = false;
                    btnSave.Visible = true;
                }
                btnAddTracking.Enabled = true;
                lblTrackingNumberData.Text = txtTrackingNumber.Text;
            }
        }

        protected void btnAddTracking_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                Int32 testStatTrac = 0;
                Int32 notAlpha = 0;
                try
                {
                    if (ddlTrackingType.SelectedRow.Cells[1].Value.ToString() == "StatTrac")
                    {
                        notAlpha = Convert.ToInt32(txtTrackingNumber.Text);
                        testStatTrac = QAUpdateManager.GetValidTrackingNumber(Convert.ToInt32(txtTrackingNumber.Text), Page.Cookies.ReportGroupID, 0);
                    }
                }
                catch
                {

                }
                //see if its in stattrac
                if (dsQAData == null) dsQAData = new QAUpdateData();
                if (notAlpha > 0)
                {
                    QAUpdateManager.FillQARefInfo(dsQAData, txtTrackingNumber.Text, Page.Cookies.ReportGroupID);
                }
                btnAdd.Enabled = true;
                btnAddTracking.Enabled = true;
                QAUpdateManager.FillQATracking(dsQAData, txtTrackingNumber.Text, Page.Cookies.UserOrgID);
                if (dsQAData.QATracking.Count == 0)
                {
                    int newTrackingID;
                    newTrackingID = 0;
                    if (testStatTrac != 0 && dsQAData.QARefInfo.Count > 0)
                    {
                        newTrackingID = QAUpdateDB.InsertTrackingNumber(txtTrackingNumber.Text, Page.Cookies.UserOrgID, Page.Cookies.StatEmployeeID, dsQAData.QARefInfo[0].SourceCodeName, dsQAData.QARefInfo[0].CallDateTime, Convert.ToInt32(dsQAData.QARefInfo[0].ReferralTypeID1), Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value),0);
                    }
                    else
                    {
                        newTrackingID = QAUpdateDB.InsertTrackingNumber(txtTrackingNumber.Text, Page.Cookies.UserOrgID, Page.Cookies.StatEmployeeID, null, System.DateTime.Now, 0, Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value),0);
                    }
                    Label1.Text = newTrackingID.ToString();
                }
                else
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "Warning! Duplicate Tracking Number");
                    Label1.Text = dsQAData.QATracking[0].QATrackingID.ToString();
                    if (testStatTrac==0) return;
                    
                }
                if (dsQAData.QARefInfo.Count != 0)
                {
                    Panel3.Visible = false;
                    Panel2.Visible = true;
                    webCalendar.Visible = false;
                    lblRefDateTime.Text = dsQAData.QARefInfo[0].CallTypeName + " " + "d/t:";
                    lblRefDateTimeData.Text = dsQAData.QARefInfo[0].CallDateTime.ToString(ConstHelper.MILITARYDATETIME);
                    lblRefTypeData.Text = dsQAData.QARefInfo[0].ReferralTypeName;
                    lblSourceCodeData.Text = dsQAData.QARefInfo[0].SourceCodeName;
                    lblTypeData.Text = dsQAData.QARefInfo[0].CallTypeName;
                    btnSave.Visible = false;
                }
                else
                {
                    if (dsQAData == null) dsQAData = new QAUpdateData();
                    QAUpdateManager.FillQATracking(dsQAData, txtTrackingNumber.Text, Page.Cookies.UserOrgID);
                    if (dsQAData.QATracking.Rows.Count != 0)
                    {
                        txtNotes.Text = dsQAData.QATracking[0].QATrackingNotes;
                        try
                        {//fix to catch old tracking numbers with null
                            dateEventDateTime.Text = dsQAData.QATracking[0].QATrackingReferralDateTime.ToString();
                        }
                        catch
                        {
                            dateEventDateTime = null;
                        }
                        btnAdd.Enabled = true;
                        Label1.Text = dsQAData.QATracking[0].QATrackingID.ToString();
                    }
                    else
                    {
                        dateEventDateTime.Text = System.DateTime.Now.ToString(ConstHelper.MILITARYDATETIME);
                        txtNotes.Text = null;
                    }
                    webCalendar.Visible = true;
                    Panel3.Visible = true;
                    Panel2.Visible = false;
                    btnSave.Visible = true;
                }
                lblTrackingNumberData.Text = txtTrackingNumber.Text;
            }
        }

        public bool IsValid()
        {
            bool returnValue = true;
            if (String.IsNullOrEmpty(txtTrackingNumber.Text))
            {
                DisplayMessages.Add(MessageType.ErrorMessage, "You must enter a tracking number");
                returnValue = false;
            }
            if (ddlTrackingType.SelectedIndex == -1 && ddlTrackingType.DisplayValue == null)
            {
                returnValue = false;
                DisplayMessages.Add(MessageType.ErrorMessage, "You must select a tracking type");
                return returnValue;
            }
            return returnValue;
        }

        protected void btn_Add_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                int newTrackingID;
                newTrackingID = 0;
                if (Label1.Text == null)
                {
                    newTrackingID = QAUpdateDB.InsertTrackingNumber(txtTrackingNumber.Text, Page.Cookies.UserOrgID, Page.Cookies.StatEmployeeID, dsQAData.QARefInfo[0].SourceCodeName, dsQAData.QARefInfo[0].CallDateTime, Convert.ToInt32(dsQAData.QARefInfo[0].ReferralTypeID1), Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value),0);
                    Label1.Text = newTrackingID.ToString();
                }
                Response.Redirect("~/QAErrorLog.aspx?TrackingNumber=" + txtTrackingNumber.Text + "&TrackingID=" + Label1.Text + "&TrackingTypeID=" + Convert.ToInt32(ddlTrackingType.SelectedRow.Cells[0].Value) + "&TrackingDesc=" + ddlTrackingType.SelectedRow.Cells[1].Value);
            }
        }

        protected void ddlOrganization_PreRender(object sender, EventArgs e)
        {
            if (!this.Page.IsPostBack)
            {
                ddlOrganization.DisplayValue = Page.Cookies.UserOrganizationName;
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            btnAdd.Enabled = false;
            txtTrackingNumber.Text = null;
            txtTrackingNumber.Focus();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                try
                {
                    if (dsQAData == null) dsQAData = new QAUpdateData();
                    QAUpdateManager.FillQATracking(dsQAData, txtTrackingNumber.Text, Page.Cookies.UserOrgID);
                    if (dsQAData.QATracking.Count != 0)
                    {
                        dsQAData.QATracking[0].QATrackingNotes = txtNotes.Text;
                        dsQAData.QATracking[0].QATrackingReferralDateTime = Convert.ToDateTime(dateEventDateTime.Text);
                        dsQAData.QATracking[0].LastStatEmployeeID = Page.Cookies.StatEmployeeID;
                        dsQAData.QATracking[0].AuditLogTypeID = 3;
                        QAUpdateDB.UpdateQATracking(dsQAData);
                    }
                }

                catch (Exception ex)
                {
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the updates from being saved. Please logout and try again. ");
                }
            }
        }
        protected void ddlTrackingType_InitializeLayout(object sender, LayoutEventArgs e)
        {
            ddlTrackingType.DropDownLayout.BaseTableName = "QATrackingType";
            ddlTrackingType.Columns[ddlTrackingType.Columns.IndexOf("QATrackingTypeID")].Hidden = true;
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            // Set ColumnFilter If QueryString exists
            if (!String.IsNullOrEmpty(Request.QueryString["TrackingType"]))
            {
                int count = ddlTrackingType.Rows.Count;

                string trackingType = Request.QueryString["TrackingType"];
                if (ddlTrackingType.FindByText(trackingType) != null)
                {
                    ddlTrackingType.SelectedRow = ddlTrackingType.FindByText(trackingType).Row;
                }
            }   
        }
    }
}