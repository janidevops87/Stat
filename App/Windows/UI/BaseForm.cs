using System;
using System.ComponentModel;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.UI
{
	public class BaseForm : System.Windows.Forms.Form
    {
        public BaseGridSearch basicGridSearch;
        private System.Drawing.Color productionBackColor = System.Drawing.ColorTranslator.FromHtml("#FFCFDBE1");
        private System.Drawing.Color nonProductionBackColor = System.Drawing.ColorTranslator.FromHtml("#FFA3BA");
        private GeneralConstant generalConstant;
        static private bool unexpectedErrorHasBeenShown = false;
                
		#region Constructor
		public BaseForm()
		{
			// Set the name of the application
			Text = "StatTrac";
            generalConstant = GeneralConstant.CreateInstance();

			AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(CurrentDomain_UnhandledException);
			Application.ThreadException += new System.Threading.ThreadExceptionEventHandler(Application_ThreadException);
		}
		#endregion
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            //Text = BaseConfiguration.GetSetting(SettingName.ApplicationName);
            BackColor = productionBackColor;
            if (generalConstant.CurrentDB != null)
                if (generalConstant.CurrentDB != "Production")
                    BackColor = nonProductionBackColor;

        }
		#region Public Methods        
        public virtual void LoadSubControl(AppScreenType groupType, AppScreenType screenTypes) { } 
        [Description("Used to Create new copy of a Control")]
        public virtual void LoadHeaderControl(Control control){}
        [Description("Used to load a control in the InFormPrompt form.")]
        public virtual void LoadInFormPromptForm(AppScreenType groupType, AppScreenType screenType) { }
        [Description("Used to load VB Forms.")]
        public virtual void NavigateToVBScreen(AppScreenType appScreenType, int recordID) { }
        public virtual void NavigateToVBScreen(AppScreenType appScreenType) { }
        public virtual String SelectedUserControlName { get { return ""; } }
        #endregion

		#region Private Methods
		private void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs uex)
		{
			Application_Exception((Exception)uex.ExceptionObject);
		}

		private void Application_ThreadException(object sender, System.Threading.ThreadExceptionEventArgs tex)
		{
			Application_Exception(tex.Exception);
		}

		private static void Application_Exception(Exception ex)
		{
			// Only log the exception if it has not already been logged
			BaseException bex = ex as BaseException;            
			if(bex != null && bex.IsExceptionAlreadyLogged)
			{
				BaseMessageBox.Show(ex.Message);
			}
            // Only show Unexpected Error message if it has not already been shown
			else if(unexpectedErrorHasBeenShown == false)
			{
				BaseLogger.LogFormUnhandledException(ex);
                string exceptionMessage = "StatTrac has reached an unexpected error and will close.\n";
                exceptionMessage += "Any unsaved data will be lost." + Environment.NewLine + Environment.NewLine;
                exceptionMessage += "Notify the Help Desk." + Environment.NewLine + Environment.NewLine;
                exceptionMessage += "Error Location: " + ex.TargetSite.Name + Environment.NewLine;
                exceptionMessage += "Error Details: " + ex.Message + Environment.NewLine;
                exceptionMessage += "Date/Time: " + DateTime.Now.ToString();

                BaseMessageBox.ShowError(exceptionMessage);
                unexpectedErrorHasBeenShown = true;
			}
		}
		#endregion

		internal void DataChanged()
		{
			if (!string.IsNullOrEmpty(BaseManagerControlKey))
			{
				Control[] foundControls = Controls.Find(BaseManagerControlKey, true);
				if (foundControls.Length == 1)
				{
					BaseManagerControl baseManagerControl = foundControls[0] as BaseManagerControl;
					if (baseManagerControl != null)
					{
						baseManagerControl.ChangeButtonToSave();
					}
				}
			}
		}

		internal string BaseManagerControlKey;

        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            // BaseForm
            // 
            this.ClientSize = new System.Drawing.Size(292, 273);
            this.Name = "BaseForm";
            this.ResumeLayout(false);

        }
        
	}
}
