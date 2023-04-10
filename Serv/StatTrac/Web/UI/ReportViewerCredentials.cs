using System;
using System.Net;
using System.Runtime.InteropServices;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using Statline.Configuration;

namespace Statline.StatTrac.Web.UI
{
    public sealed class ReportViewerCredentials : IReportServerCredentials
    {
        #region class properties
        private string userName;
        private string password;
        private string domain;
        private string UserName
        {
            get { return userName; }
            set { userName = value; }
        }
        private string Password
        {
            get { return password; }
            set { password = value; }
        }
        private string Domain
        {
            get { return domain; }
            set { domain = value; }
        }
        
        #endregion
        public ReportViewerCredentials()
        {
            UserName = ApplicationSettings.RS_UserName;
            Password = ApplicationSettings.RS_Password;
            Domain = ApplicationSettings.RS_Domain;

        }
        public ReportViewerCredentials(string userName, string password, string domain)
        {
            UserName = userName;
            Password = password;
            Domain = domain;

        }
        #region IReportServerCredentials Members


        public bool GetFormsCredentials(out Cookie authCookie, out string userName, out string password, out string authority)
        {
            authCookie = null;
            userName = password = authority = null;
            return false;
        }

        public WindowsIdentity ImpersonationUser
        {
            get
            {
                // Use the default Windows user.  Credentials will be
                // provided by the NetworkCredentials property.
                return null;

            }
        }

        public ICredentials NetworkCredentials
        {
            get
            {
                // Read the user information from the Web.config file.  
                // By reading the information on demand instead of 
                // storing it, the credentials will not be stored in 
                // session, reducing the vulnerable surface area to the
                // Web.config file, which can be secured with an ACL.

                // User name
                if (string.IsNullOrEmpty(UserName))
                    throw new Exception(
                        "Missing user name from web.config file");

                // Password
                if (string.IsNullOrEmpty(Password))
                    throw new Exception(
                        "Missing password from web.config file");

                // Domain
                if (string.IsNullOrEmpty(Domain))
                    throw new Exception(
                        "Missing domain from web.config file");

                return new NetworkCredential(UserName, Password, Domain);
            }

            //get { return null; }
        }


        #endregion
    }
}