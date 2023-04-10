using Statline.Configuration;
using Statline.StatTrac.Data.Types;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Xsl;

namespace Statline.StatTrac.StatFile
{
    partial class DataFactory
    {
        #region Constants
        private const int ADDDAYSINWEEK = 7;
        private const int ONESECOND = 1;
        #endregion Constants

        #region Fields
        private DateTime startDateTime;
        private DateTime nextStartDateTime;
        private DateTime endDateTime;
        private string fileNameAbbreviation;
        private string fileName;
        private StatFileData.ExportFileTypeRow fileTypeDataRow;
        private StatFileData.ExportFileXsltRow xsltFileDataRow;
        private StatFileData.ExportFileDataTypeRow exportFileDataTypeRow;

        private readonly IFileOutput fileOutput;
        private readonly IXslTransformProvider xslTransformProvider;

        private static readonly TimeZoneInfo MountainTimeZone =
            TimeZoneInfo.FindSystemTimeZoneById("Mountain Standard Time");

        #endregion Fields

        #region Properties
        public int ExportFileId => ExportFileDataRow.ExportFileID;

        public string FileNameAbbreviation
        {
            get
            {
                if (fileNameAbbreviation == null)
                    FileNameAbbreviation = ExportFileDataTypeRow.ExportFileDataTypeAbbreviation;
                return fileNameAbbreviation;
            }
            set { fileNameAbbreviation = value; }
        }


        public StatFileData.ExportFileDataTypeRow ExportFileDataTypeRow
        {
            get
            {
                if (exportFileDataTypeRow == null)
                    SelectExportFileDataType();
                return exportFileDataTypeRow;
            }
            set { exportFileDataTypeRow = value; }
        }

        public StatFileData.ExportFileRow ExportFileDataRow;

        //add ExportFileDataTypeRow
        /// <summary>
        /// Used to determine the File Type
        /// </summary>
        public StatFileData.ExportFileTypeRow FileTypeDataRow
        {
            get
            {
                if (fileTypeDataRow == null)
                    SelectExportFileType();
                return fileTypeDataRow;
            }
            set { fileTypeDataRow = value; }
        }
        /// <summary>
        /// Used to determine the XSLT File 
        /// </summary>
        public StatFileData.ExportFileXsltRow XsltFileDataRow
        {
            get
            {
                if (xsltFileDataRow == null)
                    SelectExportFileXslt();
                return xsltFileDataRow;
            }
            set { xsltFileDataRow = value; }
        }


        /// <summary>
        /// Determines amount of time to wait for the referralCopleteTrigger before sending a referal.
        /// This parameter is used in conjunction with ReferralCompleteTrigger.
        /// </summary>
        public int ReferralCompleteTriggerOverride => ExportFileDataRow.CloseCaseOverride;

        /// <summary>
        /// This parameter is passed to the querying stored procedure to determine when a Referral is considered complete and should be sent to the client.
        /// </summary>
        public int ReferralCompleteTrigger => ExportFileDataRow.CloseCaseTriggerID;

        /// <summary>
        /// Gives FileFrequency depth by providing a number of FileFrequencies. 
        /// Example: 2 miutes or 2 hours
        /// </summary>
        public int FileFrequencyQuantity => ExportFileDataRow.ExportFileFrequencyQuantity;

        /// <summary>
        /// Determines the frequency a file is generated minute, hour, day, week, month, custom
        /// </summary>
        public int FileFrequency => ExportFileDataRow.ExportFileFrequency;

        /// <summary>
        /// Used to determine the kind of data to query
        /// </summary>
        public int ExportFileType => ExportFileDataRow.ExportFileTypeID;

        /// <summary>
        /// determines the date used to name the file
        /// </summary>
        public int ExportFileNameDateType => ExportFileDataRow.ExportFileFileDateType;

        /// <summary>
        /// Determines What Date is used for Querying Data
        /// </summary>
        public int RecurringDateTypeID => ExportFileDataRow.ExportFileRecurringDateType;

        /// <summary>
        /// Determines what time of day the file is generated.
        /// </summary>
        public string FileRunTime => ExportFileDataRow.ExportFileOccursAt;

        /// <summary>
        /// Determines if the data is placed in one file or multiple files.
        /// </summary>
        public Boolean SeperateFiles => Convert.ToBoolean(ExportFileDataRow.ExportFileSeparateFiles);

        /// <summary>
        /// The XML Transformation File used to create the file
        /// </summary>
        public string XsltFile => XsltFileDataRow.ExportFileXsltName; //"StatFileExtendedReferralDetail.xslt";

        /// <summary>
        /// Determines what path the system will save the file. 
        /// </summary>
        public string FilePath => ExportFileDataRow.ExportFileDirectoryPath;

        /// <summary>
        /// Determines the TimeZone the files are created for. 
        /// </summary>
        public string TimeZone => ExportFileDataRow.ExportFileTZ;

        /// <summary>
        /// Determines the StatTrac Report Group used to generate the Files
        /// </summary>
        public int ReportGroupId => ExportFileDataRow.WebReportGroupID;

        /// <summary>
        /// Clients organizationID also used to determine available Report Groups.
        /// </summary>
        public int OrganizationId => ExportFileDataRow.OrganizationID;

        /// <summary>
        /// The name the file will be saved as. Depends on DateTime, FileType, ExportFileNameDateType, SeperateFiles 
        /// </summary>
        public string FileName => fileName ?? (fileName = CalculateFileName());
        /// <summary>
        /// Start Date and Time to Query the database. This is the current time frame calculated from the LastStartDateTime.
        /// </summary>
        public DateTime StartDateTime
        {
            get
            {
                if (startDateTime == new DateTime(1, 1, 1))
                {
                    // TODO: Geting property mutates state, and this is not good. 
                    // Need to refactor to a more predictable approach.
                    StartDateTime = CalculateNextStartDateTime(LastStartDateTime);
                    NextStartDateTime = CalculateNextStartDateTime(StartDateTime);
                }

                return startDateTime;
            }
            set { startDateTime = value; }
        }

        /// <summary>
        /// The Start Date and Time during the last run. Used to calculate the next run.
        /// </summary>
        public DateTime LastStartDateTime => ExportFileDataRow.ExportFileFromDate;

        /// <summary>
        /// The Start Date and Time of next run. This is a calcuated value using StartDteTime.        
        /// 
        /// </summary>
        public DateTime NextStartDateTime
        {
            get
            {
                if (nextStartDateTime == new DateTime(1, 1, 1))
                {
                    NextStartDateTime = CalculateNextStartDateTime(StartDateTime);
                }
                return nextStartDateTime;
            }
            set { nextStartDateTime = value; }
        }

        /// <summary>
        /// End Date and Time to Query the database
        /// </summary>
        public DateTime EndDateTime
        {
            get
            {
                if (endDateTime == new DateTime(1, 1, 1))
                    EndDateTime = NextStartDateTime.AddSeconds(-ONESECOND);
                return endDateTime;
            }
            set { endDateTime = value; }
        }

        /// <summary>
        /// The End Date and Time during the last run. Used to calculate the next run starttime when custom is the time frame.
        /// </summary>
        public DateTime LastEndDateTime => ExportFileDataRow.ExportFileToDate;

        #endregion Properties

        public DataFactory(
            StatFileData.ExportFileRow dataRow,
            IFileOutput fileOutput,
            IXslTransformProvider xslTransformProvider)
        {
            this.fileOutput = fileOutput ?? throw new ArgumentNullException(nameof(fileOutput));
            this.xslTransformProvider = xslTransformProvider ?? throw new ArgumentNullException(nameof(xslTransformProvider));
            ExportFileDataRow = dataRow ?? throw new ArgumentNullException(nameof(dataRow));
        }

        public async Task RunAsync()
        {
            // run the file if EndDateTime older than the current time
            // the endDateTime has to have past inorder to run
            if (IsRunnable())
            {
                var statFileData = new StatFileData();

                LoadData(statFileData);

                await TransFormDataAsync(statFileData);

                //update row with new ExportFileFromDate and ExportFileToDate
                ExportFileDataRow.ExportFileFromDate = StartDateTime;
                ExportFileDataRow.ExportFileToDate = EndDateTime;
            }
        }

        private void LoadData(StatFileData ds)
        {
            //set converted DateTimes
            DateTime startMountainDateTime = ConvertDateTimeToMountainTimeZone(StartDateTime);
            DateTime endMountainDateTime = ConvertDateTimeToMountainTimeZone(EndDateTime);

            var entityGetter = ChooseEntityGetMethod(
                (FileDataType)ExportFileDataTypeRow.ExportFileDataTypeID);

            entityGetter(
                ds,
                startMountainDateTime,
                endMountainDateTime,
                ReportGroupId,
                OrganizationId,
                RecurringDateTypeID,
                ExportFileId,
                SeperateFiles,
                ReferralCompleteTrigger,
                ReferralCompleteTriggerOverride);
        }

        private GetEntityDelegate ChooseEntityGetMethod(FileDataType fileDataType)
        {
            /// determine how to query data 
            /// if data is queried seperate run two queries
            /// set FileName for each file
            /// convert data to file format and save file
            /// if data is queried run one query
            /// set FileName            
            //convert the timeframes     
            switch (fileDataType)
            {
                case FileDataType.Referral: return Manager.GetReferral;
                case FileDataType.Message: return Manager.GetMessage;
                case FileDataType.ReferralEvent: return Manager.GetReferralEvent;
                case FileDataType.MessageEvent: return Manager.GetMessageEvent;
                default: throw new InvalidOperationException($"Unknown file data type '{fileDataType}'");
            }
        }

        private async Task TransFormDataAsync(StatFileData ds)
        {
            XmlDocument xDoc = new XmlDocument();
            xDoc.LoadXml(GetXMLDecoded(ds));

            //detrmine what files to write
            // if seperate files write both created and lastmodified
            // if single file write depending on DateType
            if (SeperateFiles)
            {
                await WriteFileCreatedAsync(xDoc);
                await WriteFileModifiedAsync(xDoc);
            }
            else
            {
                if (RecurringDateTypeID == (int)RecurringDateType.Created)
                {
                    await WriteFileCreatedAsync(xDoc);
                }
                else if (RecurringDateTypeID == (int)RecurringDateType.LastModified)
                {
                    await WriteFileModifiedAsync(xDoc);
                }
            }
        }

        private async Task WriteFileModifiedAsync(XmlDocument xDoc)
        {
            string modifiedXsltFile = XsltFile;
            string modifiedOutputFile = FilePath + @"\" + FileName + "M.txt";
            string tableName = "LastModified";

            await WriteFileAsync(xDoc, modifiedXsltFile, modifiedOutputFile, tableName);
        }

        private async Task WriteFileCreatedAsync(XmlDocument xDoc)
        {
            string createdXsltFile = XsltFile;
            string createdOutputFile = FilePath + @"\" + FileName + ".txt";
            string tableName = "Created";

            await WriteFileAsync(xDoc, createdXsltFile, createdOutputFile, tableName);
        }

        private static string GetXMLDecoded(StatFileData ds) => ds.GetXml() ?? "";

        private async Task WriteFileAsync(XmlDocument xDoc, string xsltFile, string outputFile, string tableName)
        {
            XslCompiledTransform xslFile = xslTransformProvider.Get(xsltFile);

            var sw = new StringWriter();

            XsltArgumentList arg = new XsltArgumentList();
            arg.AddParam("tableName", "", tableName);

            xslFile.Transform(xDoc, arg, sw);

            await fileOutput.WriteToFileAsync(outputFile, async stream =>
            {
                using (var fileStreamWriter = new StreamWriter(
                    stream,
                    Encoding.Default,
                    bufferSize: 1024, // Default value
                    leaveOpen: true /* We don't create the stream, we don't close it */))
                {
                    await fileStreamWriter.WriteAsync(sw.ToString()).ConfigureAwait(false);
                    // Disposing does flushing, but I left this to not break anything.
                    // Also, we can do asynchronous flush instead of synchronous in Dispose.
                    await fileStreamWriter.FlushAsync().ConfigureAwait(false);
                }
            });
        }

        internal DateTime ConvertDateTimeToMountainTimeZone(DateTime dt) =>
            dt.AddHours(-Convert.ToInt32(TimeZoneOffSet.MountainTimeZoneOffSet(TimeZone, dt)));
            
        /// <summary>
        /// used to calcuate StartDateTime and NextStartDateTime
        /// Method returns the time in the clients run time.
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        internal DateTime CalculateNextStartDateTime(DateTime dt)
        {
            if (dt == new DateTime(1, 1, 1))
                dt = new DateTime();
            switch (FileFrequency)
            {
                case (int)FileFrequencyType.Daily:
                    dt = dt.AddDays(FileFrequencyQuantity);
                    break;
                case (int)FileFrequencyType.Weekly:
                    dt = dt.AddDays(ADDDAYSINWEEK * FileFrequencyQuantity);
                    break;
                case (int)FileFrequencyType.Monthly:
                    dt = dt.AddMonths(FileFrequencyQuantity);
                    break;
                case (int)FileFrequencyType.Hourly:
                    dt = dt.AddHours(FileFrequencyQuantity);
                    break;
                case (int)FileFrequencyType.Custom:
                    dt = dt = LastEndDateTime.AddSeconds(ONESECOND);
                    break;
                case (int)FileFrequencyType.Minute:
                    dt = dt.AddMinutes(FileFrequencyQuantity);
                    break;
            }
            // only adjust the FileRuntTime if FileFrequency is Daily, Monthly or Weekly
            // do not check if minute, hour or custom
            if (FileFrequency == (int)FileFrequencyType.Daily ||
                FileFrequency == (int)FileFrequencyType.Monthly ||
                FileFrequency == (int)FileFrequencyType.Weekly)
                if (FileRunTime.Contains(":"))
                {
                    //FileRunTime is stored in clients run time , so convert it to MT.
                    string[] runTime = FileRunTime.Split(":".ToCharArray());
                    if (runTime.Length == 2)
                    {
                        DateTime tempDate;
                        int hour = Convert.ToInt32(runTime[0]);
                        int minute = Convert.ToInt32(runTime[1]);
                        tempDate = new DateTime(dt.Year, dt.Month, dt.Day, hour, minute, 0);
                        dt = new DateTime(tempDate.Year, tempDate.Month, tempDate.Day, tempDate.Hour, tempDate.Minute, 0);
                    }
                }
            return dt;
        }

        /// <summary>
        /// Locates the ExportFileType row Based on the ExportFile
        /// </summary>
        private void SelectExportFileType()
        {
            string stringFilter = "ExportFileTypeID = " + ExportFileDataRow.ExportFileTypeID;
            DataRow[] resultRow;

            resultRow = ExportFileDataRow.Table.DataSet.Tables["ExportFileType"].Select(stringFilter);


            if (resultRow[ConstHelper.DEFAULTFIRSTRECORD] != null)
                FileTypeDataRow = (StatFileData.ExportFileTypeRow)resultRow[ConstHelper.DEFAULTFIRSTRECORD];
        }

        /// <summary>
        /// Locates the ExportFileXslt row Based on the ExportFileType
        /// </summary>
        /// <returns></returns>
        private void SelectExportFileXslt()
        {
            string stringFilter = "ExportFileXsltID = " + FileTypeDataRow.ExportFileXsltID;
            DataRow[] resultRow;

            resultRow = ExportFileDataRow.Table.DataSet.Tables["ExportFileXslt"].Select(stringFilter);

            if (resultRow[ConstHelper.DEFAULTFIRSTRECORD] != null)
                XsltFileDataRow = (StatFileData.ExportFileXsltRow)resultRow[ConstHelper.DEFAULTFIRSTRECORD];

        }

        /// <summary>
        /// Locates the ExportFileDataType row Based on the ExportType
        /// </summary>
        /// <returns></returns>
        private void SelectExportFileDataType()
        {
            string stringFilter = "ExportFileDataTypeID = " + FileTypeDataRow.ExportFileDataTypeID;
            DataRow[] resultRow;

            resultRow = ExportFileDataRow.Table.DataSet.Tables["ExportFileDataType"].Select(stringFilter);

            if (resultRow[ConstHelper.DEFAULTFIRSTRECORD] != null)
                ExportFileDataTypeRow = (StatFileData.ExportFileDataTypeRow)resultRow[ConstHelper.DEFAULTFIRSTRECORD];

        }

        /// <summary>
        /// Determine the FileName based on the FileDataType, FileNameDateType
        /// This method does not take into account where 1 or multipe files are used
        /// </summary>
        private string CalculateFileName()
        {
            switch ((FileNameDateType)ExportFileNameDateType)
            {
                case FileNameDateType.Current:
                    return FileNameAbbreviation + FileNameDateFormat(StartDateTime);
                case FileNameDateType.Previous:
                    return FileNameAbbreviation + FileNameDateFormat(EndDateTime);
                default:
                    throw new InvalidOperationException($"Unknown file name date type '{ExportFileNameDateType}'");
            }
        }

        internal static string FileNameDateFormat(DateTime dt)
        {
            string buildString;

            buildString = dt.ToString("yyMMddHHmm");
            // the above sol
            // training note: this format will not have leading ZEROS 0000 
            // dt.Month.ToString() + dt.Day.ToString() + dt.Year.ToString() + dt.Hour.ToString() + dt.Minute.ToString();
            // an alternative is to use string.Format("{0:d}",dt.Month.ToString()) 

            return buildString;
        }

        internal bool IsRunnable()
        {
            int serviceDelayMilliseconds =
                Convert.ToInt32(ApplicationSettings.GetSetting(SettingName.ServiceDelayMilliseconds));

            // run the file if EndDateTime older than the current time
            // the endDateTime has to have past in order to run.
            // We convert all date/times to Mountain Time (not to UTC, due to historical reasons) 
            // to do correct comparison.
            DateTime currentMountainDateTime = 
                TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, MountainTimeZone);

            DateTime endMountainDateTime = 
                ConvertDateTimeToMountainTimeZone(EndDateTime);

            bool run = endMountainDateTime.AddMilliseconds(serviceDelayMilliseconds) < currentMountainDateTime;

            return run;
        }
    }
}
