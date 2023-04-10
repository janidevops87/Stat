using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.DataAccess.Security;
using Statline.Stattrac.Data.Types.Security;

namespace Statline.Stattrac.BusinessRules.Security
{
    public class AuthorizationRuleProviderBR: BaseBR
    {
        #region Fields/Properties
        private GeneralConstant grConstant;
        #endregion

        public AuthorizationRuleProviderBR()
		{
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new AuthorizationRuleProviderDS();
            AssociatedDA = new AuthorizationRuleProviderDA(); 

        }
    }
}
