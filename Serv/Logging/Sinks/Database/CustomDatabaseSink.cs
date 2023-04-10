using System;
using System.Data;
using System.Xml.Serialization;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.Logging.Distributor.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Logging.Sinks;
using Microsoft.Practices.EnterpriseLibrary.Logging.Sinks.Database.Configuration;

namespace Statline.Logging.Sinks.Database
{
	/// <summary>
	/// Summary description for CustomDatabaseSinks.
	/// </summary>
	/// 
	public class CustomDatabaseSink : LogSink
	{
		private DefaultLogDestination defaultSink;
		private LoggingConfigurationView loggingConfigurationView;

		private string databaseInstanceName = String.Empty;
		private string storedProcName = String.Empty;


		/// <summary>
		/// Default constructor
		/// </summary>
		public CustomDatabaseSink()
		{
			defaultSink = new DefaultLogDestination();
		}

	

		/// <summary>
		/// <para>When overridden by a class, initializes the provider with a <see cref="ConfigurationView"/>.</para>
		/// </summary>
		/// <param name="configurationView">
		/// <para>A <see cref="ConfigurationView"/> object.</para>
		/// </param>
		public override void Initialize(ConfigurationView configurationView)
		{
			ArgumentValidation.CheckForNullReference(configurationView, "configurationView");
			ArgumentValidation.CheckExpectedType(configurationView, typeof (LoggingConfigurationView));

			loggingConfigurationView = (LoggingConfigurationView) configurationView;
		}

		/// <summary>
		/// Used by derived classes to implement their specific message sending mechanism.
		/// </summary>
		/// <param name="logEntry">The <see cref="LogEntry"/> to send.</param>
		protected override void SendMessageCore(LogEntry logEntry)
		{
			if (ValidateParameters(logEntry))
			{
				try
				{
					ExecuteStoredProcedure(logEntry);
				}
				catch
				{
					//logEntry.AddErrorMessage(SR.SinkFailure(e.ToString()));
					throw;
				}

			}
		}

		private bool ValidateParameters(LogEntry logEntry)
		{
			bool valid = true;
			DatabaseSinkData test = new DatabaseSinkData();
			CustomDatabaseSinkData databaseSinkData = (CustomDatabaseSinkData)loggingConfigurationView.GetSinkData(ConfigurationName);
			if (databaseSinkData == null)
			{
				valid = false;
			}

			if (databaseSinkData.DatabaseInstanceName == null ||
			    databaseSinkData.DatabaseInstanceName.Length == 0)
			{
				valid = false;
			}

			if (databaseSinkData.StoredProcName == null ||
			    databaseSinkData.StoredProcName.Length == 0)
			{
				valid = false;
			}

			if (!valid)
			{
				//logEntry.AddErrorMessage(SR.DatabaseSinkMissingParameters);
				defaultSink.SendMessage(logEntry);
			}

			return valid;
		}


		private void ExecuteStoredProcedure(LogEntry logEntry)
		{
			DatabaseSinkData databaseSinkData = loggingConfigurationView.GetSinkData(ConfigurationName) as DatabaseSinkData;
			DatabaseProviderFactory factory = new DatabaseProviderFactory(loggingConfigurationView.ConfigurationContext);
			Microsoft.Practices.EnterpriseLibrary.Data.Database db =
				factory.CreateDatabase(databaseSinkData.DatabaseInstanceName);
			DBCommandWrapper cmd = db.GetStoredProcCommandWrapper(databaseSinkData.StoredProcName);

			cmd.AddInParameter("eventID", DbType.Int32, logEntry.EventId);
			cmd.AddInParameter("category", DbType.String, logEntry.Category);
			cmd.AddInParameter("priority", DbType.Int32, logEntry.Priority);
			cmd.AddInParameter("severity", DbType.String, logEntry.Severity.ToString());
			cmd.AddInParameter("title", DbType.String, logEntry.Title);
			cmd.AddInParameter("timestamp", DbType.DateTime, logEntry.TimeStamp);
			cmd.AddInParameter("machineName", DbType.String, logEntry.MachineName);
			cmd.AddInParameter("AppDomainName", DbType.String, logEntry.AppDomainName);
			cmd.AddInParameter("ProcessID", DbType.String, logEntry.ProcessId);
			cmd.AddInParameter("ProcessName", DbType.String, logEntry.ProcessName);
			cmd.AddInParameter("ThreadName", DbType.String, logEntry.ManagedThreadName);
			cmd.AddInParameter("Win32ThreadId", DbType.String, logEntry.Win32ThreadId);
			cmd.AddInParameter("message", DbType.String, logEntry.Message);
			cmd.AddInParameter("formattedmessage", DbType.String, FormatEntry(logEntry));

			db.ExecuteNonQuery(cmd);
		}
	}
}