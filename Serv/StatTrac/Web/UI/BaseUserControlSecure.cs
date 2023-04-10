using System;
using System.Web;
using System.Web.UI;
using System.Configuration;

namespace Statline.StatTrac.Web.UI
{

	public class BaseUserControlSecure : BaseUserControl
	{

		public BaseUserControlSecure() : base()
		{
		}

		protected override bool RequiresAuthenication
		{
			get
			{
				return true;
			}
		}


		private void Page_Load(object sender, System.EventArgs e)
		{
		}

		override protected void OnInit(EventArgs e)
		{
			this.Load += new System.EventHandler(this.Page_Load);
			base.OnInit(e);
		}

	}
}
