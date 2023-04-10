using Statline.StatTrac.Web.UI;
using System;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Statline.Registry.Web.UI.Framework.Navigation 
{
	


	public partial class OuterMenuControl : Statline.StatTrac.Web.UI.BaseMenuControl
	{
		//protected System.Web.UI.WebControls.DataList menuDataList;
		//protected System.Web.UI.WebControls.DataList menuDataList;
	
		private void InitializeComponent()
		{

		}

		protected override void OnInit(EventArgs e)
		{
			base.DefaultMenu = MenuName.Root;
			base.OnInit (e);
		}

		protected void Page_Load(object sender, System.EventArgs e)
		{
		
		}

		protected override MenuName SelectedMenuItem
		{
			get
			{
				return BaseMenuControl.MainMenu;
			}
		}


	}
}