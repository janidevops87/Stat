using System;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI.WebControls
{

	[ToolboxData("<{0}:ThemeImage runat=server></{0}:ThemeImage>")]
	public class ThemeImage : Control, INamingContainer
	{

		private string imageName = null;
		public string ImageName
		{
			get { return this.imageName; }
			set
			{
				this.imageName = value;
			}
		}

		private Image image;

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

		protected override void OnInit( EventArgs e )
		{
			this.PreRender += new System.EventHandler( this.ThemeImage_PreRender );
			base.OnInit( e );
		}

		protected void ThemeImage_PreRender( object sender, System.EventArgs e )
		{


			image = new Image();
			string format = "{0}{1}";
			string imageUrl = string.Format( format, this.Page.CurrentThemeImageBasePath, this.imageName );
			image.ImageUrl = imageUrl;
			this.Controls.Add( image );
		
		}

	}
}