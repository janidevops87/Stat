namespace Statline.Stattrac.Constant
{
	/// <summary>
	/// Constants used by the Windows.UI Project
	/// </summary>
	public class WindowsUIConstant
	{
		#region Private Fields
		private readonly string familyServiceActiveCaseControlDateRangeRequired;
		private readonly string tcssActiveCaseControlDateRangeRequired;
        private readonly string debugPathForImages;
		#endregion

		#region Singleton Implementation
		

        private static WindowsUIConstant framework;
		protected WindowsUIConstant()
		{
			familyServiceActiveCaseControlDateRangeRequired = "Updated Date/Time must contain a date range using > and < to search for a case in a Closed status.";
			tcssActiveCaseControlDateRangeRequired = "Updated Date/Time must contain a date range using > and < to search for a case in a Closed status.\n" +
				"Date Range must be less than {0} and can be increased to 90 days with additional filter criteria.";
            debugPathForImages="\\bin\\x86\\Debug";
		}

		public static WindowsUIConstant CreateInstance()
		{
			if (framework == null)
			{
				framework = new WindowsUIConstant();
			}
			return framework;
		}
		#endregion

		#region Public Properties
		/// <summary>
		/// DateRangeRequired message
		/// </summary>
		public string FamilyServiceActiveCaseControlDateRangeRequired
		{
			get { return familyServiceActiveCaseControlDateRangeRequired; }
		}

		public string TcssActiveCaseControlDateRangeRequired(int lengthOfSearchFilter)
		{
			return string.Format(tcssActiveCaseControlDateRangeRequired, lengthOfSearchFilter);
		}
        public string DebugPathForImages
        {
          get { return debugPathForImages; }  
        } 
		#endregion
	}
}
