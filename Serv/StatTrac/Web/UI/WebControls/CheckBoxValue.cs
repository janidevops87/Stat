using System;
using System.Data;
using System.Collections;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.WebControls
{

	[ToolboxData("<{0}:CheckBoxValue runat=server></{0}:CheckBoxValue>")]
	public class CheckBoxValue : CheckBoxBase
	{

		public int Value
		{
			get
			{
				try
				{
					return Convert.ToInt32( ViewState[ "CheckBoxValue" ] );
				}
				catch
				{
					return 0;
				}
			}
			set
			{
				ViewState[ "CheckBoxValue" ] = value;
			}
		}

	}
}