using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.IO;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;


using Statline.StatTrac;
//using Statline.StatTrac.Caching;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.Controls.Admin
{

	public partial class AdministrationControl : BaseUserControlSecure
	{
		//protected Statline.StatTrac.Data.Types.ReferenceData referenceData;
		protected System.Data.DataView dataViewList;
		protected System.Web.UI.HtmlControls.HtmlTableRow addTableRow;

		public AdministrationControl()
		{
		}

		protected void Page_Load(
			object sender, 
			System.EventArgs e)
		{
			if( !IsPostBack )
			{
				this.DataBind();
			}
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
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			//this.referenceData = new Statline.FSB.Data.Types.ReferenceData();
			this.dataViewList = new System.Data.DataView();
			//((System.ComponentModel.ISupportInitialize)(this.referenceData)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.dataViewList)).BeginInit();
			//((System.ComponentModel.ISupportInitialize)(this.referenceData)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.dataViewList)).EndInit();

		}
		#endregion


		public override void DataBind()
		{
			//this.optionTextBox.Text = FSBOptionManager.GetOption( FSBOption.BoardRefreshInterval );
		}

		protected void saveButton_Click(
			object sender, 
			System.EventArgs e)
		{
			Page.Validate();
			if( Page.IsValid )
			{
				//FSBOptionManager.SaveOption( FSBOption.BoardRefreshInterval, 
				//	this.optionTextBox.Text, this.Page.User.Identity.Name );
				DisplayMessages.Add( MessageType.InformationalMessage, "Your changes were saved." );
			}

		}

	}
}