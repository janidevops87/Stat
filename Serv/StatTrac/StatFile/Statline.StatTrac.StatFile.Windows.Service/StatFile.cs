using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Service;
using System;
using System.Diagnostics;


namespace Statline.StatTrac.StatFile.Windows.Service
{
    public partial class StatFile : Base
    {
        public StatFile()
        {
            InitializeComponent();
        }

              
        public override void RunProcess()
        {
            try
            {

                AutoProcess ap = new AutoProcess(fileOutput: new LocalFileOutput());
                
                if(ap != null)
                      ap.Process();
                else
                    Logger.Write("StatFile Error: Cannot run the service!", Category.Error.ToString(), Convert.ToInt32(Priority.Default));
            }
            catch (Exception ex)
            {
                int secondsBetweenErrors = 0;
                CheckFailService(ex, secondsBetweenErrors);
            }


        }

        public override void Start(string[] args)
        {
            //report the service is starting

            string loggerString = "StatFile Service: started on " + Environment.MachineName;
            Logger.Write(
                loggerString,
                Category.Information.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Information);
            EventLog.WriteEntry("StatFile", loggerString);

            base.OnStart(args);
        }
        public override void Stop()
        {
            base.OnStop();
        }
    }
}
