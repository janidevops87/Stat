using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.ServiceProcess;
using System.Text;
using Statline.Service;
using Statline.Exchange.Service;
using Statline.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace Statline.StatTrac.StatRespond.Windows.Service
{
    public partial class StatRespond : Base
    {
        public StatRespond()
        {
            InitializeComponent();
        }

        public override void RunProcess()
        {
            try
            {
                string userName = ApplicationSettings.GetSetting(SettingName.EmailUserName);
                string password = ApplicationSettings.GetSetting(SettingName.EmailPassword);
                
                string webServiceURL = ApplicationSettings.GetSetting(SettingName.WebServiceURL);

                ExchangeWSHelper autoProcess = new ExchangeWSHelper(
                    userName, 
                    password,                     
                    webServiceURL);

                if (autoProcess != null)
                    autoProcess.ProcessEmails();
                else
                    Logger.Write("StatRespond cannot run the service!", Category.Error.ToString(), Convert.ToInt32(Priority.Default));
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
