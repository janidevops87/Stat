using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownReportOrganizationCoordinator.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownReportOrganizationCoordinator runat=server></{0}:DropDownReportOrganizationCoordinator>")]
	public class DropDownReportOrganizationCoordinator : DropDownListBase
	{
        private int userOrgID = 0;
        private int reportGroupID = 0;
        private int coordinatorOrganizationID = 0;

        public int CoordinatorOrganizationID
        {
            get { return coordinatorOrganizationID; }
            set { coordinatorOrganizationID = value; }
        }
	
        public int ReportGroupID
        {
            get { return reportGroupID; }
            set { reportGroupID = value; }
        }
	
        public int UserOrgID
        {
            get { return userOrgID; }
            set { userOrgID = value; }
        }
	
		public override void DataBind()
		{

			this.DataValueField = "StatEmployeeID";
			this.DataTextField = "CoordinatorName";
			ReportReferenceData ds = new ReportReferenceData();			
            try
            {
    			Report.ReportReferenceManager.FillReportCoordinatorList(
				ds,
                UserOrgID,
                ReportGroupID,
                CoordinatorOrganizationID
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

	
	}
}
