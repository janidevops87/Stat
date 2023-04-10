using System.Collections;

namespace Statline.StatTrac.Web.UI.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;

	/// <summary>
	///		Summary description for CustomParamsProcessor.
	/// </summary>
	/// <P>Name: CustomParamsProcessor </P>
	/// <P>Date Created: 7/26/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Provides the Custom Params for Processor Numbers </P>
	/// </remarks> 
	public partial class CustomParamsProcessor : Statline.StatTrac.Web.UI.BaseUserControl, Statline.StatTrac.Web.UI.IBaseParameters
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
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

		}
		#endregion

		public void BuildParams(Hashtable reportParams)
		{
			reportParams.Add(ReportParams.ProcessorType, ddlProcessorList.SelectedValue);
		}
	}
}
