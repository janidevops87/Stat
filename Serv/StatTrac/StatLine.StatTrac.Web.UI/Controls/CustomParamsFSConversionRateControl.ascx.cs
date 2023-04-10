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
	///		Summary description for CustomParamsFSConversionRateControl.
	/// </summary>
	/// <remarks>
	/// <P>Name: CustomParamsFSConversionRateControl </P>
	/// <P>Date Created: 4/13/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Provides the Custom Params for FSConversion </P>
	/// </remarks> 
	public partial class CustomParamsFSConversionRateControl : Statline.StatTrac.Web.UI.BaseUserControl, Statline.StatTrac.Web.UI.IBaseParameters
	{
		
		protected void Page_Load(object sender, System.EventArgs e)
		{
			if(!IsPostBack && this.Visible)
				DataBind();
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

		public override void DataBind()
		{
			ddlApproachPerson.DataBind();
		}
		public void BuildParams(Hashtable parameters)
		{
			if(ddlApproachPerson.SelectedItem.Text != "...")
				parameters.Add(ReportParams.ApproachPersonID, ddlApproachPerson.SelectedItem.Value);
			parameters.Add(ReportParams.BoneSkinOnly, Convert.ToInt32(chkBoxBoneSkinOnly.Checked));
		}
	}

}



