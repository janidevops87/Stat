using System;
using System.Web;
using System.Text;

namespace Statline.StatTrac.Web.UI
{

	public enum ContentType { Html, Word, Pdf, Excel, Gif, Jpg, Text, Xml, Unknown };

	public class DownloadManager
	{
		private DownloadManager() {}


		const string contentDispositionFormat = "attachment; filename={0}";

		
		public static void Download(
			string content,
			string fileName,
			ContentType contentType
			)
		{
			DownloadManager.Download(
				content,
				fileName,
				contentType,
				true );
		}

		public static void Download(
			string content,
			string fileName,
			ContentType contentType,
			bool endResponse
			)
		{
			byte[] output = Encoding.UTF8.GetBytes( content );

			DownloadManager.Download( 
				output,
				fileName,
				contentType,
				endResponse );

		}

		public static void Download(
			byte[] content,
			string fileName,
			ContentType contentType,
			bool endResponse
			)
		{

			HttpContext context = HttpContext.Current;

			if( context != null )
			{
				context.Response.Clear();
				context.Response.ContentType = DownloadManager.ConvertContextType( contentType );
				context.Response.AppendHeader( "Content-Disposition", string.Format( contentDispositionFormat, fileName ) );
				context.Response.BinaryWrite( content );
				context.Response.Flush();
				if( endResponse )
				{
					context.Response.End();
				}
			}
		}
	
		private static string ConvertContextType( 
			ContentType contentType )
		{
			switch( contentType )
			{

				case ContentType.Word : return "application/msword";
				case ContentType.Pdf : return "application/pdf";
				case ContentType.Excel : return "application/vnd.ms-excel";
				case ContentType.Gif : return "image/gif";
				case ContentType.Jpg : return "image/jpeg";
				case ContentType.Text : return "text/txt";
				case ContentType.Html : return "text/html";
				case ContentType.Xml : return "text/xml";
				default : return "application/unknown";

			}
		}


	}
}
