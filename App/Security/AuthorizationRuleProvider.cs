using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Security;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Security.Configuration;
using System.Collections.Specialized;
using System.Security.Principal;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Security;
using Statline.Stattrac.Data.Types.Security;

namespace Statline.Stattrac.Security
{
    [ConfigurationElementType(typeof(CustomAuthorizationProviderData))]
    public class AuthorizationRuleProvider : AuthorizationProvider
    {
        private IDictionary<string, IAuthorizationRule> authorizationRules = new Dictionary<string, IAuthorizationRule>();
        private IAuthorizationProvider iAuthorizationProvider;

        #region Protected Fields

        
        private AuthorizationRuleProviderDS classDataSet;

        public AuthorizationRuleProviderDS ClassDataSet
        {
            get { return classDataSet; }
            set { classDataSet = value; }
        }


        /// <summary>
        /// Business Rules object
        /// </summary>
        private BaseBR baseBR;

        protected BaseBR BusinessRule
        {
            get { return baseBR; }
            set { baseBR = value; }
        }


        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();

        protected GeneralConstant GRConstant
        {
            get { return generalConstant; }
        }
        #endregion
      
      public AuthorizationRuleProvider(NameValueCollection configurationItems)
      {

          baseBR = new AuthorizationRuleProviderBR();
          baseBR.SelectDataSet();

          ClassDataSet = (AuthorizationRuleProviderDS)baseBR.AssociatedDataSet;

          foreach (AuthorizationRuleProviderDS.SecurityRuleRow securityRuleRow in ClassDataSet.SecurityRule)
          {
              try
              {
                  AuthorizationRuleData ruleData = new AuthorizationRuleData(securityRuleRow.SecurityRule, securityRuleRow.Expression);
                  authorizationRules.Add(ruleData.Name, ruleData);
              }
              catch (Exception ex)
              {                  
                  BaseLogger.LogFormUnhandledException(ex);
    
              }

          }

          iAuthorizationProvider = new Microsoft.Practices.EnterpriseLibrary.Security.AuthorizationRuleProvider(authorizationRules);
      }
      public override bool Authorize(IPrincipal principal, string context)
      {
          bool authorize;
          authorize = false;

          authorize = iAuthorizationProvider.Authorize(principal, context);

          return authorize;
      }
    }    

}
