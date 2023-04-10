using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.Security;
using Statline.StatTrac.Web.UI;
using Statline.StatTrac.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI
{

	public class BasePage : System.Web.UI.Page
	{

		#region Contructors

		public BasePage( ) : base()
		{
			cookieManager = new CookieManager();
		}

		public BasePage( PageName pageName ) : this()
		{
			this.pageName = pageName;
		}

		#endregion

		#region Fields

		private string title;
		private StyleSheetType styleSheet = StyleSheetType.Display;
		private PageName pageName = PageName.None;
		private MenuName menuName = MenuName.None;
		private AuthRule ruleName = AuthRule.None;

		private CookieManager cookieManager = new CookieManager();

		#endregion

		#region Properties

		public CookieManager Cookies
		{
			get { return cookieManager; }
			set { cookieManager = value; }
		}

		public PageName PageName
		{
			get
			{
				return pageName;
			}
			set
			{
				pageName = value;
			}
		}

		public new CustomPrincipal User 
		{
			get 
			{
				CustomPrincipal principal = Context.User as CustomPrincipal;
				if( principal != null )
				{
					return principal;
				}

				return null;
			}
		}

		protected Theme Theme
		{
			get { return Theme.Default; }
		}

		public string SharedThemeBasePath
		{
			get 
			{
				string baseUrl = "~/Framework/Themes/Shared/";
				return ResolveUrl( baseUrl );
			}
		}

		public string CurrentThemeBasePath
		{
			get 
			{
				string format = "~/Framework/Themes/{0}/";
				string baseUrl = string.Format( format, Theme.ToString() );
				return ResolveUrl( baseUrl );
			}
		}

		public string CurrentThemeImageBasePath
		{
			get 
			{
				string format = "{0}Images/";
				string baseUrl = string.Format( format, CurrentThemeBasePath );
				return ResolveUrl( baseUrl );
			}
		}

		public string Title
		{
			get { return title; }
			set { title = value; }
		}

		public StyleSheetType StyleSheet
		{
			set
			{
				styleSheet = value;
			}
			get
			{
				return styleSheet;
			}
		}

		public ValidationSummary ValidationSummaryMain
		{
			get
			{

				ValidationSummary validationSummary = 
					FindControl( "validationSummary" ) as ValidationSummary;

				if( validationSummary != null )
				{
					return validationSummary;
				}

				return null;

			}

		}
		
		public DataListMessageCollection MessageCollectionDataList
		{
			get
			{

				DataListMessageCollection messageCollectionDataList = 
					FindControl( "messageCollectionDataList" ) as DataListMessageCollection;

				if( messageCollectionDataList != null )
				{
					return messageCollectionDataList;
				}

				return null;

			}
		}
		
		public string StyleSheetLink
		{
			get
			{
				string styleSheetLinkBasePathFormat = 
					"<link href=\"{0}{1}.css\" type=\"text/css\" rel=\"stylesheet\">";

				string style = string.Format( styleSheetLinkBasePathFormat,
					CurrentThemeBasePath, styleSheet );

				return style;

			}
		}

		protected virtual bool RequiresAuthentication
		{
			get
			{
				return false;
			}
		}

		public AuthRule RuleName
		{
			get { return ruleName; }
			set { ruleName = value; }
		}

		#endregion

		#region Methods

		public string CreateSharedImagePath( string imageFilename )
		{

			string shareImagePath = 
				string.Format( "{0}Images/{1}", SharedThemeBasePath,
				imageFilename );

			shareImagePath = ResolveUrl( shareImagePath );

			return shareImagePath;
				
		}


		protected void RedirectToReferringPage()
		{
			Response.Redirect( ( string ) ViewState["ReferringUrl"] );
		}

		#endregion

		#region Events

		protected override void OnInit(EventArgs e)
		{

			Init += new System.EventHandler( BasePage_Init );
			Load += new System.EventHandler( BasePage_Load );
			PreRender += new System.EventHandler( BasePage_PreRender );
			Unload += new System.EventHandler(BasePage_UnLoad );
			Error += new System.EventHandler(BasePage_Error );

			base.OnInit(e);
		}

		private void BasePage_Error(
			object sender, 
			System.EventArgs e)
		{


		}

		private void BasePage_Init(
			object sender, 
			System.EventArgs e)
		{
		
			if( pageName == PageName.None )
			{
				throw new ApplicationException( "PageName has not been intialized." );
			}

			if( Request.QueryString["t"] == "t" )
			{
				Trace.IsEnabled =true;
				Trace.TraceMode = TraceMode.SortByCategory;
			}

			BaseMenuControl.SubMenu = menuName;
			
			Response.Expires = 0;
			Response.CacheControl = "Private";
		
			if( RequiresAuthentication )
			{
				if( !Request.IsAuthenticated )
				{
					QueryStringManager.RedirectToLogin();
				}
			}
		}

		private void BasePage_Load(
			object sender, 
			System.EventArgs e)
		{

			Statline.StatTrac.Web.UI.MasterPages.Region region = 
				Statline.StatTrac.Web.UI.MasterPages.Region.FindRegion( "contentRegion" );

			HtmlTable table = FindControl( "displayRegion" ) as HtmlTable;
			
			if( region != null & table != null )
			{
				
				table.CellPadding = 0;
				table.CellSpacing = 0;
				table.Border = 0;
				table.Width = "100%";
				table.Height = "100%";
				table.Rows[0].Cells[0].Width = "100%";
				table.Rows[0].Cells[0].Height = "100%";
				table.Rows[0].Cells[0].VAlign ="top";
				table.Rows[0].Cells[0].Align ="left";

				region.Controls.Add( table );

			}
			
			if(!IsPostBack)
			{
				if ( Request.UrlReferrer != null )
				{
					ViewState["ReferringUrl"] = Request.UrlReferrer.ToString( );
				}
				else
				{
					ViewState["ReferringUrl"] = Request.RawUrl.ToString( );
				}
			}
		}

		private void BasePage_PreRender(
			object sender, 
			System.EventArgs e)
		{

			QueryStringPage page = QueryStringPage.FindQueryStringPage( pageName );
			title = page.Text;


			string machineName = Environment.MachineName;
			string reverse = string.Empty;
			for( int position = machineName.Length-1; position >= 0; position-- )
			{
				reverse += machineName[position];
			}
			LiteralControl literal = new LiteralControl( string.Format( "<!--{0}-->", reverse ) );
			Controls.Add( literal );


#if DEBUG1
		string values = ErrorManager.CreateMessageList();
		string values = cookieManager.GetStateStringBreak();
		literal = new LiteralControl( values );
		Controls.Add( literal );
#endif

		}

		private void BasePage_UnLoad(
			object sender, 
			System.EventArgs e)
		{

			cookieManager.SaveCookies();

		}


		#endregion

	}
}