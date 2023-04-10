using System;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Person;
using Statline.StatTrac.Data.Tables;
using Statline.StatTrac.Data.Types;

namespace Statline.StatTrac.Person
{
	/// <summary>
	/// This class manages the Person, WebPerson and UserRoles. This class calls the DBLayer
	/// </summary>
	/// <remarks>
	/// <P>Name: PersonManager </P>
	/// <P>Date Created: 1/29/08</P>
	/// <P>Created By: Bret Knoll</P>
	/// <P>Version: 1.0</P>
	/// <P>Task: Calls the DBLayer</P>
	/// </remarks>
	public class PersonManager
	{
		public static void UpdatePerson(UserData userData, int lastStatEmployeeID)
		{
			// get db instance
			Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//create transaction within using
			using(TransactionHelper tHelper = new TransactionHelper(db))
			{
				
				try
				{
					tHelper.StartTransaction();
					//try to update Person pass userData and transaction
					PersonDB.UpdatePerson(
						db, 
						userData, 
						lastStatEmployeeID, 
						tHelper.DbTransaction); 
					
					//try to update webperso
					WebPersonDB.UpdateWebPerson(
						db, 
						userData, 
						lastStatEmployeeID, 
						tHelper.DbTransaction); 

					//try to upddate UserRoles
					UserRolesDB.UpdateUserRoles(
						db, 
						userData, 
						lastStatEmployeeID, 
						tHelper.DbTransaction);					
					//committ the application
					tHelper.CommittTransaction();
				}
				catch
				{
					tHelper.RollBackTransaction();
					throw;
				}


			}
		}

        public static int CheckStatEmployee(int statEmployeeID, int webPersonID)
        {
            if(statEmployeeID == ConstHelper.DEFAULTNEWRECORD )
              UpdateStatEmployee(ref statEmployeeID, webPersonID);
          return statEmployeeID;
        }
        public static void UpdateStatEmployee(ref int statEmployeeID, int webPersonID)
        {
            UserData userData = new UserData();
            Admin.AdminReferenceManager.FillStatEmployeeDetail(userData, webPersonID);

            //check if StatEmployee Exists
            if (userData.StatEmployee.Count == 0)
            {
                string password = userData.Person[0].PersonFirst + userData.Person[0].PersonLast + DateTime.Now.ToString();

                userData.StatEmployee.AddStatEmployeeRow(
                    userData.Person[0].PersonFirst,
                    userData.Person[0].PersonLast,
                    userData.WebPerson[0].WebPersonUserName,
                    password,
                    DateTime.Now,
                    0,
                    0,
                    0,
                    0,
                    userData.Person[0],
                    DBNull.Value.ToString(),
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0
                    );
            }

            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {
                try
                {
                    tHelper.StartTransaction();
                    //try to update Person pass userData and transaction
                    PersonDB.UpdatePerson(
                        db,
                        userData,
                        statEmployeeID,
                        tHelper.DbTransaction);

                    //try to update webperso
                    WebPersonDB.UpdateWebPerson(
                        db,
                        userData,
                        statEmployeeID,
                        tHelper.DbTransaction);

                    //try to update the StatEmployee
                    StatEmployeeDB.UpdateStatEmployee(
                        db,
                        userData,                        
                        tHelper.DbTransaction);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }

                statEmployeeID = userData.StatEmployee[ConstHelper.DEFAULTFIRSTRECORD].StatEmployeeID;
            }
        }

	}
}
