using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.ServiceProcess;

namespace Statline.StatTrac.StatRespond.Windows.Service
{
    [RunInstaller(true)]
    public partial class StatRespondInstaller : Installer
    {
        public StatRespondInstaller()
        {            
            string serviceName = "StatRespond"; // this.Context.Parameters["serviceName"];

            // This call is required by the Designer.
            InitializeComponent();
            ServiceProcessInstaller spi = new ServiceProcessInstaller();
            spi.Account = ServiceAccount.LocalSystem;
            //.User;
            //spi.Username = null;
            //spi.Password = null;
            
            ServiceInstaller si = new ServiceInstaller();
            si.ServiceName = serviceName;
            si.Description = serviceName + ".Net Windows Service";
            si.StartType = ServiceStartMode.Automatic;

            
            Installers.AddRange(new Installer[] { spi, si });



        }
    }
}