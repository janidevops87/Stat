using System;
using System.ComponentModel;

namespace Statline.StatTrac.Web.UI
{

	public class BaseUserControl : System.Web.UI.UserControl
	{

		public BaseUserControl() : base()
		{
		}

		protected virtual bool RequiresAuthenication
		{
			get
			{
				return false;
			}
		}


		private void Page_Load(object sender, System.EventArgs e)
		{

		}



		private void BasePageModule_Init(object sender, System.EventArgs e)
		{
		}

		[Browsable(false)]
		public new BasePage Page
		{
			get
			{
				return base.Page as BasePage;
			}
		}

		override protected void OnInit(EventArgs e)
		{
			this.Load += new System.EventHandler(this.Page_Load);
			this.Init += new System.EventHandler(this.BasePageModule_Init);
			base.OnInit(e);
		}
		
	}
}
