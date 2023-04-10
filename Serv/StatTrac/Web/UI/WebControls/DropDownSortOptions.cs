using System;
using System.Collections;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using Statline.StatTrac.Data.Types;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Statline.Framework;
using Statline.Framework.Logger;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for ReportSortOptions.
	/// </summary>
	[DefaultProperty("Text"), 
		ToolboxData("<{0}:DropDownSortOptions runat=server></{0}:DropDownSortOptions>")]
	public class DropDownSortOptions : DropDownListBase	
	{
		public ReportReferenceData SortOptionDataSet
		{
			set { sortOptionDataSet = value; }
		}

		private ReportReferenceData sortOptionDataSet = new ReportReferenceData();
		public override void DataBind()
		{
			this.DataValueField = "ReportSortTypeName";
			this.DataTextField = "ReportSortTypeDisplayname";
			
			DataView dataView;
			try
			{
				dataView =
					new DataView(sortOptionDataSet.ReportSortType);
			}
			catch(Exception ex)
			{
                AppLogger.CreateInstance(BaseIdentity.CurrentIdentity.Name, "General", BaseIdentity.ApplicationSecrets[Common.Constants.LoggingPassword]).Write(ex);
                throw;
			}
			dataView.Sort = this.DataTextField;

			base.DataSource = dataView;
			this.Items.Clear();
			base.DataBind();
		}

//		[Browsable(false)]
//		public string SortByID
//		{
//			get { return base.Value; }
//			set { base.Value = value; }
//		}

	}
}
