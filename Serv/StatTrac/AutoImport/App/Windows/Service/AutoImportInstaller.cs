using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.ServiceProcess;

namespace Statline.StatTrac.AutoImport.Windows.Service
{
    [RunInstaller(true)]
    public partial class AutoImportInstaller : Installer
    {
        public AutoImportInstaller()
        {
            string serviceName = "AutoImport"; // this.Context.Parameters["serviceName"];

            // This call is required by the Designer.
            InitializeComponent();
            ServiceProcessInstaller spi = new ServiceProcessInstaller();
            //spi.Account = ServiceAccount.LocalService;
            //.User;
            spi.Username = null;
            spi.Password = null;

            ServiceInstaller si = new ServiceInstaller();
            si.ServiceName = serviceName;

            si.StartType = ServiceStartMode.Automatic;

            Installers.AddRange(new Installer[] { spi, si });
        }
    }
}