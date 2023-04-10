using System;

namespace Statline.StatTrac.Data.Types
{

	public enum StatTracCaseType { FamilyServices=1, PatientNotExpired = 2 }
	public enum StatTracOption { UrgencyThresholdMinutes, RetrieveThresholdMinutes, BoardRefreshInterval };
	public enum MessageSource { Web, Board };
	public enum ApplicationStatus { Enabled, Disabled };
	public enum SortDirection { Ascending, Descending };

	public sealed class YesNo
	{
	
		public const string Yes = "Y";
		public const string No = "N";

		public static bool IsYes(
			string value
			)
		{
			return YesNo.Yes == value;
		}
	
		public static string Text( 
			string value )
		{
			return YesNo.IsYes( value ) ? "Yes" : "No";
		}

		public static string Text( 
			bool value )
		{
			return value ? "Yes" : "No";
		}

		public static string Value( 
			string value )
		{
			return YesNo.IsYes( value ) ? Yes : No;
		}

		public static string Value( 
			bool value )
		{
			return value ? Yes : No;
		}

	}

}