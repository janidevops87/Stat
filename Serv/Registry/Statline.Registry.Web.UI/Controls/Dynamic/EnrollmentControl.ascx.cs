using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Text;
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
    public partial class EnrollmentControl : BaseUserControl
    {
        #region Variables
        Int32   RegistryOwnerID = 0;
        String  LanguageCode;
        String  RegistryOwnerName;
        String  RegistryOwnerIDValue;
        String  RegistryOwnerRouteName;
        String  RegistryOwnerLanguageCode;
        String  EnrollmentFormDefaultStateSelection;
        String  LimitationsMaxLength = "200";
        String  CommentsMaxLength = "100";
        String  LicenseOrStateIDMaxLength = "20";
        int LicenseOrStateIDLength = 20;
        String  CSSFileLocation;
        bool  EnrollmentFormIsPublic;

        String URLAppRoot = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath + "/";
            
        bool    IDologyActive;
        bool    IDologyUsesSSN;
        bool    IdologyActiveInPortal;
        bool    EnrollmentFormHideComments = false; //was defaulted to true - maybe causing problems with embeded form in IE
        bool    AllowDisplayNoDonors;
        bool    AllowDonorToPrintVerificationForm;
        bool    EnrollmentFormDisplayLicenseOrStateID;
        bool    UserIsLoggedIn = false;
        
    
        const int Web = 1;
        const string MobileRoutePage = "m";
        const string WebEnglishRoutePage = "en";

        protected RegistryCommon dsDonorData;
        protected RegistryCommon dsRegistry;
        protected RegistryCommon dsAddr;
        protected RegistryCommon dsEvent;

        protected ValidationErrorMessage validationErrorMessage;

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            // Maintain position on postback
            Page.MaintainScrollPositionOnPostBack = true;

            if (Convert.ToInt32(Page.Cookies.UserId) > 0)
            {
                UserIsLoggedIn = true;
            }

            RegistryOwnerSessionVariableCheck();
            
            if (!IsPostBack)
            {
                SetDateTimeGlobalization();              

                IdentifyRegistryOwnerFromHttpRequest();
                
                GetRegistryOwnerConfiguration();

                CheckPageAccess();

                GetAndApplyRegistryOwnerEnrollmentText();

                ApplyRegistrantOwnerConfiguration();

                GetAndApplyRegistrantOwnerCategories();

                GetAndApplyRegistrantOwnerStateList();

                GetAndApplyRegistrantData();

                //set hidden fields to handle session timeout
                hdnRegistryOwnerID.Value = (string)RegistryOwnerID.ToString();
                hdnRegistryOwnerName.Value = (string)RegistryOwnerName.ToString();
                hdnRegistryOwnerRouteName.Value = (string)RegistryOwnerRouteName.ToString();
                hdnLanguageCode.Value = (string)LanguageCode.ToString();
                hdnAllowDisplayNoDonors.Value = (string)AllowDisplayNoDonors.ToString();
                hdnCSSFileLocation.Value = (string)CSSFileLocation.ToString();

                Session["RegisterNowClicked"] = null;

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
            cboSubCategory.Items.Insert(0, new ListItem("","0"));
        }

        protected void btnRegisterNow_Click(object sender, EventArgs e)
        {
            //Turn on category validation when user clicks DDL controls
            Session["RegisterNowClicked"] = true;

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

                    Int32 DonorID = RegistryCommonManager.GetExistingDonor(Convert.ToInt32(RegistryID), Convert.ToInt32(RegistryOwnerID), FirstName, LastName, LastFourSSN, License, DOB, 0);

                    if (Session["AllowDisplayNoDonors"] != null) bool.TryParse((string)(Session["AllowDisplayNoDonors"]), out AllowDisplayNoDonors);

                     if (DonorID < 1) // cannot confirm donor 
                    {       // If Allow No Donors is turned off then donor is not confirmed.
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
                QueryStringManager.Redirect(PageName.DynamicValidate);
            }

        }
      
        public void SaveData()
        {   
            if (dsDonorData == null) dsDonorData = new RegistryCommon();
            Int32 RegistryID;
            String DonorRegistrationRequest = rdoAdd.Checked ? "Add" : rdoRemove.Checked ? "Remove" : "";
            string StatEmployeeID = Page.Cookies.StatEmployeeID.ToString();
            string license = String.Empty;

            // Check if license# exists and it is in correct format.
            // License# can be up to 20 chars long.
            if(txtLicenseOrStateID.Text.Length > 0){
                license = txtLicenseOrStateID.Text.Replace("-", String.Empty).ToString();
                if (license.Length > LicenseOrStateIDLength)
                {
                    license = txtLicenseOrStateID.Text.Replace("-", String.Empty).Substring(0, LicenseOrStateIDLength).ToString();
                }
             }

            // Create New temporary record (unconfirmed)
                RegistryID = 0;
                RegistryCommon.RegistryRow row;
                row = dsDonorData.Registry.NewRegistryRow();
                row["RegistryOwnerID"] = RegistryOwnerID;
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
                row["RegisteredByID"] = Web;
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
            string validationErrorMessageLocal = String.Empty;
            if (LanguageCode == null) { LanguageCode =(string)(Session["LanguageCode"].ToString()); }

            validationErrorMessage = new ValidationErrorMessage(ValidationErrorMessageTypes.DEFAULT, LanguageCode);


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
            if (ddlDOB.Text != "" &&
                DateTime.Parse(ddlDOB.Text).Date > DateTime.Now.AddYears(-100).Date &&
                DateTime.Parse(ddlDOB.Text).Date < DateTime.Now.Date
                )
            {
                ddlDOB.BackColor = System.Drawing.Color.White;
            }
            else
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
                //04/15/2014 - Disable Regex, limit to max length of 9
                ////Check License/StateId 
                ////string licensePattern = @"^([A-Za-z0-9]{9})$";
                //Regex licenseRegex = new Regex(licensePattern);
                //string licenseOrStateId = txtLicenseOrStateID.Text.ToString().Replace("-", String.Empty);
                //Match s = licenseRegex.Match(licenseOrStateId);

                //if (s.Success || txtLicenseOrStateID.Text.Length == 0)
                if (txtLicenseOrStateID.Text.Length <= LicenseOrStateIDLength)
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
            //If SSN is not visible then bypass validation
            if (txtLastFourSSN.Visible)
            {
                //Check SSN lastFour 
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

            if (Session["LimitationsMaxLength"] != null) LimitationsMaxLength = (string)(Session["LimitationsMaxLength"].ToString());
            //Limitations Text
            if (txtLimitations.Text.Length < Convert.ToInt32(LimitationsMaxLength) + 1)
            {
                txtLimitations.BackColor = System.Drawing.Color.White;
            }
            else
            {
                txtLimitations.BackColor = System.Drawing.Color.Yellow;
                validationErrorMessage = new ValidationErrorMessage(ValidationErrorMessageTypes.LENGTH_LIMITATION, LanguageCode, LimitationsMaxLength);
                returnValue = false;
            }

            if (Session["CommentsMaxLength"] != null) CommentsMaxLength = (string)(Session["CommentsMaxLength"].ToString());
            //Comments Text
            if (txtComments.Visible)
            {
                if (txtComments.Visible && txtComments.Text.Length < Convert.ToInt32(CommentsMaxLength)+ 1)
                {
                    txtComments.BackColor = System.Drawing.Color.White;
                }
                else
                {
                    txtComments.BackColor = System.Drawing.Color.Yellow;
                    validationErrorMessage = new ValidationErrorMessage(ValidationErrorMessageTypes.LENGTH_LIMITATION, LanguageCode, LimitationsMaxLength);
                    returnValue = false;
                }
            }

            //Validate category controls
            if (areCategoriesValid() == false)
            {
                returnValue = false;
            }

            // if any validation fails, give warning 
            if (returnValue == false)
            {
                DisplayVallidationErrorMessage();
            }

            return returnValue;
        }

        public bool areCategoriesValid()
        {
            bool returnValue = true;

            if(Session["RegisterNowClicked"] != null && (bool)Session["RegisterNowClicked"] == true)
            {

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
                if (txtCategorySpecifyText.Visible == true)
                {
                    if (txtCategorySpecifyText.Text.Length > 0)
                    {
                        txtCategorySpecifyText.BackColor = System.Drawing.Color.White;
                    }
                    else
                    {
                        txtCategorySpecifyText.BackColor = System.Drawing.Color.Yellow;
                        returnValue = false;
                    }
                }

                //Check SubCategorySpecifyText
                if (txtSubCategorySpecifyText.Visible == true)
                {
                    if (txtSubCategorySpecifyText.Text.Length > 0)
                    {
                        txtSubCategorySpecifyText.BackColor = System.Drawing.Color.White;
                    }
                    else
                    {
                        txtSubCategorySpecifyText.BackColor = System.Drawing.Color.Yellow;
                        returnValue = false;
                    }
                }

                //Check SubCategory
                if (cboSubCategory.Visible == true)
                {
                    if (cboSubCategory.SelectedValue != "0")
                    {
                        cboSubCategory.BackColor = System.Drawing.Color.White;
                    }
                    else
                    {
                        cboSubCategory.BackColor = System.Drawing.Color.Yellow;
                        returnValue = false;
                    }

                }
            }

            return returnValue;
        }

        // Remove apostrophe (single quote) if present.
        private string removeIllegalSQL(string inputSQL)
        {
            return inputSQL.Replace("'", string.Empty);
        }

        private void DisplayVallidationErrorMessage()
        {
                DisplayMessages.Add(MessageType.ErrorMessage, validationErrorMessage.ErrorMessage);         
        }

        private static string FormatValidationErrorMessage(string errorMessageType, string languageCode, string errorSpecificText = null)
        {
            string formattedValidationErrorMessage = string.Empty;



            return formattedValidationErrorMessage;
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
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
            } 
            
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
                txtCategorySpecifyText.Text = "";
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
                    Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
                    DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
                }
                
                DataView view = new DataView();
                view.Table = dsRegistry.Tables["EventSubCategory"];
                view.RowFilter = "EventSubCategoryID = " + SubCategoryValue.ToString();


                if (view.Count > 0 && Convert.ToBoolean(view[0]["EventSubCategorySpecifyText"]))
                {
                    txtSubCategorySpecifyText.Visible = true;
                    lblSubCategorySpecifyText.Visible = true;

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
            if (Session["AllowDisplayNoDonors"] != null) bool.TryParse((string)(Session["AllowDisplayNoDonors"]), out AllowDisplayNoDonors);
            //Only Disable Event Controls for Registries that Do Not Allow No Donor Registration            
            if (!AllowDisplayNoDonors) DisableEventCategoryControls();
            
            //Set focus back to control
            rdoRemove.Focus();
            //inject javascript to set focus on client side.
            ScriptManager.RegisterStartupScript(this,
                                typeof(EnrollmentControl),
                                "rdoRemove_Focus1",
                                "document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_rdoRemove').focus();", true);

        
        }

        protected void rdoAdd_CheckedChanged(object sender, EventArgs e)
        {
            // if Add is selected populate the SubCategory control
            // And enable
            if (cboCategory.SelectedIndex == 0 )  InitializeSubCategory();
            EnableEventCategoryControls();
            //Set focus back to controls
            rdoAdd.Focus();
            //inject javascript to set focus on client side.
            ScriptManager.RegisterStartupScript(this,
                                typeof(EnrollmentControl),
                                "rdoAdd_Focus1",
                                "document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_rdoAdd').focus();", true);

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
                lblEventCategoryMessage.Visible = true;
                cboCategory.Visible = true;
                cboSubCategory.Visible = true;
                lblEventCategory.Visible = true;

                txtCategorySpecifyText.Text = "";
                txtSubCategorySpecifyText.Text = "";

                if (cboCategory.SelectedIndex == 0)
                {
                    cboSubCategory.Visible = false;
                    lblEventCategory.Visible = false;
                }

                // Show/enable Comments (registering in memory of:)
                if (Session["EnrollmentFormHideComments"] != null) bool.TryParse((string)(Session["EnrollmentFormHideComments"].ToString()), out EnrollmentFormHideComments);
                if (EnrollmentFormHideComments)
                {
                    txtComments.Visible = false;
                    lblComment.Visible = false;
                }
                else
                {
                    txtComments.Visible = true;
                    lblComment.Visible = true;
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

            Int32 EventCategory = Convert.ToInt32(cboCategory.SelectedValue);
            lblEventCategory.Text = cboCategory.SelectedItem.Text.Trim();

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
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
            }

            if (dsRegistry.EventSubCategory.Count > 0)
            {
                cboSubCategory.DataSource = dsRegistry.EventSubCategory;
                cboSubCategory.DataTextField = "EventSubCategoryName";
                cboSubCategory.DataValueField = "EventSubCategoryID";
                cboSubCategory.DataBind();
                cboSubCategory.Items.Insert(0, new ListItem("", "0"));
                lblEventCategory.Visible = true;
                cboSubCategory.Visible = true;
            }
            else
            {
                // No data to show
                cboSubCategory.SelectedIndex = -1; //set default
                lblEventCategory.Visible = false;
                cboSubCategory.Visible = false;

            }

            //Validate Category controls and color them yellow for missing data.
            areCategoriesValid();

            generateDoTabFromEventJavaScript();

        }

        protected void cboSubCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplaySubCategorySpecifyText();
            //cboSubCategory.BackColor = System.Drawing.Color.White;
            //Validate Category controls and color them yellow for missing data.  (We don't need to worry about the return value)
            areCategoriesValid();
            generateDoTabFromSubEventJavaScript();
        }

        protected string generateTabFromEventDropDownScript()
        {

            string scriptSrc = "";
            StringBuilder sb = new StringBuilder();

            sb.Append(" function tabFromEventDropDown() { ");
            sb.Append(" if (document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtCategorySpecifyText') !== null) { ");
            sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtCategorySpecifyText').focus(); ");
            sb.Append(" } ");
            sb.Append(" else if (document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_cboSubCategory') !== null) { ");
            sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_cboSubCategory').focus(); ");
            sb.Append(" } ");
            sb.Append(" else if (document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtComments') !== null) { ");
            sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtComments').focus(); ");
            sb.Append(" } ");
            sb.Append(" else { ");
            sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_btnRegisterNow').focus(); ");
            sb.Append(" } ");
            sb.Append(" } ");
            scriptSrc = sb.ToString();
            return scriptSrc;
        }

        protected string generateTabFromEventDropDownScript_ORIGINAL(){

            string scriptSrc = "";
            StringBuilder sb = new StringBuilder();
						
			sb.Append(" function tabFromSubEventDropDown() { ");
			sb.Append(" if (document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_cboSubCategory') !== null) { ");
			sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_cboSubCategory').focus(); ");
			sb.Append(" } ");
			sb.Append(" else if (document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtComments') !== null) { ");
			sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtComments').focus(); ");
			sb.Append(" } ");
			sb.Append(" else { ");
			sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_btnRegisterNow').focus(); ");
			sb.Append(" } ");
			sb.Append(" } ");
            scriptSrc = sb.ToString();
            return scriptSrc;
        }

        protected string generateTabFromSubEventDropDownScript()
        {

            string scriptSrc = "";
            StringBuilder sb = new StringBuilder();

            sb.Append(" function tabFromSubEventDropDown() { ");
            sb.Append(" if (document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtSubCategorySpecifyText') !== null) { ");
            sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtSubCategorySpecifyText').focus(); ");
            sb.Append(" } ");
            sb.Append(" else if (document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtComments') !== null) { ");
            sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_txtComments').focus(); ");
            sb.Append(" } ");
            sb.Append(" else { ");
            sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_EnrollmentControl2_btnRegisterNow').focus(); ");
            sb.Append(" } ");
            sb.Append(" } ");
            scriptSrc = sb.ToString();
            return scriptSrc;
        }


        protected void generateDoTabFromEventJavaScript()
        {
            ScriptManager.RegisterStartupScript(this,
                                typeof(EnrollmentControl),
                                "typeTabFromEventDropDown1",
                                "tabFromEventDropDown();", true);

        }


        protected void generateDoTabFromSubEventJavaScript()
        {
            ScriptManager.RegisterStartupScript(this,
                                typeof(EnrollmentControl),
                                "typeTabFromSubEventDropDown1",
                                "tabFromSubEventDropDown();", true);

        }

        protected string generateDatePickerScript()
        { //add one year to the end of Max allowed date to allow users to choose all months
            //ddlDOB.MaxDate = DateTime.Now.AddYears(1);

            string scriptSrc = "";
            StringBuilder sb = new StringBuilder();
            sb.Append(" $(function() { ");
            sb.Append(" $( '#_ctl0__ctl0_bCR_cR_EnrollmentControl2_ddlDOB' ).datepicker({ dateFormat:'mm/dd/yy', minDate: '-125Y', maxDate: '+1Y', changeMonth: true, changeYear: true, yearRange: \"-125:+1\", showOn: 'button', buttonImage: '");
            sb.Append(URLAppRoot);
            sb.Append("Framework/Themes/Default/Images/calendar.gif', buttonImageOnly: true  }); ");
            sb.Append(" $('#_ctl0__ctl0_bCR_cR_EnrollmentControl2_ddlDOB').mask('99/99/9999'); ");
            sb.Append(" }); ");            
            scriptSrc = sb.ToString();
            return scriptSrc;
        }

        protected string generateDateFormatAndValidationScripts()
        {
            string scriptSrc = "";
            StringBuilder sb = new StringBuilder();
            sb.Append(" function addDays(myDate,days) { return new Date(myDate.getTime() + days*24*60*60*1000); } ");
            sb.Append(" function validateDateRange(ctrlName){ ");
            sb.Append(" try { ");
            sb.Append(" if ($.datepicker.parseDate('mm/dd/yy', $(ctrlName).val()) === 'Invalid Date' ){ $(ctrlName).focus(); return } ");
            sb.Append(" } catch (e) {	$(ctrlName).focus(); alert('Invalid Date of Birth Entered'); return } ");
            sb.Append(" if (($(ctrlName).datepicker('getDate') > addDays(new Date(),-365*125)) 	&&  ");
            sb.Append(" ($(ctrlName).datepicker('getDate') <= addDays(new Date(),365)))	{ return } ");
            sb.Append(" else { 	$(ctrlName).focus(); alert('Invalid Date of Birth Entered');} } ");
            sb.Append(" $(document).ready(function() { ");
            sb.Append(" $('#_ctl0__ctl0_bCR_cR_EnrollmentControl2_ddlDOB').blur( function () { validateDateRange('#_ctl0__ctl0_bCR_cR_EnrollmentControl2_ddlDOB') } ); ");
            sb.Append(" }); ");
            
            scriptSrc = sb.ToString();
            return scriptSrc;
        }

        protected void generateHelloWorldScript()
        {
            ScriptManager.RegisterStartupScript(this,
            typeof(EnrollmentControl),
            "typeTabFromEventDropDown2",
            "alert('Hello World');", true);
        }

        protected void generateDisableSubmitButton()
        {
            ScriptManager.RegisterStartupScript(this,
            typeof(EnrollmentControl),
            "typedisableSubmitButtonOnClick",
            "disableSubmitButtonOnClick();", true);
        }

        protected string generateDisableSubmitButtonOnClickEventScript()
        {
            string postBackEvent = Page.GetPostBackEventReference(btnRegisterNow);
            string controlID = "_ctl0__ctl0_bCR_cR_EnrollmentControl2_btnRegisterNow";
            StringBuilder onClickScript = new StringBuilder();

            onClickScript.Append(" function disableSubmitButtonOnClick(){");
            onClickScript.Append(" if (document.getElementById('");
            onClickScript.Append(controlID);
            onClickScript.Append("')) { ");
            onClickScript.Append(" document.getElementById('");
            onClickScript.Append(controlID);
            onClickScript.Append("').onclick = function () { ");
            onClickScript.Append(" document.getElementById('");
            onClickScript.Append(controlID);
            onClickScript.Append("').disabled= true; ");
            onClickScript.Append(postBackEvent);
            onClickScript.Append("; ");
            onClickScript.Append(" document.getElementById('");
            onClickScript.Append(controlID);
            onClickScript.Append("').onclick = null ");
            onClickScript.Append("};");
            onClickScript.Append("}");
            onClickScript.Append("}");

            return onClickScript.ToString();
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
                    css.Href = CSSFileLocation.ToString();
                    css.Attributes["rel"] = "stylesheet";
                    css.Attributes["type"] = "text/css";
                    Page.Header.Controls.Add(css);
                }

                HtmlLink datepickerCss = new HtmlLink();
                datepickerCss.Href = "~/Framework/Themes/Default/datepicker.css";
                datepickerCss.Attributes["rel"] = "stylesheet";
                datepickerCss.Attributes["type"] = "text/css";
                Page.Header.Controls.Add(datepickerCss);

                HtmlGenericControl jQueryScriptControl = new HtmlGenericControl("script");
                jQueryScriptControl.Attributes.Add("language", "javascript");
                jQueryScriptControl.Attributes.Add("type", "text/javascript");
                jQueryScriptControl.Attributes.Add("src", "//code.jquery.com/jquery-1.9.1.js");               
                Page.Header.Controls.Add(jQueryScriptControl);

                HtmlGenericControl jQueryUiScriptControl = new HtmlGenericControl("script");
                jQueryUiScriptControl.Attributes.Add("language", "javascript");
                jQueryUiScriptControl.Attributes.Add("type", "text/javascript");
                jQueryUiScriptControl.Attributes.Add("src", "//code.jquery.com/ui/1.10.4/jquery-ui.js");
                Page.Header.Controls.Add(jQueryUiScriptControl);

                HtmlGenericControl jQueryMaskedInputScriptControl = new HtmlGenericControl("script");
                jQueryMaskedInputScriptControl.Attributes.Add("language", "javascript");
                jQueryMaskedInputScriptControl.Attributes.Add("type", "text/javascript");
                jQueryMaskedInputScriptControl.Attributes.Add("src", URLAppRoot + "Framework/Scripts/jquery.mask.min.js");
                Page.Header.Controls.Add(jQueryMaskedInputScriptControl);

                HtmlGenericControl datePickerScriptControl = new HtmlGenericControl("script");
                datePickerScriptControl.Attributes.Add("language", "javascript");
                datePickerScriptControl.Attributes.Add("type", "text/javascript");
                datePickerScriptControl.InnerHtml = generateDatePickerScript();
                Page.Header.Controls.Add(datePickerScriptControl);

                HtmlGenericControl dateFormatScriptControl = new HtmlGenericControl("script");
                dateFormatScriptControl.Attributes.Add("language", "javascript");
                dateFormatScriptControl.Attributes.Add("type", "text/javascript");
                dateFormatScriptControl.InnerHtml = generateDateFormatAndValidationScripts();
                Page.Header.Controls.Add(dateFormatScriptControl);

                HtmlGenericControl tabFromEventScriptControl = new HtmlGenericControl("script");
                tabFromEventScriptControl.Attributes.Add("language", "javascript");
                tabFromEventScriptControl.Attributes.Add("type", "text/javascript");
                tabFromEventScriptControl.InnerHtml = generateTabFromEventDropDownScript();
                Page.Header.Controls.Add(tabFromEventScriptControl);

                HtmlGenericControl tabFromSubEventScriptControl = new HtmlGenericControl("script");
                tabFromSubEventScriptControl.Attributes.Add("language", "javascript");
                tabFromSubEventScriptControl.Attributes.Add("type", "text/javascript");
                tabFromSubEventScriptControl.InnerHtml = generateTabFromSubEventDropDownScript();
                Page.Header.Controls.Add(tabFromSubEventScriptControl);

                HtmlGenericControl onclickButtonScriptControl = new HtmlGenericControl("script");
                onclickButtonScriptControl.Attributes.Add("language", "javascript");
                onclickButtonScriptControl.Attributes.Add("type", "text/javascript");
                onclickButtonScriptControl.InnerHtml = generateDisableSubmitButtonOnClickEventScript();
                Page.Header.Controls.Add(onclickButtonScriptControl);

                generateDisableSubmitButton();

            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
            }
        }


        #region Page Load Methods

        private static void SetDateTimeGlobalization()
        {
            System.Globalization.CultureInfo ci = System.Globalization.CultureInfo.CreateSpecificCulture("en-EN");
            ci.DateTimeFormat.LongDatePattern = "MM/dd/yyyy";
            ci.DateTimeFormat.ShortDatePattern = "MM/dd/yyyy";
            ci.Calendar.TwoDigitYearMax = DateTime.Now.Year;
        }

        private void GetAndApplyRegistryOwnerEnrollmentText()
        {
            GetRegistryOwnerEnrollmentText();
            ApplyRegistryOwnerEnrollmentText();
        }

        private void RegistryOwnerSessionVariableCheck()
        {
            if (Session["RegistryOwnerID"] != null && IsPostBack)
            {
                //set variables from session
                SetVariablesFromSession();       
            }
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
                Session.Add("RegistryOwnerName", (string)hdnRegistryOwnerName.Value.ToString());
                Session.Add("LanguageCode", (string)hdnLanguageCode.Value.ToString());
                Session.Add("RegistryOwnerRouteName", (string)hdnRegistryOwnerRouteName.Value.ToString());
                Session.Add("AllowDisplayNoDonors", (string)(hdnAllowDisplayNoDonors.Value.ToString()));
                Session.Add("CSSFileLocation", (string)hdnCSSFileLocation.Value.ToString());

                SetVariablesFromSession();
            }
        }

        private void SetVariablesFromSession()
        {
            RegistryOwnerID = Convert.ToInt32(Session["RegistryOwnerID"]);
            RegistryOwnerIDValue = Session["RegistryOwnerID"].ToString();
            RegistryOwnerName = Session["RegistryOwnerName"].ToString();
            RegistryOwnerLanguageCode = Session["LanguageCode"].ToString();
            RegistryOwnerRouteName = Session["RegistryOwnerRouteName"].ToString();
            CSSFileLocation = Session["CSSFileLocation"].ToString();
            
            AllowDisplayNoDonors = false;
            if (Session["AllowDisplayNoDonors"].ToString().ToUpper() == "TRUE"){
                AllowDisplayNoDonors = true;
            }
            
                        
        }

        private void IdentifyRegistryOwnerFromHttpRequest()
        {
            if (HttpContext.Current.Items["Owner"] == null)
            {   // Determine if this is a query string or session request
                RegistryOwnerIDValue = Request.QueryString["RegistryOwnerID"] != null ? HttpUtility.UrlDecode(Request.QueryString["RegistryOwnerID"]) : Session["RegistryOwnerID"].ToString();
                RegistryOwnerRouteName = String.Empty;
                RegistryOwnerLanguageCode = Request.QueryString["LanguageCode"] == null ? "en" : HttpUtility.UrlDecode(Request.QueryString["LanguageCode"]);
            }
            else
            {   // Prepair to use route information
                RegistryOwnerIDValue = "0";
                RegistryOwnerRouteName = HttpContext.Current.Items["Owner"].ToString() == null ? "ne" : HttpContext.Current.Items["Owner"].ToString();
                RegistryOwnerLanguageCode = HttpContext.Current.Items["language"].ToString() == null ? "en" : HttpContext.Current.Items["language"].ToString();


                string useragent = Request.UserAgent;
                bool isAndroid = false;
                if (useragent != null)
                {
                    if (useragent.ToLower().Contains("android"))
                    {
                        isAndroid = true;
                    }
                }

                // Look for mobile device and redirect if found
                if (Request.Browser.IsMobileDevice || isAndroid)
                {
                    Response.Redirect(String.Format("~/register/{0}/{1}", RegistryOwnerRouteName.ToString(), MobileRoutePage));
                }

            }

            Session.Add("LanguageCode", RegistryOwnerLanguageCode.ToString());
            LanguageCode = (string)(Session["LanguageCode"].ToString());
        }

        private void GetRegistryOwnerEnrollmentText()
        {
            // FillRegistryOwnerEnrollmentFormText
            if (dsRegistry == null)
                dsRegistry = new RegistryCommon();
            try
            {
                RegistryCommonManager.FillRegistryOwnerEnrollmentText(dsRegistry, Convert.ToInt32(RegistryOwnerID), LanguageCode);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);

                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented this page from loading.");
            }

            // If language not found, re-direct to English form as default 
            if (dsRegistry.RegistryOwnerEnrollmentText.Count != 1)
            {
                Response.Redirect(String.Format("~/register/{0}/{1}", RegistryOwnerRouteName.ToString(), WebEnglishRoutePage));
            }
        }

        private void ApplyRegistrantOwnerConfiguration()
        {
            txtLimitations.Height = Int32.Parse(LimitationsMaxLength) < 101 ? 20 : 84;
            txtLimitations.Attributes.Add("OnKeyPress", "return textMaxLength(this, '" + LimitationsMaxLength + "', event)");
            txtComments.Attributes.Add("OnKeyPress", "return textMaxLength(this, '" + CommentsMaxLength + "', event)");
            txtLicenseOrStateID.Attributes.Add("OnKeyPress", "return textMaxLength(this, '" + LicenseOrStateIDMaxLength + "', event)");

            //add one year to the end of Max allowed date to allow users to choose all months
            //ddlDOB.MaxDate = DateTime.Now.AddYears(1); //Now set in jQuery datepicker function

            txtCategorySpecifyText.Visible = false;
            lblCategorySpecifyText.Visible = false;

            txtSubCategorySpecifyText.Visible = false;
            lblSubCategorySpecifyText.Visible = false;

            //Apply Initial Field Visibility Settings based on RegistryOwner parameters
            if (EnrollmentFormHideComments)
            {
                txtComments.Visible = false;
                lblComment.Visible = false;
            }

            if (!EnrollmentFormDisplayLicenseOrStateID)
            {
                divStateIdInformation.Visible = false;
                lblLicenseOrStateID.Visible = false;
                txtLicenseOrStateID.Visible = false;
                txtLicenseOrStateID.Text = "";
            }

            if ((!IDologyActive) || (IDologyActive && !IDologyUsesSSN))
            {
                divSSN.Visible = false;
                lblLastFourSSN.Visible = false;
                txtLastFourSSN.Visible = false;
                txtLastFourSSN.Text = "";
            }
        }

        private void GetAndApplyRegistrantOwnerStateList()
        {
            // Fill State DropDownList
            if (dsRegistry == null)
                dsRegistry = new RegistryCommon();
            try
            {
                RegistryCommonManager.FillDropDownListState(dsRegistry, RegistryOwnerID);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
            }
            cboState.DataTextField = "RegistryOwnerStateAbbrv";
            cboState.DataValueField = "RegistryOwnerStateAbbrv";
            cboState.DataSource = dsRegistry.RegistryOwnerStateConfig;
            cboState.DataBind();
            // Set default state selection
            cboState.Items.Insert(0, new ListItem("", "0"));
            cboState.SelectedValue = EnrollmentFormDefaultStateSelection;
        }

        private void GetAndApplyRegistrantOwnerCategories()
        {
            // Fill Category control
            if (dsRegistry == null)
                dsRegistry = new RegistryCommon();
            try
            {
                RegistryCommonManager.FillEventCategoryEdit(dsRegistry, 0, RegistryOwnerID, 1);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
            }

            cboCategory.DataTextField = "EventCategoryName";
            cboCategory.DataValueField = "EventCategoryID";
            cboCategory.DataSource = dsRegistry.EventCategory;
            cboCategory.DataBind();
            cboCategory.Items.Insert(0, new ListItem("", "0"));

            InitializeSubCategory();

            //force unselected sub category to no display
            cboSubCategory.Visible = false;
            lblEventCategory.Visible = false;
        }

        private void ApplyRegistryOwnerEnrollmentText()
        {
            Image1.ImageUrl = dsRegistry.RegistryOwnerEnrollmentText[0].HeaderImageURL.ToString();
            Image1.Height = Convert.ToInt32(dsRegistry.RegistryOwnerEnrollmentText[0].HeaderImageHeight);
            Image1.Width = Convert.ToInt32(dsRegistry.RegistryOwnerEnrollmentText[0].HeaderImageWidth);
            divInstruction.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivInstruction.ToString();
            divRegistrationSelection.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivRegistrationSelection.ToString();
            lblSelectOne.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblSelectOne.ToString();
            rdoAdd.Text = dsRegistry.RegistryOwnerEnrollmentText[0].RdoAdd.ToString();
            rdoRemove.Text = dsRegistry.RegistryOwnerEnrollmentText[0].RdoRemove.ToString();
            divNameInstruction.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivNameInstruction.ToString();
            lblFirstName.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblFirstName.ToString();
            divLastName.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].LblLastName.ToString();
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
            divLimitations.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivLimitations.ToString();
            divLimitationsInstructions.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivLimitationsInstructions.ToString();
            lblEventCategoryMessage.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblEventCategoryMessage.ToString();
            lblComment.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblComment.ToString();
            divInformationContacts.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivInformationContacts.ToString();
            divSubmitInstructions.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivSubmitInstruction.ToString();
            btnRegisterNow.Text = dsRegistry.RegistryOwnerEnrollmentText[0].BtnRegisterNow.ToString();
            divFooter.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivFooter.ToString();
            divCityStateZipText.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivCityStateZipText.ToString();
            divStateIdInformation.InnerHtml = dsRegistry.RegistryOwnerEnrollmentText[0].DivStateIdInformation.ToString();
            lblLicenseOrStateID.Text = dsRegistry.RegistryOwnerEnrollmentText[0].LblLicenseOrStateID.ToString();
        }

        private void GetAndApplyRegistrantData()
        {
            if (!String.IsNullOrEmpty(Request.QueryString["RegistryID"]) && UserIsLoggedIn)
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
                    Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
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
                //this.ddlDOB.Text = Convert.ToDateTime(dsRegistry.Registry[0].DOB);
                this.ddlDOB.Text = String.Format("{0:MM/dd/yyyy}", Convert.ToDateTime(dsRegistry.Registry[0].DOB));
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
                        cboSubCategory.Items.Insert(0, new ListItem("", "0"));
                        cboSubCategory.SelectedValue = SubCategoryID.ToString();

                        if (SubCategoryID == 0)
                        {
                            cboSubCategory.Visible = false;
                            lblEventCategory.Visible = false;
                        }
                        else
                        {
                            lblEventCategory.Visible = true;
                            cboSubCategory.Visible = true;
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
        }

        private void GetRegistryOwnerConfiguration()
        {
            //Get Specific RegistryOwner Settings
            if (dsRegistry == null)
                dsRegistry = new RegistryCommon();
            try
            {
                RegistryCommonManager.FillRegistryOwner(dsRegistry, Convert.ToInt32(RegistryOwnerIDValue), RegistryOwnerRouteName);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented this page from loading.");
            }

            try
            {
                //Get Registry Owner information and options
                RegistryOwnerID = (dsRegistry.RegistryOwner[0].RegistryOwnerID);
                RegistryOwnerName = (dsRegistry.RegistryOwner[0].RegistryOwnerName);
                IDologyActive = (dsRegistry.RegistryOwner[0].IDologyActive);
                IDologyUsesSSN = Convert.ToBoolean(dsRegistry.RegistryOwner[0].IdologyUsesSSN);
                IdologyActiveInPortal = Convert.ToBoolean(dsRegistry.RegistryOwner[0].IdologyActiveInPortal);                
                EnrollmentFormHideComments = dsRegistry.RegistryOwner[0].EnrollmentFormHideComments;                
                EnrollmentFormDefaultStateSelection = dsRegistry.RegistryOwner[0].EnrollmentFormDefaultStateSelection;
                CSSFileLocation = dsRegistry.RegistryOwner[0].CSSFileLocation;
                AllowDisplayNoDonors = dsRegistry.RegistryOwner[0].AllowDisplayNoDonors;
                AllowDonorToPrintVerificationForm = dsRegistry.RegistryOwner[0].AllowDonorToPrintVerificationForm;                
                EnrollmentFormDisplayLicenseOrStateID = dsRegistry.RegistryOwner[0].EnrollmentFormDisplayLicenseOrStateID;
                EnrollmentFormIsPublic = Convert.ToBoolean(dsRegistry.RegistryOwner[0].EnrollmentFormIsPublic);

                //Set UI text box length
                LimitationsMaxLength = dsRegistry.RegistryOwner[0].EnrollmentFormLimitationsMaxLength.ToString();                
                CommentsMaxLength = dsRegistry.RegistryOwner[0].EnrollmentFormCommentsMaxLength.ToString();

                //Create sessions
                Session.Add("RegistryOwnerID", RegistryOwnerID.ToString());
                Session.Add("RegistryOwnerName", (string)RegistryOwnerName.ToString());
                Session.Add("RegistryOwnerRouteName", (string)RegistryOwnerRouteName.ToString());
                Session.Add("CSSFileLocation", CSSFileLocation.ToString());
                Session.Add("LimitationsMaxLength", LimitationsMaxLength.ToString());
                Session.Add("EnrollmentFormHideComments", EnrollmentFormHideComments.ToString());
                Session.Add("AllowDisplayNoDonors", AllowDisplayNoDonors.ToString());
                Session.Add("AllowDonorToPrintVerificationForm", AllowDonorToPrintVerificationForm.ToString());

                if (UserIsLoggedIn && IDologyActive)
                {
                    Session.Add("IDologyActive", IdologyActiveInPortal.ToString());
                }
                else
                {
                    Session.Add("IDologyActive", IDologyActive.ToString());
                }

            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
                //User tried to land on non-registered route name
                //return user to login screen 
                QueryStringManager.Redirect(PageName.Login);
            }
        }

        private void CheckPageAccess()
        {
            bool notAuthorized = false;
            int RegistryOwnerIdFromCookie =  RegistryCommonManager.GetRegistryOwnerUserOrg(Convert.ToInt32(Page.Cookies.UserOrgID), 0);
            if (EnrollmentFormIsPublic == false && UserIsLoggedIn == false)
            {
                notAuthorized = true;
            }
            else if (EnrollmentFormIsPublic == false && UserIsLoggedIn == true && RegistryOwnerID != RegistryOwnerIdFromCookie) 
            {
                notAuthorized = true;
            }


            if (notAuthorized)
            {
                Logger.Write("Unauthorized Access to Secured Registry Enrollment Form", "Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl", 1);
                //User tried to land on non-registered route name
                //return user to login screen 
                QueryStringManager.Redirect(PageName.Login);
            }
        }

        #endregion

    }
}
