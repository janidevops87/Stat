using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Net.Mail;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.Configuration;
using Statline.StatTrac.Web.UI;
using Statline.Registry.Common;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;
using Microsoft.Practices.EnterpriseLibrary.Logging;


namespace Statline.Registry.Web.UI.Controls.Dynamic
{
    public partial class ElectronicSignatureControl : BaseUserControl
    {
        protected RegistryCommon dsCommonData;
        protected RegistryCommon dsRegistry;

        Int32   RegistryOwnerID;
        String  RegistryOwnerRoute;
        String  LanguageCode;
        String  RegistryID;
        String  DonorRegistrationRequest;
        String  FirstName;
        String  LastName;
        String  LastFourSSN;
        String License;
        String  IDologyID;
        String State;

        String AddEmailSubject = String.Empty;
        String AddEmailBody = String.Empty;

        String AddEmailInvitationSubject = String.Empty;
        String AddEmailInvitationBody = String.Empty;

        String RemoveEmailSubject = String.Empty;
        String RemoveEmailBody = String.Empty;

        String EmailFromAddress = String.Empty;

        String  EmailMailboxAccount = String.Empty;

        String CertificateAuthority = String.Empty;

        bool AllowDisplayNoDonors = false;
        
        String CSSFileLocation;

        protected ValidationErrorMessage validationErrorMessage;

        const int NotAStatLineEmployeeID = -1;

        String URLAppRoot = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath + "/";

        protected void Page_Load(object sender, EventArgs e)
        {

            GetSessionInfo();
            if (!this.IsPostBack)
            {
                if (dsCommonData == null) dsCommonData = new RegistryCommon();
                    try
                    {
                    RegistryCommonManager.FillDataFormElectronicSignature(dsCommonData, Convert.ToInt32(RegistryID));
                    //Get donor information
                    lblNameValue.Text = dsCommonData.DataFormElectronicSignature[0].ElectronicSignatureName.ToString();
                    lblAddressValue.Text = dsCommonData.DataFormElectronicSignature[0].ElectronicSignatureAddress.ToString();
                    lblEmailValue.Text = dsCommonData.DataFormElectronicSignature[0].ElectronicSignatureEmail.ToString();
                    lblDOB.Text = dsCommonData.DataFormElectronicSignature[0].ElectronicSignatureDOB.ToString();

                    if (dsRegistry == null) dsRegistry = new RegistryCommon();                   
                    RegistryCommonManager.FillRegistryOwnerElectronicSignatureText(dsRegistry, Convert.ToInt32(RegistryOwnerID), LanguageCode);
                    lblName.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].LblName.ToString();
                    lblAddress.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].LblAddress.ToString();
                    lblEmail.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].LblEmail.ToString();
                    divFooter.InnerHtml = dsRegistry.RegistryOwnerElectronicSignatureText[0].DivFooter.ToString();
                    
                    if (DonorRegistrationRequest == "Add")
                        {
                            lblConfirmationText.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].AddLblConfirmation.ToString();
                            divConfirmationNotes.InnerHtml = dsRegistry.RegistryOwnerElectronicSignatureText[0].AddDivConfirmationNotes.ToString();
                            cbxConfirmation.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].AddCbxConfirmation.ToString();
                            btnRegistration.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].AddBtnRegistration.ToString();
                        
                        }
                    if (DonorRegistrationRequest == "Remove")
                        {
                            lblConfirmationText.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].RemoveLblConfirmation.ToString();
                            divConfirmationNotes.InnerHtml = dsRegistry.RegistryOwnerElectronicSignatureText[0].RemoveDivConfirmationNotes.ToString();
                            cbxConfirmation.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].RemoveCbxConfirmation.ToString();
                            btnRegistration.Text = dsRegistry.RegistryOwnerElectronicSignatureText[0].RemoveBtnRegistration.ToString();
                        }

                    //set hidden fields to handle session timeout
                        hdnRegistryOwnerID.Value = (string)RegistryOwnerID.ToString();
                        hdnRegistryOwnerRouteName.Value = (string)RegistryOwnerRoute.ToString();
                        hdnLanguageCode.Value = (string)LanguageCode.ToString();
                        hdnRegistryID.Value = (string)RegistryID.ToString();
                        hdnDonorRegistrationRequest.Value = (string)DonorRegistrationRequest.ToString();
                        hdnFirstName.Value = (string)FirstName.ToString();
                        hdnLastName.Value = (string)LastName.ToString();
                        hdnLastFourSSN.Value = (string)LastFourSSN.ToString();
                        hdnLicense.Value = (string)License.ToString();
                        hdnIDologyID.Value = (string)IDologyID.ToString();
                        hdnAllowDisplayNoDonors.Value = (string)AllowDisplayNoDonors.ToString();
                        hdnCSSFileLocation.Value = (string)CSSFileLocation.ToString();
                        hdnState.Value = (string)State.ToString();

                    }
                    catch (Exception ex)
                    {
                        Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.ElectronicSignatureControl", 1);
                        DisplayMessages.Add(MessageType.ErrorMessage, "A database error occurred.");
                    }

        }

        }

       private void GetSessionInfo()
        {

            if (Session["RegistryOwnerID"] != null) RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
            else { //session expired while user was on ElectronicSignature Page. Try to scrape Key Session Values from hidden form values and 
                   // save to session
                if (hdnRegistryOwnerRouteName.Value.ToString() == "None") RegistryOwnerID = 0; //Session expired before the page was loaded
                else { //scrape Key Session Values
                    RegistryOwnerID = Convert.ToInt32((string)hdnRegistryOwnerID.Value.ToString());
                    Session.Add("RegistryOwnerID", Convert.ToInt32((string)hdnRegistryOwnerID.Value.ToString()));
                    Session.Add("LanguageCode", (string)hdnLanguageCode.Value.ToString());
                    Session.Add("RegistryOwnerRouteName", (string)hdnRegistryOwnerRouteName.Value.ToString());
                    Session.Add("RegistryID", (string)hdnRegistryID.Value.ToString());
                    Session.Add("DonorRegistrationRequest", (string)hdnDonorRegistrationRequest.Value.ToString());
                    Session.Add("FirstName", (string)hdnFirstName.Value.ToString());
                    Session.Add("LastName", (string)hdnLastName.Value.ToString());
                    Session.Add("LastFourSSN", (string)hdnLastFourSSN.Value.ToString());
                    Session.Add("License", (string)hdnLicense.Value.ToString());
                    Session.Add("IDologyID", (string)hdnIDologyID.Value.ToString());
                    Session.Add("AllowDisplayNoDonors", bool.TryParse((string)(hdnAllowDisplayNoDonors.Value.ToString()), out AllowDisplayNoDonors));
                    Session.Add("CSSFileLocation", (string)hdnCSSFileLocation.Value.ToString());
                    Session.Add("State", (string)hdnState.Value.ToString());
                }
            
            } //set default
            if (Session["LanguageCode"] != null) LanguageCode = (string)(Session["LanguageCode"].ToString());
            else { LanguageCode = "en"; } //set default

            if (Session["RegistryOwnerRouteName"] != null) RegistryOwnerRoute = (string)(Session["RegistryOwnerRouteName"].ToString());
            else { RegistryOwnerRoute = "ne"; } //set default

            if (Session["RegistryID"] != null) RegistryID = (string)(Session["RegistryID"].ToString());
            else { RegistryID = "0"; } //set default
            if (Session["DonorRegistrationRequest"] != null) DonorRegistrationRequest = (string)(Session["DonorRegistrationRequest"].ToString());
            else { DonorRegistrationRequest = "Delete"; } //set default
            if (Session["FirstName"] != null) FirstName = (string)(Session["FirstName"].ToString());
            else { FirstName = ""; } //set default
            if (Session["LastName"] != null) LastName = (string)(Session["LastName"].ToString());
            else { LastName = ""; } //set default
            if (Session["LastFourSSN"] != null) LastFourSSN = (string)(Session["LastFourSSN"].ToString());
            else { LastFourSSN = "-"; } //set default
            if (Session["License"] != null) License = (string)(Session["License"].ToString());
            else { License = "-"; } //set default
            if (Session["IDologyID"] != null) IDologyID = (string)(Session["IDologyID"].ToString());
            else { IDologyID = "0"; } //set default
            
           if (Session["State"] != null)
                State = (string)(Session["State"].ToString());
            else
                State = "";  //set default
            
           // Set AllowDisplayNoDonors session value
            if (Session["AllowDisplayNoDonors"] != null) bool.TryParse((string)(Session["AllowDisplayNoDonors"].ToString()), out AllowDisplayNoDonors);
            //Get CSS file location
            if (Session["CSSFileLocation"] != null) CSSFileLocation = (string)(Session["CSSFileLocation"].ToString());
            else { CSSFileLocation = "~/Framework/Themes/Default/Enrollment.css"; } //set default
        }
        
        protected void cbxConfirmation_CheckedChanged(object sender, EventArgs e)
        {
            
        }

        protected void btnRegistration_Click(object sender, EventArgs e)
        {
            try
            {
                if (this.cbxConfirmation.Checked == true)
                {
                    // Check for duplicate records. DonorID results: value(), Description
                    //  1.  -1, New donor
                    //  2.   0, Don't update this record. More than one donor exists with the same criteria
                    //  3. n>1, This is an update. One donor match found. Value returned is old RegistryID

                    // Do Not use SSN in duplicate search
                    LastFourSSN = "-";
                    string DOB = lblDOB.Text.ToString();

                    Int32 DonorID = RegistryCommonManager.GetExistingDonor(Convert.ToInt32(RegistryID), Convert.ToInt32(RegistryOwnerID), FirstName, LastName, LastFourSSN, License, DOB, 0);

                    // Load current RegistryID
                    if (dsCommonData == null) dsCommonData = new RegistryCommon();
                    RegistryCommonManager.FillRegistry(dsCommonData, Convert.ToInt32(RegistryID));

                    if (DonorID >= 1)
                    {// Load Existing DonorID for update
                        if (dsCommonData == null) dsCommonData = new RegistryCommon();
                        RegistryCommonManager.FillRegistry(dsCommonData, Convert.ToInt32(DonorID));
                    }
                    if (DonorID == 0) // to many records were found. Cannot confirm id
                    {
                        // may want to flag recored just entered for delete
                        // record has a status of Donor: false, DonorConfirmed: false 
                        // dsCommonData.Registry[0].DeleteFlag = true;

                        // Either donor does not exist or multiple records found.
                        Session.Add("DonorNotConfirmed", "True");
                        Session.Add("IDRequestType", "DisplayPageOnly");
                        QueryStringManager.Redirect(PageName.DynamicValidate);
                        return;
                    }

                    if (DonorRegistrationRequest == "Add")
                    {
                        AddDonorRegistrationRequest(DonorID);

                    }
                    if (DonorRegistrationRequest == "Remove")
                    {
                        RemoveDonorRegistrationRequest(DonorID);
                    }

                    // Finial Confirmation
                    QueryStringManager.Redirect(PageName.DynamicEnrollmentConfirmation);
                }
                else
                {
                    // button was pressed without checkbox checked. Give message 
                    if (LanguageCode == null) { LanguageCode = (string)(Session["LanguageCode"].ToString()); }
                    validationErrorMessage = new ValidationErrorMessage(ValidationErrorMessageTypes.SIGNATURE_CHECKBOX_NOT_SET, LanguageCode);
                    DisplayMessages.Add(MessageType.ErrorMessage, validationErrorMessage.ErrorMessage);
                }
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
                DisplayMessages.Add(MessageType.ErrorMessage, "An Unexpected Error Occurred.");
            }
        }

        private void RemoveDonorRegistrationRequest(Int32 DonorID)
        {
            if (DonorID >= 1) // Previous record exists
            {
                // update previous donor status values
                dsCommonData.Registry[0].DeleteFlag = dsCommonData.Registry[1].DeleteFlag;
                dsCommonData.Registry[0].DonorConfirmed = dsCommonData.Registry[1].DonorConfirmed;
                dsCommonData.Registry[0].PreviousDonor = dsCommonData.Registry[1].Donor == true ? "True" : "False";
                dsCommonData.Registry[0].PreviousDonorConfirmed = dsCommonData.Registry[1].DonorConfirmed == true ? "True" : "False";

                // remove old record
                dsCommonData.Registry[1].Donor = false;
                dsCommonData.Registry[1].DonorConfirmed = false;
                dsCommonData.Registry[1].DeleteFlag = true;
            }

            // change donor status of new record
            dsCommonData.Registry[0].Donor = false;

            //ccarroll 06/15/2009 - added to permanently remove donor if performed by logged-in user.
            if (Convert.ToInt32(Page.Cookies.UserId) > 0)
            {   //Logged-in user performing change to remove record
                dsCommonData.Registry[0].DonorConfirmed = false;
                dsCommonData.Registry[0].DeleteFlag = true;
            }

            // If Allow No Donor option is true and the donor has indicated to be removed
            // the donor is confirmed as No. Delete Flag set to false to indicate active record
            if (AllowDisplayNoDonors)
            {
                dsCommonData.Registry[0].DonorConfirmed = true;
                dsCommonData.Registry[0].DeleteFlag = false;
            }

            // Commit changes
            RegistryCommonManager.UpdateRegistry(dsCommonData);

            //Configure Email message for remove and Digital Certificate 
            ConfigureEmailMessageRemove();

            // Record Digital Certificate
            RecordDigitalCertificate();

            //Send Email Confirmation
            SendEmailConfirmation(lblEmailValue.Text.ToString(), RemoveEmailSubject.ToString(), FormatPlainText(RemoveEmailBody.ToString()));
        }

        private void AddDonorRegistrationRequest(Int32 DonorID)
        {
            if (DonorID >= 1) // This is an Update 
            {
                // transfer previous donor status values
                dsCommonData.Registry[0].PreviousDonor = dsCommonData.Registry[1].Donor == true ? "True" : "False";
                dsCommonData.Registry[0].PreviousDonorConfirmed = dsCommonData.Registry[1].DonorConfirmed == true ? "True" : "False";

                // de-activate old record
                dsCommonData.Registry[1].Donor = false;
                dsCommonData.Registry[1].DonorConfirmed = false;
                dsCommonData.Registry[1].DeleteFlag = true;
            }

            // activate new record
            dsCommonData.Registry[0].Donor = true;
            dsCommonData.Registry[0].DonorConfirmed = true;
            dsCommonData.Registry[0].DeleteFlag = false;

            // Commit changes
            RegistryCommonManager.UpdateRegistry(dsCommonData);

            // Construct Email Message for Add and Digital Certificate
            ConfigureEmailMessageAdd();

            // Record Digital Certificate
            RecordDigitalCertificate();

            //Send Email Confirmation
            SendEmailConfirmation(lblEmailValue.Text.ToString(), AddEmailSubject.ToString(), FormatPlainText(AddEmailBody.ToString()));

            //Send Donor Family and Friends Invitation
            SendEmailConfirmation(lblEmailValue.Text.ToString(), AddEmailInvitationSubject.ToString(), FormatPlainText(AddEmailInvitationBody.ToString()));
        }



        private void RecordDigitalCertificate()
        {
            int statEmployeeID;

            if (Session["License"] != null) License = (string)(Session["License"].ToString());
            else { License = "-"; } //set default

            if (dsRegistry == null)
                    dsRegistry = new RegistryCommon();
                    
            RegistryCommonManager.FillRegistryOwner(dsRegistry, Convert.ToInt32(RegistryOwnerID),  Session["RegistryOwnerRouteName"].ToString());
            DigitalSignature UserSignature = null;
            //********************************************
            #if DEBUG   //Do Not Use Certificate When Debugging as Registry Specified Certificate may not be available to developer.
                string EncryptionAlgorithm = "SHA1";
            #else
                string EncryptionAlgorithm = dsRegistry.RegistryOwner[0].CertificateSigningHashAlgorithm.ToString();
            #endif            
            //********************************************

            // Create Certificate String
            string UserSignatureData =
                 CertificateAuthority.ToString() +
                "|IDologyID: " + IDologyID.ToString() +
                "|Name: " + this.lblNameValue.Text.ToString() +
                "|Address: " + this.lblAddressValue.Text.ToString() +
                "|Email: " + this.lblEmailValue.Text.ToString() +
                "|Legal text at time of signature: " + this.cbxConfirmation.Text.ToString() +
                "|Timestamp: " + System.DateTime.Now.ToString() +
                "|Driver''s License or State ID: " + License.ToString()
                ;            
            //Sign Certificate String based on Registry Owners Encryption Algorithm
            if (EncryptionAlgorithm == CryptographicMethods.X509Certificate.ToString()) 
            {
                string certSubject = dsRegistry.RegistryOwner[0].CertificateSubject.ToString();//"CN=StatlineDevelopment";                                    
                UserSignature = new DigitalSignature(UserSignatureData.ToString(), EncryptionAlgorithm, certSubject);
            }
            else //sign using SHA1
            {
                UserSignature = new DigitalSignature(UserSignatureData.ToString(), EncryptionAlgorithm);
            }
           
            //Identify if Registrant or Statline Employee performing Signature
            string cookieEmployeeID = Page.Cookies.StatEmployeeID.ToString();
            if (Convert.ToInt32(cookieEmployeeID) > 0)
            {
                statEmployeeID = Convert.ToInt32(cookieEmployeeID);
            }
            else
            {
                statEmployeeID = NotAStatLineEmployeeID;
            }


            //Record Electronic Signature
            if (dsCommonData == null) dsCommonData = new RegistryCommon();
            RegistryCommon.RegistryDigitalCertificateRow row;
            row = dsCommonData.RegistryDigitalCertificate.NewRegistryDigitalCertificateRow();
            row["RegistryID"] = Convert.ToInt32(RegistryID.ToString());
            row["RegistryDigitalCertificateData"] = UserSignature.SourceDataByteArray;
            row["LastStatEmployeeID"] = statEmployeeID;
            row["HashAlgorithmAtTimeofSigning"] = EncryptionAlgorithm.ToString();
            row["Signature"] = UserSignature.Signature;
            row["SignaturePublicKey"] = UserSignature.PublicKey.ToString();
            dsCommonData.RegistryDigitalCertificate.AddRegistryDigitalCertificateRow(row);
            RegistryCommonManager.UpdateRegistryDigitalCertificate(dsCommonData);

        }
        
        private void ConfigureEmailMessageAdd()
        {
            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            RegistryCommonManager.FillRegistryOwnerElectronicSignatureText(dsRegistry, Convert.ToInt32(RegistryOwnerID), LanguageCode);
            // Email Message Add
            EmailFromAddress = dsRegistry.RegistryOwnerElectronicSignatureText[0].EmailFrom.ToString();
            EmailMailboxAccount = dsRegistry.RegistryOwnerElectronicSignatureText[0].EmailMailboxAccount.ToString();

            AddEmailSubject = dsRegistry.RegistryOwnerElectronicSignatureText[0].AddEmailSubject.ToString();
            AddEmailBody = dsRegistry.RegistryOwnerElectronicSignatureText[0].AddEmailBody.ToString();

            // Email Message Invitation
            AddEmailInvitationSubject = dsRegistry.RegistryOwnerElectronicSignatureText[0].AddEmailInvitationSubject.ToString();
            AddEmailInvitationBody = dsRegistry.RegistryOwnerElectronicSignatureText[0].AddEmailInvitationBody.ToString();

            // Record Certificate Authority for inclusion in Digital Certificate
            CertificateAuthority = dsRegistry.RegistryOwnerElectronicSignatureText[0].CertificateAuthority.ToString();

        }
        private string FormatPlainText(string text)
        {
            text = text.Replace("\\r\\n", Environment.NewLine);
            return text;
        }
        private void ConfigureEmailMessageRemove()
        {
            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            RegistryCommonManager.FillRegistryOwnerElectronicSignatureText(dsRegistry, Convert.ToInt32(RegistryOwnerID), LanguageCode);

            // Email Message Remove
            EmailFromAddress = dsRegistry.RegistryOwnerElectronicSignatureText[0].EmailFrom.ToString();
            EmailMailboxAccount = dsRegistry.RegistryOwnerElectronicSignatureText[0].EmailMailboxAccount.ToString();

            RemoveEmailSubject = dsRegistry.RegistryOwnerElectronicSignatureText[0].RemoveEmailSubject.ToString();
            RemoveEmailBody = dsRegistry.RegistryOwnerElectronicSignatureText[0].RemoveEmailBody.ToString();

            // Record Certificate Authority for inclusion in Digital Certificate
            CertificateAuthority = dsRegistry.RegistryOwnerElectronicSignatureText[0].CertificateAuthority.ToString();

        }
        private void SendEmailConfirmation(string emailAddress, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(emailAddress.ToString());
                mail.From = new MailAddress(EmailMailboxAccount.ToString());
                mail.ReplyToList.Add(new MailAddress(EmailFromAddress.ToString()));
                mail.Subject = subject.ToString();
                mail.Body = body.ToString();
                SmtpClient smtp = new SmtpClient(ApplicationSettings.GetSetting(SettingName.MailServer), Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.EmailPort)));
                smtp.Credentials = new System.Net.NetworkCredential(EmailMailboxAccount.ToString(), ApplicationSettings.GetSetting(SettingName.EmailPassword));
                smtp.EnableSsl = true;

                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.ElectronicSignatureControl", 1);
            }
        }


        protected string moveToTopOfPageScript()
        {
            string scriptSrc = String.Empty;
            StringBuilder sb = new StringBuilder();
            sb.Append(" function moveToTopOfPage() { ");
            sb.Append(" document.getElementById('_ctl0__ctl0_bCR_cR_ElectronicSignature2_btnRegistration').focus();");
            sb.Append(" } ");
            sb.Append(" window.onload =  function () { moveToTopOfPage(); }");
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
        protected void generateInitSignaturePageMoveToTopOfPage()
        {
            ScriptManager.RegisterStartupScript(this,
            typeof(EnrollmentControl),
            "typeinitSignaturePageMoveToTopOfPage",
            "initSignaturePageMoveToTopOfPage();", true);
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
            string postBackEvent =   Page.GetPostBackEventReference(btnRegistration);
            string controlID = "_ctl0__ctl0_bCR_cR_ElectronicSignature2_btnRegistration";
            StringBuilder onClickScript = new StringBuilder();

            //onClickScript.Append("registerDisableControl_OnClickEvent(\"_ctl0__ctl0_bCR_cR_ElectronicSignature2_btnRegistration\", \"");
            //onClickScript.Append(postBackEvent);
            //onClickScript.Append("\");");

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

                HtmlGenericControl moveToTopOfPageControl = new HtmlGenericControl("script");
                moveToTopOfPageControl.Attributes.Add("language", "javascript");
                moveToTopOfPageControl.Attributes.Add("type", "text/javascript");
                moveToTopOfPageControl.Attributes.Add("src", URLAppRoot + "Framework/Scripts/Registry.js");
                Page.Header.Controls.Add(moveToTopOfPageControl);

                HtmlGenericControl onclickButtonScriptControl = new HtmlGenericControl("script");
                onclickButtonScriptControl.Attributes.Add("language", "javascript");
                onclickButtonScriptControl.Attributes.Add("type", "text/javascript");
                onclickButtonScriptControl.InnerHtml = generateDisableSubmitButtonOnClickEventScript();
                Page.Header.Controls.Add(onclickButtonScriptControl);

                generateInitSignaturePageMoveToTopOfPage();
                generateDisableSubmitButton();

            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.ElectronicSignatureControl", 1);
            }

        }
    }
}