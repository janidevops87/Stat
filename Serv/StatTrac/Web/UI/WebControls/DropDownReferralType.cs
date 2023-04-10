using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownReferralType.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownReferralType runat=server></{0}:DropDownReferralType>")]	
	public class DropDownReferralType : DropDownListBase
	{
        private int reportGroupID = 0;
        private int sourceCodeID = 0;
        [Browsable(false)]
        public int SourceCodeID
        {
            get { return sourceCodeID; }
            set { sourceCodeID = value; }
        }
        [Browsable(false)]
        public int ReportGroupID
        {
            get { return reportGroupID; }
            set { reportGroupID = value; }
        }
	
		public override void DataBind()
		{

			this.DataValueField = "ReferralTypeID";
			this.DataTextField = "ReferralTypeName";
			ReportReferenceData ds = new ReportReferenceData();
            //call different sproc for pending referral report
            if (Page.Cookies.ReportID == 220)
            {
                try
                {
                    ds.ReferralType.Clear();
                    Report.ReportReferenceManager.FillReportPendingReferralType(
				    ds,
                    reportGroupID
				    );
                }
                catch
                {
                    throw;
                }
            }
            else
            {
                try
                {
                    ds.ReferralType.Clear();
                    Report.ReportReferenceManager.FillReportReferralTypeList(
				    ds,
                    reportGroupID,
                    sourceCodeID
				    );
                }
                catch
                {
                    throw;
                }
            }
			DataView dataView =
				new DataView(ds.ReferralType);
			
            //dataView.Sort = this.DataTextField;

			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();
		}
		

	}
}


