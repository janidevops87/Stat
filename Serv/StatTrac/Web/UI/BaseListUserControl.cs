using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Statline.StatTrac.Web.UI
{

	public class BaseListUserControl : BaseUserControlSecure
	{

		public BaseListUserControl()
		{
		}

		public virtual void SetData(
			DataSet data )
		{
			throw new ApplicationException( "The SetData method of"
				+ " BaseEditableControl must be overridden." );
		}

	}
}

