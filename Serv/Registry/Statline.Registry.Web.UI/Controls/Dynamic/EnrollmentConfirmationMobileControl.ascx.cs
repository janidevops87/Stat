using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using Statline.Registry.Common;
using Statline.Registry.Data.Types.Common;
using Statline.StatTrac.Web.UI;

namespace Statline.Registry.Web.UI.Controls.Dynamic
{
    public partial class EnrollmentConfirmationMobileControl : BaseUserControl
    {
        protected RegistryCommon dsCommonData;
        
        Int32 RegistryOwnerID;
        String RegistryID;
        String LanguageCode;
        String CSSFileLocation;
        String State;
        bool AllowDonorToPrintVerificationForm;

        string DonorRegistrationRequest;
        
        protected void Page_Load(object sender, EventArgs e)
        {
           GetSessionInfo();

            if (!this.IsPostBack)
            {
                if (dsCommonData == null) 
                    dsCommonData = new RegistryCommon();
                
                RegistryCommonManager.FillRegistryOwnerEnrollmentText(dsCommonData, Convert.ToInt32(RegistryOwnerID), LanguageCode);

                divFooter.InnerHtml = dsCommonData.RegistryOwnerEnrollmentText[0].DivFooter.ToString();

                if (DonorRegistrationRequest == "Add")
                {
                    divConfirmationPanel.InnerHtml = dsCommonData.RegistryOwnerEnrollmentText[0].ConfirmationPanelAdd.ToString();
                    if (AllowDonorToPrintVerificationForm)
                    {
                        //Set print tokens
                        Session.Add("SourceID", RegistryID.ToString());
                        Session.Add("Source", "Web");
                    }
                }

                if (DonorRegistrationRequest == "Remove")
                {
                    divConfirmationPanel.InnerHtml = dsCommonData.RegistryOwnerEnrollmentText[0].ConfirmationPanelRemove.ToString();
                }
            }
        }
        private void GetSessionInfo()
        {
            if (Session["RegistryOwnerID"] != null)
                RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
            else
                RegistryOwnerID = 3;    //set default

            if (Session["RegistryID"] != null) RegistryID = (string)(Session["RegistryID"].ToString());
            else { RegistryID = "0"; } //set default

            if (Session["LanguageCode"] != null)
                LanguageCode = (string)(Session["LanguageCode"].ToString());
            else
                LanguageCode = "en";  //set default

            if (Session["DonorRegistrationRequest"] != null)
                DonorRegistrationRequest = (string)(Session["DonorRegistrationRequest"].ToString());
            else
                DonorRegistrationRequest = "Remove";  //set default

            if (Session["CSSFileLocation"] != null)
                CSSFileLocation = (string)(Session["CSSFileLocation"].ToString());
            else
                CSSFileLocation = "~/Framework/Themes/Default/Enrollment.css";  //set default

            if (Session["State"] != null)
                State = (string)(Session["State"].ToString());
            else
                State = "";  //set default

            // Get "allow donor to print" option
            if (Session["AllowDonorToPrintVerificationForm"] != null) bool.TryParse((string)(Session["AllowDonorToPrintVerificationForm"].ToString()), out AllowDonorToPrintVerificationForm);
            else { AllowDonorToPrintVerificationForm = false; } //set default

        }
        protected void Page_PreRender(object sender, EventArgs e)
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

                HtmlGenericControl scriptControl = new HtmlGenericControl("script");
                scriptControl.Attributes.Add("language", "javascript");
                scriptControl.Attributes.Add("type", "text/javascript");
                scriptControl.InnerHtml = generatePrintVerificationFormScript();
                Page.Header.Controls.Add(scriptControl);
         }

        private string generatePrintVerificationFormScript()
        {
            string scriptSrc = "";
            StringBuilder sb = new StringBuilder();
            sb.Append("function printVerificationForm() { ");
            sb.Append("if (document.getElementById('verificationform') === null) { ");
            sb.Append("var newForm = document.createElement('Form'); ");
            sb.Append("newForm.setAttribute('name', 'verificationform'); ");
            //sb.Append("newForm.name = 'verificationform'; ");
            sb.Append(" newForm.setAttribute('id', 'verificationform');");
            sb.Append(" newForm.setAttribute('action', '../Dynamic/DonorVerification.aspx?showPrint=true');");
            sb.Append(" newForm.setAttribute('method', 'post');");
            sb.Append(" newForm.setAttribute('target', '_blank');");

            sb.Append(" var formFields = document.createElement('input');");
            sb.Append(" formFields.setAttribute('name', 'RegistryOwnerID');");
            sb.Append(" formFields.setAttribute('id', 'RegistryOwnerID');");
            sb.Append(" formFields.setAttribute('type', 'hidden');");
            sb.Append(" formFields.setAttribute('value', '");
            sb.Append(RegistryOwnerID);
            sb.Append("');");
            sb.Append(" newForm.appendChild(formFields);");

            sb.Append(" formFields = document.createElement('input');");
            sb.Append(" formFields.setAttribute('name', 'RegistryID');");
            sb.Append(" formFields.setAttribute('id', 'RegistryID');");
            sb.Append(" formFields.setAttribute('type', 'hidden');");
            sb.Append(" formFields.setAttribute('value', '");
            sb.Append(RegistryID);
            sb.Append("');");
            sb.Append(" newForm.appendChild(formFields);");

            sb.Append(" var formFields = document.createElement('input');");
            sb.Append(" formFields.setAttribute('name', 'Source');");
            sb.Append(" formFields.setAttribute('id', 'Source');");
            sb.Append(" formFields.setAttribute('type', 'hidden');");
            sb.Append(" formFields.setAttribute('value', '");
            sb.Append("Web");
            sb.Append("');");
            sb.Append(" newForm.appendChild(formFields);");

            sb.Append(" var formFields = document.createElement('input');");
            sb.Append(" formFields.setAttribute('name', 'State');");
            sb.Append(" formFields.setAttribute('id', 'State');");
            sb.Append(" formFields.setAttribute('type', 'hidden');");
            sb.Append(" formFields.setAttribute('value', '");
            sb.Append(State);
            sb.Append("');");
            sb.Append(" newForm.appendChild(formFields);");

            sb.Append(" var formFields = document.createElement('input');");
            sb.Append(" formFields.setAttribute('name', 'CSSFileLocation');");
            sb.Append(" formFields.setAttribute('id', 'CSSFileLocation');");
            sb.Append(" formFields.setAttribute('type', 'hidden');");
            sb.Append(" formFields.setAttribute('value', '");
            sb.Append(CSSFileLocation);
            sb.Append("');");
            sb.Append(" newForm.appendChild(formFields);");

            sb.Append(" document.getElementById('aspnetForm').parentNode.appendChild(newForm);");
            sb.Append(" }");
            sb.Append(" document.getElementById('verificationform').submit();");
            sb.Append(" }");


            scriptSrc = sb.ToString();
            return scriptSrc;

        }
    }
}