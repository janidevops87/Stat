using System;
using Statline.StatTrac.Data.Admin;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Admin
{
	/// <summary>
	/// Summary description for AdminReferenceManager.
	/// </summary>
	/// <P>Name: AdminReferenceManager </P>
	/// <P>Date Created: 11/27/07</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Calls DB Layer </P>
	/// </remarks>	
	public class AdminReferenceManager
	{
		#region Get All Referrals Report Group ID
		public static void GetUserAllReferralsReportGroup(
			int userOrganizationID ,
			out int webReportGroupID)
		{
            try
            {
                AdminReferenceDB.GetUserAllReferralsReportGroup(
				userOrganizationID, 
				out webReportGroupID);
            }
            catch
            {
                throw;
            }
	
		}
		
		#endregion
		
		#region users
		public static void FillUserList(
			UserData dataSet, 
			int organizationID,
			int inactive)
		{
            try
            {
                AdminReferenceDB.FillUserList(dataSet, organizationID, inactive);
            }
            catch
            {
                throw;
            }

		}
		#endregion

		#region Person WebPerson
        public static void FillStatEmployeeDetail(			
            UserData dataSet, 
			int webPersonID)
        {
            FillUserDetail(dataSet, webPersonID);
            AdminReferenceDB.FillStatEmployeeDetail(dataSet, webPersonID);
        }
		public static void FillUserDetail(
			UserData dataSet, 
			int webPersonID)
		{
			AdminReferenceDB.FillPersonDetail(dataSet, webPersonID);
			AdminReferenceDB.FillWebPersonDetail(dataSet, webPersonID);
		}
		public static void GetWebPersonUserNameCount(
			string webPersonUserName,
            int inactive,
            int webPersonID,
			out int count)
		{
            try
            {
			    AdminReferenceDB.GetWebPersonUserNameCount(
				webPersonUserName,
                inactive,
                webPersonID,
				out count);
            }
            catch
            {
                throw;
            }
	
		}

		#endregion

		#region User Roles
		
		public static void FillAvailableRolesList(
			UserData dataSet, 
			int webPersonID,
			int userID)
		{
            try
            {
                AdminReferenceDB.FillAvailableRolesList(dataSet, webPersonID, userID);
            }
            catch
            {
                throw;
            }

		}

		public static void FillUserRolesList(
			UserData dataSet, 
			int webPersonID)
		{
            try
            {
                AdminReferenceDB.FillUserRolesList(dataSet, webPersonID);
            }
            catch
            {
                throw;
            }

		}

		#endregion

		#region PersonType
        public static UserData.PersonTypeDataTable FillPersonTypeList()
        {
            UserData dataSet = new UserData();
            try
            {
                AdminReferenceDB.FillPersonTypeList(dataSet);
            }
            catch
            {
                throw;
            }
            return dataSet.PersonType;

        }
        public static void FillPersonTypeList(UserData dataSet)
		{
            
            try
            {
                AdminReferenceDB.FillPersonTypeList(dataSet);
            }
            catch
            {
                throw;
            }

		}

		#endregion
			}
}