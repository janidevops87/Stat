using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Security
{
    public class BuildPrincipal
    {
        public Boolean UserNotFound { get; set; }
        private GeneralConstant generalConstant;
        private StattracIdentity identity;
        private StatEmployeeBR statEmployeeBR;
        private StatEmployeeDS statEmployeeDS;

        public BuildPrincipal(string statEmployeeUserId, Boolean isUserAuthenticated, string database)
        {
            generalConstant = GeneralConstant.CreateInstance();
            generalConstant.CurrentDB = database;
            
            string[] statEmployeeRoles = new string[1];
            identity = new StattracIdentity(statEmployeeUserId, isUserAuthenticated, database);
            
            StattracPrincipal.CreatePrincipal(identity, null);
            
            statEmployeeBR = new StatEmployeeBR(statEmployeeUserId);
            statEmployeeBR.SelectDataSet();

            statEmployeeDS = ((StatEmployeeDS)statEmployeeBR.AssociatedDataSet);

            if (statEmployeeDS.StatEmployee.Count == 1)
            {
                identity.UserId = statEmployeeDS.StatEmployee[0].StatEmployeeID;
                identity.UserName = string.Format("{0} {1}",
                                        ReplaceNull(statEmployeeDS.StatEmployee[0].StatEmployeeFirstName.ToString()),
                                        ReplaceNull(statEmployeeDS.StatEmployee[0].StatEmployeeLastName.ToString())
                                                );
                identity.UserOrganizationId = statEmployeeDS.StatEmployee[0].OrganizationID;
                identity.UserOrganizationName = statEmployeeDS.StatEmployee[0].OrganizationName.ToString();
            }
            else
            {
                //Employee not found
                UserNotFound = true;
                
            }
            //bret 10/20/2010, build the roles list

            statEmployeeDS = ((StatEmployeeDS)statEmployeeBR.AssociatedDataSet);
            if (statEmployeeDS.StatEmployeeRole.Count > 0)
            {

                var query = from row in statEmployeeDS.StatEmployeeRole.ToList()
                            select row.RoleName;

                if (query.Count() > 0)
                {
                    statEmployeeRoles = query.ToArray();
                }
            }

            //bret 10/20/2010 moved this down. Need to build the roles list first.

            StattracPrincipal.CreatePrincipal(identity, statEmployeeRoles);

            LoadUserInformation();
        }
        public void LoadUserInformation()
        {
            statEmployeeBR.AutoDisplaySourceCodeSet();

        }
        private static String ReplaceNull(string s)
        {
            if (String.IsNullOrEmpty(s) == true)
                return "";
            else
                return s;
        }

    }
}
