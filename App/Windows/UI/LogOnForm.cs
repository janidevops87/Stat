using System;
using System.Text;
using System.Windows.Forms;
using System.Security.Principal;
using System.Diagnostics;
using System.Collections;
using System.Linq;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Security;
using System.Deployment.Application;

namespace Statline.Stattrac.Windows.UI
{
	public partial class LogOnForm : Statline.Stattrac.Windows.UI.BaseForm
	{
		private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        public bool IsLoginOverride;
        public bool IsFullLogin;
        public bool IsFailedLoginOverride;
        public string OriginalLoginUserName;
        public string OriginalLoginOrganizationName;
        public bool UserNotFound;
        public bool DatabaseSelectionNotFound;

		public LogOnForm()
		{
			InitializeComponent();
            txtPassword.PasswordChar = '*';
			txtId.Text = Environment.UserName;
            this.StartPosition = FormStartPosition.CenterScreen;

            cblDatabase.DataSource = Enum.GetValues(typeof(DatabaseInstance)); 

			// Select the default Database
			BaseConnectionSetting connectionSetting = new BaseConnectionSetting();            
            cblDatabase.SelectedIndex =  cblDatabase.FindString(connectionSetting.DefaultDatabase);

			// display the version
            Version version = new Version(Application.ProductVersion);
            txtVersion.Text = version.ToString();
		}

		private void ValidateLogin()
		{
            string LoginUser = Environment.UserName;


            if (LogOnBR.ValidateUser(generalConstant.ActiveDirectory, LoginUser, txtPassword.Text, isAuthenticated, IsFullLogin))
			{

                //reset DatabaseSelectionNotFound
                DatabaseSelectionNotFound = false;

                try
                {
                    UpdatePrincipal();
                }
                catch
                {   
                    //UpdatePrincipal() failure produces gerneric exception
                    //Capture the error and replace with custom message.
                    //Also, set flags which will allow the user to retry a login already in progress.
                    StringBuilder  loginFailureNote = new StringBuilder();
                    loginFailureNote.Append("Unable to log in to the environment specified.");
                    loginFailureNote.Append(Environment.NewLine);
                    loginFailureNote.Append("Please select another environment to login.");

                    BaseMessageBox.ShowError(loginFailureNote.ToString(), "Login Error");
                    
                    //Set DatabaseSelectionNotFound
                    DatabaseSelectionNotFound = true;

                }

                if (DatabaseSelectionNotFound)
                    return;

                if (!IsLoginOverride)
                {
                    // If this is a regular user, we want to authenticate and start StatTrac.  
                    // If IsLoginOveride is true the user has not finished the login process
                    // the user is not authenticated yet and the form will remain open. 
                    isAuthenticated = true;

                    // If user is overriding login, record the event.
                    if (pnlLoginOverride.Visible && txtId.Enabled && txtId.Text.Length > 0)
                    {
                        RecordLoginOverrideEvent();
                    }
                    if (!UserNotFound)
                    {
                        // If the user was found and has finished authenticating then close the form. 
                        Close();
                    }
                    else
                    {
                        // User Not found. Reset flags for next go around
                        isAuthenticated = false;
                        UserNotFound = false;
                    }
                }

			}
			else
			{
                BaseMessageBox.Show(generalConstant.InvalidLogOn);
                isAuthenticated = false;
              
                // if user failed login attempt while overriding another user
                // flag event to prevent ValidateLogin()
                if (pnlLoginOverride.Visible)
                {
                    IsFailedLoginOverride = true;
                    btnLogin.Enabled = false;
                    
                    //Demand full authentication
                    //This will force autentication even if password is blank
                    IsFullLogin = true;
                } 



			}
		}

		private void UpdatePrincipal()
        {
            bool isUserAuthenticated = WindowsIdentity.GetCurrent().IsAuthenticated;
            string database = cblDatabase.SelectedItem.ToString();
            string name = txtId.Text;
            BuildPrincipal buildPrincipal = new BuildPrincipal(name, isUserAuthenticated, database);

            if (buildPrincipal.UserNotFound)
            {
                //Employee not found
                UserNotFound = true;
                BaseMessageBox.Show(generalConstant.InvalidUserName);
            }

		}

        private void btnExit_Click(object sender, EventArgs e)
		{
            if (pnlLoginOverride.Visible)
            {
                this.pnlLoginOverride.Visible = false;
                this.pnlLogin.Visible = true;
                this.Text = "StatTrac Login";
            }
            else
            {
                Close();
            }
        }

		private void btnLogin_Click(object sender, EventArgs e)
		{
            DetermineLoginTypeAndValidate();
		}

		private bool isAuthenticated;

		public bool IsAuthenticated
		{
			get { return isAuthenticated; }
		}

		protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
		{
            const int WM_KEYDOWN = 0x100;
            const int WM_SYSKEYDOWN = 0x104;
            Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();

            if ((msg.Msg == WM_KEYDOWN) || (msg.Msg == WM_SYSKEYDOWN))
            {
                switch (keyData)
                {
                    case Keys.Control | Keys.F12:
                        // <CTRL> + F12 : Capture login overide key strokes


                        
                        // Authorize user trying to override login (using original credentials) and
                        // Validating while IsLoginOverride flag set to true will permit future validations.
                        IsLoginOverride = true;

                        ValidateLogin();

                        // capture OriginalLoginUserName and OriginalOrganizationName for future logging.
                        OriginalLoginUserName = StattracIdentity.Identity.UserName;
                        OriginalLoginOrganizationName = StattracIdentity.Identity.UserOrganizationName;

                        UpdatePrincipal();

                        // Check User permission
                            if (securityHelper.Authorized(SecurityRule.Login_Override.ToString()))
                            {
                                //Set up properties on override login screen
                                this.pnlLoginOverride.Visible = false;
                                this.pnlLogin.Visible = true;
                                this.txtId.Enabled = true;
                                this.txtId.TabStop = true;
                                if (txtId.Enabled)
                                    this.txtId.Focus();
                            }
                            else
                            {
                                IsLoginOverride = false;
                          
                            }
                        break;

                    case Keys.Enter:
                        DetermineLoginTypeAndValidate();
                        break;
                }
            }

			return base.ProcessCmdKey(ref msg, keyData);
		}

        private void txtId_Leave(object sender, EventArgs e)
        {
             //ShowLoginIfOverride();
        }

        private void ShowLoginIfOverride()
        {
            if (txtId.Enabled && IsLoginOverride && !pnlLoginOverride.Visible)
            {
                // Setup the Login Override screen:
                // We have the user name so ask for the password.
                this.lblLoginOverrideUserNameValue.Text = OriginalLoginUserName; // this.txtId.Text;
                this.pnlLoginOverride.Visible = true;
                this.pnlLogin.Visible = false;
                this.Text = "Login Override";
                if (txtPassword.Enabled)
                    this.txtPassword.Focus();
            }
        }
        private void DetermineLoginTypeAndValidate()
        {
            if (txtId.Enabled && IsLoginOverride)
            {
                if (!pnlLoginOverride.Visible)
                {
                    ShowLoginIfOverride();
                    // If login override is not visible yet the user must be given a chance
                    // to enter a password and come back to be validated.
                    return;
                }
                
                // Release Login override flag so that the next
                // pass will validate the login with new credentials.
                IsLoginOverride = false;

                // User has already authenticated once
                // setting isAuthenticated to true will cause re-validation of username and 
                // password.
                isAuthenticated = true;


                // If password is not present do not attempt to validate
                if (txtPassword.Text.Length == 0)
                    return;
            }
            if (txtExtension.Text.Length == 0)
            {
                BaseMessageBox.ShowWarning("Please enter extension", "Required field");
                return;
            }

            if (!IsFailedLoginOverride)
                ValidateLogin();
        }
        
        private void RecordLoginOverrideEvent()
        {
            //Log the event
            string loginOverrideLogNote = 
            string.Format("WARNING - Login Override: User {0} from {1} has logged in as {2}.",
                            ReplaceNull(OriginalLoginUserName),
                            ReplaceNull(OriginalLoginOrganizationName),
                            ReplaceNull(txtId.Text.ToString())
                          );
            BaseLogger.Log(loginOverrideLogNote, loginOverrideLogNote);
        }

        private void txtPassword_Enter(object sender, EventArgs e)
        {
            //reset user override attempt
            IsFailedLoginOverride = false;
            btnLogin.Enabled = true;
        }

        private static String ReplaceNull(string s)
        {
            if (String.IsNullOrEmpty(s) == true)
                return "";
            else
                return s;
        }
	}
}
