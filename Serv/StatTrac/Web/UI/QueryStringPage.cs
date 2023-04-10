using System;
using System.Collections;

using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI
{

	public enum PageName 
	{
		None,
		Administration,
		AccessDenied,
		Help,
		Maintenance,
		GeneralError,
		Login,
		Reports,
		ReportList,
		ReportParams,
		ReportDisplay,
		ReportPassThroughLogin,
		Roles,
		RolesConfigure,
		ReportConfiguration,
		ReportAccessGroup,
		ReportAccessGroupConfiguration,
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
        Enrollment,
        EnrollmentConfirmation,
        Validate,
        ElectronicSignature,
        DynamicEnrollment,
        DynamicEnrollmentMobile,
        DynamicEnrollmentConfirmation,
        DynamicEnrollmentConfirmationMobile,
        DynamicValidate,
        DynamicValidateMobile,
        DynamicElectronicSignature,
        DynamicElectronicSignatureMobile,
        DynamicDonorVerification,
        CategoryEdit,
        MaintainCategory,
        SubCategoryEdit,
        RegistrySearch,
        RegistrySearchResults,
        RegistryStatisticsReport,
        Verification,
        LoginFailure,
        Logout
	}
	
	public class QueryStringPage
	{

		private PageName pageName;
		private string text;
		private string description;
		private string url;
		
		private QueryStringPage(
			PageName pageName,
			string text,
			string description,
			string url
			)
		{

			this.pageName = pageName;
			this.text = text;
			this.description = description;
			this.url = url;

		}

		private static PageName PageNameFromString( 
			string pageName
			)
		{
			return (PageName)Enum.Parse( typeof( PageName ), pageName, true );
		}

		private static QueryStringPage CreateQueryStringPage(
			NavigationData.PagesRow pagesRow
			)
		{
			QueryStringPage page = new 
				QueryStringPage( PageNameFromString( pagesRow.PageName ), 
				pagesRow.Text, pagesRow.Description, pagesRow.Url );
			return page;
		}

		private static QueryStringPage CreateQueryStringPage(
			string pageName 
			)
		{
			NavigationData.PagesRow pagesRow = BaseMenuControl.NavigationData.Pages.FindByPageName( pageName );
			return QueryStringPage.CreateQueryStringPage( pagesRow );
		}

		private static QueryStringPage CreateQueryStringPage(
			PageName pageName 
			)
		{
			return QueryStringPage.CreateQueryStringPage( pageName.ToString() );
		}

		public static QueryStringPage FindQueryStringPage( 
			string pageName )
		{
			return QueryStringPage.FindQueryStringPage( PageNameFromString( pageName ) );
		}

		private static Hashtable pages = new Hashtable();

		public static QueryStringPage FindQueryStringPage( 
			PageName pageName )
		{

			if( pages[ pageName ] != null )
			{
				return (QueryStringPage)pages[ pageName ];
			}
			else
			{
				QueryStringPage page = QueryStringPage.CreateQueryStringPage( pageName );
				pages[ pageName ] = page;
				return page;
			}

		}

		public static QueryStringPage FindByPhysicalPageName( 
			string fileName )
		{
			foreach( NavigationData.PagesRow pagesRow in 
				BaseMenuControl.NavigationData.Pages.Rows )
			{
				if( QueryStringPage.GetPhysicalPageFileName( pagesRow.Url ).ToLower()
					== fileName.ToLower() )
				{
					return QueryStringPage.CreateQueryStringPage( pagesRow );
				}
			}
			throw new ArgumentOutOfRangeException( "fileName", fileName, "Page not found for fileName." );
		}


		public PageName PageName
		{
			get { return this.pageName; }
		}

		public string Text
		{
			get { return this.text; }
		}

		public string Description
		{
			get { return this.description; }
		}

		public string Url
		{
			get { return this.url; }
		}

		public string QueryStringIdentifier
		{
			get { return this.pageName.ToString(); }
		}

		public static string GetPhysicalPageFileName(
			string url
			)
		{
		
			if( url.IndexOf( "/" ) >= 0 )
			{
				return url.Substring( url.LastIndexOf( "/" ) + 1 );
			}
			return url;

		}

		public string PhysicalPageFileName
		{
			get
			{
				return QueryStringPage.GetPhysicalPageFileName( this.url );
			}
		}

	}
}