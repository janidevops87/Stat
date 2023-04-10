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

namespace Statline.Registry.Web.UI.Register.Dynamic
{
    public partial class ValidateDynamicMobile : BasePage
    {
        public ValidateDynamicMobile() : base(PageName.DynamicValidateMobile)
		{
			BaseMenuControl.MainMenu = MenuName.Root;	
		}		
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = "Validate";
			
			RuleName = AuthRule.None;
        }
    }
}