using System;
using System.Data;
using System.Configuration;
using System.Collections;
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


namespace Statline.Registry.Web.UI.Controls
{
    public partial class ElectronicSignatureControl : BaseUserControl
    {
        protected RegistryCommon dsCommonData;

        String RegistryID;
        String RegistryOwnerID;
        String DonorRegistrationRequest;
        String FirstName;
        String LastName;
        //string Address;
        //string City;
        //string State;
        //string Zip;
        String LastFourSSN;
        String License;
        //String DOBYear;
        //String DOB;
        String IDologyID;
        String EmailSubject = "";
        String EmailBody = "";

  
        protected void Page_Load(object sender, EventArgs e)
        {
            GetSessionInfo();
            if (!this.IsPostBack)
            {
                if (dsCommonData == null) dsCommonData = new RegistryCommon();
                RegistryCommonManager.FillDataFormElectronicSignature(dsCommonData, Convert.ToInt32(RegistryID));
                try
                {//Get donor information
                    lblNameValue.Text = dsCommonData.DataFormElectronicSignature[0].ElectronicSignatureName.ToString();
                    lblAddressValue.Text = dsCommonData.DataFormElectronicSignature[0].ElectronicSignatureAddress.ToString();
                    lblEmailValue.Text = dsCommonData.DataFormElectronicSignature[0].ElectronicSignatureEmail.ToString();
                    lblDOB.Text = dsCommonData.DataFormElectronicSignature[0].ElectronicSignatureDOB.ToString();
                }
                catch
                {

                }
                finally
                { 
                }
                    if (DonorRegistrationRequest == "Add")
                    {
                        this.lblConfirmationText.Text = "To electronically sign your donor registration, check the 'Yes' box below and click the 'Complete Registration' button.";
                        this.cbxConfirmation.Text = "Yes - I consent to donate my organs and tissues after death in accordance with applicable state law and subject only to the limitations I have noted.";
                        this.btnRegistration.Text = "Complete Registration";
                    }
                    if (DonorRegistrationRequest == "Remove")
                    {
                        this.lblConfirmationText.Text = "To electronically sign your removal from the donor registry, check the 'Remove' box below and click the 'Remove Registration' button.";
                        this.cbxConfirmation.Text = "Remove me from the Donate Life New England Donor Registry.";
                        this.btnRegistration.Text = "Remove Registration";
                    }
            }
        }

       private void GetSessionInfo()
        {
            if (Session["RegistryID"] != null) RegistryID = (string)(Session["RegistryID"].ToString());
            else { RegistryID = "0"; } //set default
            if (Session["RegistryOwnerID"] != null) RegistryOwnerID = (string)(Session["RegistryOwnerID"].ToString());
            else { RegistryOwnerID = "0"; } //set default
           if (Session["DonorRegistrationRequest"] != null) DonorRegistrationRequest = (string)(Session["DonorRegistrationRequest"].ToString());
            else { DonorRegistrationRequest = "Delete"; } //set default
            if (Session["FirstName"] != null) FirstName = (string)(Session["FirstName"].ToString());
            else { FirstName = ""; } //set default
            if (Session["LastName"] != null) LastName = (string)(Session["LastName"].ToString());
            else { LastName = ""; } //set default
            //if (Session["Address"] != null) Address = (string)(Session["Address"].ToString());
            //else { Address = ""; } //set default
            //if (Session["City"] != null) City = (string)(Session["City"].ToString());
            //else { City = ""; } //set default
            //if (Session["State"] != null) State = (string)(Session["State"].ToString());
            //else { State = ""; } //set default
            //if (Session["Zip"] != null) Zip = (string)(Session["Zip"].ToString());
            //else { Zip = ""; } //set default
            if (Session["LastFourSSN"] != null) LastFourSSN = (string)(Session["LastFourSSN"].ToString());
            else { LastFourSSN = "-"; } //set default
            if (Session["License"] != null) License = (string)(Session["License"].ToString());
            else { License = "-"; } //set default
            //if (Session["DOB"] != null) DOB = (string)(Session["DOB"].ToString());
            //else { DOB = ""; } //set default
            if (Session["IDologyID"] != null) IDologyID = (string)(Session["IDologyID"].ToString());
            else { IDologyID = "0"; } //set default

        }
        protected void cbxConfirmation_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnRegistration_Click(object sender, EventArgs e)
        {
            //GetSessionInfo();
            if (this.cbxConfirmation.Checked == true)
            {
                // Check for duplicate records. DonorID results: value(), Description
                //  1.  -1, New donor
                //  2.   0, Don't update this record. More than one donor exists with the same criteria
                //  3. n>1, This is an update. One donor match found. Value returned is old RegistryID

                // set default for duplicate search
                if (LastFourSSN.Length == 0) { LastFourSSN = "-"; }

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

                        Session.Add("IDRequestType", "DisplayPageOnly");
                        QueryStringManager.Redirect(PageName.Validate);
                        return;
                    }

                    if (DonorRegistrationRequest == "Add")
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

                        // Record Digital Certificate
                        RecordDigitalCertificate();

                        // Donor email message
                        GetConfirmationMessage();

                        //Send Email Confirmation
                        SendEmailConfirmation(lblEmailValue.Text.ToString(), EmailSubject.ToString(), EmailBody.ToString());

                        GetFamilyFriendsMessage();
                        //Send Donor Family and Friends Invitation
                        SendEmailConfirmation(lblEmailValue.Text.ToString(), EmailSubject.ToString(), EmailBody.ToString());

                    }
                    if (DonorRegistrationRequest == "Remove")
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

                        //dsCommonData.Registry[0].DonorConfirmed = false;

                        // Commit changes
                        RegistryCommonManager.UpdateRegistry(dsCommonData);

                        // Record Digital Certificate
                        RecordDigitalCertificate();

                        //Send Email Confirmation
                        GetConfirmationRemoveMessage();
                        SendEmailConfirmation(lblEmailValue.Text.ToString(), EmailSubject.ToString(), EmailBody.ToString());
                    }



                    // Finial Confirmation
                    QueryStringManager.Redirect(PageName.EnrollmentConfirmation);
                }

            
        }

        private void GetFamilyFriendsMessage()
        {
            EmailSubject = "Donor Family and Friends Invitation";
            EmailBody = "Now that you have signed up to be a donor through the Donate Life New England Donor Registry, " +
                        "why don’t you invite your friends and family to join you in giving the gift of life!  " +
                        "Forward the message below and spread the word.\r\n" +
                        "---\r\n" +
                        "Just a quick note to let you know that I’ve just joined the Donate Life New England Donor Registry " +
                        "at www.donatelifenewengland.org.  It’s an easy way to sign up to be an organ and tissue donor.  " +
                        "Thousands of people die every year because there aren’t enough life-saving organs and now you can do " +
                        "something about it by becoming a donor.  I hope you take a few minutes and make the decision to Donate " +
                        "Life at www.donatelifenewengland.org .\r\n" +
                        "Thanks.";
        }

        private void GetConfirmationMessage()
        {
            EmailSubject = "Donor Confirmation";
            EmailBody = "Thank you for making the decision to register as an organ and/or tissue donor.  " +
                        "This email is confirmation of your decision to donate.\r\n" +
                        "Should you wish to change your Donate Life New England Donor Registry status at any time in the future, " +
                        "please visit www.donatelifenewengland.org .\r\n\r\n" +
                        "Please remember that Donate Life New England is an independent registry. Adding or removing yourself " +
                        "from this registry does not change your donor designation status with your state department of motor vehicles.\r\n" +
                        "To learn more about organ and tissue donation or to contact us directly, visit www.donatelifenewengland.org.";
        }
        private void GetConfirmationRemoveMessage()
        {
            EmailSubject = "Donor Confirmation";
            EmailBody = "This email is confirmation of your decision to remove yourself from the Donate Life New England Donor Registry.\r\n" +
                        "Should you wish to join the Donate Life New England Donor Registry again in the future, please visit www.donatelifenewengland.org .\r\n" +
                        "Please remember that Donate Life New England is an independent registry. Adding or removing yourself " +
                        "from this registry does not change your donor designation status with your state department of motor vehicles.\r\n" +
                        "To learn more about organ and tissue donation or to contact us directly, visit www.donatelifenewengland.org.";
        }
        private void RecordDigitalCertificate()
        {
            // Create Certificate String
            string CertificateData = 
                "IDologyID:" + IDologyID.ToString() +
                "|" + this.lblNameValue.Text.ToString() +
                "|" + this.lblAddressValue.Text.ToString() +
                "|" + this.lblEmailValue.Text.ToString() +
                "|Legal text at time of signature: " + this.cbxConfirmation.Text.ToString() +
                "|Timestamp: " + System.DateTime.Now.ToString() 
                ;

            byte[] certificate = new System.Text.ASCIIEncoding().GetBytes(CertificateData);
           
            //Record Electronic Signature
            //if (Session["RegistryID"] != null) RegistryID = (string)(Session["RegistryID"].ToString());
            if (dsCommonData == null) dsCommonData = new RegistryCommon();
            RegistryCommon.RegistryDigitalCertificateRow row;
            row = dsCommonData.RegistryDigitalCertificate.NewRegistryDigitalCertificateRow();
            row["RegistryID"] = Convert.ToInt32(RegistryID.ToString());
            row["RegistryDigitalCertificateData"] = certificate;
            row["LastStatEmployeeID"] = -1;
            dsCommonData.RegistryDigitalCertificate.AddRegistryDigitalCertificateRow(row);
            RegistryCommonManager.UpdateRegistryDigitalCertificate(dsCommonData);

        }

        private void SendEmailConfirmation(string emailAddress, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(emailAddress.ToString());
                mail.From = new MailAddress("register@statline.org");
                mail.ReplyToList.Add("register@donatelifenewengland.org");
                mail.Subject = subject.ToString();
                mail.Body = body.ToString();
                SmtpClient smtp = new SmtpClient(ApplicationSettings.GetSetting(SettingName.MailServer), Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.EmailPort)));
                smtp.Credentials = new System.Net.NetworkCredential("register@statline.org", ApplicationSettings.GetSetting(SettingName.EmailPassword));
                smtp.EnableSsl = true;

                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "Statline.Registry.Web.UI.Controls.Dynamic.ElectronicSignatureControl", 1);
            }
            finally
            {
            }
        }
    }
}