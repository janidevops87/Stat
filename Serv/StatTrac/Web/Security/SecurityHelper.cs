using System;
using System.Security;
using System.Security.Principal;
using System.DirectoryServices.ActiveDirectory;
using System.DirectoryServices.AccountManagement;
using System.Threading;
using Microsoft.Practices.EnterpriseLibrary.Security;
using Statline.StatTrac.Report;
using System.Net;
using System.Web;
using System.Web.Security;
using Statline.StatTrac.Data.Security;
using System.Data;
using System.Security.Cryptography;
using Statline.StatTrac.Web.UI;

namespace Statline.StatTrac.Web.Security
{

    public enum AuthRule
    {
        None,
        User,
        Administrator,
        Anonymous,
        Role,
        RoleConfigure,
        ReportAccessGroup,
        ReportAccessGroupConfigure,
        GeneralAdministration,
        UserConfigure,
        BlockEventLog,
        ReferralUpdate,
        EventLogUpdate,
        ScheduleShiftUpdate,
        ScheduleShiftDelete,
        ScheduleShiftCreate,
        Update,
        ReferralFacilityCompliance,
        ScheduleSearch,
        QA,
        QAQMForm,
        QACreate,
        QAReview,
        QAUpdateDelete,
        QAUpdate,
        QAConfig,
        QAViewOtherOrgs,
        QAPendingReview,
        QAAddEdit,
        QAAddTracking,
        Search,
        RegistryUpdate,
        MaintainCategory,
        Enrollment,
        DynamicEnrollment,
        Administration

    };
    /// <summary>
    /// Summary description for SecurityHelper.
    /// </summary>
    public class SecurityHelper
    {
        public SecurityHelper()
        { }
        public static bool Authenticate(string username, string password, CookieManager pageCookie)
        {
            bool authenticated = false;
            var dsPasswordData = RolesDB.GetPassword(username);
            string saltValue = string.Empty;
            string hashedPassword = string.Empty;

            if (dsPasswordData.Tables.Count > 0 && dsPasswordData.Tables[0].Rows.Count > 0)
            {
                DataRow row = dsPasswordData.Tables[0].Rows[0];
                saltValue = row["SaltValue"] != DBNull.Value ? (string)row["SaltValue"] : string.Empty;
                hashedPassword = row["HashedPassword"] != DBNull.Value ? (string)row["HashedPassword"] : string.Empty;
                pageCookie.SessionID = row["InternalSessionID"] != DBNull.Value ? Convert.ToString(row["InternalSessionID"]) : string.Empty;
            }

            if (hashedPassword != null)
            {
                string targetPassword = SecurityHelper.CreatePasswordHash(password, saltValue);
                //check if the password matches current
                if (hashedPassword.Equals(targetPassword)) {
                    IIdentity identity;
                    NetworkCredential namePasswordNetCredentials = new NetworkCredential(username, password);
                    DBAuthenticationProvider dbAuthenticator = new DBAuthenticationProvider();
                    authenticated = dbAuthenticator.Authenticate(namePasswordNetCredentials, out identity);
                }
            }        

            if (!authenticated)
            {
                throw new SecurityException("Invalid username or password.");
            }

            // TODO: Get Roles

            return authenticated;
        }
        public static bool Authenticate(
            int userID,
            int userOrgID,
            out string userName,
            out string userDisplayName,
            out string userOrganizationName)
        {
            bool authenticated = false;

            authenticated = ReportReferenceManager.Authenticate(
                userID,
                userOrgID,
                out userName,
                out userDisplayName,
                out userOrganizationName);

            if (!authenticated)
            {
                throw new SecurityException("Invalid username or password.");
            }


            return authenticated;


        }

        public static CustomPrincipal GetPrincipal(CustomIdentity identity)
        {
            // TODO: Get Roles
            // httpContext

            // IRolesProvider rolesprovider;
            // rolesprovider = RolesFactory.GetRolesProvider();

            //CustomPrincipal cPrincipal;
            //cPrincipal = (CustomPrincipal) rolesprovider.GetRoles(identity);

            DBRolesProvider roleProvider = new DBRolesProvider();
            CustomPrincipal cPrincipal = new CustomPrincipal(identity, roleProvider.GetRoles(identity));

            return cPrincipal;
        }
        public static bool Authorized(String rule, CustomPrincipal cPrincipal)
        {
            Type authRule = typeof(AuthRule);

            return Authorized((AuthRule)Enum.Parse(authRule, rule), cPrincipal);
        }
        public static bool Authorized(AuthRule rule, CustomPrincipal cPrincipal)
        {
            bool authorized = false;

            if (rule == AuthRule.None)
                return true;

            // TODO: Task Authorize

            IAuthorizationProvider ruleProvider;
            ruleProvider = AuthorizationFactory.GetAuthorizationProvider("Authorization Rule Provider");

            authorized = ruleProvider.Authorize(cPrincipal, rule.ToString());

            return authorized;
        }

        public static string CreatePasswordHash(string password, string saltValue)
        {
            string saltAndPwd = string.Concat(password, saltValue);
            return FormsAuthentication.HashPasswordForStoringInConfigFile(saltAndPwd, "SHA1");
        }

        public static string GenerateSaltValue(string password)
        {
            var salt = new byte[password.Length];
            using (var random = new RNGCryptoServiceProvider())
            {
                random.GetNonZeroBytes(salt);
            }

            return Convert.ToBase64String(salt);
        }
    }
}
