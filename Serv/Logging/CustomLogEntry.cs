using System;
using System.Collections;
using System.Management.Instrumentation;
using System.Security.Principal;
using System.Web;
using System.Xml.Serialization;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using System.Diagnostics;
using System.Collections.Generic;

namespace Statline.Logging
{
	/// <summary>
	/// Summary description for CustomLogEntry.
	/// </summary>
	[XmlRoot("logEntry")]
	[Serializable]
	[InstrumentationClass(InstrumentationType.Event)]
    [InstrumentationType]
    public class CustomLogEntry : LogEntry 
	{
		private string userName = string.Empty;
		
		public string UserName
		{
			get { return userName; }
			set { userName = value; }
		}

		public CustomLogEntry(): base()
		{
			CollectIntrinsticProperties();
		}
		public CustomLogEntry(object message, string category, int priority, int eventId,
            TraceEventType severity, string title, IDictionary properties) : base(message,category, priority, eventId, severity, title, (IDictionary<string, object>)properties)
		{
			CollectIntrinsticProperties();
		}
		private void CollectIntrinsticProperties()
		{
			
			IPrincipal iPrincipal = HttpContext.Current.User;
			UserName = iPrincipal.Identity.Name;

			
		}
		public new object Clone()
		{
			CustomLogEntry result = (CustomLogEntry)base.Clone();
			
			result.UserName = this.UserName;

			return result;
		}
	}
}
