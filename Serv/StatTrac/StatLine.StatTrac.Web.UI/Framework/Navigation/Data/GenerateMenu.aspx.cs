using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Statline.Configuration;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Framework.Navigation.Data
{
	/// <summary>
	/// Summary description for GenerateMenu.
	/// </summary>
	public partial class GenerateMenu : System.Web.UI.Page
	{
		protected void Page_Load(object sender, System.EventArgs e)
		{

			string fileName = string.Format( "{0}/BasicMenuDataNew.xml", Server.MapPath( "./" ) );
			NavigationData navigationData = new NavigationData();

			NavigationData.PagesRow pagesRow = navigationData.Pages.AddPagesRow( "Home", "Home", "Home", "Home.aspx" );

			navigationData.MenuLinks.AddMenuLinksRow( "Home", "Home", pagesRow, "Home", "_top",  1, "None", true, "Home", true, true );
			//			navigationData.Links.AddLinksRow( "ManageOrganization", "OuterNavMenu", "Organization", "_top", 1, "ManageOrganization", true, "This is the outer nav menu", true );
			//			navigationData.Links.AddLinksRow( "ManageApplications", "OuterNavMenu", "Application", "_top", 2, "ManageApplications", true, "This is the outer nav menu", true );

			navigationData.WriteXml( fileName );

			Response.End();
			
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
		}
		#endregion
	}
}
