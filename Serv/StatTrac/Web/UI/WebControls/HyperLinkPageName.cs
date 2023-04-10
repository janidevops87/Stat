using System;
using System.Data;
using System.Collections;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

//using Statline.StatTrac.Caching;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{

	/// <summary>
	/// Provides a hyperlink hard wired to a Page name as 
	/// defined in <see cref="QueryStringPage"/>.  Also, allows 
	/// the automatic inclusion of various query string parameters
	/// defined in <see cref="QueryStringManager"/>
	/// </summary>
	[ToolboxData("<{0}:HyperLinkPageName runat=server></{0}:HyperLinkPageName>")]
	public class HyperLinkPageName : HyperLink
	{

		public HyperLinkPageName() : base ()
		{
		}

		[Browsable(false)]
		public new string NavigateUrl
		{
			get { return base.NavigateUrl; }
			set { base.NavigateUrl = value; }
		}

		protected PageName pageName = PageName.None;
		public PageName PageName
		{
			get { return this.pageName; }
			set { this.pageName = value; }
		}

		protected PageName nextPage = PageName.None;
		public PageName NextPage
		{
			get { return this.nextPage; }
			set { this.nextPage = value; }
		}

		protected DisplayMode displayMode = DisplayMode.None;
		public DisplayMode DisplayMode 
		{
			get { return this.displayMode; }
			set { this.displayMode = value; }
		}

		protected bool print;
		public bool Print
		{
			get { return this.print; }
			set { this.print = value; }
		}

		protected override void OnInit( EventArgs e )
		{
			this.PreRender += new System.EventHandler( this.HyperLinkPageName_PreRender );
			base.OnInit( e );
		}

		protected void HyperLinkPageName_PreRender( object sender, System.EventArgs e )
		{
			if( !this.Page.IsPostBack )
			{
				if( this.pageName == PageName.None )
				{
					throw new ApplicationException( "You must specify the PageName at design time." );
				}

				if( this.Enabled )
				{
					if( this.Text.Length == 0 )
					{
						try
						{
							QueryStringPage page = QueryStringPage.FindQueryStringPage( pageName );
							
							this.Text = page.Text;
							this.ToolTip = page.Description;
						}
						catch
						{
							this.Text = pageName.ToString();
						}
					}

					QueryStringManager manager = 
						new QueryStringManager( this.pageName );

					if( this.print )
					{
						manager.AddPrint();
					}

					manager.AddDisplayMode( this.displayMode );
 
					manager.AddNextPage( this.nextPage );

					string url = manager.BuildUrl();

					this.NavigateUrl = url;

				}
				else
				{
					this.Enabled = true;
				}
			}
		}


	}
}