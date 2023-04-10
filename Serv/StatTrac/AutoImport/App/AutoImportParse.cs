using System;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.StatTrac.AutoImport.Configuration;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.AutoImport.org.statline.webmail;
namespace Statline.StatTrac.AutoImport
{
	/// <summary>
	/// This class parses emails and calls DBclasses to create Call, Message and log events
	/// </summary>
	/// <remarks>
	/// <P>Name: AutoImportParse </P>
	/// <P>Date Created: 4/17/07</P>
	/// <P>Created By: Thien Ta</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Parse Emails and create Call, Message and LogEvents</P>
	/// </remarks>
	/// <P>9/14/07 need to change how email is parsed. 
	/// <BR>Email text was changed from third notification to third and final notification.</BR>
	/// <BR>Changed Find Method</BR>
    /// </P>
    /// <P>12/15/08 adding functionality to use Exchange Webserice instead of MAPI. 
    /// </P>
	/// </remarks>

    public class AutoImportParse : IDisposable
    {
        #region class objects
        //DataSetRows Declared
        private MessageData.CallRow callRow;
        int importCoord = Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ImportCoordinatorEmployeeID));
        //create DataSets
        private EmailMessage emailParsed = new EmailMessage();
        private MessageData messageData = new MessageData();
        private TransplantCenterData transplantData = new TransplantCenterData();
        #endregion
        
        #region Fields
        private static readonly TimeZoneInfo MountainTimeZone =
            TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time");
        //declare dateTime to share among methods
        private DateTime nowInMountainDateTime;
        #endregion Fields
        #region Methods

        /// <summary>
        /// Loads TransplantCenter code to create calls
        /// </summary>
        /// <list type="number">
        ///		<listheader> List of items accomplished</listheader>
        ///		<item>Loads Transplant Center code</item>
        /// </list>
        public void LoadTransplantCenter()
        {

            try
            {
                //Get TransplantCenterData SourceCode and OrganizationID	
                LoadTransplantCenter(emailParsed.TxCenter.ToString());
            }
            catch
            {
                throw;
            }
        }
        public void LoadTransplantCenter(string transPlantCenter)
        {

            try
            {
                //Get TransplantCenterData SourceCode and OrganizationID	
                TransPlantManager.LoadTransplantCenter(ref transplantData, transPlantCenter);

            }
            catch
            {
                throw;
            }
        }
        public void LoadTransplantCenter(ImportMessage im )
        {

            try
            {
                //Get TransplantCenterData SourceCode and OrganizationID	
                LoadTransplantCenter(im.TransplantCenter);

            }
            catch
            {
                throw;
            }
        }
        /// <summary>
        /// CreateCall creates the call in the call table with the parsed email information
        /// </summary>
        /// <list type="number">
        ///		<listheader> List of items accomplished</listheader>
        ///		<item>Creates Call in StatTrac database</item>
        /// </list>
        public void CreateCall()
        {
 
            try
            {

                int personID = Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ImportCoordinatorPersonID));
                callRow = messageData.Call.AddCallRow(
                    "",
                    2,
                    nowInMountainDateTime,
                    importCoord,
                    "0",
                    0,
                    0,
                    0,
                    nowInMountainDateTime,
                    0,
                    transplantData.TransplantCenter[0].SourceCodeID,
                    -1,
                    000,
                    0,
                    0,
                    -1,
                    -1,
                    -1,
                    importCoord);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }
        }
        /// <summary>
            /// CreateMessage creates the Message in the Message table with the parsed email information
            /// </summary>
            /// <list type="number">
            ///		<listheader> List of items accomplished</listheader>
            ///		<item>Creates Message in StatTrac database</item>
            /// </list>
        public void CreateMessage()
        {
    
            try
            {
                int personID = Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ImportCoordinatorPersonID));
                messageData.Message.AddMessageRow(
                    callRow,
                    emailParsed.SenderName.ToString(),
                    "(000) 000-0000",
                    emailParsed.From.ToString(),
                    transplantData.TransplantCenter[0].OrganizationID,
                    personID,
                    2,
                    0,
                    emailParsed.BodyEmail.ToString(),
                    0,
                    nowInMountainDateTime,
                    0,
                    "",
                    emailParsed.UnosID.ToString(),
                    emailParsed.TxCenter.ToString(),
                    0,
                    importCoord
                    );
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }
        }
        
#endregion

        #region Exchange WebService Version
        
        public bool ProcessMessage(ImportMessage message, MessageType mt)
        {
            bool parseresult = false;
            bool result = false;

            parseresult = ParseEmail(message, mt);
            if (parseresult)
            {
                try
                {
                    //create nowInMountainDateTime. all methods will use the datetime
                    nowInMountainDateTime = TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, MountainTimeZone);

                    //Call to LoadTansplantCenter Method
                    transplantData.Clear();
                    LoadTransplantCenter(message);

                    //Create Call in call table
                    CreateCall(message);

                    //Create Message
                    CreateMessage(message);

                    //Create LogEvents
                    CreateLogEvent(message);

                    //Update DataSet
                    MessageManager.UpdateMessage(messageData);

                }
                catch (Exception ex)
                {
                    Logger.Write(ex, "General");
                    throw;
                }
                result = true;
            }
            return result;
        }
        private bool ParseEmail(ImportMessage im, MessageType mt)
        {
            //check to see if the email contains html          
            //if (im.RawEmailMessage.Contains("<html"))
                //remove all html from the email message
                im.RawEmailMessage = RemoveAllHTMLElements(im.RawEmailMessage);

            return ParseEmailText(im, mt);
        }
        private bool ParseEmailText(ImportMessage im, MessageType mt)
        {
            bool result = false;
            int startPos = 0;
            int currentPos = 0;
            int currentLength = 0;
            bool hasSenderName = false;

            if (!isValid(im.RawEmailMessage))
                return result;

            try
            {
                // Sender's Name emailParsed
                if (!String.IsNullOrEmpty(mt.From.Item.EmailAddress))
                {
                    //confirm From Email Address is configured
                    string[] allowedEmailDomains = ApplicationSettings.GetSetting(SettingName.ParseSenderNameAllowedEmailDomains).Split(',');
                    bool addressExists = false;
                    foreach(string allowedEmailDomain in allowedEmailDomains)
                    {
                        if (mt.From.Item.EmailAddress.Contains(allowedEmailDomain.Trim()))
                        {
                            addressExists = true;
                            break;
                        }
                    }

                    if (addressExists) // address exists in list 
                    {
                        currentPos = im.RawEmailMessage.IndexOf(ImportMessage.SENDERSNAME);
                        // Sender's Name was found in the email message so parse it out
                        currentLength = im.RawEmailMessage.IndexOf(ImportMessage.NEWLINE, currentPos) - (currentPos + ImportMessage.SENDERSNAME.Length);
                        if (currentLength < 0)
                            currentLength = im.RawEmailMessage.Length - (currentPos + ImportMessage.SENDERSNAME.Length);
                        im.SenderName = im.RawEmailMessage.Substring(
                            currentPos + ImportMessage.SENDERSNAME.Length, //start position
                            currentLength).Trim();
                        hasSenderName = true;
                    }
         
                }
                if (im.SenderName.Length < 1)
                    return result;


                // TxCenter emailParsed
                currentPos = im.RawEmailMessage.IndexOf(ImportMessage.CANDIDATE);
                im.TransplantCenter = im.RawEmailMessage.Substring(
                       currentPos + ImportMessage.CANDIDATE.Length,
                       ImportMessage.TRANSPLANTCENTERLENGTH);

                if (im.TransplantCenter.Length < 1)
                    return result;

                // From OPO 
                currentPos = im.RawEmailMessage.IndexOf(ImportMessage.OPO, im.RawEmailMessage.IndexOf(ImportMessage.ORGAN)) + ImportMessage.OPO.Length;
                currentLength = im.RawEmailMessage.IndexOf(ImportMessage.NEWLINE, currentPos) - (currentPos);
                im.FromOPO = im.RawEmailMessage.Substring(currentPos, currentLength);
                im.FromOPO = im.FromOPO.Trim();

                if (im.FromOPO.Length < 1)
                    return result;

                //unosID 
                currentPos = im.RawEmailMessage.IndexOf(ImportMessage.DONORID) + ImportMessage.DONORID.Length;
                currentLength = im.RawEmailMessage.IndexOf(ImportMessage.CARRIAGERETURN, currentPos) - currentPos;
                im.UNOSID = im.RawEmailMessage.Substring(currentPos, currentLength);

                if (im.UNOSID.Length < 1)
                    return result;

                // Message URL
                currentPos = im.RawEmailMessage.IndexOf(ImportMessage.HTTPS);
                currentLength = im.RawEmailMessage.IndexOf(')', currentPos) - currentPos;
                im.URL = im.RawEmailMessage.Substring(currentPos, currentLength);

                if (im.URL.Length < 1)
                    return result;

                // import information

                currentPos = startPos;
                currentLength = im.RawEmailMessage.IndexOf(ImportMessage.PLEASE) - currentPos;
                im.OfferInformation = im.RawEmailMessage.Substring(currentPos, currentLength);
                im.OfferInformation = im.OfferInformation.Trim();

                if (im.OfferInformation.Length < 1)
                    return result;

                //import detail
                currentPos = im.RawEmailMessage.IndexOf(ImportMessage.ORGAN);
                if (hasSenderName)
                    currentLength = im.RawEmailMessage.IndexOf(ImportMessage.THESENDERTEXT) - currentPos;
                else
                    currentLength = im.RawEmailMessage.Length - currentPos;

                im.OrganDetail = im.RawEmailMessage.Substring(currentPos, currentLength);
                im.OrganDetail = im.OrganDetail.Trim();

                if (im.OrganDetail.Length < 1)
                    return result;

                result = true;
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
            }

            return result;
        }
        /// <summary>
        /// This was originally built when migrating from MAPI Exchagne webservice
        /// As of 12/23/08 when the modifications went inot test the ParseEmailHTML was not used
        /// </summary>
        /// <param name="im"></param>
        /// <returns></returns>
        private bool ParseEmailHTML(ImportMessage im)
        {
            bool result = false;
            int startPos = 0;
            int currentPos = 0;
            int currentLength = 0;

            if (!isValid(im.RawEmailMessage))
                return result;

            // Sender's Name emailParsed
            startPos = im.RawEmailMessage.IndexOf(ImportMessage.HTMLENDTAG, im.RawEmailMessage.IndexOf(ImportMessage.STARTPOS));
            currentPos = im.RawEmailMessage.IndexOf(ImportMessage.SENDERSNAME);
            currentLength = im.RawEmailMessage.IndexOf(ImportMessage.HTMLBR, currentPos) - (currentPos + ImportMessage.SENDERSNAME.Length);
            im.SenderName = im.RawEmailMessage.Substring(
                currentPos + ImportMessage.SENDERSNAME.Length, //start position
                currentLength).Trim();
            im.SenderName = RemoveAllHTMLElements(im.SenderName);

            if (im.SenderName.Length < 1)
                return result;


            // TxCenter emailParsed
            currentPos = im.RawEmailMessage.IndexOf(ImportMessage.CANDIDATE);
            im.TransplantCenter = im.RawEmailMessage.Substring(
                   currentPos + ImportMessage.CANDIDATE.Length,
                   ImportMessage.TRANSPLANTCENTERLENGTH);
            im.TransplantCenter = RemoveAllHTMLElements(im.TransplantCenter);

            if (im.TransplantCenter.Length < 1)
                return result;

            // From OPO 
            currentPos = im.RawEmailMessage.IndexOf(ImportMessage.OPO, im.RawEmailMessage.IndexOf(ImportMessage.ORGAN)) + ImportMessage.OPO.Length;
            currentLength = im.RawEmailMessage.IndexOf(ImportMessage.HTMLBR, currentPos) - (currentPos);
            im.FromOPO = im.RawEmailMessage.Substring(currentPos, currentLength);
            im.FromOPO = im.FromOPO.Replace(ImportMessage.HTMLSPACE, "").Trim();

            if (im.FromOPO.Length < 1)
                return result;

            // Message URL
            currentPos = im.RawEmailMessage.IndexOf(ImportMessage.HTTPS);
            currentLength = im.RawEmailMessage.IndexOf('"', currentPos) - currentPos;
            im.URL = im.RawEmailMessage.Substring(currentPos, currentLength);

            if (im.URL.Length < 1)
                return result;

            // import information
            currentPos = im.RawEmailMessage.IndexOf(ImportMessage.HTMLENDTAG, im.RawEmailMessage.IndexOf(ImportMessage.HTMLFONTSIZE, startPos)) + ImportMessage.HTMLENDTAG.Length;
            currentLength = im.RawEmailMessage.IndexOf(ImportMessage.PLEASE) - currentPos;
            im.OfferInformation = im.RawEmailMessage.Substring(currentPos, currentLength);
            im.OfferInformation = im.OfferInformation.Replace(ImportMessage.HTMLBR, "").Replace(ImportMessage.HTMLSPACE, "");

            if (im.OfferInformation.Length < 1)
                return result;

            //import detail
            currentPos = im.RawEmailMessage.IndexOf(ImportMessage.ORGAN);
            currentLength = im.RawEmailMessage.IndexOf(ImportMessage.THESENDERTEXT) - currentPos;

            im.OrganDetail = im.RawEmailMessage.Substring(currentPos, currentLength);
            im.OrganDetail = im.OrganDetail.Replace(ImportMessage.HTMLBR, "").Replace(ImportMessage.HTMLSPACE, "");

            if (im.OrganDetail.Length < 1)
                return result;

            result = true;

            return result;
        }

        /// <summary>
        /// CreateCall creates the call in the call table with the parsed email information
        /// </summary>
        /// <list type="number">
        ///		<listheader> List of items accomplished</listheader>
        ///		<item>Creates Call in StatTrac database</item>
        /// </list>
        public void CreateCall(ImportMessage im)
        {

            try
            {

                int personID = Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ImportCoordinatorPersonID));
                callRow = messageData.Call.AddCallRow(
                    "",
                    2,
                    nowInMountainDateTime,
                    importCoord,
                    "0",
                    0,
                    0,
                    0,
                    nowInMountainDateTime,
                    0,
                    transplantData.TransplantCenter[0].SourceCodeID,
                    -1,
                    0,
                    0,
                    0,
                    -1,
                    -1,
                    -1,
                    importCoord);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }
        }

        /// <summary>
        /// CreateMessage creates the Message in the Message table with the parsed email information
        /// </summary>
        /// <list type="number">
        ///		<listheader> List of items accomplished</listheader>
        ///		<item>Creates Message in StatTrac database</item>
        /// </list>
        public void CreateMessage(ImportMessage im)
        {
            try
            {
                int personID = Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ImportCoordinatorPersonID));
                messageData.Message.AddMessageRow(
                    callRow,
                    im.SenderName,                    
                    "(000) 000-0000",
                    im.FromOPO.ToString(),
                    transplantData.TransplantCenter[0].OrganizationID,
                    personID ,
                    2,
                    0,
                    im.OfferInformation + " " + im.URL + "\n" + im.OrganDetail,
                    0,
                    nowInMountainDateTime,
                    0,
                    "",
                    im.UNOSID.Trim(),
                    im.TransplantCenter,
                    0,
                    importCoord
                    );
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }
        }
        /// <summary>
        /// CreateLoegEvent creates the LogEvents in the LogEvents table with the parsed email information
        /// </summary>
        /// <list type="number">
        ///		<listheader> List of items accomplished</listheader>
        ///		<item>Creates LogEvents Incoming Call in LogEvents</item>
        ///		<item>Creates LogEvents Pending Events in LogEvents</item>
        /// </list>
        public void CreateLogEvent(ImportMessage im)
        {

            try
            {
                int personID = Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ImportCoordinatorPersonID));
                //create log event incoming call
                int importCoord = Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ImportCoordinatorEmployeeID));
                messageData.LogEvent.AddLogEventRow(
                    callRow,
                    2,
                    nowInMountainDateTime,
                    0,
                    im.SenderName,
                    "",
                    im.FromOPO,
                    "Recorded message information.",
                    importCoord,
                    0,
                    nowInMountainDateTime,
                    -1,
                    -1,
                    -1,
                    -1,
                    0,
                    0,
                    nowInMountainDateTime,
                    importCoord);
                //creat page pending
                messageData.LogEvent.AddLogEventRow(
                     callRow,
                     6,
                     nowInMountainDateTime,
                     0,
                     "Import",
                     "(000) 000-0000",
                     "DonorNet",
                     im.RawEmailMessage,
                     importCoord,
                     -1,
                     nowInMountainDateTime,
                     0,
                     personID,
                     Convert.ToInt32(transplantData.TransplantCenter[0].OrganizationID),
                     0,
                     0,
                     0,
                     nowInMountainDateTime,
                     importCoord);
                //LogEvent.CreateLogEvent(ref messageData,ref transplantData,ref emailParsed,ref E1, ref EP2);
            }
            catch (Exception ex)
            {
                Logger.Write(ex, "General");
                throw;
            }
        }
        #endregion
        #region Validation
        /// <summary>
        /// The email contains HTML tags, convert the email to text
        /// </summary>
        /// <param name="inputString"></param>
        /// <returns></returns>
        private string RemoveAllHTMLElements(string inputString)
        {
            int startPos = 0;
            int currentLength = 0;
            //replace html new lines with text new lines
            Regex replaceBR = new Regex("<br>", RegexOptions.IgnoreCase);
            if(replaceBR.IsMatch(inputString))
                inputString = replaceBR.Replace(inputString, "\n");

            //replace html spaces with empty string
            if(inputString.IndexOf("&nbsp;") > -1)
                inputString = inputString.Replace("&nbsp;", "");

            //remove all html tags
            for (startPos = inputString.IndexOf("<"); startPos > -1; startPos = inputString.IndexOf("<"))
            {
                currentLength = inputString.IndexOf(">", startPos) - startPos;

                inputString = inputString.Replace(inputString.Substring(startPos, currentLength+1), "");

            }
            //remove extra lines
            for (startPos = inputString.IndexOf("\n\n"); startPos > -1; startPos = inputString.IndexOf("\n\n"))
            {
                inputString = inputString.Replace("\n\n", "\n");

            }
            //remove formating strings
            startPos = inputString.IndexOf("st1");            
            if (startPos > -1 )
            {
                currentLength = inputString.IndexOf("}", startPos) - startPos;
                inputString = inputString.Replace(inputString.Substring(startPos, currentLength + 1), "");
            }

            return inputString;
        }
        private bool isValid(string messageBody)
        {
            bool result = false;
            string sPattern = "organ offer";

            // if body of the email DOES NOT matches set patter return
            if (Regex.IsMatch(messageBody.ToString(), sPattern))
                result = true;

            return result;
        }

        #endregion

        #region IDisposable Members

        public void Dispose()
        {
            callRow = null;

            messageData = null;
            transplantData = null;
        }

        #endregion
    }
		#region Structs
	// ********************************************* Email STRUCTURES *********************************************
	//This is a struct to store the Email Message after it is Parsed.
	[StructLayout(LayoutKind.Sequential, CharSet=CharSet.Ansi)]
	public class EmailMessage
	{
		public int EmailLength;
		public int SenderNamepos;
		public string SenderName;
		public int Frompos;
		public string From;
		public int TxCenterpos;
		public string TxCenter;
		public int Unospos;
		public string UnosID;
		public string Message;
		public int OrgID;
		public int ImportCoord;
		public int Bodypos;
		public string BodyEmail;
		public int BodyposPlease;
		public int bodyposOrgan;
		public int bodyEndOrganPos;
		public int urlStartPos;
		public int urlEndPos;
		public string url;
	}
	#endregion


}