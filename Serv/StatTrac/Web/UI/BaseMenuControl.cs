using System;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Statline.StatTrac.Data.Types;
using Statline.Configuration;

namespace Statline.StatTrac.Web.UI
{

	public enum MenuName
	{	
		None, 
		Root, 
		Reports,
		Administration,
		Options,
		ReportList,
		ReportParams,
		ReportDisplay,
		Roles,
		RolesAccess,
		RolesConfigure,
		AccessGroup,
		ReportAccessGroup,
		ReportAccessGroupConfiguration,
		ReportConfiguration,
		RoleAdmin,
		RoleAdminEdit,
		UserAdmin,
		UserAdminEdit,
        Update,
        ReferralSearch,
        ReferralUpdate,
        EventLogUpdate,
        ScheduleSearch,
        ScheduleCreateUpdateShift,
        ScheduleSplitShift,
        QA,
        QAReview,
        QAErrorLog,
        QAErrorDetail,
        QAManageErrorList,
        QAAddEditError,
        QAAddEditErrorType,
        QAConfig,
        QAMonitoring,
        QAPendingReview,
        QAManageQualityMonitoringForms,
        QAManageErrorLocation,
        QAManageProcessSteps,
        QAManageErrorTypes,
        ReferralFacilityCompliance,
        Registry,
        RegistrySearch,
        RegistryReport,
        MaintainCategory,
        Enrollment,
        DynamicEnrollment

	};

	public class BaseMenuControl : BaseUserControl
	{

		protected System.Web.UI.WebControls.DataList menuDataList;

		private void Page_Load(object sender, System.EventArgs e)
		{
			
		}

		private static string menuFileName = null;
		public static string MenuFileName
		{
			get
			{
				return menuFileName;
			}
			set
			{
				menuFileName = value;
			}
		}

		protected virtual MenuName SelectedMenuItem
		{
			get
			{
				try
				{
					return (MenuName)Enum.Parse( typeof( MenuName ), HttpContext.Current.Items[ this.GetType().ToString() ].ToString(), true );
				}
				catch
				{
					return MenuName.None;
				}
			}
		}

		public static MenuName HomeMenu
		{
			get
			{
                return (MenuName)Enum.Parse(typeof(MenuName), ApplicationSettings.GetSetting(SettingName.MenuNameHomeMenu));
			}
		}

		public static PageName HomePage
		{
			get
			{
				return BaseMenuControl.GetPageName( BaseMenuControl.HomeMenu );
			}
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
			this.menuDataList.ItemDataBound += new System.Web.UI.WebControls.DataListItemEventHandler(this.menuDataList_ItemDataBound);
			this.Load += new System.EventHandler(this.Page_Load);
			this.PreRender += new System.EventHandler(this.menuDataList_PreRender);

		}
		#endregion

		private static NavigationData navigationData;

		public static NavigationData NavigationData
		{
			get
			{
				if( navigationData == null )
				{
					navigationData = LoadData();
				}
				return navigationData;
			}
		}

		public static NavigationData LoadData()
		{

			NavigationData navigationData = new NavigationData();

			if( menuFileName == null )
			{
				menuFileName = ApplicationSettings.GetSetting( SettingName.NavigationMenuFileName );
				if( menuFileName == null )
				{
					throw new ArgumentNullException( "menuFileName", "MenuFileName must not be null." );
				}
			}

			string physicalFileName = HttpContext.Current.Server.MapPath( menuFileName );
			if( !File.Exists( physicalFileName ) )
			{
				throw new FileNotFoundException( "Menu file name not found.", physicalFileName );
			}

			navigationData.ReadXml( physicalFileName );

			return navigationData;

		}

		protected DataView BuildDataSource()
		{

			NavigationData navigationData = LoadData();

			MenuName parentMenuName = this.GetParentMenuNameForSelected( this.SelectedMenuItem );
			if( parentMenuName == MenuName.None )
			{
				parentMenuName = BaseMenuControl.MainMenu;
			}

			DataView dataView = new DataView( navigationData.MenuLinks );
			dataView.RowFilter = string.Format( "ParentMenuName = '{0}' And MenuName <> '{0}' And Active", parentMenuName.ToString() );
			dataView.Sort = "SortOrder";

			return dataView;

		}

		private MenuName defaultMenu = MenuName.None;
		protected MenuName DefaultMenu
		{
			get { return this.defaultMenu; }
			set { this.defaultMenu = value; }
		}

		private void menuDataList_PreRender(object sender, System.EventArgs e)
		{

			if( !this.Page.IsPostBack )
			{

				this.menuDataList.DataSource = this.BuildDataSource();
				this.menuDataList.DataBind();

			}

			//Response.Write( string.Format( "Type: {0}, MenuName: {1}<br>", this.GetType(), this.SelectedMenuItem ) );

		}

		QueryStringManager manager = new QueryStringManager();


		private void menuDataList_ItemDataBound(object sender, System.Web.UI.WebControls.DataListItemEventArgs e)
		{

			if( e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem )
			{

				DataRowView drv = (DataRowView)e.Item.DataItem;

				MenuName menuName = (MenuName)Enum.Parse( 
					typeof( MenuName ), drv["MenuName" ].ToString(), true );

				PageName pageName = (PageName)Enum.Parse( 
					typeof( PageName ), drv["PageName" ].ToString(), true );

				string text = drv["Text" ].ToString();
				string description = drv["Description" ].ToString();
				string target = drv["Target" ].ToString();
				string requiredPrivilege = drv["RequiredPrivilege" ].ToString();
				bool requiresAuthentication = Convert.ToBoolean( drv["RequiresAuthentication" ] );
				bool enabled = Convert.ToBoolean( drv["Enabled" ] );

				e.Item.Visible = ( requiredPrivilege == "None" ) ? 
					true : requiresAuthentication == this.Page.User.Identity.IsAuthenticated 
					&& Security.SecurityHelper.Authorized(requiredPrivilege, Page.User );
					
					//this.Page.User.IsInRole( requiredPrivilege ); 

				PlaceHolder activeTab = e.Item.FindControl( "activeTab" ) as PlaceHolder;
				PlaceHolder inActiveTab = e.Item.FindControl( "inActiveTab" ) as PlaceHolder;

				manager.PageName = pageName;

				HyperLink hyperlink;

				if( menuName == this.SelectedMenuItem )
				{
					hyperlink = e.Item.FindControl( "activeHyperlink" ) as HyperLink;
				}
				else
				{
					hyperlink = e.Item.FindControl( "inActiveHyperlink" ) as HyperLink;
				}

				hyperlink.Text = text;
				if( enabled )
				{
					hyperlink.NavigateUrl = manager.BuildUrl();
				}
				hyperlink.Target = target;
				hyperlink.ToolTip = description;

				activeTab.Visible = ( menuName == this.SelectedMenuItem );
				inActiveTab.Visible = ( menuName != this.SelectedMenuItem );
                
			}

		}

		public static MenuName GetParentMenuName( MenuName menuName, MenuName defaultMenu )
		{

			try
			{
				string parentMenuItem = NavigationData.MenuLinks.FindByMenuName( menuName.ToString() ).ParentMenuName;
				MenuName parentMenuName = (MenuName)Enum.Parse( typeof( MenuName ), parentMenuItem, true );
				return parentMenuName;
			}
			catch
			{
				return defaultMenu;
			}

		}

		private MenuName GetParentMenuNameForSelected( MenuName menuName )
		{

			return BaseMenuControl.GetParentMenuName( menuName, this.defaultMenu );

		}

		private const string MainMenuMenuName = "MainMenuMenuName";
		private const string SubMenuMenuName = "SubMenuMenuName";

		public static MenuName MainMenu
		{
			set 
			{
				BaseMenuControl.SetMenuName( MainMenuMenuName, value );
			}
			get
			{
				return BaseMenuControl.GetMenuName( MainMenuMenuName, MenuName.None );
			}
		}

		public static MenuName SubMenu
		{
			set 
			{
				MenuName parentMenuName = BaseMenuControl.GetParentMenuName( value, MenuName.Root );
				if( parentMenuName == MenuName.Root )
				{
					BaseMenuControl.MainMenu = value;
					BaseMenuControl.SetMenuName( SubMenuMenuName, MenuName.None );
				}
				else
				{
					// UnComment this to shift sumneu items to main menu items
					//BaseMenuControl.MainMenu = parentMenuName;
					BaseMenuControl.SetMenuName( SubMenuMenuName, value );
				}
			}
			get
			{
				return BaseMenuControl.GetMenuName( SubMenuMenuName, MenuName.None );
			}
		}

		public static PageName GetPageName( 
			MenuName menuName 
			)
		{
 
			string pageName;
			try
			{
				pageName = BaseMenuControl.NavigationData.MenuLinks.
					FindByMenuName( menuName.ToString() ).PageName;

				return (PageName)Enum.Parse( typeof( PageName ), pageName, true );
			}
			catch( Exception ex )
			{
				string s = ex.Message;
				return PageName.None;
			}
		}


		#region MenuName 
		public static void SetMenuName( 
			string contextName,
			MenuName value )
		{
			HttpContext.Current.Items[ contextName ] = value.ToString();
		}

		public static MenuName GetMenuName( 
			string contextName,
			MenuName defaultValue )
		{
			try
			{
				return (MenuName)Enum.Parse( typeof( MenuName ), HttpContext.Current.Items[ contextName ].ToString(), true );
			}
			catch
			{
				return defaultValue;
			}
		}
		#endregion

	}
}