using System;

namespace Statline.Helpers
{

	public enum Quarters
	{
		First = 1,
		Second = 2,
		Third = 3,
		Fourth = 4
	}

	public class DateTimeHelper
	{

		#region Quarters

		public static DateTime GetStartOfQuarter( int Year, Quarters Quarter )
		{
			if( Quarter == Quarters.First )	// 1st Quarter = January 1 to March 31
				return new DateTime( Year, 1, 1, 0, 0, 0, 0 );
			else if( Quarter == Quarters.Second ) // 2nd Quarter = April 1 to June 30
				return new DateTime( Year, 4, 1, 0, 0, 0, 0 );
			else if( Quarter == Quarters.Third ) // 3rd Quarter = July 1 to September 30
				return new DateTime( Year, 7, 1, 0, 0, 0, 0 );
			else // 4th Quarter = October 1 to December 31
				return new DateTime( Year, 10, 1, 0, 0, 0, 0 );
		}

		public static DateTime GetEndOfQuarter( int Year, Quarters Quarter )
		{
			if( Quarter == Quarters.First )	// 1st Quarter = January 1 to March 31
				return new DateTime( Year, 3, DateTime.DaysInMonth( Year, 3 ), 23, 59, 59, 999 );
			else if( Quarter == Quarters.Second ) // 2nd Quarter = April 1 to June 30
				return new DateTime( Year, 6, DateTime.DaysInMonth( Year, 6 ), 23, 59, 59, 999 );
			else if( Quarter == Quarters.Third ) // 3rd Quarter = July 1 to September 30
				return new DateTime( Year, 9, DateTime.DaysInMonth( Year, 9 ), 23, 59, 59, 999 );
			else // 4th Quarter = October 1 to December 31
				return new DateTime( Year, 12, DateTime.DaysInMonth( Year, 12 ), 23, 59, 59, 999 );
		}
		
		public static Quarters GetQuarter( int Month )
		{
			if( Month <= 3 )	// 1st Quarter = January 1 to March 31
				return Quarters.First;
			else if( ( Month >= 4 ) && ( Month <= 6 ) ) // 2nd Quarter = April 1 to June 30
				return Quarters.Second;
			else if( ( Month >= 7 ) && ( Month <= 9 ) ) // 3rd Quarter = July 1 to September 30
				return Quarters.Third;
			else // 4th Quarter = October 1 to December 31
				return Quarters.Fourth;
		}

		public static DateTime GetEndOfLastQuarter()
		{			
			if( DateTime.Now.Month <= 3 ) //go to last quarter of previous year
				return GetEndOfQuarter( DateTime.Now.Year - 1, GetQuarter( 12 ));
			else //return last quarter of current year
				return GetEndOfQuarter( DateTime.Now.Year, GetQuarter( DateTime.Now.Month));
		}

		public static DateTime GetStartOfLastQuarter()
		{
			if( DateTime.Now.Month <= 3 ) //go to last quarter of previous year
				return GetStartOfQuarter( DateTime.Now.Year - 1, GetQuarter( 12 ));
			else //return last quarter of current year
				return GetStartOfQuarter( DateTime.Now.Year, GetQuarter( DateTime.Now.Month));
		}

		public static DateTime GetStartOfCurrentQuarter()
		{
			return GetStartOfQuarter( DateTime.Now.Year, GetQuarter( DateTime.Now.Month ));
		}

		public static DateTime GetEndOfCurrentQuarter()
		{
			return GetEndOfQuarter( DateTime.Now.Year, GetQuarter( DateTime.Now.Month ));
		}
		#endregion

		#region Weeks
		public static DateTime GetStartOfLastWeek()
		{
			int DaysToSubtract = (int)DateTime.Now.DayOfWeek + 7;
			DateTime dt = DateTime.Now.Subtract( System.TimeSpan.FromDays( DaysToSubtract ) );
			return new DateTime( dt.Year, dt.Month, dt.Day, 0, 0, 0, 0 );
		}

		public static DateTime GetEndOfLastWeek()
		{
			DateTime dt = GetStartOfLastWeek().AddDays(6);
			return new DateTime( dt.Year, dt.Month, dt.Day, 23, 59, 59, 999 );
		}

		public static DateTime GetStartOfCurrentWeek()
		{
			int DaysToSubtract = (int)DateTime.Now.DayOfWeek ;
			DateTime dt = DateTime.Now.Subtract( System.TimeSpan.FromDays( DaysToSubtract ) );
			return new DateTime( dt.Year, dt.Month, dt.Day, 0, 0, 0, 0 );
		}

		public static DateTime GetEndOfCurrentWeek()
		{
			DateTime dt = GetStartOfCurrentWeek().AddDays(6);
			return new DateTime( dt.Year, dt.Month, dt.Day, 23, 59, 59, 999 );
		}
		#endregion

		#region Months

		public static DateTime GetStartOfMonth( int Month, int Year )
		{
			return new DateTime( Year, Month, 1, 0, 0, 0, 0 );
		}

		public static DateTime GetEndOfMonth( int Month, int Year )
		{
			return new DateTime( Year, Month, DateTime.DaysInMonth( Year, Month ), 23, 59, 59, 999 );
		}

		public static DateTime GetStartOfLastMonth()
		{
			if( DateTime.Now.Month == 1 )
				return GetStartOfMonth( 12, DateTime.Now.Year - 1);
			else
				return GetStartOfMonth( DateTime.Now.Month -1, DateTime.Now.Year );			
		}

		public static DateTime GetEndOfLastMonth()
		{
			if( DateTime.Now.Month == 1 )
				return GetEndOfMonth( 12, DateTime.Now.Year - 1);
			else
				return GetEndOfMonth( DateTime.Now.Month -1, DateTime.Now.Year );
		}

		public static DateTime GetStartOfCurrentMonth()
		{
			return GetStartOfMonth( DateTime.Now.Month, DateTime.Now.Year );
		}

		public static DateTime GetEndOfCurrentMonth()
		{
			return GetEndOfMonth( DateTime.Now.Month, DateTime.Now.Year );
		}
		#endregion

		#region Years
		public static DateTime GetStartOfYear( int Year )
		{
			return new DateTime( Year, 1, 1, 0, 0, 0, 0 );
		}

		public static DateTime GetEndOfYear( int Year )
		{
			return new DateTime( Year, 12, DateTime.DaysInMonth( Year, 12 ), 23, 59, 59, 999 );
		}

		public static DateTime GetStartOfLastYear()
		{
			return GetStartOfYear( DateTime.Now.Year - 1 );
		}

		public static DateTime GetEndOfLastYear()
		{
			return GetEndOfYear( DateTime.Now.Year - 1 );
		}

		public static DateTime GetStartOfCurrentYear()
		{
			return GetStartOfYear( DateTime.Now.Year );
		}

		public static DateTime GetEndOfCurrentYear()
		{
			return GetEndOfYear( DateTime.Now.Year );
		}
		#endregion		

		#region Days

		public static DateTime GetStartOfDay( DateTime date )
		{
			return new DateTime( date.Year, date.Month, date.Day, 0, 0, 0, 0 );
		}

		public static DateTime GetEndOfDay( DateTime date )
		{
			return new DateTime( date.Year, date.Month, date.Day, 23, 59, 59, 999 );
		}

		#endregion
	}
}