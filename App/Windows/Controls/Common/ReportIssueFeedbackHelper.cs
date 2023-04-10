using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.Windows.Forms;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using Statline.Stattrac.Constant;
using System.Net.Mail;
using System.Net;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.Controls.Common
{
    public class ReportIssueFeedbackHelper
    {
        private List<MemoryStream> memoryStream;
        private Graphics gfxScreenshot;
        private String mailServer;
        private Int32 mailServerPort;
        private String mailServerUsername;
        private String mailServerPassword;
        private String mailServerFrom;
        private String mailServerTo;


        public ReportIssueFeedbackHelper()
        {
            mailServer = BaseConfiguration.GetSetting(SettingName.MailServer);
            mailServerPort = Convert.ToInt32(BaseConfiguration.GetSetting(SettingName.MailServerPort));
            mailServerUsername = BaseConfiguration.GetSetting(SettingName.MailServerUsername);
            mailServerPassword = BaseConfiguration.GetSetting(SettingName.MailServerPassword);
            mailServerFrom = BaseConfiguration.GetSetting(SettingName.MailServerFrom);
            mailServerTo = BaseConfiguration.GetSetting(SettingName.MailServerTo);
            memoryStream = new List<MemoryStream>();
        }

        public Boolean SendReport(String userMessage)
        {
            Boolean successful = true;
            //1. get a list of open forms
            Assembly currentAssembly = Assembly.GetExecutingAssembly();
            List<Form> formsFromOtherAssemblies = new List<Form>();
            foreach (Form form in Application.OpenForms)
            {
                if (form.GetType().Assembly != currentAssembly)
                {
                    if (form.Name == "SecureForm")
                    {
                        formsFromOtherAssemblies.Add(form);
                        form.TopMost = true;
                        form.Refresh();
                        CaptureScreens();
                        form.TopMost = false;
                        form.Refresh();
                    }
                }
            }
            foreach (Form form in Application.OpenForms)
            {
                if (form.GetType().Assembly != currentAssembly)
                {
                    if (form.Name != "SecureForm" && form.Name != "InFormPrompt")
                    {
                        formsFromOtherAssemblies.Add(form);
                        form.TopMost = true;
                        form.Refresh();                        
                        CaptureScreens();
                        form.TopMost = false;
                        form.Refresh(); 
                    }
                }
            }
            string formList = "";
            for (int loopCount = 0; loopCount < formsFromOtherAssemblies.Count; loopCount++)
            {
                if (formList.Length > 0)
                    formList += "<BR>";
                formList += formsFromOtherAssemblies[loopCount];
            }


            //3.
            string str = string.Format("UserName: {0},<BR>Organization Name: {1} <BR>Date and Time: {2},<BR>System Name: {3}<BR>Users Message: {4},<br>The following forms were open:<br>{5}", StattracIdentity.Identity.UserName, StattracIdentity.Identity.UserOrganizationName,  DateTime.Now, System.Environment.MachineName, userMessage, formList);
            
            MailMessage mailMessage = new MailMessage(mailServerFrom, mailServerTo.Replace(";", ","));                                
            mailMessage.Subject = "Information from Stattrac User";
            mailMessage.IsBodyHtml = true;
            mailMessage.Body = str;
            memoryStream.ToList().ForEach(mStream =>
                {
                    mStream.Position = 0;
                    String screenShotName = String.Format("screenShot{0}.png", mailMessage.Attachments.Count + 1);
                    mailMessage.Attachments.Add(new Attachment(mStream, screenShotName));
                });
            
            SmtpClient smtp = new SmtpClient(mailServer);
            smtp.Port = mailServerPort;            
            smtp.EnableSsl = false;            

            try
            {
                smtp.Send(mailMessage);
            }
            catch (Exception ex)
            {
                successful = false;
                BaseLogger.LogFormUnhandledException(ex);

            }

            BaseLogger.Log(userMessage, str);
            return successful;
        }
        /// <summary>
        /// loops through hosts machines screens and captures a screenshot of each.
        /// </summary>
        private void CaptureScreens()
        {

            Screen.AllScreens.ToList().ForEach(screen =>
                {
                    // Set the bitmap object to the size of the screen            
                    Bitmap bmpScreenshot = new Bitmap(screen.Bounds.Width, screen.Bounds.Height, PixelFormat.Format32bppArgb);
                    // Create a graphics object from the bitmap
                    gfxScreenshot = Graphics.FromImage(bmpScreenshot);

                    // Take the screenshot from the upper left corner to the right bottom corner
                    gfxScreenshot.CopyFromScreen(screen.Bounds.X, screen.Bounds.Y, 0, 0, screen.Bounds.Size, CopyPixelOperation.SourceCopy);

                    // Save the screenshot to the specified path that the user has chosen

                    MemoryStream memoryStreamTemp = new MemoryStream();
                    bmpScreenshot.Save(memoryStreamTemp, ImageFormat.Jpeg);

                    memoryStream.Add(memoryStreamTemp);
                    


                });

        }

    }
}
