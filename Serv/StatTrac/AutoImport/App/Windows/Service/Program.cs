using System.Collections.Generic;
using System.ServiceProcess;
using System.Text;
using System;

namespace Statline.StatTrac.AutoImport.Windows.Service
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main(string[] args)
        {
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[] { new AutoImport() };

            if (Environment.UserInteractive)
            {
                AutoImport importService = new AutoImport();

                importService.Start(args);
                Console.ReadLine();
                importService.RunProcess();
                Console.ReadLine();
                importService.Stop();
            }
            else
            {

                // More than one user Service may run within the same process. To add
                // another service to this process, change the following line to
                // create a second service object. For example,
                //
                //   ServicesToRun = new ServiceBase[] {new Service1(), new MySecondUserService()};
                //

                ServiceBase.Run(ServicesToRun);
            }
        }
    }
}