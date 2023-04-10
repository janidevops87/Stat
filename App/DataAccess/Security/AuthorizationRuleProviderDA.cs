using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Security
{
    public enum AuthorizationRuleProviderDASprocs
    {
        SecurityRuleUpdate,
        SecurityRuleDelete,
        SecurityRuleListSelect,
        SecurityRuleSelect,
        SecurityRuleInsert
    }
    public enum AuthorizationRuleProviderDATables
    { 
        SecurityRule
    }
    public class AuthorizationRuleProviderDA : BaseDA
    {
        public AuthorizationRuleProviderDA()
            : base(AuthorizationRuleProviderDASprocs.SecurityRuleSelect.ToString())
        {
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("SecurityRule", "SecurityRuleInsert", "SecurityRuleUpdate", "SecurityRuleDelete"));


        }
        public void SetDefaultTableSelect()
        {

            SpSelect = AuthorizationRuleProviderDASprocs.SecurityRuleSelect.ToString();
            SetTablesSelect(
                AuthorizationRuleProviderDATables.SecurityRule.ToString()
            );
        }

    }
}
