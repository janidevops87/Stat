using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.ServiceProcess;

namespace Statline.StatTrac.StatFile.Windows.Service
{
    [RunInstaller(true)]
    public partial class StatFileInstaller : Installer
    {
        public StatFileInstaller()
        {
            
            string serviceName = "StatFile"; // this.Context.Parameters["serviceName"];

            // This call is required by the Designer.
            InitializeComponent();
            ServiceProcessInstaller spi = new ServiceProcessInstaller();
            //spi.Account = ServiceAccount.LocalSystem;
            //.User;
            //spi.Username = null;
            //spi.Password = null;
            spi.Account = ServiceAccount.LocalSystem;

            ServiceInstaller si = new ServiceInstaller();
            si.ServiceName = serviceName;

            si.StartType = ServiceStartMode.Automatic;

            Installers.AddRange(new Installer[] { spi, si });

        }
    }
}