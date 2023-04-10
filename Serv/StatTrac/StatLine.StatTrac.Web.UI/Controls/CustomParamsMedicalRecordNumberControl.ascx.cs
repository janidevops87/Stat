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
	///		Summary description for CustomParamsMedicalRecordNumberControl.
	/// </summary>
	public partial class CustomParamsMedicalRecordNumberControl : Statline.StatTrac.Web.UI.BaseUserControl, 
		Statline.StatTrac.Web.UI.IBaseParameters
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
			if (txtBoxMedicalRecordNumber.Text.Length > 0 )
				reportParams.Add(ReportParams.MedicalRecordNumber.ToString(), 
					txtBoxMedicalRecordNumber.Text);
		}
	}
}
