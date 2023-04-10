using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Report;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownDateType.
	/// 
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownDateType runat=server></{0}:DropDownDateType>")]
	public class DropDownDateType : DropDownListBase	
	{

		private int reportID = 0;
		public override void DataBind()
		{

			this.DataValueField = "ReportDateTypeName";
			this.DataTextField = "ReportDateTypeDisplayname";
			
			ReportReferenceData ds = new ReportReferenceData();
            try
            {
                ReportReferenceManager.FillReportDateTypeList(
				ds, 
				ReportID);
            }
            catch
            {
                throw;
            }

			DataView dataView =
				new DataView(ds.ReportDateType);
			
			dataView.Sort = this.DataTextField;

			
			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();

			//set the default dataitem.
			for(int loopCount = 0; loopCount<dataView.Table.Rows.Count;loopCount++)
			{
				if (Boolean.Parse(
					dataView.Table.Rows[loopCount]["ReportDateTypeConfigurationIsDefault"].ToString()) == true)
				{
					this.SetDefaultItem = 
						dataView.Table.Rows[loopCount]["ReportDateTypeDisplayname"].ToString();
				}
			}
		}


		/// <summary>
		/// The property UserOrgId is used to specify which ReportGroups are Displayed based on the users OrganizationID
		/// </summary>
		[Browsable(false)]
		public int ReportID
		{
			get { return reportID; }
			set { reportID = value; }
		}
		[Browsable(false)]
		public string SetDefaultItem
		{
			
			set
			{
				ListItem listItem = this.Items.FindByText(value.ToString() );
				if( listItem != null  )
				{

					this.SelectedIndex = this.Items.IndexOf( listItem );
				}
				
			}
		}
	}
}
