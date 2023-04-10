using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace Registry.Common.Util
{
    public class RegistryLogger
    {
        #region Fields
        private static LogWriter logWriter;
        private readonly LogEntry logEntry;
        private readonly Dictionary<string, object> extendedProperties;
        #endregion

        #region Constructor
        private RegistryLogger(string userName)
        {
            logEntry = new LogEntry();
            logEntry.Categories.Add("Registry");
            logEntry.Priority = 3;
            logEntry.Title = "Registry";
            logEntry.AppDomainName = userName;
            logEntry.ProcessName = "";
            logEntry.Win32ThreadId = "";
            extendedProperties = new Dictionary<string, object>();
        }

        public static RegistryLogger CreateInstance(string userName)
        {
            if (logWriter == null)
            {
                var factory = new DatabaseProviderFactory(new SystemConfigurationSource());
                DatabaseFactory.SetDatabaseProviderFactory(factory, false);
                logWriter = new LogWriterFactory().Create();
            }
            return new RegistryLogger(userName);

        }
        #endregion

        #region Methods
        public void Write(Exception ex)
        {
            logEntry.Message = ex.Message;
            AddException(ex, 0);
            logEntry.ExtendedProperties = extendedProperties;
            logWriter.Write(logEntry);
        }

        public void Write(string message)
        {
            logEntry.Message = message;
            logEntry.ExtendedProperties = extendedProperties;
            logWriter.Write(logEntry);
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
                AddExtendedProperties("Message[" + level + "]", ex.Message);
                AddExtendedProperties("StackTrace[" + level + "]", ex.StackTrace);
                AddExtendedProperties("TargetSite[" + level + "]", ex.TargetSite);
                var exception = ex as SqlException;

                if (exception != null)
                {
                    SqlException sqlEx = exception;
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
                AddException(ex.InnerException, level + 1);
            }
        }

        private string GetSafeXml(string str)
        {
            if (string.IsNullOrEmpty(str))
                return string.Empty;

            return str.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;");
        }

        #endregion
    }
}
