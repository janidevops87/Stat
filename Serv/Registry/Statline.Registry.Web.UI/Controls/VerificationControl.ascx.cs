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

namespace Statline.Registry.Web.UI.Controls
{
    public partial class VerificationControl : BaseUserControl
    {
        protected RegistryCommon dsCommonData;

        Int32 RegistryOwnerID;
        string SourceID;
        string Source;
        string State;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                SourceID = Request.QueryString["SourceID"];
                Source = Request.QueryString["Source"];
                State = Request.QueryString["State"];

                if (Session["RegistryOwnerID"] != null) RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
                else { SetSession(); } 

                if (dsCommonData == null) dsCommonData = new RegistryCommon();
                RegistryCommonManager.FillDataFormVerification(dsCommonData, Convert.ToInt32(SourceID), Source, State);

                // Get Verification information and legal text
                if (RegistryOwnerID != 1) //if not NEOB 
                {
                    RegistryCommonManager.FillRegistryOwnerStateVerificationText(dsCommonData, RegistryOwnerID, State.ToString(), null);
                     
                    lblStateID.Text = dsCommonData.RegistryOwnerStateConfig[0].lblStateIdText.ToString();
                    lblLimitations.Text = dsCommonData.RegistryOwnerStateConfig[0].lblLimitationsText.ToString();
                    lblStateIDValue.Text = dsCommonData.DataFormVerification[0].VerificationStateID.ToString();
                    //lblContactInformation.Text = dsCommonData.RegistryOwnerStateConfig[0].ContactInformationText.ToString();
                    if (Source == "Web")
                    {
                        lblHeader.Text = dsCommonData.RegistryOwnerStateConfig[0].WebLegalHeader.ToString();
                        lblLegal.Text = "";
                        lblLegalIntro.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalIntroText.ToString();
                        lblLegalDescription.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalText.ToString();
                        lblLegalDescription2.Text = dsCommonData.RegistryOwnerStateConfig[0].WebLegalDescriptionlText.ToString();
                        lblWebRegistryNo.Text = "Web Registry #:" + SourceID.ToString();
                        divContactInformation.InnerHtml = dsCommonData.RegistryOwnerStateConfig[0].ContactInformationText.ToString();
                    }
                    else
                    {
                        lblHeader.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalHeaderText.ToString();
                        lblLegal.Text = "";
                        lblLegalIntro.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalIntroText.ToString(); 
                        lblLegalDescription.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalText.ToString();
                        lblLegalDescription2.Text = dsCommonData.RegistryOwnerStateConfig[0].LegalDescriptionlText.ToString();
                        divContactInformation.InnerHtml = dsCommonData.RegistryOwnerStateConfig[0].ContactInformationText.ToString();

                    }
                }
                else
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
                    }
                }

                lblFullNameValue.Text = dsCommonData.DataFormVerification[0].VerificationFullName.ToString();
                lblDOBValue.Text = dsCommonData.DataFormVerification[0].VerificationDOB.ToString();
                lblResidentialAddressValue.Text = dsCommonData.DataFormVerification[0].VerificationResidentialAddress.ToString();
                lblCityStateZipValue.Text = dsCommonData.DataFormVerification[0].VerificationCityStateZip.ToString();
                lblLimitationsValue.Text = dsCommonData.DataFormVerification[0].VerificationLimitations.ToString();
                lblSignatureDateValue.Text = dsCommonData.DataFormVerification[0].VerificationSignatureDate.ToString();

            }

        }
        public void SetSession()
        {
            RegistryOwnerID = RegistryCommonManager.GetRegistryOwnerUserOrg(Convert.ToInt32(Page.Cookies.UserOrgID), 0);
            Session.Add("RegistryOwnerID", RegistryOwnerID.ToString());
        }
    }
}