using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownCauseOfDeath.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownCauseOfDeath runat=server></{0}:DropDownCauseOfDeath>")]		
	public class DropDownCauseOfDeath : DropDownListBase
	{
		public override void DataBind()
		{

			this.DataValueField = "CauseOfDeathID";
			this.DataTextField = "CauseOfDeathName";
			ReportReferenceData ds = new ReportReferenceData();			
            try
            {
    			Report.ReportReferenceManager.FillReportCauseOfDeathList(
				ds
				);
            }
            catch
            {
                throw;
            }

			DataView dataView =
				new DataView(ds.CauseOfDeath);
			
			dataView.Sort = this.DataTextField;

			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();
		}
	
	
	}
}
