using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using System.Globalization;
using Statline.Stattrac.Constant;
using System.Collections;
using System.Windows.Forms;
using System.Diagnostics;

namespace Statline.Stattrac.Framework
{
    public enum LoggingCategories
    { 
        StatTrac,
        ClientServicesNotification,
        IssueReportComment
    }
	public sealed class BaseLogger
	{
		private BaseLogger(){}

		#region Debug Methods
		[Conditional("DEBUG")]
		internal static void LogSqlScript(BaseCommand cmdSelect)
		{
			StringBuilder sb = new StringBuilder();
			sb.Append("\nEXEC " + cmdSelect.command.CommandText + "\n");

			IDataParameterCollection parameterCollection = cmdSelect.command.Parameters;
			for (int i = 0; i < parameterCollection.Count; i++)
			{
				SqlParameter param = (SqlParameter)parameterCollection[i];
				sb.Append(param.ParameterName + "='");
				if (param.DbType == DbType.Boolean)
				{
					if (((bool)param.Value) == true)
						sb.Append("1'");
					else
						sb.Append("0'");
				}
				else
				{
					sb.Append(param.Value + "'");
				}
				// If this is not the last parameter then add a comma
				if (i < parameterCollection.Count - 1)
				{
					sb.Append(",\n");
				}
			}

			try
			{
				string file = Application.StartupPath + "/SqlScript.sql";
				FileStream stream = new FileStream(file, FileMode.Append, FileAccess.Write);
				StreamWriter sw = new StreamWriter(stream);
				sw.Write(sb.ToString());
				sw.Close();
				stream.Close();
			}
			catch (Exception)
			{
				// We wnat to eat any exception that we get trying to log the exception
			}
		}

		[Conditional("DEBUG")]
		internal static void LogSqlScript(DataSet dataSet, string tableName, BaseCommand baseCommand, DataRowState state)
		{
			StringBuilder sb = new StringBuilder();

			bool currentEnforceConstraints = dataSet.EnforceConstraints;
			dataSet.EnforceConstraints = false; // This removes the Foreign Key Checks
			DataSet dsChanges = dataSet.GetChanges(state);

			if ((dsChanges != null) && (state != DataRowState.Deleted))
			{
				for (int j = 0; j < dsChanges.Tables[tableName].Rows.Count; j++)
				{
					sb = new StringBuilder("\nEXEC " + baseCommand.command.CommandText + "\n");
					SqlParameterCollection coll = (SqlParameterCollection)baseCommand.command.Parameters;
					for (int i = 0; i < coll.Count; i++)
					{
						if (coll[i].SourceColumn == "") // When the value is Directy bound. ex. CaseId
						{
							if (coll[i].Value == DBNull.Value)
							{
								sb.Append(coll[i].ParameterName + "=null");
							}
							else if (coll[i].Value is Boolean)
							{
								if (((bool)coll[i].Value) == true)
									sb.Append(coll[i].ParameterName + "='1'");
								else
									sb.Append(coll[i].ParameterName + "='0'");
							}
							else
							{
								sb.Append(coll[i].ParameterName + "='" + coll[i].Value.ToString() + "'");
							}
						}
						else // When the value is from the dataSet
						{
							object thisValue = dsChanges.Tables[tableName].Rows[j][coll[i].SourceColumn];

							if (thisValue == DBNull.Value)
							{
								sb.Append(coll[i].ParameterName + "=null");
							}
							else if (thisValue is Boolean)
							{
								if (((bool)thisValue) == true)
									sb.Append(coll[i].ParameterName + "='1'");
								else
									sb.Append(coll[i].ParameterName + "='0'");
							}
							else
							{
								sb.Append(coll[i].ParameterName + "='" + dsChanges.Tables[tableName].Rows[j][coll[i].SourceColumn] +
									"'");
							}
						}

						// If this is not the last parameter then add a comma
						if (i < coll.Count - 1)
						{
							sb.Append(",\n");
						}
					}
				}
			}
			dataSet.EnforceConstraints = currentEnforceConstraints; // Re-enable the Constraint

			try
			{
				string file = Application.StartupPath + "/SqlScript.sql";
				FileStream stream = new FileStream(file, FileMode.Append, FileAccess.Write);
				StreamWriter sw = new StreamWriter(stream);
				sw.Write(sb.ToString());
				sw.Close();
				stream.Close();
			}
			catch (Exception)
			{
				// We wnat to eat any exception that we get trying to log the exception
			}
		} 
		#endregion

		internal static void LogBaseBrException(Exception ex, DataSet dataSet, string messagePrefix = "")
		{
			LogEntry logEntry = new LogEntry();
			logEntry.EventId = 100;
			logEntry.Priority = 1;
			logEntry.Message = messagePrefix + ex.Message;
			logEntry.ExtendedProperties.Add("dataSet", dataSet.GetXml());
			LogInnerException(logEntry, ex, 0);
			Logger.Write(logEntry);
		} 

		internal static void LogBaseDaSaveException(Exception ex, System.Data.DataSet dataSet, string tableName, BaseCommand command,
			System.Data.DataRowState dataRowState)
		{
			StringBuilder sb = new StringBuilder();
			DataTable dtChanges = dataSet.Tables[tableName].GetChanges(dataRowState);

			if ((dtChanges != null) && (dataRowState != DataRowState.Deleted))
			{
				for (int j = 0; j < dtChanges.Rows.Count; j++)
				{
					sb = new StringBuilder("EXEC " + command.command.CommandText + " ");
					SqlParameterCollection coll = (SqlParameterCollection)command.command.Parameters;
					for (int i = 0; i < coll.Count; i++)
					{
						if (string.IsNullOrEmpty(coll[i].SourceColumn)) // When the value is Directy bound. ex. CaseId
						{
							if (coll[i].Value == DBNull.Value)
							{
								sb.Append(coll[i].ParameterName + "=null");
							}
							else if (coll[i].Value is Boolean)
							{
								if (((bool)coll[i].Value) == true)
									sb.Append(coll[i].ParameterName + "='1'");
								else
									sb.Append(coll[i].ParameterName + "='0'");
							}
							else
							{
								sb.Append(coll[i].ParameterName + "='" + coll[i].Value.ToString() + "'");
							}
						}
						else // When the value is from the dataSet
						{
							object thisValue = dtChanges.Rows[j][coll[i].SourceColumn];

							if (thisValue == DBNull.Value)
							{
								sb.Append(coll[i].ParameterName + "=null");
							}
							else if (thisValue is Boolean)
							{
								if (((bool)thisValue) == true)
									sb.Append(coll[i].ParameterName + "='1'");
								else
									sb.Append(coll[i].ParameterName + "='0'");
							}
							else
							{
								sb.Append(coll[i].ParameterName + "='" + dtChanges.Rows[j][coll[i].SourceColumn] +
									"'");
							}
						}

						// If this is not the last parameter then add a comma
						if (i < coll.Count - 1)
						{
							sb.Append(",");
						}
					}
					LogBaseDaException(ex, sb.ToString(), command.command.CommandText);
				}
			}
		}

        internal static void LogBaseDaSelectException(Exception ex, string sql, string message)
        {
            LogBaseDaException(ex, sql, message);
        }


        private static void LogBaseDaException(Exception ex, string sql, string spName)
		{
			LogEntry logEntry = new LogEntry();
			logEntry.EventId = 100;
			logEntry.Priority = 1;
			logEntry.Message = spName;
			logEntry.ExtendedProperties.Add("SQL", sql);
			LogInnerException(logEntry, ex, 0);
			Logger.Write(logEntry);            
		}

		public static void LogFormUnhandledException(Exception ex)
		{
			LogEntry logEntry = new LogEntry();
			logEntry.EventId = 100;
			logEntry.Priority = 1;
			logEntry.Message = ex.Message;
			LogInnerException(logEntry, ex, 0);
			Logger.Write(logEntry);
		}

		/// <summary>
		/// Log the exception as well as the vlues of each eac control in the page
		/// </summary>
		/// <param name="ex"></param>
		/// <param name="userControl"></param>
		public static void LogFormUnhandledException(Exception ex, Control control)
		{
			LogEntry logEntry = new LogEntry();
			logEntry.EventId = 100;
			logEntry.Priority = 1;
			logEntry.Message = ex.Message;
			LogControl(logEntry, control);
			LogInnerException(logEntry, ex, 0);
			Logger.Write(logEntry);
		}

		/// <summary>
		/// Log the control and its children
		/// </summary>
		/// <param name="logEntry"></param>
		/// <param name="control"></param>
		private static void LogControl(LogEntry logEntry, Control control)
		{
			for (int index = 0; index < control.Controls.Count; index++)
			{
				try
				{
					logEntry.ExtendedProperties.Add(control.Controls[index].Name, control.Controls[index]);
					LogControl(logEntry, control.Controls[index]);
				}
				catch (Exception)
				{
					// Just ignore any errors since we can live without some extra details
					// We were getting an error that an item with the same key was already added
				}
			}
		}


		#region LoadDataFromUnos Log Methods
		public static void LogLoadDataFromUnosException(Exception ex, string tableName, string columnName)
		{
			LogEntry logEntry = new LogEntry();
			logEntry.EventId = 100;
			logEntry.Priority = 1;
			logEntry.Message = ex.Message + " in Table=" + tableName + " Column=" + columnName;
			LogInnerException(logEntry, ex, 0);
			Logger.Write(logEntry);
		}

		public static void LogLoadDataFromUnosException(Exception ex, string controlId)
		{
			LogEntry logEntry = new LogEntry();
			logEntry.EventId = 100;
			logEntry.Priority = 1;
			logEntry.Message = ex.Message + " for Control=" + controlId;
			LogInnerException(logEntry, ex, 0);
			Logger.Write(logEntry);
		}
		#endregion

		private static void LogInnerException(LogEntry logEntry, Exception ex, int level)
		{
			if (ex != null)
			{
				string strLevel = string.Empty;
				if (level > 0)
				{
					strLevel = "_" + level.ToString(GeneralConstant.CreateInstance().StattracCulture);
				}

				logEntry.ExtendedProperties.Add("Message" + strLevel, ex.Message);
				logEntry.ExtendedProperties.Add("Source" + strLevel, ex.Source);
				logEntry.ExtendedProperties.Add("StackTrace" + strLevel, ex.StackTrace);
				LogInnerException(logEntry, ex.InnerException, level + 1);
			}
		}

		public static void Log(string message, string str)
		{
			LogEntry logEntry = new LogEntry();
			logEntry.EventId = 100;
			logEntry.Priority = 1;
			logEntry.Message = message;
			logEntry.ExtendedProperties.Add("STRING", str);
			Logger.Write(logEntry);
        }

        public static void LogBrowserCapabilities(string message, IDictionary browserCapabilities)
        {
            LogEntry logEntry = new LogEntry();
            logEntry.EventId = 100;
            logEntry.Priority = 1;
            logEntry.Message = message;
            foreach (DictionaryEntry item in browserCapabilities)
            {
                logEntry.ExtendedProperties.Add(item.Key.ToString(), item.Value);
            }
            Logger.Write(logEntry);
        }

        public static void EmailClientServices(string message, LoggingCategories loggingCategory)
        {
            
            Logger.Write(message, loggingCategory.ToString());


        }
	}
}
