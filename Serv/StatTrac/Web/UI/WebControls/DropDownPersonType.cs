using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Statline.StatTrac.Admin;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Web.UI.WebControls
{
	/// <summary>
	/// Summary description for DropDownPersonType.
	/// </summary>
	[DefaultProperty("Text"), 
	ToolboxData("<{0}:DropDownReportPersonType runat=server></{0}:DropDownReportPersonType>")]
	public class DropDownPersonType : DropDownListBase
	{
		private int reportGroupID = 0;
		public void DataBind(string defaultValue)
		{
			this.DataBind();
			this.SetDefaultValue = defaultValue;

		}
		public override void DataBind()
		{

			this.DataValueField = "PersonTypeId";
			this.DataTextField = "PersonTypeName";
			
			UserData ds = new UserData();
            try
            {
                AdminReferenceManager.FillPersonTypeList(
				ds
				);
            }
            catch
            {
                throw;
            }
			
			DataView dataView =
				new DataView(ds.PersonType);
			
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
		public string SetDefaultValue
		{
			
			set
			{
				ListItem listItem = this.Items.FindByValue(value.ToString() );
				if( listItem != null  )
				{

					this.SelectedIndex = this.Items.IndexOf( listItem );
				}
				
			}
		}	
	}
}
