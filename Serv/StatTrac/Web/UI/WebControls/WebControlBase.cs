using System;
using System.Collections;
using System.Data;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.WebControls
{

	public class WebControlBase : System.Web.UI.WebControls.WebControl
	{
        
		/// <summary>
		/// Overrides the Page to allow access to the framework BasePage.
		/// </summary>
		[Browsable(false)]
		public new BasePage Page
		{
			get
			{

				BasePage page = base.Page as BasePage;
				if( page != null )
					return page;
				else
					throw new ApplicationException( "Invalid BasePage." );
			}
		}

	}
}