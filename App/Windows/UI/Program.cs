using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Threading;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.UI
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            //Application.EnableVisualStyles();
            Application.ThreadException += HandleThreadException;
            Application.SetUnhandledExceptionMode(UnhandledExceptionMode.ThrowException);
            AppDomain.CurrentDomain.UnhandledException += HandleUnhandledException;
            Application.SetCompatibleTextRenderingDefault(false);

            //Application.Run(new TestForm());

            LogOnForm loginForm = new LogOnForm();
            Application.Run(loginForm);

            // Run the Secure form only if the user is authenticated
            if (loginForm.IsAuthenticated)
            {
                if (loginForm != null)
                {
                    loginForm.Dispose();
                }

                var trackEventMessage = "StatTrac Login Authenticated for " + Environment.UserName 
                    + " using version " + Application.ProductVersion;
                Telemetry.TrackEvent(trackEventMessage);

                Application.Run(new SecureForm());
            }
        }

        private static void HandleUnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            //Logs exceptions that came up outside of a try/catch block
            var exMessage = ((Exception) e.ExceptionObject).Message;
            var ex = new Exception("StatTrac Unhandled Exception: " + exMessage, (Exception) e.ExceptionObject);
            try
            {
                StatTracLogger.CreateInstance().Write(ex);
                Telemetry.TrackException(ex.InnerException);
            }
            catch (Exception exception)
            {
                //Swallow error
            }
        }

        private static void HandleThreadException(object sender, ThreadExceptionEventArgs  e)
        {
            //Logs exceptions that came from unmanaged code
            var exMessage = ((Exception)e.Exception).Message;
            var ex = new Exception("StatTrac Thread Exception: " + exMessage, (Exception)e.Exception);
            try
            {
                StatTracLogger.CreateInstance().Write(ex);
                Telemetry.TrackException(ex.InnerException);
            }
            catch (Exception exception)
            {
                //Swallow error
            }
        }
    }
}