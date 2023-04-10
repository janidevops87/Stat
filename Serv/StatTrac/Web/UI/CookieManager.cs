using System;
using System.Collections;
using System.Text;
using System.ComponentModel;
using System.Web;
using Statline.StatTrac.Report;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI
{
	
	#region StatName enum
	/// <summary>
	///  The names of the state machine entities.
	/// </summary>
	public enum StateName
	{
		/// <summary>
		/// WebPersonID
		/// </summary>
		UserId,
		/// <summary>
		/// Users Organization ID
		/// </summary>
		UserOrgId,
        /// <summary>
        /// RegistryOwnerID, if associated to a Registry
        /// </summary>
        RegistryOwnerId,
        /// <summary>
		/// Name and path of Current Report
		/// </summary>
		ReportName,
		/// <summary>
		/// Parameters for Current Report
		/// </summary>
		ReportParameters,
		/// <summary>
		/// ReportID of Current Report
		/// </summary>
		ReportID,
		/// <summary>
		/// Display Name
		/// </summary>
		UserDisplayName,
		/// <summary>
		/// Organization Name
		/// </summary>
		UserOrganizationName,
		/// <summary>
		/// Report Display Name for Current Report
		/// </summary>
		ReportDisplayName,
		/// <summary>
		/// Current Report Group selected
		/// </summary>
		ReportGroupID,
		/// <summary>
		/// StatEmployeeID of the user if it exists
		/// </summary>
		StatEmployeeID,
        /// <summary>
        /// TimeZone is used to determine what tz to convert date/time into
        /// </summary>        
        TimeZone,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        CallID,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        CallDate,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        CallNumber,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        PatientInfo,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        OrganizationID,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        OrganizationName,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        PatientDemographics,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        ScheduleGroupID,
        /// <summary>
        /// Used to to pass among Update screens
        /// </summary>
        ScheduleItemID,
        StartDate,
        EndDate

	}
	#endregion

	#region constructor
	/// <summary>
	/// The state machine for application state management.  
	/// Currently uses in-memory cookies in the client browser interface. (i.e. the cookies do not persist between browser sessions.)
	/// The cookies maintained within this management interface will "go away" only when the browser is closed.
	/// </summary>
    /// <remarks>
    ///     <list type="Adding New Cookies">
    ///     <item> Add new cookie to StatName enum</item>
    ///     <item> Add new cookie Class Property </item>
    ///     <item> Add new cookie to GetStateString method </item>
    ///     <item> Add new cookie to CookieManger Constructor </item>
    ///     <item> Add new cookie to ClearCookie method </item>
    ///     </list>
    /// </remarks>
	public class CookieManager
	{	

		/// <summary>
		///  When the object is created, get all the state machine values from its respective cookie.
		/// </summary>
		public CookieManager()
		{
			try 
			{
				UserId = Convert.ToInt32( GetCookie( StateName.UserId, typeof(  int ), 0 ) );
				
				UserOrgID  = Convert.ToInt32( GetCookie( StateName.UserOrgId, typeof( int ), 0 ) );
				
				ReportName = Convert.ToString( GetCookie( StateName.ReportName, typeof (string), string.Empty));

				reportParameters = ConvertParameters((String)GetCookie( StateName.ReportParameters, typeof(string), string.Empty));

				ReportID = Convert.ToInt32(GetCookie(StateName.ReportID, typeof(int), 0));
			
				UserDisplayName = Convert.ToString( GetCookie( StateName.UserDisplayName, typeof (string), string.Empty));

				UserOrganizationName = Convert.ToString( GetCookie( StateName.UserOrganizationName, typeof (string), string.Empty));

				ReportDisplayName = Convert.ToString(GetCookie(StateName.ReportDisplayName, typeof (string), string.Empty));

				ReportGroupID = Convert.ToInt32(GetCookie(StateName.ReportGroupID, typeof (int), 0));

				StatEmployeeID = Convert.ToInt32(GetCookie(StateName.StatEmployeeID, typeof (int), 0));

                TimeZone = Convert.ToString(GetCookie(StateName.TimeZone, typeof(string), ""));

                CallID = Convert.ToInt32(GetCookie(StateName.CallID, typeof(int), ""));

                CallDate = Convert.ToDateTime(GetCookie(StateName.CallDate, typeof(DateTime), ""));

                CallNumber = Convert.ToString(GetCookie(StateName.CallNumber, typeof(string), ""));
                
                PatientInfo = Convert.ToString(GetCookie(StateName.PatientInfo, typeof(string), ""));
                
                OrganizationID = Convert.ToInt32(GetCookie(StateName.OrganizationID, typeof(int), ""));
                
                OrganizationName = Convert.ToString(GetCookie(StateName.OrganizationName, typeof(string), ""));
                
                PatientDemographics = Convert.ToString(GetCookie(StateName.PatientDemographics, typeof(string), ""));
                
                ScheduleGroupID = Convert.ToInt32(GetCookie(StateName.ScheduleGroupID, typeof(int), ""));
                
                ScheduleItemID = Convert.ToInt32(GetCookie(StateName.ScheduleItemID, typeof(int), ""));

                StartDate = Convert.ToDateTime(GetCookie(StateName.StartDate, typeof(DateTime), ""));

                EndDate = Convert.ToDateTime(GetCookie(StateName.EndDate, typeof(DateTime), ""));
			}
			catch (Exception e )
			{
				Console.WriteLine(e);
			}

		}
		#endregion

	#region Properties
		private int userId;
		private int userOrgID;
		private string reportName;
		private int reportID;
		private Hashtable reportParameters;
		private static string cookiePrefix = "x";
		private string userDisplayName;
		private string userOrganizationName;
		private string reportDisplayName;
		private int reportGroupID;
        private string timeZone;
        private DateTime callDate;
        private string callNumber;
        private string patientInfo;
        private string patientDemographics;
        private int organizationID;
        private string organizationName;
        private int scheduleGroupID;
        private int scheduleItemID;
        private int callID;
        private DateTime startDate;
        private DateTime endDate;
        private string sessionID;

        public int ScheduleItemID
        {
            get { return scheduleItemID; }
            set { scheduleItemID = value; }
        }
        public int ScheduleGroupID
        {
            get { return scheduleGroupID; }
            set { scheduleGroupID = value; }
        }
        public int OrganizationID
        {
            get { return organizationID; }
            set { organizationID = value; }
        }
        public int CallID
        {
            get { return callID; }
            set { callID = value; }
        }
        public string CallNumber
        {
            get { return callNumber; }
            set { callNumber = value; }
        }
        public string PatientInfo
        {
            get { return patientInfo; }
            set { patientInfo = value; }
        }
        public string PatientDemographics
        {
            get { return patientDemographics; }
            set { patientDemographics = value; }
        }
        public string OrganizationName
        {
            get { return organizationName; }
            set { organizationName = value; }
        }
        public DateTime CallDate
        {
            get { return callDate; }
            set { callDate = value; }
        }
        public string TimeZone
        {
            get { return timeZone; }
            set { timeZone = value; }
        }
		public int StatEmployeeID
		{
			get { return statEmployeeID; }
			set { statEmployeeID = value; }
		}

		private int statEmployeeID;

		public int ReportGroupID
		{
			get { return reportGroupID; }
			set { reportGroupID = value; }
		}

		public string ReportDisplayName
		{
			get { return reportDisplayName; }
			set { reportDisplayName = value; }
		}
		public string UserDisplayName
		{
			get { return userDisplayName; }
			set { userDisplayName = value; }
		}

		public string UserOrganizationName
		{
			get { return userOrganizationName; }
			set { userOrganizationName = value; }
		}

		public int ReportID
		{
			get { return reportID; }
			set { reportID = value; }
		}
		

		public int UserId
		{
			get { return userId; }
			set { userId = value; }
		}

		public int UserOrgID
		{
			get { return userOrgID; }
			set { userOrgID = value; }
		}

		public string ReportName
		{
			get { return reportName; }
			set { reportName = value; }
		}

		public Hashtable ReportParameters
		{
			get { return reportParameters; }
			set { reportParameters = value; }
		}

       

        public DateTime EndDate
        {
            get { return endDate; }
            set { endDate = value; }
        }

        public DateTime StartDate
        {
            get { return startDate; }
            set { startDate = value; }
        }

        public string SessionID
        {
            get { return sessionID; }
            set { sessionID = value; }
        }

        #endregion

        #region Methods
        /// <summary>
        ///  Set all cookies to "null".
        /// </summary>
        public void ClearCookies()
		{
			SetCookie( StateName.UserId, null );
			SetCookie( StateName.UserOrgId, null );
			SetCookie( StateName.ReportName, null );
			SetCookie( StateName.ReportParameters, null );
			SetCookie( StateName.ReportID, null);
			SetCookie( StateName.UserDisplayName, null);
			SetCookie( StateName.UserOrganizationName, null);
			SetCookie( StateName.ReportDisplayName, null);
			SetCookie( StateName.ReportGroupID, null);
			SetCookie( StateName.StatEmployeeID, null);
            SetCookie( StateName.TimeZone, null);
            SetCookie(StateName.CallID, null);
            SetCookie(StateName.CallDate, null);
            SetCookie(StateName.CallNumber, null);
            SetCookie(StateName.PatientInfo, null);
            SetCookie(StateName.OrganizationID, null);
            SetCookie(StateName.OrganizationName, null);
            SetCookie(StateName.PatientDemographics, null);
            SetCookie(StateName.ScheduleGroupID, null);
            SetCookie(StateName.ScheduleItemID, null);
            SetCookie(StateName.StartDate, null);
            SetCookie(StateName.EndDate, null);

		}

		/// <summary>
		/// Saves all state values by setting its respective cookie.
		/// </summary>
		public void SaveCookies()
		{
			SetCookie( StateName.UserId, UserId );
			SetCookie( StateName.UserOrgId, UserOrgID );
			SetCookie( StateName.ReportName, ReportName );
			SetCookie( StateName.ReportParameters, ConvertParameters(reportParameters) );
			SetCookie( StateName.ReportID, ReportID);
			SetCookie( StateName.UserDisplayName, UserDisplayName);
			SetCookie( StateName.UserOrganizationName, UserOrganizationName);
			SetCookie( StateName.ReportDisplayName, ReportDisplayName);
			SetCookie( StateName.ReportGroupID, ReportGroupID);
			SetCookie( StateName.StatEmployeeID, StatEmployeeID);
            SetCookie( StateName.TimeZone, TimeZone);
            SetCookie( StateName.CallID, CallID);
            SetCookie( StateName.CallDate, CallDate);
            SetCookie( StateName.CallNumber, CallNumber);
            SetCookie( StateName.PatientInfo, PatientInfo);
            SetCookie( StateName.OrganizationID, OrganizationID);
            SetCookie( StateName.OrganizationName, OrganizationName);
            SetCookie( StateName.PatientDemographics, PatientDemographics);
            SetCookie( StateName.ScheduleGroupID, ScheduleGroupID);
            SetCookie( StateName.ScheduleItemID, ScheduleItemID);
            SetCookie(StateName.StartDate, StartDate);
            SetCookie(StateName.EndDate, EndDate);
		}
		public string GetStateStringBreak()
		{
			return GetStateString( "<br>" );
		}

		public string GetStateStringNewLine()
		{
			return GetStateString();
		}

		public string GetStateString()
		{
			return GetStateString( "\r\n" );
		}

		public string GetStateString( string LineTerminator  )
		{
			StringBuilder sb = new StringBuilder();
			sb.AppendFormat( "{0}={1}{2}", StateName.UserId.ToString(), UserId, LineTerminator );
			sb.AppendFormat( "{0}={1}{2}", StateName.UserOrgId.ToString(), UserOrgID, LineTerminator );
			sb.AppendFormat( "{0}={1}{2}", StateName.ReportParameters.ToString(), ReportParameters, LineTerminator );
			sb.AppendFormat( "{0}={1}{2}", StateName.ReportID, ReportID, LineTerminator );
			sb.AppendFormat( "{0}={1}{2}", StateName.UserDisplayName.ToString(), UserDisplayName, LineTerminator );
			sb.AppendFormat( "{0}={1}{2}", StateName.UserOrganizationName.ToString(), UserOrganizationName, LineTerminator );
			sb.AppendFormat("{0}={1}{2}", StateName.ReportDisplayName.ToString(), ReportDisplayName, LineTerminator);
			sb.AppendFormat( "{0}={1}{2}", StateName.ReportGroupID, ReportGroupID, LineTerminator );
			sb.AppendFormat( "{0}={1}{2}", StateName.StatEmployeeID, StatEmployeeID, LineTerminator );
            sb.AppendFormat("{0}={1}{2}", StateName.TimeZone, TimeZone, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.CallID, CallID, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.CallDate, CallDate, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.CallNumber, CallNumber, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.PatientInfo, PatientInfo, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.OrganizationID, OrganizationID, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.OrganizationName, OrganizationName, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.PatientDemographics, PatientDemographics, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.ScheduleGroupID, ScheduleGroupID, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.ScheduleItemID, ScheduleItemID, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.StartDate, StartDate, LineTerminator);
            sb.AppendFormat("{0}={1}{2}", StateName.EndDate, EndDate, LineTerminator);
			return sb.ToString();

			
		}
		#region save and retrieve HashTables
		/// <summary>
		/// Convert the string saved in the cookie to a HasTable
		/// </summary>
		/// <param name="convertString"></param>
		/// <returns></returns>
		private Hashtable ConvertParameters(String convertString)
		{
			Hashtable buildTable = new Hashtable();
			if(convertString.Equals(string.Empty))
				return buildTable;
			
			string[] paramList = convertString.Split('&');
			for(int loopCount = 0 ; loopCount < paramList.Length ; loopCount++)
			{
				string[] paramKeyValue = paramList[loopCount].Split('=');
				if(paramKeyValue.Length == 2)
					buildTable.Add(paramKeyValue[0], paramKeyValue[1]);
			}
			return buildTable;
		}
		/// <summary>
		/// Convert the parameters hashtable to a string to save in a cookie
		/// </summary>
		/// <param name="convertTable"></param>
		/// <returns></returns>
		private string ConvertParameters(Hashtable convertTable) 
		{
			
			if(convertTable == null)
				return "";
			string paramsString = String.Empty;
			if(convertTable.Count < 1)
				return paramsString;

			// Enumerate properties and create report server specific string.
			IDictionaryEnumerator customPropEnumerator = convertTable.GetEnumerator();
			while ( customPropEnumerator.MoveNext() )
			{
				paramsString += "&" 
					+ customPropEnumerator.Key 
					+ "=" + customPropEnumerator.Value;
			}

			return paramsString;

		}
		#endregion

		#endregion
	
	#region Cookie State Management
		/// <summary>
		///  The CookiePrefix defines the string to prepend to the integer value of the StateName.
		/// </summary>
		

		/// <summary>
		///  Converts the StateName to a ( cookiePrefix + the integer value of the enum value StateName ).
		/// </summary>
		/// <param name="TheCookieName">The Cookie to munge.</param>
		/// <returns>The munged cookie name</returns>
		private static string CookieName( StateName TheCookieName )
		{
			return cookiePrefix + Convert.ToInt32( TheCookieName ).ToString();
		}

		/// <summary>
		///  Gets the cookie from the Request.
		/// </summary>
		/// <param name="TheCookieName">The Cookie to get.</param>
		/// <param name="TheType">The Value Type to return.</param>
		/// <param name="DefaultValue">The default value to return if the cookie does not exist in the Request.</param>
		/// <returns>A value of TheType</returns>
		private static object GetCookie( StateName TheCookieName, Type TheType, object DefaultValue )
		{
			object thevalue = null;
			
			if( HttpContext.Current.Request.Cookies[ CookieName( TheCookieName ) ] != null )
				thevalue = HttpContext.Current.Request.Cookies[ CookieName( TheCookieName ) ].Value;

			if( thevalue != null )
			{
				return TypeDescriptor.GetConverter( TheType ).ConvertFrom( thevalue );
			}
			else
			{
				return DefaultValue;
			} 
		}

		/// <summary>
		/// Sets the cookie in the Response.
		/// </summary>
		/// <param name="TheCookieName">The Cookie to set.</param>
		/// <param name="TheCookieValue">The Value to set.</param>
		private static void SetCookie( StateName TheCookieName, object TheCookieValue )
		{
			if( TheCookieValue != null && TheCookieValue.ToString().Length > 0 )
				HttpContext.Current.Response.Cookies[ CookieName( TheCookieName ) ].Value = TheCookieValue.ToString();
			
			else //Expire Cookie
			{
				HttpContext.Current.Response.Cookies[ CookieName( TheCookieName ) ].Expires = DateTime.Now.Subtract( new TimeSpan( 30, 0, 0, 0 ) );
			}

		}

		#endregion

        public static void SetUserCookies(string userName, int userOrgID, CookieManager pageCookie)
        {
            string password = "";

            SetUserCookies(userName, password, userOrgID, pageCookie);
        }
        public static void SetUserCookies(string userName, string password, CookieManager pageCookie)
        {
            int userOrgId = 0;
            SetUserCookies(userName, password, userOrgId, pageCookie);
        }
        public static void SetUserCookies(string userName, string password, int userOrgId, CookieManager pageCookie)
        {
            int userId = 0;            
            int statEmployeeId = 0;
            string timeZone = "";
            string userDisplayName = String.Empty;
            string userOrganizationName = String.Empty;
            try
            {
                ReportReferenceManager.SetUserReportInformation(
                userName,
                password,
                pageCookie.SessionID,
                ref userId,
                ref userOrgId,
                ref userDisplayName,
                ref userOrganizationName,
                ref statEmployeeId,
                ref timeZone);
            }
            catch
            {
                DisplayMessages.Add(MessageType.ErrorMessage, ConstHelper.ERRORGENERALDATABASE);
            }
            if (userId == 0)
                pageCookie.SessionID = string.Empty;

            pageCookie.UserId = userId;
            pageCookie.UserOrgID = userOrgId;
            pageCookie.UserDisplayName = userDisplayName;
            pageCookie.UserOrganizationName = userOrganizationName;
            pageCookie.StatEmployeeID = statEmployeeId;
            pageCookie.TimeZone = timeZone;
        }  

	}
}