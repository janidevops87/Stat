using Infragistics.WebUI.UltraWebGrid;
using Statline.StatTrac.Report;

namespace Statline.StatTrac.Web.UI.Controls
{
	using System;
	using System.Data;
	using System.Drawing;
	using System.Web;
	using System.Web.UI.WebControls;
	using System.Web.UI.HtmlControls;
    using System.Web.Services;
using System.Web.UI;

	/// <summary>
	///		Summary description for ReportList.
	/// </summary>
	/// <remarks>
	/// <P>Name:  Statline.StatTrac.Web.UI.Controls.ReportList</P>
	/// <P>Date Created: 1/1/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Display a list of reports for the given user</P>
	/// </remarks>
	public partial class ReportList  : BaseUserControlSecure
	{
        protected Statline.StatTrac.Data.Types.ReportReferenceData reportReference;
		
		#region events

		protected void Page_Load(object sender, System.EventArgs e)
		{
            scmReportList.Scripts.Add(new ScriptReference(ResolveUrl("~/scripts/GenericPage.js")));                       
			// Check for post backpage load
				if (IsPostBack)
					return;
			// Databind page
				DataBind();
                
		}

		#endregion
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
			this.reportReference = new Statline.StatTrac.Data.Types.ReportReferenceData();
			((System.ComponentModel.ISupportInitialize)(this.reportReference)).BeginInit();
			this.gridReportList.InitializeLayout += new Infragistics.WebUI.UltraWebGrid.InitializeLayoutEventHandler(this.gridReportList_InitializeLayout);
			this.gridReportList.ActiveRowChange += new Infragistics.WebUI.UltraWebGrid.ActiveRowChangeEventHandler(this.gridReportList_ActiveRowChange);
			this.gridReportList.InitializeDataSource += new Infragistics.WebUI.UltraWebGrid.InitializeDataSourceEventHandler(this.gridReportList_InitializeDataSource);
			// 
			// reportReference
			// 
			this.reportReference.DataSetName = "ReportReferenceData";
			this.reportReference.Locale = new System.Globalization.CultureInfo("en-US");
			((System.ComponentModel.ISupportInitialize)(this.reportReference)).EndInit();

		}
		#endregion

		#region methods
		public  override void DataBind()
		{
			
            LoadReportReferenceDataSet();
			gridReportList.DataBind();

		}
		private void LoadReportReferenceDataSet()
		{
			// retrieve dataset from server if not already available
			if (reportReference.UserReportList.Rows.Count <= 0)
			{
				// fill dataset with server data
				try
				{
					ReportReferenceManager.FillUserReportList(
						reportReference, 
						Page.Cookies.UserId );	
				}
				catch
				{
					DisplayMessages.Add(MessageType.ErrorMessage, "A database error has prevented the Report List from being displayed");
				}
				
				//add guid column for new rows
			}
		}
		
		#endregion        
		private void gridReportList_InitializeLayout(object sender, Infragistics.WebUI.UltraWebGrid.LayoutEventArgs e)
		{
			// UltraWebGrid1.DisplayLayout.SelectTypeCellDefault=SelectType.Extended;
				gridReportList.DisplayLayout.SelectTypeCellDefault = SelectType.Extended;
			// UltraWebGrid1.DisplayLayout.SelectTypeRowDefault=SelectType.Single;
				gridReportList.DisplayLayout.SelectTypeRowDefault = SelectType.Single;
			// UltraWebGrid1.DisplayLayout.SelectTypeColDefault=SelectType.Extended;
				gridReportList.DisplayLayout.SelectTypeColDefault=SelectType.Extended;
			// UltraWebGrid1.DisplayLayout.CellClickActionDefault=CellClickAction.RowSelect;
				gridReportList.DisplayLayout.CellClickActionDefault=CellClickAction.RowSelect;
		}
      
		private void gridReportList_ActiveRowChange(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
		{
			Page.Cookies.ReportID = Convert.ToInt32(e.Row.Cells[0].Value);
			Page.Cookies.ReportName = Convert.ToString(e.Row.Cells[1].Value);
			Page.Cookies.ReportDisplayName = Convert.ToString(e.Row.Cells[2].Value);
			QueryStringManager.Redirect(PageName.ReportParams);

		}

		private void gridReportList_InitializeDataSource(object sender, Infragistics.WebUI.UltraWebGrid.UltraGridEventArgs e)
		{
			LoadReportReferenceDataSet();
		}

	}
}
