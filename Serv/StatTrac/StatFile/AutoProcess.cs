using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Configuration;
using Statline.Service;
using Statline.StatTrac.Data.Types;
using System;
using System.Diagnostics;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFile
{
    /// <summary>
    /// inherites the Statline.Service.IAutoProcess
    /// 
    /// </summary>
    public class AutoProcess : IAutoProcess
    {
        private readonly IFileOutput fileOutput;
        private readonly IXslTransformProvider xslTransformProvider;
        #region Parameters
        private readonly StatFileData statFileDs = new StatFileData();
        #endregion

        public AutoProcess(IFileOutput fileOutput)
        {
            this.fileOutput = fileOutput ?? throw new ArgumentNullException(nameof(fileOutput));

            string applicationPath = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().GetName().CodeBase);

            xslTransformProvider = 
                new CachingXslTransformProvider(
                    new FileXslTransformProvider(baseDirectory: applicationPath));
        }

        #region IAutoProcess Members

        public void Process()
        {
            ProcessCore(useLegacyBehavior: true).GetAwaiter().GetResult();
        }

        public async Task ProcessAsync()
        {
            await ProcessCore(useLegacyBehavior: false);
        }

        /// <param name="useLegacyBehavior">
        /// Specifies whether to preserve legacy behavior which targets
        /// legacy host (windows service), e.g. exception handling strategy.
        /// </param>
        private async Task ProcessCore(bool useLegacyBehavior)
        {
            int exceptionCount = 0;
            ///Load the dataset
            LoadData();

            ///loop through the dataset and process all StatFile Configurations  
            
            foreach (StatFileData.ExportFileRow row in statFileDs.ExportFile.Rows)
            {
                try
                {
                    DataFactory statFile = new DataFactory(row, fileOutput, xslTransformProvider);
                    await statFile.RunAsync();
                }
                catch (System.Data.SqlClient.SqlException sqlEx)
                {
                    if (!sqlEx.Message.Contains("TimeOut"))
                    {
                        exceptionCount++;
                        UpdateData();
                        Logger.Write(sqlEx, Category.Error.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);
                    }
                    if (!useLegacyBehavior || exceptionCount > 10)
                        throw;
                }
                catch (Exception ex)
                {
                    exceptionCount++;
                    UpdateData();
                    Logger.Write(ex, Category.Error.ToString(), Convert.ToInt32(Priority.Default), 0, TraceEventType.Error);

                    // TODO: Consider removing this after migration to a web job
                    // if we will not run this method repeatedly by timer 
                    // (but on a web job schedule).
                    if (!useLegacyBehavior || exceptionCount > 10)
                        throw;
                }
            }

            UpdateData();

        }

        /// <summary>
        /// Load the dataset with the appropriate data.
        /// 3/11/09 Add exportFileList to allow the service to be configured to run 1, more or all statfiles.
        /// If All exportfile configruations should be included set exportFileList to 0.
        /// </summary>
        private void LoadData()
        {
            int organizationID = 0;
            int exportFileID = 0; // hard coding exportFile for CAOL
            string exportFileList = ApplicationSettings.GetSetting(SettingName.ExportFileIDList);

            string [] exportFileIDs = exportFileList.Split(",".ToCharArray());
            for (int loopCount = 0; loopCount < exportFileIDs.Length; loopCount++)
            {
                exportFileID = Convert.ToInt32(exportFileIDs[loopCount]);
                StatFile.Manager.GetExportFile(statFileDs, organizationID, exportFileID);
            }

        }
        /// <summary>
        /// update the dataset following the run 
        /// </summary>
        private void UpdateData()
        {
            int statEmployeeID = Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ServiceEmployeeID));
            StatFile.Manager.UpdateExportFile(statFileDs, statEmployeeID);
        }

        #endregion
    }
}
