using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Statline.StatTrac.Web.Security
{
    public class UserRoleManager
    {
        private const string SPCreateUser = "InsertUser";
        private const string SPDeleteUser = "DeleteUserByName";
        private const string SPCreateRole = "InsertRole";
        private const string SPDeleteRole = "DeleteRoleByName";
        private const string SPCreateUserRole = "AddUserToRoleByName";
        private const string SPDeleteUserRole = "RemoveUserFromRoleByName";
        private const string SPGetIdentityId = "GetUserIdByName";
        private const string SPGetRoleId = "GetRoleIdByName";
        private const string SPRenameRole = "UpdateRoleById";
        private const string SPChangePassword = "ChangePasswordByName";
        private const string SPGetPassword = "GetPassword";
        private const string SPGetRolesByName = "GetRolesByName";

        private const string SPGetAllRoles = "GetAllRoles";
        private const string SPGetAllUsers = "GetAllUsers";
        private const string SPGetRoleUsers = "GetUserInRoleByName";
    }
}
