using System;
using System.ComponentModel;
using System.Data;
using System.Web.UI;
using Statline.Registry.Reports;
using Statline.Registry.Data.Types.Reports;

namespace Statline.StatTrac.Web.UI.WebControls
{
    /// <summary>
    /// Summary description for DropDownRegistryMainCategory.
    /// </summary>
    [DefaultProperty("Text"),
    ToolboxData("<{0}:DropDownRegistryMainCategory runat=server></{0}:DropDownRegistryMainCategory>")]
    public class DropDownRegistryMainCategory : DropDownListBase
    {
        private string state = "";
        public override void DataBind()
        {
            this.DataValueField = "EventCategoryID";
            this.DataTextField = "EventCategoryName";
            RegistryData ds = new RegistryData();
            RegistryReferenceManager.FillRegistryOutreachList(
                ds, state
            );

            DataView dataView =
                new DataView();
            dataView = ds.Tables["EventCategory"].DefaultView;
            dataView.Sort = this.DataTextField;
            base.DataSource = dataView;
            this.Items.Clear();
            base.DataBind();
        }
        [Browsable(false)]
        public string State
        {
            get { return state; }
            set { state = value;}
        }
    
    }
}
