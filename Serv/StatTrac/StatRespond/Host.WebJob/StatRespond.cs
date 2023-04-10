using Microsoft.ApplicationInsights;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Configuration;
using Statline.Exchange.Service;
using System;
using System.Diagnostics;

namespace Statline.StatTrac.StatRespond.Host.WebJob
{
    public class StatRespond
    {
        private static readonly TelemetryClient tc = StatRespondTelemetryClient.Initialize();

        public void RunProcess()
        {
            tc.TrackTraceWithFlush("StatRespond Started");

            try
            {
                string userName = ApplicationSettings.GetSetting(SettingName.EmailUserName);
                string password = ApplicationSettings.GetSetting(SettingName.EmailPassword);

                string webServiceURL = ApplicationSettings.GetSetting(SettingName.WebServiceURL);

                ExchangeWSHelper autoProcess = new ExchangeWSHelper(
                    userName,
                    password,
                    webServiceURL);

                autoProcess.ProcessEmails();
            }
            catch (Exception ex)
            {
                LogError(ex);
                throw;
            }
        }

        public void LogError(Exception ex)
        {
            var serviceName = ApplicationSettings.GetSetting(SettingName.ApplicationName);

            string loggerString = "The " + serviceName + " has failed please restart the service on " + Environment.MachineName;

            tc.TrackExceptionWithFlush(ex, loggerString);
            Logger.Write(
                loggerString,
                Category.Notify.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);

            Logger.Write(ex, Category.Error.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);
        }
    }
}
