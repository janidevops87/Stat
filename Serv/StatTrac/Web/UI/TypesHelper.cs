using System;
using System.Collections;
using System.Collections.Specialized;
using System.Data;
using System.Drawing;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Web.UI;

using Statline.Collections;
using Statline.StatTrac.Web.UI.WebControls;

namespace Statline.StatTrac.Web.UI
{

	public class TypesHelper
	{
		public TypesHelper() {}

		public static string GetIntsString( 
			DataView dataView,
			string columnName )
		{

			UniqueStringCollection ruleids = new UniqueStringCollection();

			for( int i = 0; i < dataView.Count; i++ )
				ruleids.Add( dataView[ i ][ columnName ].ToString() );

			return ruleids.ToString( "," );

		}


		#region String Helpers

		public static NameValueCollection Splitter(
			string value,
			char[] separator
			)
		{
			
			NameValueCollection nvc = 
				new NameValueCollection();

			if( value.IndexOf( Convert.ToString( separator ), 0 ) < 0 )
			{
				return  nvc;
			}

			string[] nvps = value.Split( separator );

			foreach( string nvp in nvps )
			{
				nvc.Add( TypesHelper.Splitter(
					nvp, new char[] { '=' } ) );
			}

			return nvc;

		}


		public static string GetString( 
			DataTable dataTable,
			string columnName,
			string separator )
		{

			DataRow[] dataRows = new DataRow[dataTable.Rows.Count];
			return TypesHelper.GetString( dataRows, columnName, separator );

		}

		public static string GetString( 
			DataRow[] dataRows,
			string columnName,
			string separator
			)
		{

			string[] stringArray = TypesHelper.GetStrings( dataRows, columnName );

			return string.Join( separator, stringArray );
		
		}
		
		public static bool StringExists( string stringToFind, string[] stringArray )
		{

			foreach( string stringValue in stringArray )
			{
				if( stringValue.Equals( stringToFind ) )
				{
					return true;
				}
			}

			return false;

		}

		public static string[] GetStrings( 
			DataTable dataTable,
			string columnName )
		{

			DataRow[] dataRows = new DataRow[dataTable.Rows.Count];

			dataTable.Rows.CopyTo( dataRows, 0 );

			return GetStrings( dataRows, columnName );

		}

		public static string[] GetStrings( 
			DataRow[] dataRows,
			string columnName )
		{

			if( dataRows.Length > 0 && dataRows[0][ columnName ].GetType() != typeof( string ) )
			{
				throw new InvalidOperationException( "Column (" + columnName + ") is not of type string." );
			}

			ArrayList list = new ArrayList();

			for( int i = 0; i < dataRows.Length; i++ )
				list.Add( dataRows[ i ][ columnName ] );

			return (string[])list.ToArray( typeof( string ) );

		}

		#endregion

		#region Int Helpers

		public static bool IntExists( int intToFind, int[] intArray )
		{

			foreach( int intValue in intArray )
			{
				if( intValue.Equals( intToFind ) )
				{
					return true;
				}
			}

			return false;

		}

		public static int[] GetInts( 
			DataTable dataTable,
			string columnName )
		{

			DataRow[] dataRows = new DataRow[dataTable.Rows.Count];
            
			dataTable.Rows.CopyTo( dataRows, 0 );

			return GetInts( dataRows, columnName );

		}

		public static int[] GetInts( 
			DataRow[] dataRows,
			string columnName )
		{

			if( dataRows.Length > 0 && dataRows[0][ columnName ].GetType() != typeof( int ) )
			{
				throw new InvalidOperationException( "Column (" + columnName + ") is not of type int." );
			}

			ArrayList list = new ArrayList();

			for( int i = 0; i < dataRows.Length; i++ )
				list.Add( dataRows[ i ][ columnName ] );

			return (int[])list.ToArray( typeof( int ) );

		}

		#endregion

		#region DateTime Helpers
		
		public static DateTime ConvertToMorning( DateTime date )
		{
			return new DateTime( date.Year, date.Month, date.Day, 0, 0, 0, 0 );
		}

		public static DateTime ConvertToNight( DateTime date )
		{
			return new DateTime( date.Year, date.Month, date.Day, 23, 59, 59, 999 );
		}

		static public DateTime GetFirstDayOfMonth( DateTime date )
		{
			int month = date.Month;
			int year = date.Year;
			return ( DateTime.Parse( month.ToString() + "/01/" + year.ToString() ) );
			
		}

		static public DateTime GetLastDayOfMonth(DateTime date)
		{
			int month = date.Month;
			int year = date.Year;
			
			return ( DateTime.Parse( month.ToString() + "/" + DateTime.DaysInMonth(year,month).ToString() + "/" + year.ToString() ) );
		}

		public static string Format24Hour(DateTime dateTime)
		{
			return dateTime.ToString("MM/dd/yyyy HH:mm:ss");
		}
		#endregion

		#region DataTable Helpers

		public static bool BuildRowFilter(
			DataTable dataTable,
			string columnName,
			string operation,
			string conjugate,
			bool singleQuoteValues,
			out string filter
			)
		{

			DataRow[] dataRows = new DataRow[dataTable.Rows.Count];

			dataTable.Rows.CopyTo( dataRows, 0 );
			return TypesHelper.BuildRowFilter( 
				dataRows,
				columnName,
				operation,
				conjugate,
				singleQuoteValues,
				out filter );

		}

		public static bool BuildRowFilter(
			DataRow[] dataRows,
			string columnName,
			string operation,
			string conjugate,
			bool singleQuoteValues,
			out string filter
			)
		{
			bool found = false;

			ArrayList items = new ArrayList();

			string item;
			string format = singleQuoteValues ? "{0} {1} '{2}'" : "{0} {1} {2}";

			foreach( DataRow dataRow in dataRows )
			{
				
				item = string.Format( format, columnName, operation, dataRow[columnName].ToString() );
				items.Add( item );
				found = true;

			}

			string[] itemArray = (string[])items.ToArray( typeof( string ) );
			string itemArrayString = string.Join( " " + conjugate + " ", itemArray );

			filter = "( " + itemArrayString + " )";

			return found;

		}

		public static string BuildRowFilter(
			DataTable dataTable,
			string columnName,
			string operation,
			string conjugate,
			bool singleQuoteValues
			)
		{

			string filter = null;

			if( BuildRowFilter(
				dataTable,
				columnName,
				operation,
				conjugate,
				singleQuoteValues,
				out filter ) )
			{
				return filter;
			}
			else
			{

				return null;

			}

		}

		#endregion

		#region Validation Helpers
		
		public static bool Validate( 
			string pattern,
			string value 
			)
		{
			Regex regex = new Regex( pattern, RegexOptions.Compiled | RegexOptions.Singleline );
			return regex.IsMatch( value );
		}

		public static bool ValidateEmail( 
			string value 
			)
		{
			string expression = string.Empty;
			expression = @"^([0-9a-zA-Z'`]([-.\w]*[0-9a-zA-Z'`])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$";
			
			return TypesHelper.Validate( expression, value.Trim() );
		}

		public static UniqueStringCollection RemoveComments(
			UniqueStringCollection value,
			string commentMarker
			)
		{
			UniqueStringCollection newValues = new UniqueStringCollection();
			foreach( string theString in value )
			{
				if( !theString.StartsWith( commentMarker ) )
				{
					newValues.Add( theString );
				}
			}
			return newValues;
		}

		public static void ValidateEmails(
			UniqueStringCollection emailsToValidate,
			UniqueStringCollection emailsExisting,
			out UniqueStringCollection emailsInvalid,
			out UniqueStringCollection emailsDuplicate,
			out UniqueStringCollection emailsNew
			)
		{
			emailsNew = new UniqueStringCollection();
			emailsInvalid = new UniqueStringCollection();
			emailsDuplicate = new UniqueStringCollection();
			
			string clean;
			foreach( string emailToValidate in emailsToValidate )
			{
				clean = emailToValidate.Trim().ToLower();
				
				if( clean.Length == 0 )
				{
					continue;
				}

				if( !TypesHelper.ValidateEmail( clean ) )
				{
					emailsInvalid.Add( clean );
				}
				else if( emailsExisting.Contains( clean ) )
				{
					emailsDuplicate.Add( clean );
				}
				else
				{
					emailsNew.Add( clean );
				}
			}
		}

		#endregion

		#region CheckBoxList Helpers

		public static void CheckAll(
			CheckBoxList checkBoxList
			)
		{
			TypesHelper.Check( checkBoxList, true );
		}

		public static void UnCheckAll(
			CheckBoxList checkBoxList
			)
		{
			TypesHelper.Check( checkBoxList, false );
		}

		public static void Check(
			CheckBoxList checkBoxList,
			bool check
			)
		{
			foreach( ListItem listItem in checkBoxList.Items )
			{
				listItem.Selected = check;
			}
		}

		public static void SetSelectedIds(
			CheckBoxList checkBoxList,
			DataTable dataTable,
			string columnName
			)
		{
			int[] foundIds = TypesHelper.GetInts( 
				dataTable,
				columnName );
			TypesHelper.SetSelectedIds( checkBoxList,
				foundIds );
		}

		public static void SetSelectedIds(
			CheckBoxList checkBoxList,
			int[] ids
			)
		{
			foreach( int id in ids )
			{
				ListItem item = checkBoxList.Items.FindByValue( id.ToString() );
				if( item != null )
				{
					item.Selected = true;
				}
			}
		}

		public static int[] GetSelectedIds(
			CheckBoxList checkBoxList
			)
		{

			return TypesHelper.GetSelectedIds( checkBoxList, false );

		}

		public static int[] GetSelectedIds(
			CheckBoxList checkBoxList,
			bool reselect
			)
		{

			ArrayList idsArray = new ArrayList();

			int id;
			for(
				ListItem item = checkBoxList.SelectedItem; 
				item != null;
				item = checkBoxList.SelectedItem
				)
			{
				id = Convert.ToInt32( item.Value );
				idsArray.Add( id );
				item.Selected = false;
			}

			int[] ids = (int[])idsArray.ToArray( typeof( int ) );

			if( reselect )
			{
				TypesHelper.SetSelectedIds( checkBoxList, ids );
			}

			return ids;

		}

		public static void SetSelectedStrings(
			CheckBoxList checkBoxList,
			DataTable dataTable,
			string columnName
			)
		{
			string[] foundStrings = TypesHelper.GetStrings( 
				dataTable,
				columnName );
			TypesHelper.SetSelectedStrings( checkBoxList,
				foundStrings );
		}

		public static void SetSelectedStrings(
			CheckBoxList checkBoxList,
			string[] theStrings
			)
		{
			foreach( string theString in theStrings )
			{
				ListItem item = checkBoxList.Items.FindByValue( theString.ToString() );
				if( item != null )
				{
					item.Selected = true;
				}
			}
		}

		public static string[] GetSelectedStrings(
			CheckBoxList checkBoxList
			)
		{

			return TypesHelper.GetSelectedStrings( checkBoxList, false );

		}

		public static string[] GetSelectedStrings(
			CheckBoxList checkBoxList,
			bool reselect
			)
		{

			ArrayList theStringsArray = new ArrayList();

			string theString;
			for(
				ListItem item = checkBoxList.SelectedItem; 
				item != null;
				item = checkBoxList.SelectedItem
				)
			{
				theString = item.Value;
				theStringsArray.Add( theString );
				item.Selected = false;
			}

			string[] theStrings = (string[])theStringsArray.ToArray( typeof( string ) );

			if( reselect )
			{
				TypesHelper.SetSelectedStrings( checkBoxList, theStrings );
			}

			return theStrings;

		}

		#endregion

		#region DataList Helpers

		public static void SetForeColor(
			DataList dataList,
			string controlName,
			Color color
			)
		{
			foreach( DataListItem item in dataList.Items )
			{
				if( item.ItemType == ListItemType.Item ||
					item.ItemType == ListItemType.AlternatingItem)
				{
					WebControl control  = 
						item.FindControl( controlName ) as WebControl;
					if( control != null  )
					{
						control.ForeColor = color;
					}
				}
			}
		}

		public static void CheckAll(
			DataList dataList,
			string checkBoxName
			)
		{
			TypesHelper.Check( dataList, checkBoxName, true );
		}

		public static void UnCheckAll(
			DataList dataList,
			string checkBoxName
			)
		{
			TypesHelper.Check( dataList, checkBoxName, false );
		}

		public static void Check(
			DataList dataList,
			string checkBoxName,
			bool check
			)
		{
			foreach( DataListItem item in dataList.Items )
			{
				if( item.ItemType == ListItemType.Item ||
					item.ItemType == ListItemType.AlternatingItem)
				{
					CheckBoxValue checkBoxValue = 
						item.FindControl( checkBoxName ) as CheckBoxValue;
					if( checkBoxValue != null  )
					{
						checkBoxValue.Checked = check;
					}
				}
			}
		}
		public static void SetSelectedIds(
			DataList dataList,
			string checkBoxName,
			DataTable dataTable,
			string columnName
			)
		{

			int[] ids = TypesHelper.GetInts( dataTable, columnName );

			foreach( DataListItem item in dataList.Items )
			{

				if( item.ItemType == ListItemType.Item ||
					item.ItemType == ListItemType.AlternatingItem)
				{
					CheckBoxValue checkBoxValue = 
						item.FindControl( checkBoxName ) as CheckBoxValue;
					checkBoxValue.Checked = 
						TypesHelper.IntExists( checkBoxValue.Value, ids );
				}
			}

		}
		public static int[] GetSelectedIds(
			DataList dataList,
			string checkBoxName
			)
		{

			ArrayList array = new ArrayList();

			foreach( DataListItem item in dataList.Items )
			{

				if( item.ItemType == ListItemType.Item ||
					item.ItemType == ListItemType.AlternatingItem)
				{
					CheckBoxValue checkBoxValue = 
						item.FindControl( checkBoxName ) as CheckBoxValue;
					if( checkBoxValue.Checked )
					{
						array.Add( Convert.ToInt32( checkBoxValue.Value ) );
					}
				}
			}

			int[] ints = (int[])array.ToArray( typeof( int ) );

			return ints;

		}

//		public static void SetTextBoxValues(
//			DataList dataList,
//			string textBoxName,
//			DataTable dataTable
//			)
//		{
//
//			int[] ids = TypesHelper.GetInts( dataTable, columnName );
//
//			foreach( DataListItem item in dataList.Items )
//			{
//
//				if( item.ItemType == ListItemType.Item ||
//					item.ItemType == ListItemType.AlternatingItem)
//				{
//					TextBoxValue textBoxValue = 
//						item.FindControl( textBoxName ) as TextBoxValue;
//					textBoxValue.Value = 
//						TypesHelper.IntExists( checkBoxValue.Value, ids );
//				}
//			}
//
//		}
//		public static int[] GetTextBoxValues(
//			DataList dataList,
//			string textBoxName
//			)
//		{
//
//			ArrayList array = new ArrayList();
//
//			foreach( DataListItem item in dataList.Items )
//			{
//
//				if( item.ItemType == ListItemType.Item ||
//					item.ItemType == ListItemType.AlternatingItem)
//				{
//					CheckBoxValue checkBoxValue = 
//						item.FindControl( checkBoxName ) as CheckBoxValue;
//					if( checkBoxValue.Checked )
//					{
//						array.Add( Convert.ToInt32( checkBoxValue.Value ) );
//					}
//				}
//			}
//
//			int[] ints = (int[])array.ToArray( typeof( int ) );
//
//			return ints;
//
//		}

		#endregion

		#region FileName Helpers

		public static string DuplicateName( 
			string existingName 
			)
		{

			int count = 1;
			
			string endsWith = "(" + count.ToString() + ")";
			bool found = true;
			while( !existingName.EndsWith( endsWith ) )
			{
				count++;
				endsWith = "(" + count.ToString() + ")";
				if( count > 50 )
				{
					found = false;
					break;
				}
			}
			if( found )
			{
				return existingName.Substring( 0, existingName.Length - ( 2 + count.ToString().Length ) ) + " (" + count.ToString() + ")";
			}
			else
			{
				return existingName + " (1)";
			}

		}

		#endregion

	}
}