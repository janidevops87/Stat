using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Text;
using System.Security.Permissions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Statline.StatTrac.Web.UI
{
	/// <summary>
	/// Summary description for ExportManager.
	/// </summary>
	public class ExportManager
	{

		public static string RenderControl(
			Control control )
		{

			StringWriter  sw = new StringWriter();
			HtmlTextWriter w = new HtmlTextWriter( sw );
			control.RenderControl( w );

			return sw.ToString();

		}

		public static void Export( 
			DataTable dataTable,
			string fileName,
			ContentType contentType
			)
		{

			ExportManager.Export( dataTable, fileName, contentType, null );
		
		}

		public static void Export( 
			DataTable dataTable,
			string fileName,
			ContentType contentType,
			Hashtable headings
			)
		{
			string content = ExportManager.GetString( dataTable, headings );

			DownloadManager.Download( content, fileName, contentType );
		}

		public static void ExportCustom( 
			DataTable dataTable,
			string fileName,
			ContentType contentType,
			SortedList headings
			)
		{
			string content = ExportManager.GetStringCustom( dataTable, headings );

			DownloadManager.Download( content, fileName, contentType );
		}

		private static string GetStringCustom( 
			DataTable dataTable,
			SortedList columns
			)
		{
			StringBuilder sb = new StringBuilder();

			foreach( int key in columns.Keys )
			{
				sb.AppendFormat( "\"{0}\",", columns[ key ] );
			}
			sb.Append( Environment.NewLine );

			DataRow row;
			for( int rowIndex = 0; rowIndex < dataTable.Rows.Count; rowIndex++ )
			{
				row = dataTable.Rows[ rowIndex ];
				foreach( int key in columns.Keys )
				{
					sb.AppendFormat( "\"{0}\",", row[ key ] );
				}
				sb.Append( Environment.NewLine );
			}

			return sb.ToString();
		}

		public static void ExportCustom( 
			DataView dataView,
			string fileName,
			ContentType contentType,
			SortedList headings
			)
		{
			string content = ExportManager.GetStringCustom( dataView, headings );

			DownloadManager.Download( content, fileName, contentType );
		}

		private static string GetStringCustom( 
			DataView dataView,
			SortedList columns
			)
		{
			StringBuilder sb = new StringBuilder();

			foreach( int key in columns.Keys )
			{
				sb.AppendFormat( "\"{0}\",", columns[ key ] );
			}
			sb.Append( Environment.NewLine );

			DataRowView rowView;
			for( int rowIndex = 0; rowIndex < dataView.Count; rowIndex++ )
			{
				rowView = dataView[ rowIndex ];
				foreach( int key in columns.Keys )
				{
					sb.AppendFormat( "\"{0}\",", rowView[ key ] );
				}
				sb.Append( Environment.NewLine );
			}

			return sb.ToString();
		}

		private static string GetString( 
			DataTable dataTable,
			Hashtable headings
			)
		{
			StringBuilder sb = new StringBuilder();

			string heading = null;

			for( int columnIndex = 0; columnIndex < dataTable.Columns.Count - 1; columnIndex++ )
			{
				if( headings != null && headings[ columnIndex ] != null )
				{
					heading = headings[ columnIndex ].ToString();
				}
				else
				{
					heading = dataTable.Columns[ columnIndex ].ColumnName;
				}
				sb.AppendFormat( "\"{0}\",", heading );
			}

			if( headings != null && headings[ dataTable.Columns.Count - 1 ] != null )
			{
				heading = headings[ dataTable.Columns.Count - 1 ].ToString();
			}
			else
			{
				heading = dataTable.Columns[ dataTable.Columns.Count - 1 ].ColumnName;
			}

			sb.AppendFormat( "\"{0}\"{1}", heading, Environment.NewLine );

			DataRow row;
			for( int rowIndex = 0; rowIndex < dataTable.Rows.Count; rowIndex++ )
			{
				row = dataTable.Rows[ rowIndex ];
				for( int columnIndex = 0; columnIndex < dataTable.Columns.Count - 1; columnIndex++ )
				{
					sb.AppendFormat( "\"{0}\",", row[ columnIndex ].ToString() );
				}
				sb.AppendFormat( "\"{0}\"{1}", row[ dataTable.Columns.Count - 1 ].ToString(), Environment.NewLine );
			}

			return sb.ToString();
		}

		private static string GetString( 
			DataView ExportDataView 
			)
		{
			StringBuilder sb = new StringBuilder();

			for( int columnIndex = 0; columnIndex < ExportDataView.Table.Columns.Count - 1; columnIndex++ )
			{
				sb.AppendFormat( "\"{0}\",", ExportDataView.Table.Columns[ columnIndex ].ColumnName );
			}
			sb.AppendFormat( "\"{0}\"{1}", ExportDataView.Table.Columns[ ExportDataView.Table.Columns.Count - 1 ].ColumnName, Environment.NewLine );

			DataRowView rowView;
			for( int rowIndex = 0; rowIndex < ExportDataView.Count; rowIndex++ )
			{
				rowView = ExportDataView[ rowIndex ];
				for( int columnIndex = 0; columnIndex < ExportDataView.Table.Columns.Count - 1; columnIndex++ )
				{
					sb.AppendFormat( "\"{0}\",", rowView[ columnIndex ].ToString() );
				}
				sb.AppendFormat( "\"{0}\"{1}", rowView[ ExportDataView.Table.Columns.Count - 1 ].ToString(), Environment.NewLine );
			}

			return sb.ToString();
		}

		private static DataView ApplySort(
			DataTable dataTable, 
			string sortExpression
			)
		{

			return new DataView(
				dataTable, null, sortExpression, DataViewRowState.OriginalRows);
		}

	}
}