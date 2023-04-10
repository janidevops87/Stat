using System;
using System.Collections;
using System.Data;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls;

using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{

	public class BreadCrumb : System.Web.UI.WebControls.WebControl
	{
        
		[Browsable(false)]
		public new BasePage Page
		{
			get
			{
				if( base.Page as BasePage != null )
					return base.Page as BasePage;
				else
					throw new ApplicationException( "Invalid BasePage." );
			}
		}

		public override void DataBind()
		{

			this.EnsureChildControls();

			base.DataBind();

		}

		private string separatorCssClass = "";
		[Bindable(false), Category("Custom"), DefaultValue("")] 
		public string SeparatorCssClass
		{
			set
			{
				this.separatorCssClass = value;
			}
			get 
			{ 
				return this.separatorCssClass;
			}
		}

		private string separatorText = ">";
		[Bindable(false), Category("Custom"), DefaultValue(">")] 
		public string SeparatorText
		{
			set
			{
				this.separatorText = value;
			}
			get 
			{ 
				return this.separatorText;
			}
		}

		private string imageUrl = null;
		[Bindable(false), Category("Custom"), DefaultValue("")] 
		public string ImageUrl
		{
			set
			{
				this.imageUrl = value;
			}
			get 
			{ 
				return this.imageUrl;
			}
		}

		private TableCell CreateHyperLinkTableCell( MenuName menuName, string cssClass )
		{
			
			PageName pageName = BaseMenuControl.GetPageName( menuName );

			NavigationData.PagesRow pagesRow = 
				BaseMenuControl.NavigationData.Pages.FindByPageName( pageName.ToString() );

			NavigationData.MenuLinksRow menuLinksRow = 
				BaseMenuControl.NavigationData.MenuLinks.FindByMenuName( menuName.ToString() );

			TableCell tableCell = new TableCell();
			tableCell.Wrap = false;

			HyperLink hyperLink = new HyperLink();
			hyperLink.NavigateUrl = "~/" + pagesRow.Url;
			hyperLink.CssClass = cssClass;
			hyperLink.Text = menuLinksRow.Text;

			tableCell.Controls.Add( hyperLink );

			return tableCell;
		}

		private TableCell CreateFirstCell( MenuName menuName )
		{
			TableCell tableCell = new TableCell();
			tableCell.Wrap = false;
			NavigationData.MenuLinksRow menuLinksRow = 
				BaseMenuControl.NavigationData.MenuLinks.FindByMenuName( menuName.ToString() );

			if( menuLinksRow != null )
			{
				tableCell.Text = menuLinksRow.Text;
			}
			else
			{
				tableCell.Visible = false;
			}
			tableCell.CssClass = this.CssClass;
			return tableCell;

		}

		private TableCell CreateSeparatorTableCell()
		{
			TableCell tableCell = new TableCell();
			tableCell.HorizontalAlign = HorizontalAlign.Center;
			tableCell.VerticalAlign = VerticalAlign.Middle;
			tableCell.Wrap = false;
			if( this.imageUrl != null && this.imageUrl.Length > 0 )
			{
				Image image = new Image();
				image.ImageUrl = this.imageUrl;
				image.BorderWidth = 0;
				image.ImageAlign = ImageAlign.Bottom;
				tableCell.Controls.Add( image );
			}
			else
			{
				Label label = new Label();
				label.Text = this.separatorText;
				label.CssClass = this.separatorCssClass;
				tableCell.Controls.Add( label );
			}
			return tableCell;
		}

		protected override void CreateChildControls()
		{

			MenuName currentMenu = BreadCrumb.BreadCrumbMenu;

			if( currentMenu == MenuName.None )
			{
				return;
			}

			Table table = new Table();
			TableRow tableRow = new TableRow();
			table.Rows.Add( tableRow );

			//table.GridLines = GridLines.Both;

			if( currentMenu != MenuName.Root )
			{

				tableRow.Cells.AddAt( 0, CreateFirstCell( currentMenu ) );
				currentMenu = BaseMenuControl.GetParentMenuName( currentMenu, MenuName.Root );

				while( currentMenu != MenuName.Root )
				{
					tableRow.Cells.AddAt( 0, CreateSeparatorTableCell( ) );
					tableRow.Cells.AddAt( 0, CreateHyperLinkTableCell( currentMenu, this.CssClass ) );
					currentMenu = BaseMenuControl.GetParentMenuName( currentMenu, MenuName.Root );
				}

			}

			//currentPage = BaseMenuControl.GetPageName( BaseMenuControl.HomeMenu );
			//tableRow.Cells.AddAt( 0, CreateHyperLinkTableCell( currentPage, this.CssClass ) );

			Controls.Add( table );

			base.CreateChildControls();

		}

		private const string BreadCrumbMenuName = "BreadCrumbMenuName";

		public static MenuName BreadCrumbMenu
		{
			set 
			{
				BaseMenuControl.SetMenuName( BreadCrumbMenuName, value );
			}
			get
			{
				return BaseMenuControl.GetMenuName( BreadCrumbMenuName, MenuName.None );
			}
		}

	}
}