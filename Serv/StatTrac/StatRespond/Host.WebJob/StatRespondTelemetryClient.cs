using Microsoft.ApplicationInsights;
using Microsoft.ApplicationInsights.DataContracts;
using Microsoft.ApplicationInsights.Extensibility;
using System;
using System.Collections.Generic;
using System.Configuration;

namespace Statline.StatTrac.StatRespond.Host.WebJob
{
    public static class StatRespondTelemetryClient
    {
        public static TelemetryClient Initialize()
        {
            // Read appsettings from config
            var connString = ConfigurationManager.AppSettings["ApplicationInsights.ConnectionString"];
            var appName = ConfigurationManager.AppSettings["Application.Name"];

            // Create our configuration object and set our connection string
            TelemetryConfiguration configuration = TelemetryConfiguration.CreateDefault();
            configuration.ConnectionString = connString;

            // Create our telemetry client object and set our application name
            TelemetryClient tc = new TelemetryClient(configuration);
            tc.Context.Cloud.RoleName = appName;

            return tc;
        }
        public static void TrackExceptionWithFlush(this TelemetryClient input, Exception ex, string message = null)
        {
            // Check to see if message is available
            if (string.IsNullOrEmpty(message))
            {
                // No message
                input.TrackException(ex);
            }
            else
            {
                // Message is available so use it
                var properties = new Dictionary<string, string>
                    {
                        { "Details", message}
                    };
                input.TrackException(ex, properties);
            }
            input.Flush();
        }
        public static void TrackExceptionWithFlush(this TelemetryClient input, string message)
        {
            var exceptionTelemetry = new ExceptionTelemetry(new Exception(message));
            input.TrackException(exceptionTelemetry);
            input.Flush();
        }
        public static void TrackTraceWithFlush(this TelemetryClient input, string message)
        {
            input.TrackTrace(message);
            input.Flush();
        }
    }
}
