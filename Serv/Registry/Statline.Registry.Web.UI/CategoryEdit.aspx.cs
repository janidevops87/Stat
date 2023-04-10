using System;
using Statline.StatTrac.Web.UI;
using Statline.StatTrac.Web.Security;


namespace Statline.Registry.Web.UI
{
    public partial class CategoryEdit : BasePageSecure
    {
        public CategoryEdit() : base(PageName.CategoryEdit)
        {
            BaseMenuControl.MainMenu = MenuName.Registry;
            BaseMenuControl.SubMenu = MenuName.MaintainCategory;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = "Registry Search";

            RuleName = AuthRule.MaintainCategory;
        }
    }
}
