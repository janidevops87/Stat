using System;
using System.Collections.Specialized;
using System.Text;
using System.Web;
using Statline.StatTrac.Web.UI.MasterPages;

namespace Statline.StatTrac.Web.UI
{
	public enum QueryStringName
	{
		Page,
		NextPage,
		DisplayMode,
		Report,
		WebPersonID,
		OrganizationID,
        RoleID
	} ;

	public sealed class QueryStringManager
	{
		private PageName page = BaseMenuControl.GetPageName(BaseMenuControl.HomeMenu);

		private NameValueCollection parameters =
			new NameValueCollection();

		static QueryStringManager()
		{
		}

		public QueryStringManager(
			PageName destinationPage
			)
		{
			page = destinationPage;
		}

		public QueryStringManager()
		{
		}

		public PageName PageName
		{
			get { return page; }
			set { page = value; }
		}

		public string BuildUrl()
		{
			return BuildUrl(false);
		}

		public string BuildUrl(
			bool includeQueryStringParameters
			)
		{
			if (page == PageName.None)
			{
				throw new ApplicationException("PageName has not " +
				                               "been initialized.");
			}


			if (includeQueryStringParameters)
				AddCurrentQueryString(this);

			string url = string.Format("~/{0}", QueryStringPage.FindQueryStringPage(page).Url);

			url = HttpContext.Current.Response.ApplyAppPathModifier(url);

			if (parameters.Count > 0)
			{
				url += "?";
				url += BuildQueryString();
			}

			return url;
		}

		public string BuildQueryString()
		{
			string url = null;

			for (int keyIndex = 0;
			     keyIndex < parameters.Keys.Count;
			     keyIndex++)
			{
				string name = parameters.Keys[keyIndex];
				string value = parameters.Get(keyIndex);

				url += string.Format("{0}={1}", name, value);

				if (keyIndex < parameters.Keys.Count - 1)
					url += "&";
			}

			string base64Url = Convert.ToBase64String(Encoding.UTF8.GetBytes(url));

			//base64Url = EncryptionManager.EncryptWithSalt( base64Url );

			return string.Format("{0}={1}", QSName, base64Url);
		}


		public static PageName NextPage
		{
			get
			{
				PageName pageName = BaseMenuControl.HomePage;
				try
				{
					string pageIdentifier =
						QueryStringManager.Get(QueryStringName.NextPage);

					pageName = QueryStringPage.FindQueryStringPage(pageIdentifier).PageName;
				}
				catch
				{
					pageName = PageName.None;
				}

				return pageName;
			}
		}

		public void Redirect()
		{
			string url = BuildUrl();

			HttpContext.Current.Response.Redirect(url);
		}

		public void Redirect(
			DisplayMode mode
			)
		{
			if (mode != DisplayMode.None)
				AddDisplayMode(mode);

			string url = BuildUrl();

			HttpContext.Current.Response.Redirect(url);
			HttpContext.Current.Response.End();
		}

		public static void RedirectFromLogin()
		{
			RedirectToNextPage();
		}

		public static void RedirectToNextPage()
		{
			Redirect(NextPage,
			         DisplayMode.None, false);
		}

		public static void RedirectToNextPage(bool includeParameters)
		{
			Redirect(NextPage,
			         DisplayMode.None, includeParameters);
		}

		public static void RedirectToNextPage(
			DisplayMode displayMode
			)
		{
			PageName pageName = NextPage;

			if (pageName == PageName.None)
				pageName = CurrentPage;

			Redirect(pageName,
			         displayMode, false);
		}

		public static void Redirect(
			PageName page
			)
		{
			Redirect(page, DisplayMode.None, false);
		}

		public static void RedirectToHomePage()
		{
			Redirect(BaseMenuControl.HomePage);
		}

		public static void RedirectToLogin()
		{
			QueryStringManager manager =
				new QueryStringManager(PageName.Login);

			manager.AddNextPage(CurrentPage);

			manager.Redirect();
		}

		public static void RedirectToDisplayMode(DisplayMode mode)
		{
			QueryStringManager manager =
				new QueryStringManager(CurrentPage);

			AddCurrentQueryString(manager);

			manager.Redirect(mode);
		}


		public static PageName CurrentPage
		{
			get
			{
				PageName pageName;
				try
				{
					string pageNameIdentifier =
						QueryStringManager.Get(QueryStringName.Page);

					pageName = QueryStringPage.FindQueryStringPage(pageNameIdentifier).PageName;
				}
				catch
				{
					pageName = PageName.None;
				}

				return pageName;
			}
		}

		public static string BuildDisplayModeUrl(DisplayMode mode)
		{
			QueryStringManager manager =
				new QueryStringManager(CurrentPage);

			//QueryStringManager.AddCurrentQueryString( manager );

			manager.AddDisplayMode(mode);

			return manager.BuildUrl();
		}


		public static void Redirect(
			PageName page,
			DisplayMode displayMode
			)
		{
			Redirect(page, displayMode, false);
		}


		public static void Redirect(
			PageName pageName,
			DisplayMode displayMode,
			bool includeParameters)
		{
			if (pageName == PageName.None)
				pageName = BaseMenuControl.HomePage;

			HttpContext context = HttpContext.Current;

			QueryStringManager manager =
				new QueryStringManager(pageName);

			if (displayMode != DisplayMode.None)
				manager.AddDisplayMode(displayMode);

			if (includeParameters)
			{
				AddCurrentQueryString(manager);
			}

			string url = manager.BuildUrl();

			context.Response.Redirect(url);
			context.Response.End();
		}

		public static PageName CurrentPageName
		{
			get
			{
				string absolutPath = HttpContext.Current.Request.Url.AbsolutePath;
				string fileName = absolutPath.Substring(absolutPath.LastIndexOf("/") + 1);
				QueryStringPage page = QueryStringPage.FindByPhysicalPageName(fileName);

				PageName physicalPageName;
				if (page != null)
					physicalPageName = page.PageName;
				else
					physicalPageName = BaseMenuControl.HomePage;

				return physicalPageName;
			}
		}

		private static void AddCurrentQueryString(
			QueryStringManager manager
			)
		{
			HttpContext context = HttpContext.Current;
			foreach (string name in 
				context.Request.QueryString.AllKeys)
			{
				manager.AddString(name, context.Request[name]);
			}
		}

		public void SetCustom(
			string name,
			string value
			)
		{
			AddString(name, value);
		}

		public static string GetCustom(
			string name
			)
		{
			string value = Get(name);
			if (value == null)
			{
				throw new ArgumentOutOfRangeException(
					"name", name, "Custom name not found.");
			}
			return value;
		}

		public void AddPrint()
		{
			AddDisplayMode(DisplayMode.Print);
		}


		public void AddNextPage(
			PageName pageName
			)
		{
			if (pageName != PageName.None)
			{
				QueryStringPage page = QueryStringPage.FindQueryStringPage(pageName);
				AddString(QueryStringName.NextPage, page.QueryStringIdentifier);
			}
		}

		public void AddDisplayMode(
			DisplayMode mode
			)
		{
			if (mode != DisplayMode.None)
			{
				AddString(QueryStringName.DisplayMode, mode.ToString());
			}
		}

		public void AddReport(
			int reportId
			)
		{
			AddInt(QueryStringName.Report, Report);
		}
        public void AddRoleId(
            int roleId
            )
        {
            AddInt(QueryStringName.RoleID, roleId);
        }
        public void AddWebPersonId(
			int webPersonId
			)
		{
			AddInt(QueryStringName.WebPersonID, webPersonId);
		}
		public void AddOrganizationId(
			int organizationId)
		{
			AddInt(QueryStringName.OrganizationID, organizationId);
		}
        public static int RoleId
        {
            get
            {
                int roleId = 0;
                try
                {
                    roleId = GetInt(QueryStringName.RoleID);
                }
                catch
                {
                    roleId = 0;
                }
                return roleId;
            }
        }
        public static int WebPersonId
		{
			get
			{
				int webPersonId = 0;
				try
				{
					webPersonId = GetInt(QueryStringName.WebPersonID);
				}
				catch
				{
					webPersonId = 0;
				}

				return webPersonId;
			}
			
		}
		public static int OrganizationId
		{
			get
			{
				int organizationId = 0;
				try
				{
					organizationId = GetInt(QueryStringName.OrganizationID);
				}
				catch
				{
					organizationId = 0;
				}

				return organizationId;
			}
			
		}

		#region Private Add Methods

		private void AddBool(
			QueryStringName name,
			bool boolValue
			)
		{
			AddString(name, boolValue.ToString());
		}

		private void AddByte(
			QueryStringName name,
			byte byteValue
			)
		{
			AddString(name, byteValue.ToString());
		}

		private void AddShort(
			QueryStringName name,
			short shortValue
			)
		{
			AddString(name, shortValue.ToString());
		}

		private void AddInt(
			QueryStringName name,
			int intValue)
		{
			AddString(name, intValue.ToString());
		}

		private void AddLong(
			QueryStringName name,
			long longValue
			)
		{
			AddString(name, longValue.ToString());
		}

		private void AddString(
			string name,
			string value
			)
		{
			if (name == null || name.Length == 0)
			{
				throw new ArgumentNullException(
					"name", "Must not be null or have a zero length.");
			}
			if (value == null || value.Length == 0)
			{
				throw new ArgumentNullException(
					"value", "Must not be null or have a zero length.");
			}


			string existingValue = parameters.Get(name.ToString());

			if (existingValue != null)
				parameters.Remove(name.ToString());

			parameters.Add(name.ToString(), value);
		}


		private void AddString(
			QueryStringName name,
			string value
			)
		{
			AddString(name.ToString(), value);
		}

		#endregion

		public static int Report
		{
			get
			{
				int reportId = 0;
				try
				{
					reportId = GetInt(QueryStringName.Report);
				}
				catch
				{
					reportId = 0;
				}

				return reportId;
			}
		}

		public static DisplayMode DisplayMode
		{
			get
			{
				DisplayMode mode;

				try
				{
					string modeString = QueryStringManager.Get(QueryStringName.DisplayMode);
					mode = (DisplayMode) Enum.Parse(typeof (DisplayMode), modeString, true);
				}
				catch
				{
					mode = DisplayMode.View;
				}

				return mode;
			}
		}

		public static QueryStringPage GetCurrentPageToLoad()
		{
			QueryStringPage page = null;
			try
			{
				string pageName = QueryStringManager.Get(QueryStringName.Page);
				page = QueryStringPage.FindQueryStringPage(pageName);
			}
			catch
			{
				page = null;
			}

			return page;
		}

		public static bool HideForPrintableVersion
		{
			get
			{
				try
				{
					return !(DisplayMode == DisplayMode.Print);
				}
				catch
				{
					return true;
				}
			}
		}

		public static void Transfer(
			PageName pageName
			)
		{
			Region.UnRegisterRegions();
			HttpContext.Current.Server.Transfer(QueryStringPage.FindQueryStringPage(pageName).PhysicalPageFileName);
		}

		#region Get Methods

		public static DateTime GetDateTime(
			QueryStringName name
			)
		{
			string qsValue = Get(name);
			try
			{
				return DateTime.Parse(qsValue);
			}
			catch
			{
				throw new ApplicationException(
					string.Format("Unable to convert {0} of "
					              + "value {1} to DateTime", name, qsValue));
			}
		}

		public static bool GetBool(
			QueryStringName name
			)
		{
			string qsValue = Get(name);
			try
			{
				return bool.Parse(qsValue);
			}
			catch
			{
				throw new ApplicationException(
					string.Format("Unable to convert {0} of "
					              + "value {1} to Bool", name, qsValue));
			}
		}

		public static byte GetByte(
			QueryStringName name
			)
		{
			string qsValue = Get(name);
			try
			{
				return Convert.ToByte(qsValue);
			}
			catch
			{
				throw new ApplicationException(
					string.Format("Unable to convert {0} of "
					              + "value {1} to Byte", name, qsValue));
			}
		}

		public static short GetShort(
			QueryStringName name
			)
		{
			string qsValue = Get(name);
			try
			{
				return Convert.ToInt16(qsValue);
			}
			catch
			{
				throw new ApplicationException(
					string.Format("Unable to convert {0} of "
					              + "value {1} to Short.", name, qsValue));
			}
		}

		public static int GetInt(
			QueryStringName name
			)
		{
			if (name == QueryStringName.Report ||
				name == QueryStringName.OrganizationID ||
				name == QueryStringName.WebPersonID ||
                name == QueryStringName.RoleID
				)
			{
				string qsValue = Get(name);
				try
				{
					return Convert.ToInt32(qsValue);
				}
				catch
				{
					throw new ApplicationException(
						string.Format("Unable to convert {0} of "
						              + "value {1} to Int.", name, qsValue));
				}
			}
			else
			{
				throw new ApplicationException(
					string.Format("Invalid Request. StatTracCaseId and Report are the "
					              + "only integers available."));
			}
		}

		public static long GetLong(
			QueryStringName name
			)
		{
			string qsValue = Get(name);
			try
			{
				return Convert.ToInt64(qsValue);
			}
			catch
			{
				throw new ApplicationException(
					string.Format("Unable to convert {0} of "
					              + "value {1} to Long", name, qsValue));
			}
		}

		public static string Get(
			QueryStringName name
			)
		{
			return Get(name.ToString());
		}

		private const string QSName = "qs";

		public static string Get(
			string name
			)
		{
			HttpContext context = HttpContext.Current;

			if (context.Request.QueryString[QSName] == null)
			{
				throw new
					InvalidOperationException("No query string is available.");
			}

			string qsBase64 = context.Request.QueryString[QSName];

			//qsBase64 = EncryptionManager.DecryptWithSalt( qsBase64 );

			string qs = Encoding.UTF8.GetString(Convert.FromBase64String(qsBase64));

			NameValueCollection nvc =
				new NameValueCollection();

			string[] nvps;
			if (qs.IndexOf("&", 0) >= 0)
			{
				nvps = qs.Split('&');
			}
			else
			{
				nvps = new string[1] {qs};
			}

			string[] nvvalue = new string[2] {null, null};
			foreach (string nvp in nvps)
			{
				nvvalue = nvp.Split(new char[] {'='}, 2);
				nvc.Add(nvvalue[0], nvvalue[1]);
			}

			if (nvc[name] != null)
			{
				return nvc[name];
			}
			else
			{
				throw new
					ApplicationException("Query String Name"
					                     + " not found: " + name);
			}
		}

		#endregion
	}
}