using System;
namespace Statline.Stattrac.Constant
{
	/// <summary>
	/// Constants used by the Windows Project
	/// </summary>
	public class WindowsConstant
	{
		#region Private Fields
		private readonly string dateTimeFormat;
        private readonly string ultraDateTimeFormat;
		private readonly string dateTimeNullFormat;
		private readonly DateTime dateTimeNull;
		private readonly char textBoxPasswordChar;
		private readonly string textBoxPasswordFont;
		#endregion

		#region Singleton Implementation
		private static WindowsConstant framework;
		protected WindowsConstant()
		{
            ultraDateTimeFormat = "mm/dd/yyyy hh:mm";
            dateTimeFormat = "MM/dd/yyyy HH:mm";
			dateTimeNullFormat = " ";
			dateTimeNull = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1, 0, 0, 0, 10);
			textBoxPasswordChar = 'w';
			textBoxPasswordFont = "Bookshelf Symbol 7";
		}

		public static WindowsConstant CreateInstance()
		{
			if (framework == null)
			{
				framework = new WindowsConstant();
			}
			return framework;
		}
		#endregion

		#region Public Properties
		/// <summary>
		/// Date Time Format
		/// </summary>
		public string DateTimeFormat
		{
			get { return dateTimeFormat; }
		}
        /// <summary>
        /// Date Time Format for Infragistics control
        /// </summary>
        public string UltraDateTimeFormat
        {
            get { return ultraDateTimeFormat; }
        } 

		/// <summary>
		/// Date Time Null Format
		/// </summary>
		public string DateTimeNullFormat
		{
			get { return dateTimeNullFormat; }
		}

		/// <summary>
		/// Date Time Null Format
		/// </summary>
		public DateTime DateTimeNull
		{
			get { return dateTimeNull; }
		}


		/// <summary>
		/// TextBox Password Char
		/// </summary>
		public char TextBoxPasswordChar
		{
			get { return textBoxPasswordChar; }
		}

		/// <summary>
		/// TextBoxPasswordFont
		/// </summary>
		public string TextBoxPasswordFont
		{
			get { return textBoxPasswordFont; }
		}
		#endregion
	}
}
