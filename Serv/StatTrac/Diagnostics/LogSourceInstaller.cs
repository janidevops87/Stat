using System;
using System.Collections;
using System.ComponentModel;
using System.Configuration.Install;
using System.Diagnostics;

using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Diagnostics
{

	[RunInstaller(true)]
	public class LogSourceInstaller : System.Configuration.Install.Installer
	{

		public LogSourceInstaller()
		{
		
			ArrayList list = new ArrayList();

            const string applicationName = "Statline Reports";

			foreach( string source in Enum.GetNames( typeof( MessageSource ) ) )
			{
				EventLogInstaller logInstaller = new EventLogInstaller();
				logInstaller.Log = "Application";
				logInstaller.Source = applicationName + " " + source;
				list.Add( logInstaller );
			}

			Installer[] installers = (Installer[])list.ToArray( typeof( Installer ) );
			this.Installers.AddRange( installers );

		}

	}
}
