using System.Collections;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.UI;

namespace Statline.StatTrac.Web.UI.Controls
{

	/// <summary>
	///		Summary description for WebUserControl1.
	/// </summary>
	public partial class CustomParamsAvayaTroubleReportControl : Statline.StatTrac.Web.UI.BaseUserControl, Statline.StatTrac.Web.UI.IBaseParameters 
		// Statline.StatTrac.Web.UI.BaseCustomParamsUserControl
	{

		protected void Page_Load(object sender, System.EventArgs e)
		{
			
				DisableTextBox(txtBoxAgentID);	
				DisableTextBox(txtBoxCallingNumber);
				DisableTextBox(txtBoxDialedNumber);
				DisableTextBox(txtBoxMinmumQueueTime);
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

		private void EnableTextBox(TextBox textBox)
		{
			textBox.Enabled = true;
			textBox.BackColor = Color.Empty;
		}
		private void DisableTextBox(TextBox textBox)
		{
			textBox.Enabled = false;
			textBox.BackColor = Color.FromName("#CCCCCC");

		}
		public void BuildParams(Hashtable parameters)
		{
			//check each of the params 
			//if the check box is not enable grab the value.
			//if the check box is enable assume null and do nothing
			if (txtBoxAgentID.Text.Length > 0 )
				parameters.Add(ReportParams.AnswerLoginID.ToString(), txtBoxAgentID.Text);	
			if (txtBoxCallingNumber.Text.Length > 0 )
				parameters.Add(ReportParams.CallingParty.ToString(), txtBoxCallingNumber.Text);
			if (txtBoxDialedNumber.Text.Length > 0 )		
				parameters.Add(ReportParams.DialedNumber.ToString(), txtBoxDialedNumber.Text);
			if (txtBoxMinmumQueueTime.Text.Length > 0 )					
				parameters.Add(ReportParams.MinQueueTime.ToString(), txtBoxMinmumQueueTime.Text);
		}

	}
}
