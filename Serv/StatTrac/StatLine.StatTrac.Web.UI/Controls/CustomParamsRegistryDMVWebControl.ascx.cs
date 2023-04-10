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
using Statline.StatTrac.Web.UI.Controls;
using Statline.Registry.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;

namespace Statline.StatTac.Web.UI.Controls
{   
    public partial class CustomParamsRegistryDMVWebControl :
        Statline.StatTrac.Web.UI.BaseUserControl,
        Statline.StatTrac.Web.UI.IBaseParameters
    {
        protected RegistryCommon dsCommonData;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!Visible)
                    return;
            }
        }

        #region IBaseParameters Members
        public void BuildParams(Hashtable reportParams)
        {

            //loop through the Registry list and add the selected valus to ReportParams            
            foreach (ListItem liRegistry in chkBoxListRegistry.Items)
            {
                if (liRegistry.Selected == true)
                {
                    if (liRegistry.Value == "State")
                        reportParams.Add(
                        ReportParams.RegistryState, true);

                    if (liRegistry.Value == "Web")
                        reportParams.Add(
                        ReportParams.RegistryWeb, true);
                }
            }

         }

        #endregion

    }
}