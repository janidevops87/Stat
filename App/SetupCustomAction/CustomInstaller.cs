using System.ComponentModel;
using System.Configuration;
using System.Configuration.Install;
using System.Diagnostics;
using System.IO;
using System.Reflection;
using System.Text;

namespace Statline.Stattrac.SetupCustomAction
{
	[RunInstaller(true)]
	public partial class CustomInstaller : Installer
	{
		#region Constructor
		public CustomInstaller()
		{
			InitializeComponent();
		}
		#endregion

		#region Public Methods
		public override void Install(System.Collections.IDictionary stateSaver)
		{
			base.Install(stateSaver);
			//InstallEncryptionKey();
			//EncryptConnString();
		}
		#endregion

		#region Private Fields
		/// <summary>
		/// Path to the key file
		/// </summary>
		private string StatTracKeyPath;
		#endregion

		#region Private Method
		/// <summary>
		/// Encrypt the connection string
		/// </summary>
		private void EncryptConnString()
		{
			FileInfo file = new FileInfo(Context.Parameters["assemblypath"]);
			string configFilePath = file.DirectoryName + @"\Statline.Stattrac.Windows.UI.exe";

			Configuration configuration = ConfigurationManager.OpenExeConfiguration(configFilePath);

			// Update the connectin string
			configuration.ConnectionStrings.ConnectionStrings["Backup"].ConnectionString = "Data Source=st-dtdevsvr;Initial Catalog=_ReferralDev1;User ID=sa;Password=kuvasz;";
			configuration.ConnectionStrings.ConnectionStrings["Logging"].ConnectionString = "Data Source=st-dtdevsvr;Initial Catalog=Logging;User ID=sa;Password=kuvasz;";
			configuration.ConnectionStrings.ConnectionStrings["Production"].ConnectionString = "Data Source=st-dtdevsvr;Initial Catalog=_ReferralDev1;User ID=sa;Password=kuvasz;";
			configuration.ConnectionStrings.ConnectionStrings["ProductionArchive"].ConnectionString = "Data Source=st-dtdevsvr;Initial Catalog=_ReferralDev1;User ID=StatTracadmin;Password=StatTrac;";
			configuration.ConnectionStrings.ConnectionStrings["Test"].ConnectionString = "Data Source=st-dtdevsvr;Initial Catalog=_ReferralDev1;User ID=StatTracadmin;Password=StatTrac;";
			configuration.ConnectionStrings.ConnectionStrings["Training"].ConnectionString = "Data Source=st-dtdevsvr;Initial Catalog=_ReferralDev1;User ID=StatTracadmin;Password=StatTrac;";

			//// Encrypt the connection string
			//ConfigurationSection section = configuration.GetSection("connectionStrings");
			//if (!section.SectionInformation.IsProtected)
			//{
			//   section.SectionInformation.ProtectSection("StatTracProtectedConfigurationProvider");
			//}

			//// Save the data
			//configuration.Save();
		}

		/// <summary>
		/// Install the key
		/// </summary>
		private void InstallEncryptionKey()
		{
			SaveStatLineKey();

			// Delete the key if it already exists
			Process aspnet = new Process();
			aspnet.StartInfo.FileName = @"C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\aspnet_regiis.exe";
			aspnet.StartInfo.Arguments = "-pz \"StatTracKey\"";
			aspnet.Start();

			// Install the key
			aspnet = new Process();
			aspnet.StartInfo.FileName = @"C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\aspnet_regiis.exe";
			aspnet.StartInfo.Arguments = "-pi \"StatTracKey\" StatTracKey.xml";
			aspnet.Start();

			DeleteStatLineKey();
		}

		/// <summary>
		/// Save the key file into the users machine
		/// </summary>
		private void SaveStatLineKey()
		{
			// Save the key file
			Assembly asm = Assembly.GetExecutingAssembly();

			Stream stream = asm.GetManifestResourceStream("Statline.Stattrac.SetupCustomAction.StatTracKey.xml");
			StreamReader sr = new StreamReader(stream);
			StringBuilder sb = new StringBuilder(sr.ReadToEnd());
			sr.Close();

			FileInfo dllFile = new FileInfo(asm.Location);
			StatTracKeyPath = dllFile.DirectoryName + "/StatTracKey.xml";

			// Delete The file if it exists so that we write a new one
			DeleteStatLineKey();

			// Write the data to the file
			File.WriteAllText(StatTracKeyPath, sb.ToString());
		}

		/// <summary>
		/// Delete the key from the users machine
		/// </summary>
		private void DeleteStatLineKey()
		{
			// Delete The file if it exists so that we write a new one
			if (File.Exists(StatTracKeyPath))
			{
				File.Delete(StatTracKeyPath);
			}

		} 
		#endregion
	}
}
