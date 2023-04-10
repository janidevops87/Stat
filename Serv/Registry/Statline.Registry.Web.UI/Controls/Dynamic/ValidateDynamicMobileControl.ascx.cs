using System;
using System.Collections;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Xml;
using System.Xml.Xsl;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Configuration;
using Statline.Registry.Common;
using Statline.Registry.Data.Types.Common;
using Statline.Security;
using Statline.StatTrac.Web.UI;
using System.Web.UI.HtmlControls;

namespace Statline.Registry.Web.UI.Controls.Dynamic
{
    public partial class ValidateDynamicMobileControl : BaseUserControl
    {
        Int32 RegistryOwnerID;
        String LanguageCode;
        string RegistryID;
        string FirstName;
        string LastName;
        string Address;
        string City;
        string State;
        string Zip;
        string LastFourSSN;
        string DOBMonth;
        string DOBYear;
        string IDologyID;
        string IDRequestType;
        bool DonorNotConfirmed;
        string url;
        // Email Address to send Idology errors to:
        string EmailErrorAddress = ApplicationSettings.GetSetting(SettingName.DeveloperEmails);

        //IDology settings
        bool IDologyActive;
        string IDologyUser; 
        string IDologyPass; 
        string IDologyURL = ApplicationSettings.GetSetting(SettingName.IDologyWebServiceRequestURL);
        string IDologyQuestionURL = ApplicationSettings.GetSetting(SettingName.IDologyWebServiceQuestionsURL);
        string IDologyChallengeURL = ApplicationSettings.GetSetting(SettingName.IDologyWebServiceChallengeURL);
        string IDologyChallengeQuestionURL = ApplicationSettings.GetSetting(SettingName.IDologyWebServiceChallengeAnswersURL);
        string IDologyRequestTypeNew = ApplicationSettings.GetSetting(SettingName.IDologyRequestTypeNew);
        string IDologyRequestTypeQuestion = ApplicationSettings.GetSetting(SettingName.IDologyRequestTypeQuestion);
        string IDologyRequestTypeChallenge = ApplicationSettings.GetSetting(SettingName.IDologyRequestTypeChallenge);
        string IDologyRequestTypeChallengeQuestion = ApplicationSettings.GetSetting(SettingName.IDologyRequestTypeChallengeQuestion);
        string IDologyCustomerServicePhoneNumber = ApplicationSettings.GetSetting(SettingName.IDologyCustomerServicePhoneNumber);

        protected RegistryCommon dsCommonData;
        protected RegistryCommon dsRegistry;
        protected RegistryCommon dsIDologyData;

        String CSSFileLocation;

        protected void Page_Load(object sender, EventArgs e)
        {

            GetSessionInfo();

            //Check if IDology Service is active
            if (IDologyActive == false)
            {
                // bypass IDology and complete registration for Donor
                Session.Add("IDRequestType", "Finished");

                if (DonorNotConfirmed)
                {   //This is a delete with no existing (or multiple) donor(s) found
                    //End here.
                    LoadDefaultPageMessage();
                    
                    //In case this was in error release session state
                    Session["DonorNotConfirmed"] = null;
                }
                else
                {
                    QueryStringManager.Redirect(PageName.DynamicElectronicSignatureMobile);
                }
            }
            else
            {

                GetIDologySessionInfo();

                if (dsRegistry == null) dsRegistry = new RegistryCommon();
                RegistryCommonManager.FillRegistryOwnerElectronicSignatureText(dsRegistry, Convert.ToInt32(RegistryOwnerID), LanguageCode);
                divFailureMessage.InnerHtml = dsRegistry.RegistryOwnerElectronicSignatureText[0].FailureMessage.ToString();

                if (IDRequestType == IDologyRequestTypeNew ||
                    IDRequestType == IDologyRequestTypeQuestion ||
                    IDRequestType == IDologyRequestTypeChallenge ||
                    IDRequestType == IDologyRequestTypeChallengeQuestion
                    )
                {
                    PrepareDataArray();
                }
                else
                {
                    LoadDefaultPageMessage();
                }
            } //End Idology check
        }

        private void LoadDefaultPageMessage()
        {
            if (dsRegistry == null) dsRegistry = new RegistryCommon();
            RegistryCommonManager.FillRegistryOwnerElectronicSignatureText(dsRegistry, Convert.ToInt32(RegistryOwnerID), LanguageCode);
            divFailureMessage.InnerHtml = dsRegistry.RegistryOwnerElectronicSignatureText[0].FailureMessage.ToString();

            if (dsCommonData == null)
                dsCommonData = new RegistryCommon();

            RegistryCommonManager.FillRegistryOwnerEnrollmentText(dsCommonData, Convert.ToInt32(RegistryOwnerID), LanguageCode);

            divFooter.InnerHtml = dsCommonData.RegistryOwnerEnrollmentText[0].DivFooter.ToString();

        }


        private void PrepareDataArray()
        {
            //String IDRequestType;
            if (Session["IDRequestType"] != null)
            {
                IDRequestType = (string)Session["IDRequestType"];

                // Question request
                switch (IDRequestType)
                {
                  case "Question" :
                  case "ChallengeQuestion" :

                      if (IDRequestType == IDologyRequestTypeChallengeQuestion)
                      {
                          url = IDologyChallengeQuestionURL;
                      }

                      if (IDRequestType == IDologyRequestTypeQuestion)
                      {
                          url = IDologyQuestionURL;
                      }

                    //construct header array for questions
                    ArrayList fieldNameList = new ArrayList();
                    fieldNameList.Add("username");
                    fieldNameList.Add("password");

                    ArrayList fieldValueList = new ArrayList();
                    fieldValueList.Add(IDologyUser);
                    fieldValueList.Add(IDologyPass);

                    //resubmit questions to IDology 
                    string value;
                    int parameterIndex =0;

                    foreach (string name in Request.QueryString)
                    {
                        if (Request.QueryString[name] != "")
                        {
                            value = Request.QueryString[name];
                            //check for multiple contained values and split
                            string[] items = value.Split(',');
                            parameterIndex = 0;

                            if (items.Length > 1 )
                            { // one or more questions were submitted
                                // rename to correct format
                                // parameterIndex = 0;
                                foreach (string item in items)
                                {
                                    parameterIndex = (parameterIndex + 1);
                                    fieldNameList.Add("question" + parameterIndex.ToString() + name);
                                    fieldValueList.Add(item);
                                }
                            }
                            else
                            {
                                if (name == "idNumber")
                                {
                                    fieldNameList.Add(name);
                                    fieldValueList.Add(value);
                                }
                                else
                                {
                                    parameterIndex = (parameterIndex + 1);
                                    fieldNameList.Add("question" + parameterIndex.ToString() + name);
                                    fieldValueList.Add(value);
                                }
                            }
                        }
                    }
                    //Get Questions post from IDology
                    // convert to string array
                    string[] fieldNameQ = fieldNameList.ToArray(typeof(string)) as string[];
                    string[] fieldValueQ = fieldValueList.ToArray(typeof(string)) as string[];

                    // Get and parse question response
                    string responseStreamQ = GetIDologyPost(url, fieldNameQ, fieldValueQ);

                    evaluateResponse(responseStreamQ);
                    return;
                    // End of Question request

                case "Challenge":

                    url = IDologyChallengeURL;
                    //construct header array for questions
                    ArrayList fieldNameListC = new ArrayList();
                    fieldNameListC.Add("username");
                    fieldNameListC.Add("password");

                    ArrayList fieldValueListC = new ArrayList();
                    fieldValueListC.Add(IDologyUser);
                    fieldValueListC.Add(IDologyPass);

                    //resubmit questions to IDology 
                    string valueC;

                    foreach (string name in Request.QueryString)
                    {
                        if (name == "idNumber")
                        {                        
                            valueC = Request.QueryString[name];
                            string[] items = valueC.Split(',');
                            fieldNameListC.Add(name);
                            fieldValueListC.Add(valueC);
                        }
                    }
                    //Get Questions post from IDology
                    // convert to string array
                    string[] fieldNameC = fieldNameListC.ToArray(typeof(string)) as string[];
                    string[] fieldValueC = fieldValueListC.ToArray(typeof(string)) as string[];

                    // Get and parse question response
                    string responseStreamC = GetIDologyPost(url, fieldNameC, fieldValueC);

                    evaluateResponse(responseStreamC);
                    return;
                // End of Challenge request

                    case "New" :

                            // This is a new IDology request
                                string[] fieldName = {
                                "username",
                                "password",
                                "invoice",
                                "amount",
                                "shipping",
                                "tax",
                                "total",
                                "idType",
                                "idIssuer",
                                "idNumber",
                                "paymentMethod",
                                "firstName",
                                "lastName",
                                "address",
                                "city",
                                "state",
                                "zip",
                                "ssnLast4",
                                "dobMonth",
                                "dobYear",
                                "sku",
                                "uid"
                            };
                                        string[] fieldValue = {
                                IDologyUser,
                                IDologyPass,
                                "", //invoice
                                "", //amount
                                "", //shipping
                                "", //tax
                                "", //total
                                "", //idType
                                "", //idIssuer
                                "", //idNumber
                                "", //paymentMethod
                                FirstName, //firstName
                                LastName, //lastName
                                Address, //address
                                City, //city
                                State, //state
                                Zip, //zip
                                LastFourSSN, //ssnLast4
                                DOBMonth, //dobMonth
                                DOBYear, //dobYear
                                "", //sku
                                "" //uid
                            };

                         url = IDologyURL;

                        // Get and parse initial response
                        string responseStream = GetIDologyPost(url, fieldName, fieldValue);

                        //this.txtResponse.Text = responseStream;
                        evaluateResponse(responseStream);
                        return;
                    }

            }
        }

        
        
        //*** IDology validation ***
        private void evaluateResponse(string responseStream)
        {
            //Boolean messagePass;
            //Boolean keyMatch;
            string result;
            if (    // before asking challenge question, check for no.data error or id.falure
                    responseStream.Contains("<key>result.match</key>") &&
                    (
                        !responseStream.Contains("<summary-result><key>id.failure</key>")
                        //ccarroll 06/24/2009 added check for id.failure to capture wider array
                        //of IDology failures. Removed code below:
                        //!responseStream.Contains("<key>result.challenge.no.data</key>") ||
                        //!responseStream.Contains("<key>resultcode.ssn.does.not.match</key>")
                    )
               )
            {
                if (
                        responseStream.Contains("<questions><question>") ||
                        ( responseStream.Contains("<key>result.questions.1.incorrect</key>") &&
                          !responseStream.Contains("<key>result.challenge.0.incorrect</key>")
                        )
                    )
                {
                    if (
                            responseStream.Contains("<key>result.questions.1.incorrect</key>") &&
                            IDRequestType == "Question"
                       )
                    { 
                        // One question answered incorrect. Ask challenge question.
                        Session.Add("IDRequestType", "Challenge");
                        PrepareDataArray();
                    }
                    else
                    {
                        //display and re-submit questions to IDology
                        if (IDRequestType == "Challenge")
                        {
                            Session.Add("IDRequestType", "ChallengeQuestion");
                        }
                        else
                        {
                            Session.Add("IDRequestType", "Question");
                        }

                        if (responseStream.Contains("<key>result.challenge.1.incorrect</key>")) 
                        {
                            Session.Add("IDRequestType", "Finished");
                            return;
                        }
                        
                        askAdditionalQuestions(responseStream);
                    }

                }
                else
                {
                    result = "PASS";
                    Session.Add("Validation", result);

                    // either id.success returned with no questions asked in which case this is a Pass
                    // (see else below) or this is a response to questions or challenge questions which
                    // require further evaluation to fail. 

                     if (
                            responseStream.Contains("<key>result.questions.2.incorrect</key>") ||
                            responseStream.Contains("<key>result.challenge.1.incorrect</key>") 
                        )
                     {
                         Session.Add("IDRequestType", "Finished");
                         //Failed: two questions asked, two incorrect answers or
                         //        one incorrect challenge question answered
                         LoadDefaultPageMessage();

                    }
                    else
                    {   //Pass: all or one question answered correctly
                        Session.Add("IDRequestType", "Finished");
                        QueryStringManager.Redirect(PageName.DynamicElectronicSignatureMobile);
                    }                 
                }

            }
            else
            {
                
                // check for All questions answered correctly
                if (
                        responseStream.Contains("<key>result.questions.0.incorrect</key>") ||
                        responseStream.Contains("<key>result.challenge.0.incorrect</key>")
                   )
 
                {
                    Session.Add("IDRequestType", "Finished");
                    QueryStringManager.Redirect(PageName.DynamicElectronicSignatureMobile);
                }
                //Failure unable to registure at this time
                result = "FAIL";
                Session.Add("Validation", result);

                // This page will display the following message:
                // "Unfortunately, we have been unable to verify your registration information. Please contact us directly through www.donatelifenewengland.org and we will assist you in your donation registration. Thank you.";
            }
        }
        public string GetIDologyPost(string url, string[] paramName, string[] paramVal)
        {

            HttpWebRequest request = WebRequest.Create(new Uri(url))
                                 as HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";

            //Build IDology query and encode
            StringBuilder query = new StringBuilder();
            for (int i = 0; i < paramName.Length; i++)
            {
                query.Append("&");
                query.Append(paramName[i]);
                query.Append("=");
                query.Append(HttpUtility.UrlEncode(paramVal[i]));
            }
            //record sent value minus username password string
            Int32 ClipLength = IDologyUser.Length + IDologyPass.Length + 20;
            string requestData = query.ToString().Substring(ClipLength);

            // Encode the parameters as form data:
            byte[] formData =
                UTF8Encoding.UTF8.GetBytes(query.ToString());

            // Send request:
            Stream post = null;

            try
                {
                    request.ContentLength = formData.Length;
                    post = request.GetRequestStream();
                    post.Write(formData, 0, formData.Length);
                }
            catch (WebException ex)
                {
                   // IDology connection error
                    string EmailErrorSubject = "IDology service failure";
                    string EmailErrorBody = "There has been a failure connecting to IDology.\r\n" + ex;
                    SendEmailErrors(EmailErrorAddress, EmailErrorSubject, EmailErrorBody);

                }
            finally
            {
                if (post != null)
                {
                    post.Close();
                }
            }

            // Get response:
            string responseData = null;
            using (HttpWebResponse response = request.GetResponse()
                                          as HttpWebResponse)
            {
                try
                {
                    StreamReader reader =
                        new StreamReader(response.GetResponseStream());
                    responseData = reader.ReadToEnd();
                }
                catch
                { // IDology service failure - no response
                  // notify ITOPS
                    string EmailErrorSubject = "IDology service failure";
                    string EmailErrorBody = String.Format("There has been a failure in receiving a response from IDology.\r\n" +
                                            "IDology Customer Service {0}", IDologyCustomerServicePhoneNumber.ToString());
                    SendEmailErrors(EmailErrorAddress, EmailErrorSubject, EmailErrorBody);
                }
            }

            // Determine if PASS or FAIL, Match or No Match
            if (responseData.Contains("<error>Invalid username and password</error>"))
            {
                // Send message to IT Ops
                string EmailErrorSubject = "IDology Web Service Username:Password failure";
                string EmailErrorBody = String.Format("There has either been a Username or Password change for the IDology web service.\r\n" +
                                        "Please contact IDology Customer Service {0} " +
                                        "or correct the login/password for this web service.", IDologyCustomerServicePhoneNumber.ToString());
                SendEmailErrors(EmailErrorAddress, EmailErrorSubject, EmailErrorBody);
            }

            if (responseData.Contains("<error>Your IP address is not registered"))
            {
                // Send message to IT Ops
                string EmailErrorSubject = "IDology IP address is not registered";
                string EmailErrorBody = String.Format("Server IP address for web site has changed.\r\n" +
                                        "Please contact IDology Customer Service {0} " +
                                        "to have new IP address added to their white list", IDologyCustomerServicePhoneNumber.ToString());
                SendEmailErrors(EmailErrorAddress, EmailErrorSubject, EmailErrorBody);
            }

            // TEST: responseData = responseData.Replace("<key>result.match</key>", "<failed>");
            // TEST: responseData = responseData.Replace("<key>result.match</key>", "<failed>Exception initializing proxy: [com.idology.persist.Query#297958]</failed>");
            if (
                responseData.Contains("<failed>") ||
                responseData.Contains("<error>")
               )
            {
                // Send message to IT Ops
                string EmailErrorSubject = "IDology incurred a problem with web service";
                string EmailErrorBody = String.Format("IDology web service incurred a problem returning results.\r\n" +
                                        "This could be due to malformed submission to the service. " +
                                        "Please view the complete response in the IDologyLog " +
                                        "before contacting IDology Customer Service at {0}", IDologyCustomerServicePhoneNumber.ToString());
                SendEmailErrors(EmailErrorAddress, EmailErrorSubject, EmailErrorBody);
                
            }
            
            // Add checks for additional errors and notify ITOPS **here**

            // Get-Set IDology <id-number>
            //if (1==1) //(Session["IDologyID"] == null)
            //{
                XmlTextReader textReader = new XmlTextReader(new StringReader(responseData));
                textReader.Read();
                while (textReader.Read())
                {
                    textReader.MoveToElement();
                    if (textReader.Name.ToString() == "id-number")
                    {
                        textReader.Read();
                        Session.Add("IDologyID", textReader.Value.ToString());
                        break;
                    }


                }
            //}

            // Record IDology response data            
            if (Session["RegistryID"] != null)
                RegistryID = (string)(Session["RegistryID"].ToString());
            if (dsIDologyData == null)
                dsIDologyData = new RegistryCommon();

            // Set IDologyID
            if (Session["IDologyID"] != null)
            {
                IDologyID = (string)(Session["IDologyID"].ToString());
            }
            else
            {
                IDologyID = "0";
            }

            // save IDology request and response to database 
            RegistryCommon.IDologyLogRow row;
            row = dsIDologyData.IDologyLog.NewIDologyLogRow();
            row["RegistryID"] = Convert.ToInt32(RegistryID.ToString());
            row["IDologyLogNumberID"] = Convert.ToInt32(IDologyID.ToString());
            row["IDologyLogRequest"] = Truncate(requestData.ToString(), 2000);
            row["IDologyLogResponse"] = Truncate(responseData.ToString(), 2000);
            row["LastStatEmployeeID"] = -1;
            dsIDologyData.IDologyLog.AddIDologyLogRow(row);
            RegistryCommonManager.UpdateIDologyLog(dsIDologyData);

            return responseData;
        }
        public void askAdditionalQuestions(string xmlStream)
        {
            // Transform XML-HTML via XSLT
            // Dynamically build question page from XML stream 

            // Transform the xml file
            string applicationPath = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase);
            string bin =  "bin";
            string register;
 

            // Mobile Question Template
            register = "Register\\Dynamic\\QuestionTemplateMobile.xslt";


            string xsltFile = applicationPath.Replace(bin, register);

            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xmlStream);

            XslCompiledTransform xslFile = new XslCompiledTransform();
            StringWriter sw = new StringWriter();
            try
            {
                xslFile.Load(xsltFile);
                xslFile.Transform(xmlDoc, null, sw);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
                throw;
            }

            // Decode HTML before presenting
            Response.Write(HttpUtility.HtmlDecode(sw.ToString()));
            Response.End();

        }
        public static string Truncate(string source, int length)
        {
            if (source.Length > length)
            {
                source = source.Substring(0, length);
            }
            return source;
        }
        private void GetSessionInfo()
        {
            // IDRequestType parameter options:
            // 1. "New" - Submits initial request and sends to IDology.
            // 2. "Question" - Re-formulates request question string and sends to IDology.
            // 3. "Challenge" - Submits initial request to IDology.
            // 4. "ChallengeQuestion" - Re-formulates request questions with answers and sends to IDology.
            // 5. "DisplayPageOnly" - Does not send any requests to IDology. Displays failure message only.
            // 6. "Finished" - All Requests have completed.

            if (Session["IDologyActive"] != null) 
                IDologyActive = Convert.ToBoolean((string)(Session["IDologyActive"].ToString()));                
            else 
                IDologyActive = false; //set default

            if (Session["DonorNotConfirmed"] != null) 
                DonorNotConfirmed = Convert.ToBoolean((string)(Session["DonorNotConfirmed"].ToString()));
            else 
                DonorNotConfirmed = false;  //set default

            if (Session["RegistryOwnerID"] != null) 
                RegistryOwnerID = Convert.ToInt32((string)(Session["RegistryOwnerID"].ToString()));
            else 
                RegistryOwnerID = 0;  //set default

            if (Session["LanguageCode"] != null) 
                LanguageCode = (string)(Session["LanguageCode"].ToString());
            else  
                LanguageCode = "en";  //set default

            
            if (Session["IDRequestType"] != null) 
                IDRequestType = (string)(Session["IDRequestType"].ToString());
            else 
                IDRequestType = "DisplayPageOnly";  //set default

            if (Session["RegistryID"] != null) 
                RegistryID = (string)(Session["RegistryID"].ToString());
            else 
                RegistryID = "2";  //set default
            
            if (Session["FirstName"] != null) 
                FirstName = (string)(Session["FirstName"].ToString());
            else 
                FirstName = "";  //set default
            
            if (Session["LastName"] != null) 
                LastName = (string)(Session["LastName"].ToString());
            else 
                LastName = "";  //set default
            
            if (Session["Address"] != null) 
                Address = (string)(Session["Address"].ToString());
            else 
                Address = "";  //set default
            if (Session["City"] != null) 
                City = (string)(Session["City"].ToString());
            else 
                City = "";  //set default
            if (Session["State"] != null) 
                State = (string)(Session["State"].ToString());
            else 
                State = "";  //set default
            
            if (Session["Zip"] != null) 
                Zip = (string)(Session["Zip"].ToString());
            else 
                Zip = "";  //set default
            
            if (Session["LastFourSSN"] != null) 
                LastFourSSN = (string)(Session["LastFourSSN"].ToString());
            else 
                LastFourSSN = "";  //set default

            if (Session["DOBMonth"] != null)
                DOBMonth = (string)(Session["DOBMonth"].ToString());
            else
                DOBMonth = "";  //set default
            
            if (Session["DOBYear"] != null) 
                DOBYear = (string)(Session["DOBYear"].ToString());
            else 
                DOBYear = "";  //set default

            if (Session["CSSFileLocation"] != null)
                CSSFileLocation = (string)(Session["CSSFileLocation"].ToString());
            else
                CSSFileLocation = "~/Framework/Themes/Default/EnrollmentMobile.css";  //set default

        }
        private void GetIDologySessionInfo()
        {
            if (dsCommonData == null) dsCommonData = new RegistryCommon();
            RegistryCommonManager.FillRegistryOwner(dsCommonData, Convert.ToInt32(RegistryOwnerID), String.Empty);
            divFailureMessage.InnerHtml = string.Empty; //dsCommonData.RegistryOwner[0].IDologyPassword.ToString();

            IDologyActive = dsCommonData.RegistryOwner[0].IDologyActive;

            switch (LanguageCode)
            {
                case "es" :
                    IDologyUser = EncryptionManager.DecryptWithSalt(dsCommonData.RegistryOwner[0].IDologySpLogin.ToString());
                    IDologyPass = EncryptionManager.DecryptWithSalt(dsCommonData.RegistryOwner[0].IDologySpPassword.ToString());
                    break;
                default:
                    IDologyUser = EncryptionManager.DecryptWithSalt(dsCommonData.RegistryOwner[0].IDologyLogin.ToString());
                    IDologyPass = EncryptionManager.DecryptWithSalt(dsCommonData.RegistryOwner[0].IDologyPassword.ToString());
                    break;
            }
        }

        private void SendEmailErrors(string emailAddress, string subject, string body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(emailAddress.ToString());
                mail.From = new MailAddress("WebRegistry@Statline.org"); //new MailAddress(ApplicationSettings.GetSetting(SettingName.DeveloperEmails));
                mail.Subject = subject.ToString();
                mail.Body = body.ToString();
                SmtpClient smtp = new SmtpClient(ApplicationSettings.GetSetting(SettingName.MailServer), Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.EmailPort)));
                smtp.Credentials = new System.Net.NetworkCredential(ApplicationSettings.GetSetting(SettingName.EmailUserName), ApplicationSettings.GetSetting(SettingName.EmailPassword));
                smtp.EnableSsl = true;

                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General", 1);
                throw;
            }
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
            meta.Content = "width=device-width; initial-scale=1.0;";
            //meta.Content = "initial-scale=1.0, maximum-scale=1.0, user-scalable=0;";
            head.Controls.Add(meta);
        }
    }
}