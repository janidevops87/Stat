using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for ErrorManager.
	/// </summary>
	public class ErrorManager
	{
		private ErrorManager(){}

		public const string MostRecentExceptionKey = "MostRecentExceptionKey";

		public static Exception MostRecentException
		{
			get
			{
				try
				{
					return (Exception)HttpContext.Current.Items[ ErrorManager.MostRecentExceptionKey ];
				}
				catch
				{
					return null;
				}
			}
			set
			{
				try
				{
					HttpContext.Current.Items[ ErrorManager.MostRecentExceptionKey ] = value;
				}
				catch
				{
					HttpContext.Current.Items[ ErrorManager.MostRecentExceptionKey ] = null;
				}
			}
		}


		public static byte[] CreateMessageListBytes()
		{
			string message = ErrorManager.CreateMessageList();
			return Encoding.Unicode.GetBytes( message );
		}

		public static string CreateMessageList()
		{

			string rendered = null;

			string separator = "".PadRight( 125, '-' );

			separator = "<b>" + separator + "</b>";


			NameValueData data = new NameValueData();

			data.NameValues.AddNameValuesRow( "Machine Information", separator );
			data.NameValues.AddNameValuesRow( "MachineName", Environment.MachineName );
			data.NameValues.AddNameValuesRow( "OSVersion ", Environment.OSVersion.ToString() );
			data.NameValues.AddNameValuesRow( "MemoryWorkingSet", Environment.WorkingSet.ToString() );
			data.NameValues.AddNameValuesRow( "Version", Environment.Version.ToString() );

			HttpContext context = HttpContext.Current;
			
			if( context != null )
			{
				BasePage page = context.Handler as BasePage;
				if( page != null )
				{

					data.NameValues.AddNameValuesRow( "Page Information", separator );
					data.NameValues.AddNameValuesRow( "Type", page.GetType().ToString() );
					data.NameValues.AddNameValuesRow( "BaseType", page.GetType().BaseType.ToString() );
					data.NameValues.AddNameValuesRow( "Title", page.Title );
					data.NameValues.AddNameValuesRow( "StyleSheet", page.StyleSheet.ToString() );

					data.NameValues.AddNameValuesRow( "QueryStringManager Information", separator );
					data.NameValues.AddNameValuesRow( "CurrentPage", QueryStringManager.CurrentPage.ToString() );
					data.NameValues.AddNameValuesRow( "NextPage", QueryStringManager.NextPage.ToString() );
					data.NameValues.AddNameValuesRow( "DisplayMode", QueryStringManager.DisplayMode.ToString() );

					data.NameValues.AddNameValuesRow( "User Information", separator );
					data.NameValues.AddNameValuesRow( "UserName", page.User.Identity.Name );
					data.NameValues.AddNameValuesRow( "Authenticated", page.User.Identity.IsAuthenticated.ToString() );
					//data.NameValues.AddNameValuesRow( "Roles", string.Join( ", ", page.User.Roles ) );

					Exception exception = ErrorManager.MostRecentException;
					if( exception != null )
					{
						data.NameValues.AddNameValuesRow( "Exception Information", separator );
						data.NameValues.AddNameValuesRow( ErrorManager.MostRecentExceptionKey, exception.ToString() );
					}

				}

				data.NameValues.AddNameValuesRow( "ServerVariables", separator );
				foreach( string key in context.Request.ServerVariables.Keys)
				{
					data.NameValues.AddNameValuesRow( key, context.Request.ServerVariables[key] );
				}

				data.NameValues.AddNameValuesRow( "Cookies", separator );
				foreach( string name in context.Request.Cookies.Keys )
				{
					data.NameValues.AddNameValuesRow( name, context.Request.Cookies[ name ].Value );
				}

				data.NameValues.AddNameValuesRow( "Form Variables", separator );
				foreach( string name in context.Request.Form.Keys )
				{
					data.NameValues.AddNameValuesRow( name, context.Request.Form[ name ] );
				}

				rendered = ErrorManager.RenderDataTable( data.NameValues );
			
			}

			return rendered;

		}

		public static string RenderDataSet(
			DataSet dataSet )
		{

			StringBuilder sb = new StringBuilder();

			if( dataSet != null )
			{
				for( int i = 0; i < dataSet.Tables.Count; i++ )
				{
					sb.AppendFormat( "<br>{0}<br><br>", dataSet.Tables[ i ].TableName );
					sb.Append( RenderDataTable( dataSet.Tables[ i ] ) );
				}
			}
			else
			{
				sb.Append( "No data in dataset." ); 
			}

			return sb.ToString();
		}

		public static string RenderDataTable(
			DataTable dataTable )
		{
			StringWriter sw = new StringWriter();

			HtmlTextWriter writer = new HtmlTextWriter( sw );

			DataGrid dg = new DataGrid();

			dg.Width = new Unit( "100%" );
			dg.AutoGenerateColumns = true;
			dg.Font.Name = "Verdana";
			dg.Font.Size = new FontUnit( "10px" );

			dg.DataSource = dataTable;

			dg.ItemDataBound += 
				new System.Web.UI.WebControls.DataGridItemEventHandler(
				nameValueDataDataGrid_ItemDataBound);

			dg.DataBind();

			dg.RenderControl( writer );

			writer.Close();

			sw.Close();

			return sw.ToString();

		}

		private static void nameValueDataDataGrid_ItemDataBound(
			object sender, 
			System.Web.UI.WebControls.DataGridItemEventArgs e
			)
		{

			if( e.Item.ItemType == ListItemType.Item | 
				e.Item.ItemType == ListItemType.AlternatingItem )
			{

				TableCell cell = e.Item.Cells[1];

				cell.Attributes.Add( "width", "650px" );
				cell.Attributes.Add( "nowrap", "nowrap" );
				
				if( cell.Text.Length > MaxLength )
				{
					cell.Text = Split( cell.Text );
				}

			}

		}

		const int MaxLength = 80;


		private static string Split( string value )
		{
			string newValue = "";

			while( value.Length > MaxLength )
			{
				newValue += value.Substring( 0, MaxLength ) + "<br>\r\n";
				value = value.Substring( MaxLength + 1 );
			}

			newValue += value;

			return newValue;

		}

	}
}
