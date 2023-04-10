using System;
using System.Collections;
using System.Data;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.WebControls
{

	/// <summary>
	/// Defines the base CheckBox for the framework.
	/// </summary>
	public class CheckBoxBase : System.Web.UI.WebControls.CheckBox
	{
        
		/// <summary>
		/// Overrides the Page to allow access to the framework BasePage.
		/// </summary>
		[Browsable(false)]
		public new BasePage Page
		{
			get
			{
				return base.Page as BasePage;
			}
		}

	}
}