using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.ServiceProcess;
using System.Text;
using System.Timers;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.StatTrac.AutoImport.Configuration;
using Timer = System.Timers.Timer;
using Statline.Service;


namespace Statline.StatTrac.AutoImport.Windows.Service
{

    /// <summary>
    /// This service calls the Statline.StatTrac.AutoImpor.MapiHelper.ProcessEmails method on a times basis
    /// </summary>
    /// <remarks>
    /// <P>Name: AutoImportService</P>
    /// <P>Date Created: 4/17/07</P>
    /// <P>Created By: Bret Knoll</P>
    /// <P>Version: 1.0</P>
    /// <P>Task: Check DonorNet emails on a regular basis</P>
    /// </remarks>
    partial class AutoImport : Base
    {
        #region class objects
        /// <summary>
        /// Used to determine if the service should shut itself down.
        /// </summary>
        private DateTime lastErrorOccuredAt = DateTime.Now;
        private Exception serviceException;
        #endregion

        public AutoImport()
        {

            //
            //components = new System.ComponentModel.Container();
            // This call is required by the Windows.Forms Component Designer.
            InitializeComponent();

        }
      

        public override void RunProcess()
        {
            try
            {
                string userName = ApplicationSettings.GetSetting(SettingName.EmailUserName);
                string password = ApplicationSettings.GetSetting(SettingName.EmailPassword);
                string domain = ApplicationSettings.GetSetting(SettingName.ActiveDirectoryDomain);
                string webServiceURL = ApplicationSettings.GetSetting(SettingName.WebServiceURL);

                ExchangeWSHelper ws = new ExchangeWSHelper(userName, password, domain, webServiceURL);

                if (ws != null)
                    ws.ProcessEmails();
                else
                    Logger.Write("The AutoImport Service cannot connect to Exchange!", Category.Error.ToString(), Convert.ToInt32(Priority.Default));
            }
            catch (Exception ex)
            {                
                CheckFailService(ex);
            }
        }

        public override void Start(string[] args)
        {
            base.OnStart(args);
        }
        public override void Stop()
        {
            base.OnStop();
        }
    }
}
