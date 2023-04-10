using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.Registry.Reports;
using Statline.Registry.Data.Types.Reports;

namespace Statline.StatTrac.Web.UI.WebControls
{
    /// <summary>
	/// Summary description for DropDownRegistrySubCategory.
	/// </summary>
	[DefaultProperty("Text"),
    ToolboxData("<{0}:DropDownRegistrySubCategory runat=server></{0}:DropDownRegistrySubCategory>")]
    public class DropDownRegistrySubCategory : DropDownListBase
    {
        private string state = "";
        private int eventCategory;


	
        public override void DataBind()
        {
            this.DataValueField = "EventSubCategoryID";
            this.DataTextField = "EventSubCategoryName";
            RegistryData ds = new RegistryData();
            RegistryReferenceManager.FillRegistryOutreachSubList(
                ds, eventCategory, state
            );
            DataView dataView = new DataView();
            dataView = ds.Tables["EventSubCategory"].DefaultView;
            dataView.Sort = this.DataTextField;
            base.DataSource = dataView;
            this.Items.Clear();
            base.DataBind();
        }
        [Browsable(false)]
        public string State
        {
            get { return state; }
            set { state = value; }
        }
        [Browsable(false)]
        public int EventCategory
        {
            get { return eventCategory; }
            set { eventCategory = value; }
        }
    }
}
