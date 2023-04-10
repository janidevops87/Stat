using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
// Use EntLib Security
using Microsoft.Practices.EnterpriseLibrary.Security;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;
using System.Threading;
using Statline.Stattrac.Data.Types.Security;


namespace Statline.Stattrac.Security
{

    /// <summary>
    /// Notes to setup new Permissions aka SecurityRules
    //*	1. Add role at this time we can include spaces.
    //*	2. Add permission to SecurityRule enum. Statline.StatTrac.Security.SecurityHelper.
    //*	3. Add permission and expression to SecurityRule Table
    //*	4. 
    //*	5. Assign role to User. Note if creating a new Role the Role is automatically assigned. 
    //*   6. Test exec StatEmployeeSelectDataSet @StatEmployeeUserId=N'bret'
    /// </summary>
    //public enum SecurityRule
    //{
    //    Add_Organizations,
    //    Add_Source_Code,
    //    Administration_Access,
    //    Base_Configuration,
    //    Case_Review,
    //    Contact_Permissions,
    //    Delete_Call,
    //    Delete_Events,
    //    Edit_Organizations,
    //    Edit_Exclusive_Calls,        
    //    Delete_Bulletin_Board,
    //    Family_Services,
    //    FS_Active_Cases,     
    //    Locked_High_Profile_Cases,
    //    Modify_Source_Code_Name,
    //    OASIS,        
    //    Reassign_Numbers,
    //    Reassign_Organizations,
    //    Recycled_Cases,
    //    Reopen_OASIS_Case,
    //    Response_Interval,
    //    Rule_Out_Indications,
    //    Schedule_Changes,
    //    Set_Source_Code_Inactive,
    //    Unlock_Case,        
    //    Unlock_Events,
    //    Updates,
    //    Verify_Organizations,
    //    View_ASP_Organizations,
    //    Login_Override
    //}
    public class SecurityHelper
    {

        private static SecurityHelper _securityHelper;
        private IAuthorizationProvider _ruleProvider; 
        private SecurityHelper(){}

        public static SecurityHelper GetInstance()
        {
            if (_securityHelper == null)
                _securityHelper = new SecurityHelper();
            return _securityHelper;
        }
        public void ResetRules()
        {
            _ruleProvider = null;
        }
        public bool Authorized(string rule)
        {
            bool authorized = false;

            // Check rule-base authorization
            // No parameter passed to GetInstance method as 
            // we'll set the Default Authorization Instance in App.config. 
            if (_ruleProvider == null)
                _ruleProvider = EnterpriseLibraryContainer.Current.GetInstance<IAuthorizationProvider>();

            //check rule exists, if it does not reurn false.
            if (((AuthorizationRuleProviderDS)((AuthorizationRuleProvider)_ruleProvider).ClassDataSet).SecurityRule.Any(row => row.SecurityRule == rule))
                authorized = _ruleProvider.Authorize(Thread.CurrentPrincipal, rule);

            return authorized;
        }

    }
}
