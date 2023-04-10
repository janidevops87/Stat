using System;
using System.Text;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for JSFrameWork.
	/// </summary>
	public sealed class JSFrameWork
	{
		private JSFrameWork(){}

		public static string CreateClientId(
			string uniqueId
			)
		{
			return uniqueId.Replace( ":", "_" );
		}

		public static string CreateClientId(
			Control control
			)
		{
			return CreateClientId( control.UniqueID );
		}

		public static string CreateShow(
			string uniqueId
			)
		{
			return string.Format( "show( '{0}' )", uniqueId );
		}

		public static string CreateHide(
			string uniqueId
			)
		{
			return string.Format( "hide( '{0}' )", uniqueId );
		}

		public static void SetShow(
			WebControl onClickControl,
			Control targetControl
			)
		{
			SetShow( onClickControl, targetControl.UniqueID );
		}

		public static void SetShow(
			WebControl onClickControl,
			string targetControlUniqueId
			)
		{
			onClickControl.Attributes[ "onclick" ] = CreateShow( CreateClientId( targetControlUniqueId ) );
		}


		public static void SetHide(
			WebControl onClickControl,
			Control targetControl
			)
		{
			SetHide( onClickControl, targetControl.UniqueID );
		}

		public static void SetHide(
			WebControl onClickControl,
			string targetControlUniqueId
			)
		{
			onClickControl.Attributes[ "onclick" ] = CreateHide( CreateClientId( targetControlUniqueId ) );
		}

		public static void SetShow(
			HtmlControl onClickControl,
			Control targetControl
			)
		{
			SetShow( onClickControl, targetControl.UniqueID );
		}

		public static void SetShow(
			HtmlControl onClickControl,
			string targetControlUniqueId
			)
		{
			onClickControl.Attributes[ "onclick" ] = CreateShow( CreateClientId( targetControlUniqueId ) );
		}


		public static void SetHide(
			HtmlControl onClickControl,
			Control targetControl
			)
		{
			SetHide( onClickControl, targetControl.UniqueID );
		}

		public static void SetHide(
			HtmlControl onClickControl,
			string targetControlUniqueId
			)
		{
			onClickControl.Attributes[ "onclick" ] = CreateHide( CreateClientId( targetControlUniqueId ) );
		}


	}
}
