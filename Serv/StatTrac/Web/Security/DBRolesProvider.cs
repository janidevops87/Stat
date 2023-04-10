using System;
using System.Linq;
using System.Data;
using System.Collections;
using System.Collections.Generic;
using System.Security.Principal;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Statline.StatTrac.Web.Configuration;
using System.Web.Security;
using System.Web;
using Statline.StatTrac.Data.Security;
using Statline.StatTrac.Data.Types;
using Statline.StatTrac.Security;

namespace Statline.StatTrac.Web.Security
{
	/// <summary>
	/// Summary description for DBRolesProvider.
	/// </summary>
	public class DBRolesProvider : StatRolesProvider
	{
        //Based on http://www.projky.com/entlib/1.1/Microsoft/Practices/EnterpriseLibrary/Security/Database/UserRoleManager.cs.html
		
        public override string[] GetRoles()
        {
            return ((RolePrincipal)HttpContext.Current.User).GetRoles();
        }
        //private SecurityConfigurationView securityConfigurationView;

		public DBRolesProvider()
        { }

		protected override string[] CollectAllUserRoles(IIdentity userIdentity)
		{
            ////Copy each role name into a string array
            //CustomRolesProviderData dbRolesProviderData = (CustomRolesProviderData)securityConfigurationView.GetRolesProviderData(ConfigurationName);

            //UserRoleManager manager = new UserRoleManager(dbRolesProviderData.Extensions[0].Value, securityConfigurationView.ConfigurationContext);
            //DataSet dsRoles = manager.GetUserRoles(userIdentity.Name);

            //StringBuilder tmpRoles = new StringBuilder();
            //foreach (DataRow row in dsRoles.Tables[0].Rows)
            //{
            //    tmpRoles.Append(row["RoleName"]);
            //    tmpRoles.Append(",");
            //}

            //return tmpRoles.ToString().TrimEnd(',').Split(',');

            return GetRolesForUser(userIdentity.Name);
        }

        //public override void Initialize(ConfigurationView configurationView)
        //{
        //    ArgumentValidation.CheckForNullReference(configurationView, "configurationView");
        //    ArgumentValidation.CheckExpectedType(configurationView, typeof(SecurityConfigurationView));

        //    this.securityConfigurationView = (SecurityConfigurationView)configurationView;
        //}

        public string[] GetRoles(CustomIdentity identity)
        {
            string[] rolesList = GetRolesForUser(identity.Name);

            return rolesList;
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            string[] users = GetUsersInRole(roleName);
			
            List<string> userList = users.ToList();

            return userList.FindAll(item => item.Contains(usernameToMatch)).ToArray<string>();
        }

        public override string[] GetAllRoles()
        {
            DataSet dsRoles = RolesDB.GetAllRoles();

            StringBuilder tmpRoles = new StringBuilder();
            foreach (DataRow row in dsRoles.Tables[0].Rows)
            {
                tmpRoles.Append(row["RoleName"]);
                tmpRoles.Append(",");
            }

            return tmpRoles.ToString().TrimEnd(',').Split(',');
        }

        public override string[] GetRolesForUser(string username)
        {
            DataSet dsRoles = RolesDB.GetUserRoles(username);

			StringBuilder tmpRoles = new StringBuilder();
			foreach (DataRow row in dsRoles.Tables[0].Rows)
			{
				tmpRoles.Append(row["RoleName"]);
				tmpRoles.Append(",");
			}

			return tmpRoles.ToString().TrimEnd(',').Split(',');
        }

        public override string[] GetUsersInRole(string roleName)
        {
            DataSet dsUsers = RolesDB.GetRoleUsers(roleName);

            StringBuilder tmpUsers = new StringBuilder();
            foreach (DataRow row in dsUsers.Tables[0].Rows)
            {
                tmpUsers.Append(row["WebPersonUserName"]);
                tmpUsers.Append(",");
            }

            return tmpUsers.ToString().TrimEnd(',').Split(',');
		}

        public override bool IsUserInRole(string username, string roleName)
		{
            string[] userRoles = GetRolesForUser(username);

            List<string> roleList = userRoles.ToList();

            return roleList.Contains(roleName);
		}
	}
}
