using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.UI;
using System.ComponentModel;

namespace Statline.StatTrac.Web.UI.WebControls
{
    [DefaultProperty("Text"),
   ToolboxData("<{0}:ReportViewer runat=server></{0}:ReportViewer>")]		

    public class ReportViewer : WebControl
	{
		#region Private Member Variables

		// Private members that will map to url access builder.
		private bool _showToolbar = true;
		private bool _showParameters = false;
		private Hashtable _reportParameters = new Hashtable();
		private string _serverUrl = "";
		private String _reportPath = "";
		private bool _customReport = false;

		#endregion

		#region Constructors

		public ReportViewer()
		{
		}

		#endregion

		#region Properties

		[ Browsable(true), ReadOnly(true),
			Category("General Report Parameters"),
			Description("Full report url.") ]
		public string Url
		{
			get
			{
				return BuildURLString(ServerUrl,
				                      ReportPath,
				                      ShowParameters,
				                      ShowToolbar,
				                      ReportParameters);
			}
		}

		private Unit width;

		[ Bindable(false),
			Category("Layout"),
			DefaultValue(""),
			Description("Gets or sets the width of the web server control.") ]
		public Unit Width
		{
			get { return width; }
			set { width = value; }
		}

		private Unit height;

		[ Bindable(false),
			Category("Layout"),
			DefaultValue(""),
			Description("Gets or sets the height of the web server control.") ]
		public Unit Height
		{
			get { return height; }
			set { height = value; }
		}

		[ Category("General Report Parameters"),
			Description("Server url such as http://localhost/reportserver") ]
		public string ServerUrl
		{
			get { return _serverUrl; }
            set
            {   //confirm the end of the server string has a ? 
                if (!value.Substring(value.Length - 1, 1).Contains("?"))
                    value = value + "?";
                _serverUrl = value; }
		}

		[ Category("General Report Parameters"),
			Description("Report path such as /SampleReports/Company Sales") ]
		public String ReportPath
		{
			get { return _reportPath; }

			set { _reportPath = value; }
		}

		[ Category("HTMLViewer Commands"),
			Description("Indicates whether to display the report toolbar.") ]
		public bool ShowToolbar
		{
			get { return _showToolbar; }
			set { _showToolbar = value; }
		}

		[ Category("HTMLViewer Commands"),
			Description("Indicates whether to show the parameters area of the toolbar.") ]
		public bool ShowParameters
		{
			get { return _showParameters; }
			set { _showParameters = value; }
		}

		public Hashtable ReportParameters
		{
			get { return _reportParameters; }
			set { _reportParameters = value; }
		}

		public bool CustomReport
		{
			get { return _customReport; }
			set { _customReport = value; }
		}

		#endregion

		#region Methods

		/// <summary>
		/// Enumerate Hashtable and create report server access specific string.
		/// </summary>
		/// <param name="properties"></param>
		/// <returns></returns>
		private static string EmumProperties(Hashtable properties)
		{
			string paramsString = String.Empty;
			// Enumerate properties and create report server specific string.
			IDictionaryEnumerator customPropEnumerator = properties.GetEnumerator();
			while (customPropEnumerator.MoveNext())
			{
				paramsString += "&"
				                + customPropEnumerator.Key
				                + "=" + customPropEnumerator.Value;
			}

			return paramsString;
		}

		/// <summary>
		/// Called to retrieve URL string to run a report when the report is to be displayed in the 
		/// main or a pop-up window without the standard surrounding page header/nav/footer.
		/// </summary>
		/// <param name="serverURL">URL to the ReportServer. Retrieve value from ConfigUtil.ReportServerURL</param>
		/// <param name="reportPath">Path to the report on the ReportServer "/JobRequisitionLog/[Report Name]"</param>
		/// <param name="showParameters">Boolean flag indicating whether or not to show parameter entry section when rendering report in HTML. Generally should specify False.</param>
		/// <param name="showToolbar">Boolean flag indicating whether to show toolbar when rendering in HTML for features such as exporting, paging, etc.  Generally should specify True.</param>
		/// <param name="reportParameters">Hashtable containing parameters for the report.  Key should be parameter name.</param>
		/// <returns>URL that will run the report using Reporting Services URL API</returns>
		public static string BuildURLString
			(string serverURL, string reportPath, bool showParameters, bool showToolbar, Hashtable reportParameters)
		{
			string strShowToolbar = "false";
			string strShowParameters = "false";

			if (showToolbar)
			{
				strShowToolbar = "true";
			}

			if (showParameters)
			{
				strShowParameters = "true";
			}

			reportParameters.Add("rc:toolbar",
			                     strShowToolbar);
			reportParameters.Add("rc:parameters",
			                     strShowParameters);
            reportParameters.Add("rc:LinkTarget", "_blank");
			//reportParameters.Add("rs:SessionID", System.Web.HttpContext.Current.Session.SessionID);


//			string url = serverURL + reportPath + 
//				"&rs:Command=Blank&rc:LinkTarget=_blank" + EmumProperties(reportParameters);
			string url = string.Format("{0}{1}&rs:Command=Blank{2}",
			                           serverURL,
			                           reportPath,
			                           EmumProperties(reportParameters));
			return url;
		}

		#endregion

		#region Render

		/// <summary>
		/// Render the report in an IFrame
		/// </summary>
		/// <param name="output"></param>
		protected override void Render(HtmlTextWriter output)
		{
			if (_serverUrl == String.Empty || _reportPath == String.Empty)
			{
				output.Write("<P style=\"font-family: Verdana; font-size: 11px\">");
				output.Write("To render a report, enter the ServerUrl and ReportPath.</P>");
			}
			else
			{
				// Create IFrame if the user enters ServerUrl and ReportPath
				output.WriteBeginTag("iframe");

				//URL string size has a limit of 2048 characters
				//Posting to the report server does not have limit on hidden field's values
                //if (_customReport)
                //{
					output.WriteAttribute("src",
					                      BuildURLString(_serverUrl,
					                                     _reportPath,
					                                     _showParameters,
					                                     _showToolbar,
					                                     _reportParameters));
                //}
                //else
                //{
                //    output.WriteAttribute("src", 
                //                          Page.ResolveUrl("~") + "/Reporting/DisplayReportPost.aspx");
                //}
				output.WriteAttribute("width",
				                      Width.ToString());
				output.WriteAttribute("height",
				                      Height.ToString());
				output.WriteAttribute("style",
				                      "border: 1 solid #C0C0C0");
				output.WriteAttribute("border",
				                      "0");
				output.WriteAttribute("frameborder",
				                      "0");

				output.Write(HtmlTextWriter.TagRightChar);
				output.WriteEndTag("iframe");
				output.WriteLine();
			}
		}

		#endregion
    }
}
