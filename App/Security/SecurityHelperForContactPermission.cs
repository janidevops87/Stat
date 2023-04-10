using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Principal;
using System.Threading;
using Statline.Stattrac.Data.Types.Security;
// Use EntLib Security
using Microsoft.Practices.EnterpriseLibrary.Security;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;

namespace Statline.Stattrac.Security
{
    public class SecurityHelperForContactPermission
    {
        private static SecurityHelperForContactPermission _securityHelperForContactPermission;
        private IAuthorizationProvider _ruleProvider;
        private SecurityHelperForContactPermission() { }
        public static SecurityHelperForContactPermission GetInstance()
        {
            if (_securityHelperForContactPermission == null)
                _securityHelperForContactPermission = new SecurityHelperForContactPermission();
            return _securityHelperForContactPermission;
        }
        public void ResetRules()
        {
            _ruleProvider = null;
        }
        
        public bool Authorized(string rule, GenericPrincipal principal)
        {
            bool authorized = false;

            // Check rule-base authorization
            // No parameter passed to GetInstance method as 
            // we'll set the Default Authorization Instance in App.config. 
            if (_ruleProvider == null)
            _ruleProvider =
                EnterpriseLibraryContainer.Current.GetInstance<IAuthorizationProvider>();

            //check rule exists, if it does not reurn false.
            if (((AuthorizationRuleProviderDS)((AuthorizationRuleProvider)_ruleProvider).ClassDataSet).SecurityRule.Any(row => row.SecurityRule == rule))
                authorized = _ruleProvider.Authorize(principal, rule);

            return authorized;
        }
    }
}
