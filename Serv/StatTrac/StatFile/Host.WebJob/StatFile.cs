using Microsoft.ApplicationInsights;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Configuration;
using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFile.Host.WebJob
{
    public class StatFile
    {
        private readonly IFileOutput fileOutput;
        private static readonly TelemetryClient tc = StatFileTelemetryClient.Initialize();

        public StatFile(IFileOutput fileOutput)
        {
            this.fileOutput = fileOutput ?? throw new ArgumentNullException(nameof(fileOutput));
        }

        public async Task RunProcessAsync()
        {
            try
            {
                AutoProcess ap = new AutoProcess(fileOutput);
                await ap.ProcessAsync();
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
