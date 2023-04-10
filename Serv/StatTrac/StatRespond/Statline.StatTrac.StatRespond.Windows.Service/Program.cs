using System.Collections.Generic;
using System.ServiceProcess;
using System.Text;
using System;
using System.Reflection;

namespace Statline.StatTrac.StatRespond.Windows.Service
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main(string[] args)
        {
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[] { new StatRespond() };

            if (Environment.UserInteractive)
            {
                StatRespond respondService = new StatRespond();

                respondService.Start(args);
                Console.ReadLine();
                respondService.RunProcess();
                Console.ReadLine();
                respondService.Stop();
            }
            else
            {

                // More than one user Service may run within the same process. To add
                // another service to this process, change the following line to
                // create a second service object. For example,
                //
                //   ServicesToRun = new ServiceBase[] {new Service1(), new MySecondUserService()};

                ServiceBase.Run(ServicesToRun);
            }
        }

    }
}