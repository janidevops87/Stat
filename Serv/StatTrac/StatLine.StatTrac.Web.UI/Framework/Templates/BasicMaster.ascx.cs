using System;
using Statline.StatTrac.Web.UI;
using Statline.Configuration;

namespace Statline.StatTrac.Web.UI.Framework.Templates
{
	/// <summary>
	///		Summary description for BasicMaster.
	/// </summary>
	public partial class BasicMaster : BaseUserControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
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
			this.PreRender += new System.EventHandler(this.masterForm_PreRender);

		}
		#endregion

		protected void masterForm_PreRender(object sender, System.EventArgs e)
		{
			string applicationTitle = ApplicationSettings.GetSetting( SettingName.ApplicationTitle );
			this.pageTitleLiteral.Text = applicationTitle + " - " + this.Page.Title + " - " + "Provided by Statline";
			this.styleSheetLiteral.Text = this.Page.StyleSheetLink;
		}
	}
}
