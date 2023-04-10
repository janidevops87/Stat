using Microsoft.ApplicationInsights;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.StatTrac.AutoImport.Configuration;
using System;
using System.Diagnostics;


namespace Statline.StatTrac.AutoImport.Host.WebJob
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
    partial class AutoImport
    {
        private static readonly TelemetryClient tc = AutoImportTelemetryClient.Initialize();

        public void RunProcess()
        {
            tc.TrackTraceWithFlush("AutoImport Started");

            try
            {
                string userName = ApplicationSettings.GetSetting(SettingName.EmailUserName);
                string password = ApplicationSettings.GetSetting(SettingName.EmailPassword);
                string webServiceURL = ApplicationSettings.GetSetting(SettingName.WebServiceURL);

                ExchangeWSHelper ws = new ExchangeWSHelper(userName, password, webServiceURL);

                if (ws != null)
                    ws.ProcessEmails();
                else
                    Logger.Write("The AutoImport Service cannot connect to Exchange!", Category.Error.ToString(), Convert.ToInt32(Priority.Default));
            }
            catch (Exception ex)
            {
                LogError(ex);
                throw;
            }
        }

        // TODO: Move to a common base class.
        private void LogError(Exception ex)
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
