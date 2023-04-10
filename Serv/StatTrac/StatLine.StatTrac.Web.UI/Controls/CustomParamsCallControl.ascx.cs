using System.Collections;
using System;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Statline.StatTrac.Web.UI.Controls
{

	/// <summary>
	///		Summary description for CustomParamsCallControl.
	/// </summary>
	public partial class CustomParamsCallControl : Statline.StatTrac.Web.UI.BaseUserControl, 
		Statline.StatTrac.Web.UI.IBaseParameters
	{
		
		protected void Page_Load(object sender, System.EventArgs e)
		{
			SetCallIDLabel(Page.Cookies.ReportName.ToString());
		}
		private void SetCallIDLabel(string reportName)
		{
            
			if(reportName.IndexOf("Referral")>0)
			{
				callIDFieldLabel.Text = "Referral";
			}
			else if(reportName.IndexOf("Message")>0)
			{
				callIDFieldLabel.Text = "Message";
			}
			else if(reportName.IndexOf("Import")>0)
			{
				callIDFieldLabel.Text = "Import";
			}

		}
		public void BuildParams(Hashtable parameters)
		{
			//check each of the params 
			//if the check box is not enable grab the value.
			//if the check box is enable assume null and do nothing
			if (txtBoxCallID.Text.Length > 0 )
				parameters.Add(ReportParams.CallID.ToString(), txtBoxCallID.Text);
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
	}
}
