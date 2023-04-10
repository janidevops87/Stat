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

	public partial class MenuControl : BaseUserControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
            if (Page.User != null)
                this.Visible = Page.User.Identity.IsAuthenticated;
            else
                Visible = false;
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{

		}
		#endregion

	}
}
