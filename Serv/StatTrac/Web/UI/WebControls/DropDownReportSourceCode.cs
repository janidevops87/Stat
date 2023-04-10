using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownReportSourceCode.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownReportSourceCode runat=server></{0}:DropDownReportSourceCode>")]	
	public class DropDownReportSourceCode : DropDownListBase
	{
		private int reportGroupID = 0;
        private int sourceCodeTypeID = 0;
		public override void DataBind()
		{

			ReportReferenceData ds = new ReportReferenceData();
			this.DataValueField = "SourceCodeID";
			this.DataTextField = "SourceCodeName";
			
	        try
            {
    			Report.ReportReferenceManager.FillReportSourceCodeList(
				ds,
				ReportGroupID,
                sourceCodeTypeID
				);
            }
            catch
            {
                throw;
            }

			DataView dataView =
				new DataView(ds.SourceCodeNameList);
			
			dataView.Sort = this.DataTextField;

			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();
		}


		/// <summary>
		/// The property ReportGroupID is used to specify what Organizations are displayed
		/// </summary>
		[Browsable(false)]
		public int ReportGroupID
		{
			get { return reportGroupID; }
			set { reportGroupID = value; }
		}
        [Browsable(false)]
        public int SourceCodeTypeID
        {
            get { return sourceCodeTypeID; }
            set { sourceCodeTypeID = value; }
        }
	
		
	}
}
