using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections.Specialized;
using System.Data;
using System.IO;
using System.Configuration;
using System.Reflection;

namespace Statline.Stattrac.NetworkSetup
{
	/// <summary>
	/// Copies the files to a network folder
	/// </summary>
	internal class CopyFiles
	{
		#region Const Fields
		private const string networkSetup = "NetworkSetup";
		private const string sourcedirectory = "sourcedirectory";
		private const string destination = "Destination";
		private const string directory = "directory";
		private const string protectedConfigurationProviderName = "protectedConfigurationProvider";
		private const string exeConfigurationFileName = "exeConfigurationFile";
		private const string connectionStrings = "connectionStrings";
		#endregion

		#region Private Fields
		/// <summary>
		/// The Protection provider to use
		/// </summary>
		private string protectedConfigurationProvider;

		/// <summary>
		/// The name of the executable file
		/// </summary>
		private string exeConfigurationFile;
	
		/// <summary>
		/// The directory where the release files are stored
		/// </summary>
		private string sourceDirectory;

		/// <summary>
		/// List of folders where we want to copy the files to
		/// </summary>
		private StringCollection destinationDirectoryList;
		#endregion

		#region Constructor
		/// <summary>
		/// Initilizes the variables from the xmlFile
		/// </summary>
		/// <param name="xmlFile"></param>
		public CopyFiles(string xmlFile)
		{
			// Load the dataset
			DataSet dataSet = new DataSet();
			dataSet.ReadXml(xmlFile);

			// set the variable
			sourceDirectory = dataSet.Tables[networkSetup].Rows[0][sourcedirectory].ToString();
			protectedConfigurationProvider = dataSet.Tables[networkSetup].Rows[0][protectedConfigurationProviderName].ToString();
			exeConfigurationFile = dataSet.Tables[networkSetup].Rows[0][exeConfigurationFileName].ToString();

			// set the destinationDirectory
			destinationDirectoryList = new StringCollection();
			DataRowCollection dataRowCollection = dataSet.Tables[destination].Rows;
			for (int index = 0; index < dataRowCollection.Count; index++)
			{
				destinationDirectoryList.Add(dataRowCollection[index][directory].ToString());
			}
		}
		#endregion

		#region Internal Methods
		internal void ExecuteCopyFiles()
		{
			FileInfo executingFile = new FileInfo(Assembly.GetExecutingAssembly().Location);
			string errorLog = executingFile.DirectoryName + "/ErrorLog.txt";
			StreamWriter eroorLogStream = new StreamWriter(File.Create(errorLog));

			for (int index = 0; index < destinationDirectoryList.Count; index++)
			{
				try
				{
					Console.WriteLine(destinationDirectoryList[index]);
					CopyFilesToDestination(sourceDirectory, destinationDirectoryList[index]);
					EncryptConnString(destinationDirectoryList[index] + "/" + exeConfigurationFile);
				}
				catch (Exception ex)
				{
					Console.WriteLine("FAILED FAILED FAILED FAILED FAILED\n");
					// Log the error and continue

					eroorLogStream.WriteLine(destinationDirectoryList[index] + " : " + ex.ToString() + "\n\n");
					//erroLogFile.AppendText(destinationDirectoryList[index] + " : " + ex.ToString() + "\n\n");
					//File.AppendAllText(errorLog, destinationDirectoryList[index] + " : " + ex.ToString() + "\n\n");
				}
			}
			eroorLogStream.Flush();
			eroorLogStream.Close();
		}
		#endregion

		#region Private Methods
		private void CopyFilesToDestination(string sourceDirectory, string destinationDirectory)
		{
			DirectoryInfo source = new DirectoryInfo(sourceDirectory);
			DirectoryInfo destination = new DirectoryInfo(destinationDirectory);

			// create the directory if it does not exist
			if (!destination.Exists)
			{
				destination.Create();
			}

			// Copy each file form
			FileInfo[] fi = source.GetFiles();
			for (int fileIndex = 0; fileIndex < fi.Length; fileIndex++)
			{
				fi[fileIndex].CopyTo(destination + "/" + fi[fileIndex].Name, true);
			}

			// Copy eac directory and items inside it
			DirectoryInfo[] di = source.GetDirectories();
			for (int directoryIndex = 0; directoryIndex < di.Length; directoryIndex++)
			{
				CopyFilesToDestination(di[directoryIndex].FullName, destination + "/" + di[directoryIndex].Name);
			}
		}

		private void EncryptConnString(string configFilePath)
		{
			//Configuration configuration = ConfigurationManager.OpenExeConfiguration(configFilePath);

			//// Encrypt the connection string
			//ConfigurationSection section = configuration.GetSection(connectionStrings);
			//if (!section.SectionInformation.IsProtected)
			//{
			//   section.SectionInformation.ProtectSection(protectedConfigurationProvider);
			//}
			//// Save the data
			//configuration.Save();
		}
		#endregion
	}
}
