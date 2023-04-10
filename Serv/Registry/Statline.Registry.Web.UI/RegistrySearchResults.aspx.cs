using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Statline.StatTrac.Web.UI;
using Statline.StatTrac.Web.Security;

namespace Statline.Registry.Web.UI
{
    public partial class RegistrySearchResults : BasePageSecure
    {
        public RegistrySearchResults() : base(PageName.RegistrySearchResults)
        {
            BaseMenuControl.MainMenu = MenuName.Registry;
            BaseMenuControl.SubMenu = MenuName.RegistrySearch;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = "Registry Search Results";

            RuleName = AuthRule.Search;

        }
    }
}
