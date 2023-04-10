using System;
using System.Data;
using System.Collections;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

//using Statline.StatTrac.Caching;

namespace Statline.StatTrac.Web.UI.WebControls
{

	/// <summary>
	/// Provides a display mode hyperlink to the current page.
	/// </summary>
	[ToolboxData("<{0}:HyperLinkDisplayMode runat=server></{0}:HyperLinkDisplayMode>")]
	public class HyperLinkDisplayMode : HyperLink
	{

		public HyperLinkDisplayMode() : base ()
		{
		}

		/// <summary>
		/// The navigate url is automatically determined from the current request.
		/// </summary>
		[Browsable(false)]
		public new string NavigateUrl
		{
			get { return base.NavigateUrl; }
			set { base.NavigateUrl = value; }
		}

		DisplayMode displayMode;

		/// <summary>
		/// The effective display mode for the hyperlink.
		/// </summary>
		[Category("Behavior")] 
		public DisplayMode DisplayMode
		{
			get
			{ 
				return this.displayMode; 
			}
			set 
			{
				this.displayMode = value; 
			}
		}

		/// <summary>
		/// The text of the hyperlink is automatically 
		/// determined from the display mode setting.
		/// </summary>
		[Browsable(false)]
		public new string Text
		{
			get { return base.Text; }
			set { base.Text = value; }
		}

		protected override void OnInit( EventArgs e )
		{
			this.PreRender += new System.EventHandler( this.HyperLinkDisplayMode_PreRender );
			base.OnInit( e );
		}

		protected void HyperLinkDisplayMode_PreRender( object sender, System.EventArgs e )
		{
			if( !this.Page.IsPostBack )
			{

				this.NavigateUrl = QueryStringManager.BuildDisplayModeUrl( this.DisplayMode );
				this.Text = this.DisplayMode.ToString();

			}
		}


	}
}