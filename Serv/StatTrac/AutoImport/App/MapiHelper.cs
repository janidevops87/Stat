//using System;
//using System.Threading;
//using MAPI;
//using Microsoft.Practices.EnterpriseLibrary.Logging;
//using Microsoft.Practices.EnterpriseLibrary.Logging.Tracing;
//using Statline.StatTrac.AutoImport.Configuration;

//namespace Statline.StatTrac.AutoImport
//{
//    /// <summary>
//    /// Connects to an email box and calls AutoImportParse.ProcessEmail if emails exists in the inbox.
//    /// </summary>
//    /// <remarks>
//    /// <P>Name: MapiHelper</P>
//    /// <P>Date Created: 4/17/07</P>
//    /// <P>Created By: Bret Knoll</P>
//    /// <P>Version: 1.0</P>
//    /// <P>Task: Login into inbox and kick off email process</P>
//    /// <P>9/14/07 Caught an exception so the emails will not cause the application to fail 
//    /// <BR>Add a try catch to Process.</BR>
//    /// </remarks>
//    public class MapiHelper : IDisposable
//    {
//        #region class objects

//        //private SessionClass session;
//        private SessionClass session;

//        public SessionClass Session
//        {
//            get { return session; }
//            set { session = value; }
//        }
	
//        private Messages messages;
//        private Folder inbox;
//        private Folder processedFolder;
//        private Folder errorFolder;
//        private Folders inboxFolders;
		
//        /// <summary>
//        /// Name of the folder used to place emails after processing.
//        /// </summary>
//        private string processFolderName;

//        /// <summary>
//        /// Name of folder used to place error emails
//        /// </summary>
//        private string errorFolderName;
//#endregion

//        #region class constructor
//        /// <summary>
//        /// inializes the email connection
//        /// </summary>        
//        public MapiHelper(SessionClass session)
//        {
//            if (Session == null)
//                //Session = session;
//                Session = new SessionClass();
//            try
//            {
//                Logon();
//            }
//            catch (Exception ex)
//            {
//                Logger.Write(ex, Category.Error.ToString(), 1);
//                throw;
//            }

//            processFolderName = ApplicationSettings.GetSetting(SettingName.ProcessFolderName);
//            errorFolderName = ApplicationSettings.GetSetting(SettingName.ErrorFolderName);

//        }

		
//        #endregion

//        #region Methods
//        /// <summary>
//        /// Tries to Logoff of session
//        /// </summary>
//        private void Logoff()
//        {
//            try
//            {
//                Session.Logoff();
//            }
//            catch(Exception ex)
//            {
//                Logger.Write(ex, Category.Error.ToString(), 1);
//                throw;
//            }
			
//        }
//        [STAThread]
//        private void Logon()
//        {
//            string profileName = ApplicationSettings.GetSetting(SettingName.ProfileName);
//            //string profilePassword = ApplicationSettings.GetSetting(SettingName.ProfilePassword);
//            object profilePassword = Type.Missing;
//            object showDialog = Type.Missing;
//            object newSession = Type.Missing;
//            object parentWindow = Type.Missing;
//            object noMail = Type.Missing;
//            object profileInfo = Type.Missing;

//            try
//            {
//                Session.Logon(
//                    (object) profileName,
//                    (object) profilePassword,
//                    (object) showDialog,
//                    (object) newSession,
//                    (object) parentWindow,
//                    (object) noMail,
//                    (object) profileInfo);
//                inbox = (Folder) session.Inbox;
//                messages = (Messages) inbox.Messages;
//                inboxFolders = (Folders) inbox.Folders;
//            }
//            catch (Exception ex)
//            {
//                    Logger.Write(ex, Category.Error.ToString(), 1);
//                    throw;
//            }
			
//        }
//        /// <summary>
//        /// Creates an instance of MapiHelper and calls the process method if email exist
//        /// </summary>
//        [STAThread]
//        public void ProcessEmails()
//        {

//            //login was sucessful. Try to process the messages 
//            // always logoff using a finally
//            try
//            {
//                //confirm messages is not null
//                if (messages == null)
//                    throw new Exception("The system is not conntect to Exchange!");
//                    if (Convert.ToInt32(messages.Count) > 0)
//                    {
//                        processedFolder = GetFolder(processFolderName);
//                        errorFolder = GetFolder(errorFolderName);
//                        Process();
//                    }
//            }
//            catch(Exception ex)
//            {
//                Logger.Write(ex, Category.Error.ToString(), 1);
//                throw;
//            }
			

//        }
//        /// <summary>
//        /// loops through the inboxFolders and returns the folder specified by folderName
//        /// </summary>
//        /// <param name="folderName"></param>
//        /// <returns></returns>
//        private Folder GetFolder(string folderName)
//        {
//            Folder folder;
//            folder = (Folder) inboxFolders.GetFirst();
//            for (int folderListCount = 0; folderListCount < Convert.ToInt32(inboxFolders.Count); folderListCount++)
//            {
//                if (folder.Name.ToString() == folderName)
//                    return folder;

//                folder = (Folder) inboxFolders.GetNext();
//            }
//            folder = null;
//            return folder;
//        }

//        /// <summary>
//        /// Loops through the emails and calls the Statline.StatTrac.AutoImport.AutoImportParse.ProcessMessage method. If ProcessMessage returns a success the emails is placed in the processed folder.If the result is an error
//        /// </summary>
//        private void Process()
//        {
			 
//            using (AutoImportParse parseImport = new AutoImportParse())
//            {
//                using(new Tracer(TraceType.Application.ToString(), "ProcessEmails"))
//                {
//                    Message message = (MAPI.Message) messages.GetFirst(messages.Filter);
//                    do 
//                    {
						
//                        bool emailStatus = false; // used to determine what folder to stick the email

//                            // 9/14/07 The ProcessMessage can throw an exception. 
//                            // Catch it and	log it
//                        try
//                        {
//                            emailStatus = parseImport.ProcessMessage(message);
//                        }
//                        catch(Exception ex)
//                        {
//                            emailStatus = false;
//                            Logger.Write(ex, Category.Error.ToString(), 1);
//                        }
//                        if (emailStatus)
//                        {
//                            message.MoveTo(processedFolder.ID, processedFolder.StoreID);
//                        }
//                        else
//                        {
//                            message.MoveTo(errorFolder.ID, errorFolder.StoreID);                            
//                            Logger.Write("The AutomImport process has moved an email to the Error folder." ,
//                            Category.ImportMailError.ToString()                            
//                            );
//                        }

//                        message = (MAPI.Message) messages.GetNext();

//                    }
//                    while(message != null);
//                }
//            }
//        }

//        #endregion

//        #region IDisposable Members
//        /// <summary>
//        /// IDisposable implmented method, handling object disposal
//        /// </summary>
//        public void Dispose()
//        {
//            errorFolder = null;
//            processedFolder = null;
//            messages = null;
//            inboxFolders = null;
//            inbox = null;
//            //try to logoff
//            try
//            {
//                Logoff();
//            }
//            catch
//            {
//            }

//            session = null;
//        }

//        #endregion
//    }
//}