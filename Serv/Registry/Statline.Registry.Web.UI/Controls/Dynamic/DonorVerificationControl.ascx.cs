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
using Statline.StatTrac.Web.UI;
using Statline.Registry.Common;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;

namespace Statline.Registry.Web.UI.Controls.Dynamic
{
    public partial class DonorVerificationControl : BaseUserControl
    {
        protected RegistryCommon dsCommonData;
        protected RegistryCommon dsRegistry;

        String RegistryOwnerRouteName = String.Empty;

        Int32 RegistryOwnerID;
        string RegistryID;
        string SourceID;
        string Source;
        string State;
        string LanguageCode;
        string CSSFileLocation;
        string ShowPrinterDialog;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {

                GetSessionInfo();

                // Set perameters for verification display
                SourceID = RegistryID;

                // The Source and State value are set as follows:
                // 1. Source - on EnrollmentConfirmationControl if AllowDonorToPrintVerificationForm true
                // 2. SourceID - on EnrollmentConfirmationControl if AllowDonorToPrintVerificationForm true
                // 3. State - Set on the enrollment form
                // If session is missing from enrollment then redirect
                if (String.IsNullOrEmpty(Source) || String.IsNullOrEmpty(State))
                { //Redirect
                    QueryStringManager.Redirect(PageName.Login);
                }

                if (dsCommonData == null) dsCommonData = new RegistryCommon();
                RegistryCommonManager.FillDataFormVerification(dsCommonData, Convert.ToInt32(SourceID), Source, State);
                if (dsRegistry == null) dsRegistry = new RegistryCommon();

                RegistryCommonManager.FillRegistryOwner(dsRegistry, Convert.ToInt32(RegistryOwnerID), RegistryOwnerRouteName);

                CSSFileLocation = dsRegistry.RegistryOwner[0].CSSFileLocation;
                imgMiopHeart.Visible = false;

                string dmvSource = null;
                if (IsGOLMRegistrant())
                {
                    switch (Source)
                    {
                        case "DMV":
                            dmvSource = "DMV_MI_SOS";
                            break;
                        case "DMV_MI":
                            dmvSource = Source;
                            break;
                        case "Web_MI":
                            dmvSource = "DMV_MI";
                            break;
                    }
                }

                RegistryCommonManager.FillRegistryOwnerStateVerificationText(dsCommonData, RegistryOwnerID, State.ToString(), dmvSource);

                lblFullNameValue.Text = dsCommonData.DataFormVerification[0].VerificationFullName.ToString();
                lblDOBValue.Text = dsCommonData.DataFormVerification[0].VerificationDOB.ToString();
                lblResidentialAddressValue.Text = dsCommonData.DataFormVerification[0].VerificationResidentialAddress.ToString();
                lblCityStateZipValue.Text = dsCommonData.DataFormVerification[0].VerificationCityStateZip.ToString();
                lblLimitationsValue.Text = dsCommonData.DataFormVerification[0].VerificationLimitations.ToString();

                if (!IsNEOBRegistrant()) // Not NEOB, use form text for DMV_Common 
                {	    
	                lblStateID.Text = dsCommonData.RegistryOwnerStateConfig[0].lblStateIdText.ToString();
	                lblStateIDValue.Text = dsCommonData.DataFormVerification[0].VerificationStateID.ToString();
                    	
	                if (Source == "Web")
	                {
		                lblHeader.Text = dsCommonData.RegistryOwnerStateConfig[0].WebLegalHeader.ToString();
		
		                lblLegalIntro.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalIntroText.ToString();
		                lblLegalDescription.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalText.ToString();
		                divLegalDescription.InnerHtml = dsCommonData.RegistryOwnerStateConfig[0].WebLegalDescriptionlText.ToString();
		                lblWebRegistryNo.Text = "Web Registry #:" + SourceID.ToString();
		                divContactInformation.InnerHtml = dsCommonData.RegistryOwnerStateConfig[0].ContactInformationText.ToString();                        
	                }
	                else
	                {
		                lblHeader.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalHeaderText.ToString();

		                lblLegalIntro.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalIntroText.ToString();
		                lblLegalDescription.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalText.ToString();
		                divLegalDescription.InnerHtml = dsCommonData.RegistryOwnerStateConfig[0].LegalDescriptionlText.ToString();
		                divContactInformation.InnerHtml = dsCommonData.RegistryOwnerStateConfig[0].ContactInformationText.ToString();
	                }
                }


                if (IsNEOBRegistrant()) //NEOB
                {   // NEOB Only: may be removed when NEOB is added to Verification section of dbo.RegistryOwnerStateConfig
	                if (Source == "Web")
	                {
		                lblHeader.Text = "Donate Life New England Donor Registry <br> Confidential Donor Registry Verification";
		                lblLegal.Text = "CT (Sec.19a-279a et seq.), MA (ch113 §7 et seq.), ME (tit 22 ch 710-B §2941 et seq.), NH (ch 291-A:1 et seq.), RI (§23-18.6.1 et seq.) and VT (tit 18, ch 109, §5238 et seq.)";
		                lblLegalDescription.Text = "The Individual named below registered with the Donate Life New England Donor Registry " +
								                   "to become an organ and/or tissue donor subject only to the limitations listed below. " +
								                   "Registration in the Donate Life New England Donor Registry constitutes legal authorization " +
								                   "from the Individual for anatomical gifts to be made upon death.";

		                lblWebRegistryNo.Text = "Web Registry #:" + SourceID.ToString();
	                }
	                else
	                {
		                switch (State.ToUpper())
		                {
			                case "CT":
				                lblHeader.Text = "STATE OF Connecticut <br> Confidential Donor Registry Verification";
				                lblLegalIntro.Text = "";
				                lblLegal.Text = "Pursuant to Section 19a-279a of the Connecticut General Statutes";
				                break;
			                case "MA":
				                lblHeader.Text = "STATE OF Massachusetts <br> Confidential Donor Registry Verification";
				                lblLegalIntro.Text = "";
				                lblLegal.Text = "Pursuant to Section 7 of chapter 113 of the Massachusetts General Laws";
				                break;
			                case "ME":
				                lblHeader.Text = "STATE OF Maine <br> Confidential Donor Registry Verification";
				                lblLegalIntro.Text = "";
				                lblLegal.Text = "Pursuant to Maine General Satutes <br> Title 22, Chapter 710, Sections 2902 and 2903 and <br>Title 29-A, Chapter 11, Section 1402-A";
				                break;
			                case "NH":
				                lblHeader.Text = "STATE OF New Hampshire <br> Confidential Donor Registry Verification";
				                lblLegalIntro.Text = "";
				                lblLegal.Text = "Pursuant to New Hampshire General Statutes <br> NHRSA Section 263:41 & Section 291-A:3";
				                break;
			                case "RI":
				                lblHeader.Text = "STATE OF Rhode Island <br> Confidential Donor Registry Verification";
				                lblLegalIntro.Text = "";
				                lblLegal.Text = "Pursuant to Rhode Island General Statutes <br> Section 23-18.6.1";
				                break;
			                case "VT":
				                lblHeader.Text = "STATE OF Vermont <br> Confidential Donor Registry Verification";
				                //lblLegalIntro.Text = "";
				                lblLegal.Text = "VT (tit 18, ch 109, §5238 et seq.)";
				                break;
		                }
		                lblStateID.Text = "Driver's License/ID number <BR> Or Registry ID number: ";
		                lblStateIDValue.Text = dsCommonData.DataFormVerification[0].VerificationStateID.ToString();
		                lblLimitations.Text = "Donor Comments:";
		                lblLegalDescription.Text = "The Individual named below registered with the Department of Motor Vehicles to become an organ and " +
									                "tissue donor. This is legal authorization from the Individual for anatomical gifts to be made upon death. ";
                        lblSignatureDateValue.Text = dsCommonData.DataFormVerification[0].VerificationSignatureDate.ToString();
                    }
                }
                else if (IsGOLMRegistrant()) //MIOP
                {
	
	                divMiopRectangle.Attributes["class"] = "MiopRectangle";

                    lblLimitations.Visible = false;
                    lblLimitationsValue.Visible = false;
                    //lblLimitationsValue.Text = dsCommonData.RegistryOwnerStateConfig[0].lblLimitationsText.ToString();                    

                    lblInsigniaComment.Text = dsCommonData.RegistryOwnerStateConfig[0].lblLimitationsText.ToString(); 
                                        
                    
	                imgMiopHeart.Visible = true;
	                imgMiopHeart.ImageUrl = "~/Framework/Themes/MIOP/Images/donorheart.gif";
	                imgMiopHeart.Height = 40;
	                imgMiopHeart.Width = 125;
	 	
	                lblLegal.Text = "";
                    // divContactInformation.InnerHtml = "Original (File in Patient Medical Record)";
                    lblSignatureDateValue.Text = ""; //Display no signature for MIOP
                }
                else //Not NEOB or MIOP
                {	
	                lblLimitations.Text = dsCommonData.RegistryOwnerStateConfig[0].lblLimitationsText.ToString();
	                lblStateIDValue.Text = dsCommonData.DataFormVerification[0].VerificationStateID.ToString();
                    lblLegal.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalText.ToString();
                    lblLegalDescription.Text = "";
                    lblSignatureDateValue.Text = dsCommonData.DataFormVerification[0].VerificationSignatureDate.ToString();
	                if (Source == "Web")
	                {		    
		                if (IsHIOPRegistrant())
		                {
			                lblComments.Text = "Registering in honor of: ";
			                lblCommentsValue.Text = dsCommonData.DataFormVerification[0].VerificationComment.ToString();
		                }
	                }
        
                }                                               
                
                ApplyPrintMediaCSS();

                ShowPrinterDialog = Request.QueryString["showPrint"] == null ? "false" : HttpUtility.UrlDecode(Request.QueryString["showPrint"]);
                if (ShowPrinterDialog.ToUpper().ToString() == "TRUE") { ShowPrintDialog(); }                
            }

        }
        
        private void GetSessionInfo()
        {
            RegistryOwnerID = Convert.ToInt32(GetRegistryVariable("RegistryOwnerID", "0"));
            RegistryID = GetRegistryVariable("RegistryID", "0");

            // Source, State and RegistryID sesssion values are required for printing donor verification form
            Source = GetRegistryVariable("Source", "");
            State = GetRegistryVariable("State", "");

            //Get CSS file location
            CSSFileLocation = GetRegistryVariable("CSSFileLocation", "~/Framework/Themes/Default/Enrollment.css");

        }

        private string GetRegistryVariable(string registryVariableName, string defaultValue)
        {
            string paramValue = defaultValue;
            
            if (Request.Form.GetValues(registryVariableName) != null)
            {
                paramValue = (string)Request.Form.GetValues(registryVariableName)[0];
            }
            else if (Request.Cookies["StatlineRegistryCookie"] != null && Request.QueryString[registryVariableName] != null) //Only allow QueryString parameters if Logged In
            {
                paramValue = (string)Request.QueryString[registryVariableName]; 
            }
            else if (Session[registryVariableName] != null)
            {
                paramValue = (string)Session[registryVariableName];
            }
            return paramValue;
        }


        private void ShowPrintDialog()
        {
            HtmlGenericControl scriptControl = new HtmlGenericControl("script");
            scriptControl.Attributes.Add("language", "javascript");
            scriptControl.Attributes.Add("type", "text/javascript");
            scriptControl.InnerHtml = "window.onload = function () { window.print();}";
            Page.Header.Controls.Add(scriptControl);
        }

        private void ApplyPrintMediaCSS()
        {
            string CSSLocation = CSSFileLocation;
            HtmlLink css = new HtmlLink();
            css.Href = CSSLocation.ToString();
            css.Attributes["rel"] = "stylesheet";
            css.Attributes["type"] = "text/css";
            css.Attributes["media"] = "all";
            Page.Header.Controls.Add(css);

            CSSLocation = CSSFileLocation.Replace("Enrollment.css","Print.css");            
            HtmlLink printcss = new HtmlLink();
            printcss.Href = CSSLocation.ToString();
            printcss.Attributes["rel"] = "stylesheet";
            printcss.Attributes["type"] = "text/css";
            printcss.Attributes["media"] = "print";
            Page.Header.Controls.Add(printcss);            
        }

        private bool IsGOLMRegistrant()
        {
            bool result = false;
            if (GetRegistryVariable("RegistryOwnerName", "") == "MIOP")
            {
                result = true;
            }
            return result;
        }

        private bool IsNEOBRegistrant()
        {
            bool result = false;
            if (RegistryOwnerID == 1)
            {
                result = true;
            }

            return result;

        }

        private bool IsHIOPRegistrant()
        {
            bool result = false;
            if (RegistryOwnerID == 5)
            {
                result = true;
            }

            return result;

        }
    }
}