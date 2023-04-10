using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
//include EnterpriseLibrary
using Microsoft.Practices.EnterpriseLibrary.Security;
using Microsoft.Practices.EnterpriseLibrary.Security.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;


namespace Statline.Stattrac.Security
{
    public class AuthorizationRule : IAuthorizationRule
    {
        private string name;
        private string expression;
        public AuthorizationRule(string name, string expression)
        {
            this.name = name;
            this.expression = expression;
        }
        #region IAuthorizationRule Members

        string IAuthorizationRule.Expression
        {
            get { return expression; }
        }

        string IAuthorizationRule.Name
        {
            get { return name; }
        }

        #endregion
    }
}
