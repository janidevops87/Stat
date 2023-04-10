using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Framework.Transformation.Connection;

namespace Statline.Framework
{
	public class BaseLogger
	{
		#region Fields
		private static LogWriter logWriter;
		private LogEntry logEntry;
		private Dictionary<string, object> extendedProperties;
		#endregion

		#region Constructor
		private BaseLogger()
		{
			logEntry = new LogEntry();
			logEntry.Categories.Add("Logging");
			logEntry.Priority = 3;
			// only show this if BaseIdentity is set
			if (Thread.CurrentPrincipal.Identity is BaseIdentity)
			{
				logEntry.Title = BaseIdentity.CurrentIdentity.Title;
				logEntry.AppDomainName = BaseIdentity.CurrentIdentity.AppDomainName;
				logEntry.ProcessName = BaseIdentity.CurrentIdentity.ProcessName;
				logEntry.Win32ThreadId = BaseIdentity.CurrentIdentity.Win32ThreadId;
			}
			extendedProperties = new Dictionary<string, object>();
		}

		public static BaseLogger CreateInstance(string transformText)
		{
			if (logWriter == null)
			{                
                logWriter = new LogWriterFactory(new TransformSqlConnection().UpdatePasswordConnectionString("Logging", transformText)).Create();
            }
			return new BaseLogger();

		}
		#endregion

		#region Methods
		public void Write(Exception ex)
		{
			logEntry.Message = ex.Message;
			// only show this if BaseIdentity is set
			if (Thread.CurrentPrincipal.Identity is BaseIdentity)
			{
				BaseIdentity.CurrentIdentity.AddLogProperties(this);
			}
			AddException(ex, 0);
			logEntry.ExtendedProperties = extendedProperties;
			logWriter.Write(logEntry);
		}

		public void Write(string message)
		{
			logEntry.Message = message;
			// only show this if BaseIdentity is set
			if (Thread.CurrentPrincipal.Identity is BaseIdentity)
			{
				BaseIdentity.CurrentIdentity.AddLogProperties(this);
			}
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

				if (ex is BaseException)
				{
					BaseException bex = (BaseException)ex;
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
		#endregion
	}
}
