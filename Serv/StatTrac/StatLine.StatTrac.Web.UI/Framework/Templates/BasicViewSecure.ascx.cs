using System;
using Statline.StatTrac.Web.UI;


namespace Statline.StatTrac.Web.UI.Framework.Templates
{
	/// <summary>
	///		Summary description for BasicViewSecure.
	/// </summary>
	public partial class BasicViewSecure : BaseUserControlSecure
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
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
			this.PreRender += new System.EventHandler(this.BasicViewSecure_PreRender);

		}
		#endregion

		protected void BasicViewSecure_PreRender(object sender, System.EventArgs e)
		{

		}
	}
}
