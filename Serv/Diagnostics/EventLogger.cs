using System;
using System.ComponentModel;
using System.Collections;
using System.Diagnostics;
using System.Text;

using Statline.Configuration;

namespace Statline.Diagnostics
{
	/// <summary>
	/// Summary description for EventLogger.
	/// </summary>
	public class EventLogger : System.ComponentModel.Component
	{
		private System.Diagnostics.EventLog eventLogNotification;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public EventLogger(System.ComponentModel.IContainer container)
		{
			///
			/// Required for Windows.Forms Class Composition Designer support
			///
			container.Add(this);
			InitializeComponent();

			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		public EventLogger( 
			Enum source
			)
		{
			///
			/// Required for Windows.Forms Class Composition Designer support
			///
			InitializeComponent();

			string applicationName = ApplicationSettings.GetSetting( SettingName.ApplicationName );

			this.eventLogNotification.Source = applicationName + " " + source.ToString();

		}
		public EventLogger(	)
		{
			///
			/// Required for Windows.Forms Class Composition Designer support
			///
			InitializeComponent();

			string applicationName = ApplicationSettings.GetSetting( SettingName.ApplicationName );

			this.eventLogNotification.Source = applicationName;

		}

		private static string GetExceptionInfo( 
			Exception exception )
		{
			StringBuilder message = new StringBuilder();

			message.AppendFormat( "{0}\n", exception.Message );
			message.AppendFormat( "{0}\n", "--------------------------------" );
			message.AppendFormat( "{0}\n", exception.StackTrace );

			if( exception.InnerException != null )
			{
				string innerExceptionText = GetExceptionInfo( exception.InnerException );
				message.AppendFormat( "=======================\n{0}\n", innerExceptionText );
			}

			return message.ToString();

		}

		public void WriteError(
			Exception exception,
			byte[] rawData
			)
		{
			string message = GetExceptionInfo( exception );
			this.WriteEntry( message, EventLogEntryType.Error, rawData );
		}

		public void WriteError(
			string message
			)
		{
			this.WriteEntry( message, EventLogEntryType.Error, null );
		}

		public void WriteError(
			string message,
			byte[] rawData
			)
		{
			this.WriteEntry( message, EventLogEntryType.Error, rawData );
		}

		public void WriteError(
			Exception exception
			)
		{
			string message = GetExceptionInfo( exception );
			this.eventLogNotification.WriteEntry( message, EventLogEntryType.Error );
		}

		public void WriteInfo(
			string message
			)
		{
			this.eventLogNotification.WriteEntry( message, EventLogEntryType.Information );
		}

		public void WriteEntry(
			string message,
			EventLogEntryType type,
			byte[] rawData
			)
		{
			this.eventLogNotification.WriteEntry( message, type, 0, 0, rawData );
		}

		/// <summary> 
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if(components != null)
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}


		#region Component Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			this.eventLogNotification = new System.Diagnostics.EventLog();
			((System.ComponentModel.ISupportInitialize)(this.eventLogNotification)).BeginInit();
			// 
			// eventLogNotification
			// 
			this.eventLogNotification.Log = "Application";
			this.eventLogNotification.Source = "Statline";
			((System.ComponentModel.ISupportInitialize)(this.eventLogNotification)).EndInit();

		}
		#endregion
	}
}
