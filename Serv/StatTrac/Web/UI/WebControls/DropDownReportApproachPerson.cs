using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownReportApproachPerson.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownReportApproachPerson runat=server></{0}:DropDownReportApproachPerson>")]	
	public class DropDownReportApproachPerson :  DropDownListBase
	{
		public override void DataBind()
		{

			this.DataValueField = "PersonID";
			this.DataTextField = "CoordinatorName";
			ReportFSConversionRateData ds = new ReportFSConversionRateData(); 

            try
            {
                Report.ReportReferenceManager.FillApproachPerson(
				ds
				);
            }
            catch
            {
                throw;
            }

			DataView dataView =
				new DataView(ds.ApproachPerson);
			
			dataView.Sort = this.DataTextField;

			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();
		}

	}
}
