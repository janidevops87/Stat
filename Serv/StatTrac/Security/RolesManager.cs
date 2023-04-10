using System;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Security;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Security
{
	/// <summary>
	/// Summary description for RolesManager.
	/// </summary>
	public class RolesManager
	{
        public static SecurityData.ReportsDataTable FillAvailableReports(
                  SecurityData dataSet,
                  int webPersonId,
                  int roleId)
        {
            try
            {
                RolesDB.FillAvailableReports(dataSet, webPersonId, roleId);
            }
            catch
            {
                throw;
            }
            return dataSet.Reports;
        }
        public static SecurityData FillSecurityData(
            int webPersonId,
            int roleId)
        {            
            SecurityData dataSet = new SecurityData();
            try
            {
                FillAvailableReports(dataSet, webPersonId, roleId);
                FillSelectedReports(dataSet, webPersonId, roleId);
            }
            catch
            {
                throw;
            }
            return dataSet;
        }
    public static SecurityData.ReportsDataTable FillAvailableReports(
        int webPersonId,
        int roleId)
    {
        SecurityData dataSet = new SecurityData();
        try
        {
            FillAvailableReports(dataSet, webPersonId, roleId);
        }
        catch
        {
            throw;
        }

        return dataSet.Reports; 

    }
      
    public static void FillSelectedReports(
            SecurityData dataSet,
            int webPersonId,
            int roleId)
        {
         
            try
            {                
                RolesDB.FillSelectedReports(dataSet, webPersonId, roleId);
            }
            catch
            {
                throw;
            }
    
        }
         
    public static SecurityData.ReportRuleDataTable FillSelectReports(
        int webPersonId,
        int roleId)
    {
        SecurityData dataSet = new SecurityData();
        try
        {
            FillSelectedReports(dataSet, webPersonId, roleId);
        }
        catch
        {
            throw;
        }

        return dataSet.ReportRule; 

    }
    public static SecurityData.UserListDataTable FillRoleUsers(
    int webPersonId,
    int roleId)
{
        SecurityData dataSet = new SecurityData();
        try
        {
            RolesDB.FillRoleUsers(dataSet, webPersonId, roleId);
        }
        catch
        {
            throw;
        }

        return dataSet.UserList;

    }
        public static void FillRoleUsers(
            SecurityData dataSet,
            int webPersonId,
            int roleId
            )
        {
            try
            {
                RolesDB.FillRoleUsers(dataSet, webPersonId, roleId);
            }
            catch
            {
                throw;
            }

        }
    public static UserData.RolesDataTable GetRolesTable(
            int webPersonID)
        {
            UserData dsUserData = new UserData();
            try
            {
                dsUserData = GetRoles(webPersonID);
            }
            catch
            {
                throw;
            }

            return dsUserData.Roles;
            
        }
        public static UserData GetRoles(
            int webPersonID)
        {
            UserData dsUserData = new UserData();
            try
            {
                GetRoles(dsUserData, webPersonID);
            }
            catch
            {
                throw;
            }
            return dsUserData;
        }
        public static UserData GetRoles(   
            UserData dataSet,
            int webPersonID
            
            )
		{            
			try
			{
				RolesDB.FillRolesList(
                    dataSet, 
                    webPersonID);                
			}
			catch
			{
				throw;
			}
            return dataSet;
		}

		public static int UpdateRoles(
            SecurityData dataSet,
            int statEmpoyeeID
            )
		{
            int rows;
            // get db instance
			Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //get a transaction
                    //update roles
                    rows = RolesDB.UpdateRoles(
                        db,
                        tHelper.DbTransaction,
                        dataSet,
                        statEmpoyeeID);
                    //update report rule
                    rows += RolesDB.UpdateReportRule(
                        db,
                        tHelper.DbTransaction,
                        dataSet,
                        statEmpoyeeID);
                    //committ the transaction
                    tHelper.CommittTransaction();
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }
            }
			return rows;
		}

        public static void GetRole(
            SecurityData dataSet,
            int roleId)
        {
            try
            {
                RolesDB.GetRole(dataSet, roleId);
            }
            catch
            {
                throw;
            }

        }
	}
}
