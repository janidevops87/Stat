using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownReportStatTracUser.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownReportStatTracUser runat=server></{0}:DropDownReportStatTracUser>")]
	public class DropDownReportStatTracUser : DropDownListBase
	{

		private int userOrgID = 0;
		public override void DataBind()
		{

			this.DataValueField = "StatEmployeeID";
			this.DataTextField = "CoordinatorName";
			ReportReferenceData ds = new ReportReferenceData();			
            try
            {
    			Report.ReportReferenceManager.FillReportStatTracUserList(
				ds,
				userOrgID
				);
            }
            catch
            {
                throw;
            }

			DataView dataView =
				new DataView(ds.OrganizationCoordinatorList);
			
			dataView.Sort = this.DataTextField;

			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();
		}
		
		
		
		/// <summary>
		/// Used to set the UserOrgID property
		/// </summary>
		[Browsable(false)]
		public int UserOrgID
		{
			get { return userOrgID; }
			set { userOrgID = value; }
		}

	
	}
}

