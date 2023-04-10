using System;

namespace Statline.StatTrac.Data.Types
{
	/// <summary>
	/// Summary description for ConstHelper.
	/// </summary>
	/// <P>Name: ConstHelper </P>
	/// <P>Date Created: 11/27/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Stores all application constants </P>
	/// </remarks>	
	public class ConstHelper
	{
		public const int NEWUSER = -1;
        public const int NEWROLE = -1;
        public const int DEFAULTNEWRECORD = -1;
        public const int DEFAULTFIRSTRECORD = 0;
        public const int DEFAULTDROPDOWNVALUE = 0;
        public const int STATLINEORGANIZATIONID = 194;
        
        public const string ERRORGENERALDATABASE = "A database error has prevented the data from being loaded.";
        public const string STATEMPLOYEEIDREQUIRED = "A StatTrac login is required to access this page.";
        public const string ERRORReportDisplay = "There was an error while trying to display the selected report.";
        public const string ERRORQAModuleVersionDisplay = "There was an error determining the QA Module Version.";
        public const string SHORTDATE =  "MM/dd/yyyy";
        public const string MONTHYEAR = "MM/yyyy";
        public const string MILITARYDATETIME = "MM/dd/yyyy HH:mm";
        public const string CULTUREINFOENUS = "en-US";
        public const int LOGEVENTCALLBACKPENDINGCLOSED = 0;
        public const int LOGEVENTCONTACTCONFIRMED = 1;
		public enum AuditLogType
		{
			CREATE = 1, 
			REVIEW = 2, 
			MODIFY = 3, 
			DELETE = 4, 
			UNKNOWN = 5
		}

        public enum SourceCodeType
        {
            Referrals = 1, 
            MessagesImports = 2,
            Imports = 2,
            Message = 2,
            Information = 4

        }
        public enum SQLException
        {
            PrimaryKeyViolation = 2627
        }
	}
}
