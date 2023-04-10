using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using Statline.Configuration;
using Statline.StatTrac.Web.UI;
using Statline.Registry.Common;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace Statline.Registry.Web.UI.Controls.Dynamic
{
    public partial class EnrollmentMobileControl : BaseUserControl
    {
        Int32 RegistryOwnerID = 0;
        String LanguageCode;
        String RegistryOwnerIDValue;
        String RegistryOwnerRouteName;
        String RegistryOwnerLanguageCode;
        bool IDologyActive;
        bool IDologyUsesSSN;
        bool EnrollmentFormHideComments;
        String EnrollmentFormDefaultStateSelection;
        String LimitationsMaxLength = "200";
        String CommentsMaxLength = "100";
        String LicenseOrStateIDMaxLength = "9";
        String CSSFileLocation;

        bool AllowDisplayNoDonors;
        bool AllowDonorToPrintVerificationForm;
        bool EnrollmentFormDisplayLicenseOrStateID;


        String lblNameInstruction = string.Empty;
        const int Mobile = 2;


        protected RegistryCommon dsDonorData;
        protected RegistryCommon dsRegistry;
        protected RegistryCommon dsAddr;
        protected RegistryCommon dsEvent;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["RegistryOwnerID"] != null)
                RegistryOwnerID = Convert.ToInt32(Session["RegistryOwnerID"]);
            else if (hdnRegistryOwnerRouteName.Value.ToString() == "None")
            {
                RegistryOwnerID = 0; //Default Value, Not a postback
                CleanSessionState();
            }
            else
            { //session expired while user was on Enrollment Page. Try to scrape Key Session Values from hidden form values and 
                // save to session
                //scrape Key Session Values
                RegistryOwnerID = Convert.ToInt32((string)hdnRegistryOwnerID.Value.ToString());
                Session.Add("RegistryOwnerID", Convert.ToInt32((string)hdnRegistryOwnerID.Value.ToString()));
                Session.Add("LanguageCode", (string)hdnLanguageCode.Value.ToString());
                Session.Add("RegistryOwnerRouteName", (string)hdnRegistryOwnerRouteName.Value.ToString());
                Session.Add("AllowDisplayNoDonors", (string)(hdnAllowDisplayNoDonors.Value.ToString()));
                Session.Add("CSSFileLocation", (string)hdnCSSFileLocation.Value.ToString());
            }

            // Maintain position on postback
            Page.MaintainScrollPositionOnPostBack = true;

            if (!IsPostBack)
            {
                System.Globalization.CultureInfo ci = System.Globalization.CultureInfo.CreateSpecificCulture("en-EN");
                ci.DateTimeFormat.LongDatePattern = "MM/dd/yyyy";
                ci.DateTimeFormat.ShortDatePattern = "MM/dd/yyyy";
                ci.Calendar.TwoDigitYearMax = DateTime.Now.Year;
                //ddlDOB.CalendarLayout.Culture = ci;

                if (HttpContext.Current.Items["Owner"] == null)
                {   // Determine if this is a query string or session request
                    RegistryOwnerIDValue = Request.QueryString["RegistryOwnerID"] != null ? HttpUtility.UrlDecode(Request.QueryString["RegistryOwnerID"]) : Session["RegistryOwnerID"].ToString();
                    RegistryOwnerRouteName = String.Empty;

                    if (Session["LanguageCode"] == null)
                    { RegistryOwnerLanguageCode = Request.QueryString["LanguageCode"] == null ? "en" : HttpUtility.UrlDecode(Request.QueryString["LanguageCode"]); }
                    else
                    { RegistryOwnerLanguageCode = (string)(Session["LanguageCode"].ToString()); }
                }
                else
                {   // Prepair to use route information
                    RegistryOwnerIDValue = "0";
                    RegistryOwnerRouteName = HttpContext.Current.Items["Owner"].ToString() == null ? "ne" : HttpContext.Current.Items["Owner"].ToString();
                    RegistryOwnerLanguageCode = HttpContext.Current.Items["language"].ToString() == null ? "en" : HttpContext.Current.Items["language"].ToString();
                }


                Session.Add("LanguageCode", RegistryOwnerLanguageCode.ToString());
                LanguageCode = (string)(Session["LanguageCode"].ToString());


                //Get Specific RegistryOwner Settings
                if (dsRegistry == null)
                    dsRegistry = new RegistryCommon();
                try
                {
                    RegistryCommonManager.FillRegistryOwner(dsRegistry, Convert.ToInt32(RegistryOwnerIDValue), RegistryOwnerRouteName);
                }
                catch (Exception ex)
                {
                    Logger.Write(ex, "General", 1);
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented this page from loading.");
                }

                try
                {
                    //Get Registry Owner information and options
                    RegistryOwnerID = (dsRegistry.RegistryOwner[0].RegistryOwnerID);
                    IDologyActive = (dsRegistry.RegistryOwner[0].IDologyActive);
                    IDologyUsesSSN = Convert.ToBoolean(dsRegistry.RegistryOwner[0].IdologyUsesSSN);
                    Session.Add("IDologyActive", IDologyActive.ToString());
                    EnrollmentFormHideComments = dsRegistry.RegistryOwner[0].EnrollmentFormHideComments;
                    EnrollmentFormDefaultStateSelection = dsRegistry.RegistryOwner[0].EnrollmentFormDefaultStateSelection;
                    CSSFileLocation = dsRegistry.RegistryOwner[0].CSSFileLocation.Replace("Enrollment", "EnrollmentMobile");
                    AllowDisplayNoDonors = dsRegistry.RegistryOwner[0].AllowDisplayNoDonors;
                    Session.Add("AllowDisplayNoDonors", AllowDisplayNoDonors.ToString());
                    AllowDonorToPrintVerificationForm = dsRegistry.RegistryOwner[0].AllowDonorToPrintVerificationForm;
                    Session.Add("AllowDonorToPrintVerificationForm", AllowDonorToPrintVerificationForm.ToString());
                    EnrollmentFormDisplayLicenseOrStateID = dsRegistry.RegistryOwner[0].EnrollmentFormDisplayLicenseOrStateID;
                    
                    //Set UI text box length
                    LimitationsMaxLength = dsRegistry.RegistryOwner[0].EnrollmentFormLimitationsMaxLength.ToString();
                    CommentsMaxLength = dsRegistry.RegistryOwner[0].EnrollmentFormCommentsMaxLength.ToString();                    
                    
                    //Create sessions
                    Session.Add("RegistryOwnerID", RegistryOwnerID.ToString());
                    Session.Add("RegistryOwnerRouteName", (string)RegistryOwnerRouteName.ToString());
                    Session.Add("CSSFileLocation", CSSFileLocation.ToString());
                }
                catch (Exception ex)
                {
                    Logger.Write(ex, "General", 1);
                    //User tried to land on non-registered route name
                    //return user to login screen 
                    QueryStringManager.Redirect(PageName.Login);
                }

                // FillRegistryOwnerEnrollmentFormText
                if (dsRegistry == null)
                    dsRegistry = new RegistryCommon();
                try
                {
                    RegistryCommonManager.FillRegistryOwnerEnrollmentText(dsRegistry, Convert.ToInt32(RegistryOwnerID), LanguageCode);
                }
                catch (Exception ex)
                {
                    Logger.Write(ex, "General", 1);
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented this page from loading.");
                }
                Image1.ImageUrl = dsRegistry.RegistryOwnerEnrollmentText[0].HeaderImageURL.ToString();
                Image1.Height = Convert.ToInt32(dsRegistry.RegistryOwnerEnrollmentText[0].HeaderImageHeight);
                Image1.Width = Convert.ToInt32(dsRegistry.RegistryOwnerEnrollmentText[0].HeaderImageWidth);
                divInstruction.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivInstruction.ToString();
                divRegistrationSelection.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivRegistrationSelection.ToString();
                lblSelectOne.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblSelectOne.ToString();
                rdoAdd.Text = dsRegistry.RegistryOwnerEnrollmentText[0].RdoAdd.ToString();
                rdoRemove.Text = dsRegistry.RegistryOwnerEnrollmentText[0].RdoRemove.ToString();

                lblNameInstruction = dsRegistry.RegistryOwnerEnrollmentText[0].DivNameInstruction.ToString();

                divFirstNameInstruction.InnerHtml = lblNameInstruction.ToString();
                divLastNameInstruction.InnerHtml = lblNameInstruction.ToString();
                lblFirstName.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblFirstName.ToString();
                lblLastName.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblLastName.ToString();
                lblMiddleName.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblMiddleName.ToString();
                lblGender.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblGender.ToString();
                rdoMale.Text = dsRegistry.RegistryOwnerEnrollmentText[0].RdoMale.ToString();
                rdoFemale.Text = dsRegistry.RegistryOwnerEnrollmentText[0].RdoFemale.ToString();
                lblDateOfBirth.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblDateOfBirth.ToString();
                divResidentialAddress.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivResidentialAddress.ToString();
                lblStreetAddress.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblStreetAddress.ToString();
                lblAddress2.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblAddress2.ToString();
                lblCityStateZip.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblCityStateZip.ToString();
                divContactInformation.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivContactInformation.ToString();
                lblEmailAddress.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblEmailAddress.ToString();
                divEmailConfirmation.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivEmailConfirmation.ToString();
                divSSN.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivSSN.ToString();
                lblLastFourSSN.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblLastFourSSN.ToString();
                lblLimitations.Text = dsRegistry.RegistryOwnerEnrollmentText[0].DivLimitations.ToString();
                divLimitationsInstructions.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivLimitationsInstructions.ToString();
                lblEventCategoryMessage.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblEventCategoryMessage.ToString();
                lblComment.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblComment.ToString();
                divInformationContacts.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivInformationContacts.ToString();
                divSubmitInstructions.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivSubmitInstruction.ToString();
                btnRegisterNow.Text = dsRegistry.RegistryOwnerEnrollmentText[0].BtnRegisterNow.ToString();
                divFooter.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivFooter.ToString();

                txtLimitations.Attributes.Add("OnKeyPress", "return textMaxLength(this, '" + LimitationsMaxLength + "', event)");
                txtComments.Attributes.Add("OnKeyPress", "return textMaxLength(this, '" + CommentsMaxLength + "', event)");
                txtLicenseOrStateID.Attributes.Add("OnKeyPress", "return textMaxLength(this, '" + LicenseOrStateIDMaxLength + "', event)");
                txtLicenseOrStateID.Visible = EnrollmentFormDisplayLicenseOrStateID;
                lblLicenseOrStateID.Visible = EnrollmentFormDisplayLicenseOrStateID;
                if (dsRegistry.RegistryOwnerEnrollmentText[0].LblLicenseOrStateID.ToString().Length > 0)
                {
                    lblLicenseOrStateID.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblLicenseOrStateID.ToString();
                }
                //add one year to the end of Max allowed date to allow users to choose all months
                //ddlDOB.MaxDate = DateTime.Now.AddYears(1);

                txtCategorySpecifyText.Visible = false;
                lblCategorySpecifyText.Visible = false;
                cboSubCategory.Visible = false;
                txtSubCategorySpecifyText.Visible = false;
                lblSubCategorySpecifyText.Visible = false;

                // Do not display on mobile form
                lblMiddleName.Visible = false;
                txtMiddleName.Visible = false;
                // lblAddress2 used for State
                txtAddress2.Visible = false;
                divSubmitInstructions.Visible = false;

                // Set default rdoAdd value for mobile users.
                // Mobile users are not allowed to select delete.
                rdoAdd.Checked = true;

                // Apply Initial Field Visibility Settings
                if (EnrollmentFormHideComments)
                {
                    txtComments.Visible = false;
                    lblComment.Visible = false;
                }
                if ((!IDologyActive) || (IDologyActive && !IDologyUsesSSN))
                {
                    divSSN.Visible = false;
                    LabelLastFourSSN.Visible = false;
                    lblLastFourSSN.Visible = false;
                    
                    txtLastFourSSN.Visible = false;
                    txtLastFourSSN.Text = "";
                }

                String StatEmployeeID = Page.Cookies.StatEmployeeID.ToString();

                // Fill Category control
                if (dsRegistry == null)
                    dsRegistry = new RegistryCommon();
                try
                {
                    RegistryCommonManager.FillEventCategoryEdit(dsRegistry, 0, RegistryOwnerID, 1);
                }
                catch (Exception ex)
                {
                    Logger.Write(ex, "General", 1);
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
                }

                cboCategory.DataTextField = "EventCategoryName";
                cboCategory.DataValueField = "EventCategoryID";
                cboCategory.DataSource = dsRegistry.EventCategory;
                cboCategory.DataBind();
                cboCategory.Items.Insert(0, new ListItem("Choose a selection below", "0"));

                InitializeSubCategory();

                // Fill State DropDownList
                if (dsRegistry == null)
                    dsRegistry = new RegistryCommon();
                try
                {
                    RegistryCommonManager.FillDropDownListState(dsRegistry, RegistryOwnerID);
                }
                catch (Exception ex)
                {
                    Logger.Write(ex, "General", 1);
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
                }
                cboState.DataTextField = "RegistryOwnerStateAbbrv";
                cboState.DataValueField = "RegistryOwnerStateAbbrv";
                cboState.DataSource = dsRegistry.RegistryOwnerStateConfig;
                cboState.DataBind();
                // Set default state selection
                cboState.Items.Insert(0, new ListItem("Choose a selection below", "0"));
                cboState.SelectedValue = EnrollmentFormDefaultStateSelection;

                if (!String.IsNullOrEmpty(Request.QueryString["RegistryID"]) && Convert.ToInt32(Page.Cookies.UserId) > 0)
                {
                    Int32 RegistryID = Convert.ToInt32(Request.QueryString["RegistryID"]);
                    String RegistrationStatus = Request.QueryString["RegistrationStatus"];

                    if (dsRegistry == null) dsRegistry = new RegistryCommon();
                    try
                    {
                        RegistryCommonManager.FillRegistry(dsRegistry, RegistryID);
                        RegistryCommonManager.FillRegistryAddr(dsRegistry, RegistryID, 1);
                        RegistryCommonManager.FillEventRegistry(dsRegistry, RegistryID);
                    }
                    catch (Exception ex)
                    {
                        Logger.Write(ex, "General", 1);
                        DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
                    }

                    String gender = dsRegistry.Registry[0].Gender.ToString();

                    String FindState = dsRegistry.RegistryAddr[0].State == null ? "MA" : dsRegistry.RegistryAddr[0].State.ToString();
                    Int32 FindCategoryID = dsRegistry.EventRegistry[0].EventCategoryID > 0 ? dsRegistry.EventRegistry[0].EventCategoryID : 0;
                    Int32 FindSubCategoryID = dsRegistry.EventRegistry[0].EventSubCategoryID > 0 ? dsRegistry.EventRegistry[0].EventSubCategoryID : 0;

                    // populate form fields
                    if (RegistrationStatus == "Add") rdoAdd.Checked = true;
                    if (RegistrationStatus == "Remove") rdoRemove.Checked = true;
                    this.txtFirstName.Text = dsRegistry.Registry[0].FirstName.ToString();
                    this.txtMiddleName.Text = dsRegistry.Registry[0].MiddleName.ToString();
                    this.txtLastName.Text = dsRegistry.Registry[0].LastName.ToString();
                    if (gender == "M") this.rdoMale.Checked = true;
                    if (gender == "F") this.rdoFemale.Checked = true;
                    this.ddlDOB.Text = Convert.ToDateTime(dsRegistry.Registry[0].DOB).ToShortDateString();
                    this.txtStreetAddress.Text = dsRegistry.RegistryAddr[0].Addr1.ToString();
                    this.txtAddress2.Text = dsRegistry.RegistryAddr[0].Addr2.ToString();
                    this.txtCity.Text = dsRegistry.RegistryAddr[0].City.ToString();

                    cboCategory.DataBind();

                    cboState.SelectedValue = FindState.ToString();

                    this.txtZip.Text = dsRegistry.RegistryAddr[0].Zip.ToString();
                    this.txtEmailAddress.Text = dsRegistry.Registry[0].Email.ToString();
                    this.txtLicenseOrStateID.Text = dsRegistry.Registry[0].License.ToString();
                    this.txtLastFourSSN.Text = dsRegistry.Registry[0].SSN.ToString();
                    this.txtLimitations.Text = dsRegistry.Registry[0].Limitations.ToString();

                    if (RegistrationStatus == "Add")
                    { // populate eventCategory controls
                        try
                        {
                            if (dsRegistry == null) dsRegistry = new RegistryCommon();
                            RegistryCommonManager.FillEventRegistry(dsRegistry, RegistryID);

                            Int32 CategoryID = dsRegistry.EventRegistry[0].EventCategoryID;
                            Int32 SubCategoryID = dsRegistry.EventRegistry[0].EventSubCategoryID;

                            cboCategory.SelectedValue = CategoryID.ToString();
                            lblEventCategory.Text = cboCategory.SelectedItem.Text.ToString();


                            // Fill Sub Category control
                            if (dsRegistry == null) dsRegistry = new RegistryCommon();
                            RegistryCommonManager.FillEventSubCategoryEdit(dsRegistry, 0, CategoryID, 1);
                            cboSubCategory.DataValueField = "EventSubCategoryID";
                            cboSubCategory.DataTextField = "EventSubCategoryName";
                            cboSubCategory.DataSource = dsRegistry.EventSubCategory;
                            cboSubCategory.DataBind();
                            cboSubCategory.Items.Insert(0, new ListItem("Choose a selection below", "0"));
                            cboSubCategory.SelectedValue = SubCategoryID.ToString();

                            if (SubCategoryID == 0)
                            {
                                cboSubCategory.Visible = false;
                                lblEventCategory.Visible = false;
                            }
                            txtCategorySpecifyText.Text = dsRegistry.EventRegistry[0].EventCategorySpecifyText == null ? "" : dsRegistry.EventRegistry[0].EventCategorySpecifyText.ToString();
                            txtSubCategorySpecifyText.Text = dsRegistry.EventRegistry[0].EventSubCategorySpecifyText == null ? "" : dsRegistry.EventRegistry[0].EventSubCategorySpecifyText.ToString();

                            DisplayCategorySpecifyText();
                            DisplaySubCategorySpecifyText();

                        }
                        catch
                        {
                            cboCategory.SelectedIndex = 0;
                            cboSubCategory.SelectedIndex = 0;
                        }

                    }
                    else
                    {
                        DisableEventCategoryControls();
                    }


                    cboSubCategory.SelectedValue = FindSubCategoryID.ToString();
                    this.txtComments.Text = dsRegistry.Registry[0].Comment.ToString();

                } // End of querystring check
                else
                { // This is a blank enrollment form.
                    // The EventCategory control was loaded prior to querystring check.
                    // EventSubcategory control requires binding to the datatable before pageload completes
                    // data will be loaded when the select category event is fulfilled.
                    cboSubCategory.DataSource = dsRegistry.EventSubCategory;
                    cboSubCategory.DataBind();
                }

                //set hidden fields to handle session timeout
                hdnRegistryOwnerID.Value = (string)RegistryOwnerID.ToString();
                hdnRegistryOwnerRouteName.Value = (string)RegistryOwnerRouteName.ToString();
                hdnLanguageCode.Value = (string)LanguageCode.ToString();
                hdnAllowDisplayNoDonors.Value = (string)AllowDisplayNoDonors.ToString();
                hdnCSSFileLocation.Value = (string)CSSFileLocation.ToString();
            } // End of Postback check
            if (this.IsPostBack && cboCategory.SelectedValue == "0")
            {   // initialize SubCategory
                if (Session["RegistryOwnerID"] != null)
                    RegistryOwnerID = Convert.ToInt32(Session["RegistryOwnerID"]);
                InitializeSubCategory();
            }
        }

        private void InitializeSubCategory()
        {
            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            RegistryCommonManager.FillEventSubCategoryEdit(dsRegistry, 0, -1, 1);
            cboSubCategory.DataValueField = "EventSubCategoryID";
            cboSubCategory.DataTextField = "EventSubCategoryName";
            cboSubCategory.DataSource = dsRegistry.EventSubCategory;
            cboSubCategory.DataBind();
            cboSubCategory.Items.Insert(0, new ListItem("Choose a selection below", "0"));
        }

        protected void btnRegisterNow_Click(object sender, EventArgs e)
        {
            //validate user form information prior to post
            if (IsValid())
            {
                SaveData();
                string RegistryID;
                if (Session["RegistryID"] != null)
                    RegistryID = (string)(Session["RegistryID"].ToString());
                else
                    RegistryID = "0";

                if (rdoRemove.Checked == true)
                {
                    // Check for existing record prior to IDology check.
                    //  1.  -1, New donor
                    //  2.   0, Don't update this record. More than one donor exists with the same criteria
                    //  3. n>1, This is an update. One donor match found. Value returned is old RegistryID
                    string FirstName = removeIllegalSQL(txtFirstName.Text.ToString());
                    string LastName = removeIllegalSQL(txtLastName.Text.ToString());
                    string LastFourSSN = txtLastFourSSN.Text.ToString();
                    string License = txtLicenseOrStateID.Text.ToString().Replace("-", String.Empty);
                    string DOB = ddlDOB.Text.ToString();

                    Int32 DonorID = RegistryCommonManager.GetExistingDonor(Convert.ToInt32(RegistryID), RegistryOwnerID, FirstName, LastName, LastFourSSN, License, DOB, 0);
                    if (Session["AllowDisplayNoDonors"] != null) bool.TryParse((string)(Session["AllowDisplayNoDonors"]), out AllowDisplayNoDonors);


                    if (DonorID < 1) // cannot confirm donor 
                    {   // If Allow No Donors is turned off then donor is not confirmed.
                        // if Allow No Donors is on then continue

                        if (DonorID == 0 || (DonorID == -1 && !AllowDisplayNoDonors))
                        {
                            // multiple records found.
                            // IDology check not required.
                            Session.Add("DonorNotConfirmed", "True");
                            Session.Add("IDRequestType", "DisplayPageOnly");
                        }

                    }
                }

                //validate with IDology and continue registration
                QueryStringManager.Redirect(PageName.DynamicValidateMobile);
            }

        }
        protected void btnClearForm_Click(object sender, EventArgs e)
        {
            //Clear Form data only by reloading page
             QueryStringManager.Redirect(PageName.DynamicEnrollmentMobile);
        }
        public void SaveData()
        {
            if (dsDonorData == null) dsDonorData = new RegistryCommon();
            Int32 RegistryID;
            String DonorRegistrationRequest = rdoAdd.Checked ? "Add" : rdoRemove.Checked ? "Remove" : "";
            string StatEmployeeID = Page.Cookies.StatEmployeeID.ToString();
            string license = txtLicenseOrStateID.Text.ToString();
            if (license.Length > 0 ) license = txtLicenseOrStateID.Text.Replace("-", String.Empty).Substring(0, (license.Length - 1)).ToString();

            // Create New temporary record (unconfirmed)
            RegistryID = 0;
            RegistryCommon.RegistryRow row;
            row = dsDonorData.Registry.NewRegistryRow();
            row["RegistryOwnerID"] = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
            row["SSN"] = txtLastFourSSN.Text.ToString().Trim();
            row["DOB"] = Convert.ToDateTime(ddlDOB.Text).ToShortDateString();
            row["FirstName"] = removeIllegalSQL(txtFirstName.Text.ToString().Trim());
            row["MiddleName"] = removeIllegalSQL(txtMiddleName.Text.ToString().Trim());
            row["LastName"] = removeIllegalSQL(txtLastName.Text.ToString().Trim());
            row["Gender"] = rdoMale.Checked ? "M" : rdoFemale.Checked ? "F" : "U";
            row["Email"] = txtEmailAddress.Text.ToString().Trim();
            row["Comment"] = removeIllegalSQL(txtComments.Text.ToString().Trim());
            row["Limitations"] = removeIllegalSQL(txtLimitations.Text.ToString().Trim());
            row["License"] = license.ToString().Trim();
            row["Donor"] = false; //not a donor until IDolody confirms and electronic signature obtained
            row["DonorConfirmed"] = false; //not a donor until IDolody confirms and electronic signature obtained
            row["OnlineRegDate"] = DateTime.Now.ToString();
            row["DeleteFlag"] = true; //not a donor until IDolody confirms and electronic signature obtained
            row["LastStatEmployeeID"] = Convert.ToInt32(StatEmployeeID); //Public(0) Admin (> 0)
            row["AuditLogTypeID"] = 1;
            row["RegisteredByID"] = Mobile;
            dsDonorData.Registry.AddRegistryRow(row);
            RegistryCommonManager.UpdateRegistry(dsDonorData);

            RegistryID = row.RegistryID;

            // Insert Registry Address data
            RegistryCommon.RegistryAddrRow rowAddr;
            rowAddr = dsDonorData.RegistryAddr.NewRegistryAddrRow();
            rowAddr["RegistryID"] = RegistryID;
            rowAddr["AddrTypeID"] = 1;
            rowAddr["Addr1"] = txtStreetAddress.Text.ToString().Trim();
            rowAddr["Addr2"] = txtAddress2.Text.ToString().Trim();
            rowAddr["City"] = txtCity.Text.ToString().Trim();
            rowAddr["State"] = cboState.SelectedItem.Text.ToString().Trim();  //electedRow.Cells[3].Value.ToString();
            rowAddr["Zip"] = txtZip.Text.ToString().Trim();
            rowAddr["LastStatEmployeeID"] = Convert.ToInt32(StatEmployeeID); //Public(0) Admin (> 0)
            rowAddr["AuditLogTypeID"] = 1;
            dsDonorData.RegistryAddr.AddRegistryAddrRow(rowAddr);
            RegistryCommonManager.UpdateRegistryAddr(dsDonorData);

            // Insert Event Registry data
            RegistryCommon.EventRegistryRow rowEventReg;
            rowEventReg = dsDonorData.EventRegistry.NewEventRegistryRow();
            rowEventReg["RegistryID"] = RegistryID;
            rowEventReg["EventCategoryID"] = cboCategory.SelectedIndex == -1 ? 0 : Convert.ToInt32(cboCategory.SelectedValue);
            rowEventReg["EventSubCategoryID"] = cboSubCategory.SelectedIndex == -1 ? 0 : Convert.ToInt32(cboSubCategory.SelectedValue);
            rowEventReg["LastStatEmployeeID"] = Convert.ToInt32(StatEmployeeID); //Public(0) Admin (> 0)

            rowEventReg["EventCategorySpecifyText"] = txtCategorySpecifyText.Text.Length < 1 ? String.Empty : txtCategorySpecifyText.Text.ToString();
            rowEventReg["EventSubCategorySpecifyText"] = txtSubCategorySpecifyText.Text.Length < 1 ? String.Empty : txtSubCategorySpecifyText.Text.ToString();

            rowEventReg["AuditLogTypeID"] = 1;
            dsDonorData.EventRegistry.AddEventRegistryRow(rowEventReg);
            RegistryCommonManager.UpdateEventRegistry(dsDonorData);

            //data has been stored
            SaveStateInformation(RegistryID, DonorRegistrationRequest);

        }

        private void SaveStateInformation(Int32 RegistryID, String DonorRegistrationRequest)
        {
            //Save state information
            Session.Add("IDRequestType", "New");
            Session.Add("RegistryID", RegistryID.ToString());
            Session.Add("DonorRegistrationRequest", DonorRegistrationRequest);
            Session.Add("FirstName", removeIllegalSQL(txtFirstName.Text.ToString().Trim()));
            Session.Add("LastName", removeIllegalSQL(txtLastName.Text.ToString().Trim()));
            Session.Add("Address", removeIllegalSQL(txtStreetAddress.Text.ToString().Trim()));
            Session.Add("City", removeIllegalSQL(txtCity.Text.ToString().Trim()));
            Session.Add("State", cboState.SelectedItem.Text.ToString().Trim()); //ddlState.SelectedRow.Cells[3].Value.ToString());
            Session.Add("Zip", txtZip.Text.ToString().Trim());
            Session.Add("LastFourSSN", txtLastFourSSN.Text.ToString());
            Session.Add("DOBMonth", Convert.ToDateTime(ddlDOB.Text).Month.ToString());
            Session.Add("DOBYear", Convert.ToDateTime(ddlDOB.Text).Year.ToString());
            Session.Add("DOB", Convert.ToDateTime(ddlDOB.Text).ToString());
        }


        /// <summary>
        /// Sets Key Session Values to Null to prevent update of incorrect Registrant
        /// </summary>
        private void CleanSessionState()
        {
            try
            {
                Session["IDRequestType"] = null;
                Session["RegistryID"] = null;
                Session["DonorRegistrationRequest"] = null;
                Session["FirstName"] = null;
                Session["LastName"] = null;
                Session["Address"] = null;
                Session["City"] = null;
                Session["State"] = null;
                Session["Zip"] = null;
                Session["LastFourSSN"] = null;
                Session["DOBYear"] = null;
                Session["DOB"] = null;
            }
            catch
            {
                //fail silently - exceptions are OK when clearing session
            }
        }


        public bool IsValid()
        {
            bool returnValue = true;
            string validationErrorMessage = String.Empty;

            //Check to see that registration status is selected
            if ((rdoAdd.Checked == true) || (rdoRemove.Checked == true))
            {
                //Item is selected
                rdoAdd.BackColor = System.Drawing.Color.White;
                rdoRemove.BackColor = System.Drawing.Color.White;

            }
            else
            {
                rdoAdd.BackColor = System.Drawing.Color.Yellow;
                rdoRemove.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }
            //Check FirstName
            if (txtFirstName.Text.Length > 0)
            {
                //add reg explesion check here
                txtFirstName.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtFirstName.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check LastName
            if (txtLastName.Text.Length > 0)
            {
                //add reg explesion check here
                txtLastName.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtLastName.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check Gender
            if ((rdoMale.Checked == true) || (rdoFemale.Checked == true))
            {
                rdoMale.BackColor = System.Drawing.Color.White;
                rdoFemale.BackColor = System.Drawing.Color.White;
            }
            else
            {
                rdoMale.BackColor = System.Drawing.Color.Yellow;
                rdoFemale.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check DOB
            try
            {
                DateTime DOB = DateTime.Parse(ddlDOB.Text);
                if (
                        DOB.Date > DateTime.Now.AddYears(-100).Date &&
                        DOB.Date < DateTime.Now.Date
                    )
                {
                    ddlDOB.BackColor = System.Drawing.Color.White;
                }

                 else
                {
                    ddlDOB. BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }           
            }
            catch
            {
                ddlDOB.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check Street Address
            if (txtStreetAddress.Text.Length > 0)
            {
                txtStreetAddress.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtStreetAddress.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }
            //Check City

            if (txtCity.Text.Length > 0)
            {
                txtCity.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtCity.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check State
            if (cboState.SelectedIndex != 0)
            {
                cboState.BackColor = System.Drawing.Color.White;
            }
            else
            {
                cboState.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //Check Zip code
            string zipPattern = @"^\d{5}(-\d{4})?$";
            Regex zipRegex = new Regex(zipPattern);
            string zip = txtZip.Text.ToString();
            Match z = zipRegex.Match(zip);
            if (z.Success)
            {
                txtZip.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtZip.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }



            //Check Email address
            string emailPattern = @"^(([\w-]+\.)+[\w-]+|([a-zA-Z]{1}|[\w-]{2,}))@"
            + @"((([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\."
            + @"([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])\.([0-1]?[0-9]{1,2}|25[0-5]|2[0-4][0-9])){1}|"
            + @"([a-zA-Z]+[\w-]+\.)+[a-zA-Z]{2,4})$";

            Regex emailregex = new Regex(emailPattern);
            string email = txtEmailAddress.Text.ToString().Trim();
            Match m = emailregex.Match(email);
            if (m.Success)
            {
                txtEmailAddress.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtEmailAddress.BackColor = System.Drawing.Color.Yellow;
                returnValue = false;
            }

            //License or StateID is optional
            //If control is not visible then bypass validation
            if (txtLicenseOrStateID.Visible)
            {
                //Check License/StateId 
                string licensePattern = @"^([A-Za-z0-9]{9})$";
                Regex licenseRegex = new Regex(licensePattern);
                string licenseOrStateId = txtLicenseOrStateID.Text.ToString().Replace("-", String.Empty);
                Match s = licenseRegex.Match(licenseOrStateId);
                if (s.Success || txtLicenseOrStateID.Text.Length == 0)
                {
                    txtLicenseOrStateID.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    txtLicenseOrStateID.BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }
            }

            //SSN is optional
            //If SSN is not visible then SSN is assumed turned off - bypass validation
            if (txtLastFourSSN.Visible)
            {
                //Check SSN lastFour (Turn back on after testing)
                string ssnPattern = @"([0-9][0-9][0-9][0-9])";
                Regex ssnRegex = new Regex(ssnPattern);
                string ssn = txtLastFourSSN.Text.ToString();
                Match s = ssnRegex.Match(ssn);
                if (s.Success)
                {
                    txtLastFourSSN.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    txtLastFourSSN.BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }
            }

            //Limitations Text
            if (txtLimitations.Text.Length < Convert.ToInt32(LimitationsMaxLength) + 1)
            {
                txtLimitations.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtLimitations.BackColor = System.Drawing.Color.Yellow;
                validationErrorMessage = "Please limit text to no more than " + LimitationsMaxLength + " characters.";
                returnValue = false;
            }

            //Comments Text
            if (txtComments.Visible)
            {
                if (txtComments.Visible && txtComments.Text.Length < Convert.ToInt32(CommentsMaxLength) + 1)
                {
                    txtComments.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    txtComments.BackColor = System.Drawing.Color.Yellow;
                    validationErrorMessage = "Please limit text to no more than " + CommentsMaxLength + " characters.";
                    returnValue = false;
                }
            }

            //Check Category
            if (cboCategory.Visible == true)
            {
                if (cboCategory.SelectedValue != "0")
                {
                    cboCategory.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    cboCategory.BackColor = System.Drawing.Color.Yellow;
                    returnValue = false;
                }
            }

            //Check CategorySpecifyText
            //if (txtCategorySpecifyText.Visible == true)
            //{
            //    if (txtCategorySpecifyText.Text.Length > 0)
            //    {
            //        txtCategorySpecifyText.BackColor = System.Drawing.Color.White;
            //    }
            //    else
            //    {
            //        txtCategorySpecifyText.BackColor = System.Drawing.Color.Yellow;
            //        returnValue = false;
            //    }
            //}

            //Check SubCategorySpecifyText
            //if (txtSubCategorySpecifyText.Visible == true)
            //{
            //    if (txtSubCategorySpecifyText.Text.Length > 0)
            //    {
            //        txtSubCategorySpecifyText.BackColor = System.Drawing.Color.White;
            //    }
            //    else
            //    {
            //        txtSubCategorySpecifyText.BackColor = System.Drawing.Color.Yellow;
            //        returnValue = false;
            //    }
            //}

            //Check SubCategory
            //if (cboSubCategory.Visible == true)
            //{
            //    if (cboSubCategory.SelectedValue != "0")
            //    {
            //        cboSubCategory.BackColor = System.Drawing.Color.White;
            //    }
            //    else
            //    {
            //        cboSubCategory.BackColor = System.Drawing.Color.Yellow;
            //        returnValue = false;
            //    }

            //}



            // if any validation fails, give warning 
            if (returnValue == false)
            {
                DisplayVallidationErrorMessage(validationErrorMessage);
            }

            return returnValue;
        }

        // Remove apostrophe (single quote) if present.
        private string removeIllegalSQL(string inputSQL)
        {
            return inputSQL.Replace("'", string.Empty);
        }

        private static void DisplayVallidationErrorMessage(string errorMessage)
        {
            if (errorMessage.Length > 0)
            {
                // display specific error message
                DisplayMessages.Add(MessageType.ErrorMessage, errorMessage);
            }
            else
            {   //default error message 
                DisplayMessages.Add(MessageType.ErrorMessage, "Please correct the following items highlighted in yellow:");
            }
        }


        private void DisplayCategorySpecifyText()
        {
            int CategoryValue = Convert.ToInt32(cboCategory.SelectedValue);

            if (dsRegistry == null) dsRegistry = new RegistryCommon();

            try
            {
                RegistryCommonManager.FillEventCategoryEdit(dsRegistry, CategoryValue, RegistryOwnerID, 1);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
            }

            try
            {
                DataView view = new DataView();
                view.Table = dsRegistry.Tables["EventCategory"];
                view.RowFilter = "EventCategoryID = " + CategoryValue.ToString();
                if (Convert.ToBoolean(view[0]["EventCategorySpecifyText"]))
                {
                    txtCategorySpecifyText.Visible = true;
                    lblCategorySpecifyText.Visible = true;

                }
                else
                {
                    txtCategorySpecifyText.Text = String.Empty;
                    txtCategorySpecifyText.Visible = false;
                    lblCategorySpecifyText.Visible = false;
                }
            }
            catch
            {
                txtCategorySpecifyText.Text =String.Empty;
                txtCategorySpecifyText.Visible = false;
                lblCategorySpecifyText.Visible = false;
            }
        }

        private void DisplaySubCategorySpecifyText()
        {
            int SubCategoryValue = Convert.ToInt32(cboSubCategory.SelectedValue);

            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            try
            {
                RegistryCommonManager.FillEventSubCategoryEdit(dsRegistry, SubCategoryValue, 0, 1);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
            }

            DataView view = new DataView();
            view.Table = dsRegistry.Tables["EventSubCategory"];
            view.RowFilter = "EventSubCategoryID = " + SubCategoryValue.ToString();


            if (view.Count > 0 && Convert.ToBoolean(view[0]["EventSubCategorySpecifyText"]))
            {
                txtSubCategorySpecifyText.Visible = false;
                lblSubCategorySpecifyText.Visible = false;

            }
            else
            {
                txtSubCategorySpecifyText.Text = "";
                txtSubCategorySpecifyText.Visible = false;
                lblSubCategorySpecifyText.Visible = false;
            }

        }

        protected void odsCategory_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
        {
            if (this.IsPostBack)
            {
                // e.Cancel = true;
            }
        }

        protected void rdoRemove_CheckedChanged(object sender, EventArgs e)
        {
            DisableEventCategoryControls();

            //Set focus back to control
            rdoRemove.Focus();
        }

        protected void rdoAdd_CheckedChanged(object sender, EventArgs e)
        {
            // if Add is selected populate the SubCategory control
            // And enable
            InitializeSubCategory();
            EnableEventCategoryControls();
            //Set focus back to control
            rdoAdd.Focus();
        }

        private void DisableEventCategoryControls()
        {
            if (rdoRemove.Checked == true)
            {
                // Hide/disable EventCategory controls
                cboCategory.SelectedIndex = -1;
                cboSubCategory.SelectedIndex = -1;
                txtCategorySpecifyText.Text = "";
                txtSubCategorySpecifyText.Text = "";

                lblEventCategoryMessage.Visible = false;
                lblCategorySpecifyText.Visible = false;
                cboCategory.Visible = false;
                txtCategorySpecifyText.Visible = false;
                lblEventCategory.Visible = false;
                lblSubCategorySpecifyText.Visible = false;
                cboSubCategory.Visible = false;
                txtSubCategorySpecifyText.Visible = false;

                // Hide disable Comments (registering in memory of:)
                lblComment.Visible = false;
                txtComments.Visible = false;

                txtComments.Text = "";
            }
        }

        private void EnableEventCategoryControls()
        {
            if (rdoAdd.Checked == true)
            {
                // Show/enable EventCategory controls
                lblEventCategoryMessage.Visible = false;
                cboCategory.Visible = true;
                // Mobile Enrollment does not use Sub Category
                // Set visible to false
                cboSubCategory.Visible = false;
                lblEventCategory.Visible = false;

                txtCategorySpecifyText.Text = "";
                txtSubCategorySpecifyText.Text = "";

                if (cboCategory.SelectedIndex == 0)
                {
                    cboSubCategory.Visible = false;
                    lblEventCategory.Visible = false;
                }

                // Show/enable Comments (registering in memory of:)
                if (EnrollmentFormHideComments)
                {
                    txtComments.Visible = false;
                    lblComment.Visible = false;
                }
                txtComments.Text = "";
            }
        }


        protected void cboCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

            // reset SubCategory (Default)
            txtSubCategorySpecifyText.Text = "";
            txtSubCategorySpecifyText.Visible = false;
            lblSubCategorySpecifyText.Visible = false;

            Int32 EventCategory = 0;

            try
            {
                EventCategory = Convert.ToInt32(cboCategory.SelectedValue);
                lblEventCategory.Text = cboCategory.SelectedItem.Text.Trim();
            }
            catch
            {
                EventCategory = 0;
                lblEventCategory.Text = String.Empty;
            }

            if (EventCategory == 0) //Nothing selected
            {
                EventCategory = -1;
            }
            else
            {
                cboCategory.BackColor = System.Drawing.Color.White;
                DisplayCategorySpecifyText();
            }

            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            try
            {
                RegistryCommonManager.FillEventSubCategoryEdit(dsRegistry, 0, EventCategory, 1);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
            }

            if (dsRegistry.EventSubCategory.Count > 0)
            {
                cboSubCategory.DataSource = dsRegistry.EventSubCategory;
                cboSubCategory.DataTextField = "EventSubCategoryName";
                cboSubCategory.DataValueField = "EventSubCategoryID";
                cboSubCategory.DataBind();
                cboSubCategory.Items.Insert(0, new ListItem("Choose a selection below", "0"));
                // Mobile set to false 
                lblEventCategory.Visible = false;
                cboSubCategory.Visible = false;
            }
            else
            {
                // No data to show
                cboSubCategory.SelectedIndex = -1; //set default
                lblEventCategory.Visible = false;
                cboSubCategory.Visible = false;

            }

        }

        protected void cboSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplaySubCategorySpecifyText();
            cboSubCategory.BackColor = System.Drawing.Color.White;
        }

        protected void generateHideUpdatePanel()
        {
            ScriptManager.RegisterStartupScript(this,
            typeof(EnrollmentControl),
            "typegenerateHideUpdatePanel",
            "document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentMobileControl1_UpdatePanel1').style.display = 'none';", true);
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            
            try
            {
                //If CSSFileLocation exists Add custom CSS reference
                if (CSSFileLocation == null)
                    CSSFileLocation = (string)(Session["CSSFileLocation"].ToString());

                if (CSSFileLocation.Length > 0)
                {
                    HtmlLink css = new HtmlLink();

                    // Mobile device
                    css.Href = CSSFileLocation.ToString();
                    css.Attributes["rel"] = "stylesheet";
                    css.Attributes["type"] = "text/css";
                    //css.Attributes["media"] = "all";
                    Page.Header.Controls.Add(css);
                }

                    // Add meta data for mobile device
                    HtmlMeta meta = new HtmlMeta();
                    HtmlHead head = (HtmlHead)Page.Header;
                    meta.Name = "viewport";
                    meta.Content = "width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0;";
                    //meta.Content = "initial-scale=1.0, maximum-scale=1.0, user-scalable=0;";
                    head.Controls.Add(meta);

                    generateHideUpdatePanel();
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
            }

        }
    }
}
