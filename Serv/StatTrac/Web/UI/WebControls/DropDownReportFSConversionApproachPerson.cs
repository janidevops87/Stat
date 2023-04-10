using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownReportFSConversionApproachPerson.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownReportFSConversionApproachPerson runat=server></{0}:DropDownReportFSConversionApproachPerson>")]
	public class DropDownReportFSConversionApproachPerson : DropDownListBase
	{
		private int organizationID = 0;
		public override void DataBind()
		{

			this.DataValueField = "PersonID"; 
			this.DataTextField = "PersonName";
            ReportReferenceData ds = new ReportReferenceData(); 
            try
            {
    			Report.ReportReferenceManager.FillFSConversionRateApproachPerson(
				ds
				);
            }
            catch
            {
                throw;
            }

			DataView dataView =
				new DataView(ds.ApproachPersonList);
			
			dataView.Sort = this.DataTextField;

			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();
		}


		/// <summary>
		/// The property ReportGroupID is used to specify what Organizations are displayed
		/// </summary>
		[Browsable(false)]
		public int OrganizationID
		{
			get { return organizationID; }
			set { organizationID = value; }
		}
		
	}
}
