using System;
using System.Collections.Generic;
using System.Text;
using System.Timers;
using Statline.Configuration;
using System.ServiceProcess;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using System.Diagnostics;

namespace Statline.Service
{
  
    /// <summary>
    /// This interface will be used by any Windows Service created for Statline Applications.
    /// All services use a timer and service name.
    /// </summary>
    public abstract class Base : ServiceBase
    {
        #region fields Note: not on private
        /// <summary> 
        /// Required designer variable.
        /// </summary>
        private Timer serviceTimer = null;
        /// <summary>
        /// Sets the name of the service in the Services screen of the system
        /// </summary>
        private string serviceName = String.Empty;
        /// <summary>
        /// Used to set a value indicating how often the serivce will run.
        /// </summary>
        /// <remarks>
        /// <P>To calculate the time interval multiply the value by 60.</P>
        /// <P>A value 1.0 will cause the service to run every minute</P>
        /// <P>0.25 will run the service every 15 seconds</P>
        /// </remarks>
        private double timerSetting = new double();
        /// <summary>
        /// Used to determine if the service should shut itself down.
        /// </summary>
        private DateTime lastErrorOccuredAt = DateTime.Now;
        private const int DEFAULTSIXTYSECONDS = 60;
        #endregion
        public Base()
        {
            serviceName = ApplicationSettings.GetSetting(SettingName.ApplicationName);
            timerSetting = Convert.ToDouble(ApplicationSettings.GetSetting(SettingName.ServiceTimer));
            ServiceName = serviceName;
        }

        protected override void OnStart(string[] args)
        {
            //report the service is starting
            
            string loggerString = "The " + serviceName + " process has started on " + System.Windows.Forms.SystemInformation.ComputerName;
            Logger.Write(
                loggerString,
                Category.Notify.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Information);
            
            SetTimer();

        }

        protected override void OnStop()
        {
            serviceTimer.Stop();
        }
        /// <summary>
        /// sets and starts the timer
        /// </summary>
        /// <list type="number">
        ///		<listheader> List of items accomplished</listheader>
        ///		<item>Sets and starts the services timer interval</item>
        ///		<item>Logs the timer interval in seconds to the database log</item>
        ///		<item>Sets the Service name</item>
        /// </list>
        private void SetTimer()
        {
            serviceTimer = new Timer();
            serviceTimer.Interval = (timerSetting) * 60 * 1000;
            Logger.Write("service.Interval: " + (serviceTimer.Interval / 60 / 1000).ToString(), Category.Information.ToString(), Convert.ToInt32(Priority.Default));
            Logger.Write("serviceName: " + serviceName, Category.Information.ToString(), Convert.ToInt32(Priority.Default));
            serviceTimer.Start();

            serviceTimer.Elapsed += new ElapsedEventHandler(serviceTimer_Elapsed);
        }
        #region event

        /// <summary>
        /// Event called based on the timer interval
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void serviceTimer_Elapsed(object sender, ElapsedEventArgs e)
        {
            serviceTimer.Stop();

            try
            {
                RunProcess();
            }
            catch
            {
                throw;
            }

            serviceTimer.Start();
        }
        /// <summary>
        /// Determines if service should fail or should allow one failure in a minute before failing
        /// </summary>
        /// <param name="ex"></param>
        public void CheckFailService(Exception ex)
        {
            if (FailService(DEFAULTSIXTYSECONDS))
            {
                string loggerString = "The " + serviceName + " has failed please restart the service on " + System.Windows.Forms.SystemInformation.ComputerName;
                Logger.Write(
                    loggerString,
                    Category.Notify.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);

                Logger.Write(ex, Category.Error.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);

                // this causes the service to stop. The Server can restart from this stop.
                // The service cannot Call Stop() because this is a normal stop
                Environment.Exit(99);

            }
            else
                lastErrorOccuredAt = DateTime.Now;
        }
        public void CheckFailService(Exception ex, int secondsBetweenErrors)
        {
            if (FailService(secondsBetweenErrors))
            {
                string loggerString = "The " + serviceName + " has failed please restart the service on " + System.Windows.Forms.SystemInformation.ComputerName;
                Logger.Write(
                    loggerString,
                    Category.Notify.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);

                Logger.Write(ex, Category.Error.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);

                // this causes the service to stop. The Server can restart from this stop.
                // The service cannot Call Stop() because this is a normal stop
                Environment.Exit(99);

            }
            else
                lastErrorOccuredAt = DateTime.Now;
        }

        private bool FailService(int secondsBetweenErrors)
        {
            //get the current time to compare to the last time an error was thrown.
            DateTime currentTime = DateTime.Now;
            bool result = false;
            //compare the last time an error was thrown to the current time. If more than one
            //error has happened within a minute than stop the service.
            if (currentTime.Subtract(lastErrorOccuredAt).Seconds < secondsBetweenErrors)
                result = true;            
            else
                lastErrorOccuredAt = DateTime.Now;
            return result;

        }
        /// <summary>
        /// This is implementd by the inheriting class to run the service process.
        /// </summary>
        public abstract void RunProcess();
        public abstract void Start(string[] args);
        public abstract void Stop();
        #endregion
    }
}
