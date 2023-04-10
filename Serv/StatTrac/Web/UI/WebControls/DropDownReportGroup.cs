using System.ComponentModel;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Statline.StatTrac.Data.Report;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Data;
using Statline.StatTrac.Report;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownReportGroup.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownReportGroup runat=server></{0}:DropDownReportGroup>")]
	public class DropDownReportGroup : DropDownListBase	
	{

		private int userOrgID = 0;
		public void DataBind(string TextToSet )
		{
			this.DataBind();
			this.SetDefaultItem = TextToSet;
		}
		public override void DataBind()
		{

			this.DataValueField = "WebReportGroupID";
			this.DataTextField = "ReportGroupName";
			
			ReportReferenceData ds = new ReportReferenceData();
            try
            {
                ReportReferenceManager.FillReportGroupList(
				ds, 
				UserOrgID);
            }
            catch
            {
                throw;
            }

			DataView dataView =
				new DataView(ds.WebReportGroupList);
			
			dataView.Sort = this.DataTextField;

			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();
		
		}


		/// <summary>
		/// The property UserOrgId is used to specify which ReportGroups are Displayed based on the users OrganizationID
		/// </summary>
		[Browsable(false)]
		public int UserOrgID
		{
			get { return userOrgID; }
			set { userOrgID = value; }
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
