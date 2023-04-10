using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for ValidationHelper.
	/// </summary>
	public class ValidationHelper
	{

		private ValidationHelper(){}

		private static Color ValidFontColor = Color.Black;
		private static Color ValidBackGroundColor = Color.White;

		private static Color InValidFontColor = Color.White;
		private static Color InValidBackGroundColor = Color.Red;


		public static void SetValid( 
			WebControl control )
		{
			control.ForeColor = ValidFontColor;
			control.BackColor = ValidBackGroundColor;
		}

		public static void SetInValid( 
			WebControl control )
		{
			control.ForeColor = InValidFontColor;
			control.BackColor = InValidBackGroundColor;
		}

	}
}
