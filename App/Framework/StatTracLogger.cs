using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Reflection;
using System.Threading;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace Statline.Stattrac.Framework
{
    // Why Keep Both StatTracLogger and BaseLogger
    // Intent was to replace StatTrac logging in a phased approach where we keep 
    // the old logging and have it run alongside the new logging at the same time.

	public class StatTracLogger
	{
		#region Fields
		private static LogWriter logWriter;
		private LogEntry logEntry;
		private Dictionary<string, object> extendedProperties;
        #endregion

        #region Constructor
        private StatTracLogger()
        {
            logEntry = new LogEntry();
            logEntry.Categories.Add("StatTrac");
            logEntry.Priority = 3;
            // only show this if Identity is set
            if (Thread.CurrentPrincipal.Identity is StatTracIdentity)
			{
				logEntry.Title = StatTracIdentity.CurrentIdentity.Title;
				logEntry.AppDomainName = StatTracIdentity.CurrentIdentity.AppDomainName;
				logEntry.ProcessName = StatTracIdentity.CurrentIdentity.ProcessName;
				logEntry.Win32ThreadId = StatTracIdentity.CurrentIdentity.Win32ThreadId;
			}
			extendedProperties = new Dictionary<string, object>();
		}

		public static StatTracLogger CreateInstance()
		{
			if (logWriter == null)
			{
				logWriter = EnterpriseLibraryContainer.Current.GetInstance<LogWriter>();
			}
			return new StatTracLogger();

		}
		#endregion

		#region Methods
		public void Write(Exception ex, TraceEventType severity = TraceEventType.Error)
        {
            logEntry.Severity = severity;
            logEntry.Priority = Convert.ToInt32(severity);
            logEntry.Message = GetExceptionMessageDetails(ex, false);            
            // only show this if Identity is set
            if (Thread.CurrentPrincipal.Identity is StatTracIdentity)
			{
                StatTracIdentity.CurrentIdentity.AddLogProperties(this);
			}
			AddException(ex, 0);
			logEntry.ExtendedProperties = extendedProperties;
			logWriter.Write(logEntry);

            //Make sure we have an exception that needs to be logged
            if (logEntry.Severity <= TraceEventType.Error 
                && logEntry.ToString().ToLower().Contains("stacktrace"))
            {
                WriteExceptionToLocalEventLog(logEntry);
            }            
        }

		public void AddExtendedProperties(string key, object value)
		{
			if (!extendedProperties.ContainsKey(key) && value != null && !string.IsNullOrEmpty(value.ToString()))
			{
				extendedProperties.Add(key, GetSafeXml(value.ToString()));
			}
		}
		#endregion

		#region Private Methods
		private void AddException(Exception ex, int level)
		{
			if (ex != null && extendedProperties != null)
            {
                //Build Sql Details
                string sqlDetails = string.Empty;
                if (ex.GetType().GetProperty("Data") != null
                    && ex.Data != null
                    && ex.Data.Count > 0)
                {
                    if (ex.Data.Contains("ConnectionString"))
                    {
                        sqlDetails += "(ConnectionString=\"" + ex.Data["ConnectionString"].ToString() + "\")";
                    }
                    if (ex.Data.Contains("SQLStatement"))
                    {
                        sqlDetails += "(SqlStatement=\"" + ex.Data["SQLStatement"].ToString() + "\")";
                    }
                    if (ex.Data.Contains("AttemptNumber"))
                    {
                        sqlDetails += "(AttemptNumber=\"" + ex.Data["AttemptNumber"].ToString() + "\")";
                    }
                }

                AddExtendedProperties("Message[" + level + "]", GetExceptionMessageDetails(ex));
                AddExtendedProperties("StackTrace[" + level + "]", ex.StackTrace + sqlDetails);
				AddExtendedProperties("TargetSite[" + level + "]", ex.TargetSite);

				if (ex is StatTracException)
				{
                    StatTracException bex = (StatTracException)ex;
					foreach (var item in bex.ExceptionList)
					{
						AddExtendedProperties(item.Key, item.Value);
					}
				}

				if (ex is SqlException)
				{
					SqlException sqlEx = (SqlException)ex;
					AddExtendedProperties("SqlErrorCode[" + level + "]", sqlEx.ErrorCode);
					for (int index = 0; index < sqlEx.Errors.Count; index++)
					{
						AddExtendedProperties("SqlErrors[" + level + "," + index + "].Class", sqlEx.Errors[index].Class);
						AddExtendedProperties("SqlErrors[" + level + "," + index + "].LineNumber", sqlEx.Errors[index].LineNumber);
						AddExtendedProperties("SqlErrors[" + level + "," + index + "].Message", sqlEx.Errors[index].Message);
						AddExtendedProperties("SqlErrors[" + level + "," + index + "].Number", sqlEx.Errors[index].Number);
						AddExtendedProperties("SqlErrors[" + level + "," + index + "].Procedure", sqlEx.Errors[index].Procedure);
						AddExtendedProperties("SqlErrors[" + level + "," + index + "].Server", sqlEx.Errors[index].Server);
						AddExtendedProperties("SqlErrors[" + level + "," + index + "].Source", sqlEx.Errors[index].Source);
						AddExtendedProperties("SqlErrors[" + level + "," + index + "].State", sqlEx.Errors[index].State);
                    }
				}

                if (logEntry.Severity <= TraceEventType.Error && ex.StackTrace is null)
                {
                    //If we have no stack trace, let's create a list of calling Classes/Methods
                    StackTrace stackTrace = new StackTrace();
                    short callingMethodsFound = 0;

                    for (int thisFrameID = 0; thisFrameID < stackTrace.FrameCount; thisFrameID++)
                    {
                        MethodBase methodBase = stackTrace.GetFrame(thisFrameID).GetMethod();
                        if (methodBase.DeclaringType.Name != nameof(StatTracLogger))
                        {
                            callingMethodsFound++;
                            AddExtendedProperties("CalledBy[" + callingMethodsFound + "]", methodBase.DeclaringType.Name + "." + methodBase.Name);
                        }

                        //Break when we have 3 calling methods
                        if (callingMethodsFound == 3)
                        {
                            break;
                        }
                    }
                }

                AddException(ex.InnerException, level + 1);
			}
		}

		private string GetSafeXml(string str)
		{
			if (string.IsNullOrEmpty(str))
				return string.Empty;
			else
				return str.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;");
        }

        private string GetExceptionMessageDetails(Exception e, Boolean includeCallId = true)
        {
            //Get class name
            string exClass = string.Empty;
            if (e.GetType().GetProperty("InnerException") != null
                && e.InnerException != null
                && e.InnerException.GetType().GetProperty("TargetSite") != null
                && e.InnerException.TargetSite != null
                && e.InnerException.TargetSite.GetType().GetProperty("ReflectedType") != null
                && e.InnerException.TargetSite.ReflectedType != null
                && e.InnerException.TargetSite.ReflectedType.GetType().GetProperty("Name") != null
                && e.InnerException.TargetSite.ReflectedType.Name != null)
            {
                exClass = e.InnerException.TargetSite.ReflectedType.Name;
            }
            else if (e.GetType().GetProperty("TargetSite") != null
                && e.TargetSite != null
                && e.TargetSite.GetType().GetProperty("ReflectedType") != null
                && e.TargetSite.ReflectedType != null
                && e.TargetSite.ReflectedType.GetType().GetProperty("Name") != null)
            {
                exClass = e.TargetSite.ReflectedType.Name;
            }

            //Get method name
            string exMethod = string.Empty;
            if (e.GetType().GetProperty("InnerException") != null
                && e.InnerException != null
                && e.InnerException.GetType().GetProperty("TargetSite") != null
                && e.InnerException.TargetSite != null
                && e.InnerException.TargetSite.GetType().GetProperty("Name") != null
                && e.InnerException.TargetSite.Name != null)
            {
                exMethod = e.InnerException.TargetSite.Name;
            }
            else if (e.GetType().GetProperty("TargetSite") != null
                && e.TargetSite != null
                && e.TargetSite.GetType().GetProperty("Name") != null
                && e.TargetSite.Name != null)
            {
                exMethod = e.TargetSite.Name;
            }

            //Build MessageDetails
            string exMessage = e.Message;
            if (!exMessage.StartsWith("StatTrac"))
            {
                exMessage = "StatTrac Exception: " + exMessage;
            }
            if (!string.IsNullOrEmpty(exClass) || !string.IsNullOrEmpty(exMethod))
            {
                exMessage += "  ";
            }
            if (!string.IsNullOrEmpty(exClass))
            {
                exMessage += exClass;
            }
            if (!string.IsNullOrEmpty(exClass) && !string.IsNullOrEmpty(exMethod))
            {
                exMessage += ".";
            }
            if (!string.IsNullOrEmpty(exMethod))
            {
                exMessage += exMethod;
            }
            //Add callid
            if (includeCallId && SessionDetails.callId != null)
            {
                exMessage += " CallID:" + SessionDetails.callId;
            }

            return exMessage;
        }

        private void WriteExceptionToLocalEventLog(LogEntry logEntry)
        {
            //Save exception details in the local event log
            using (EventLog eventLog = new EventLog("Application"))
            {
                eventLog.Source = "StatTrac";
                //try writing to event log (use try/catch block in-case there's a security exception)
                try
                {
                    eventLog.WriteEntry(logEntry.ToString(), EventLogEntryType.Error, Convert.ToInt32(logEntry.ProcessId), 0);
                }
                catch (Exception)
                {
                    //swallow error
                }
            }
        }
        #endregion
    }
}
