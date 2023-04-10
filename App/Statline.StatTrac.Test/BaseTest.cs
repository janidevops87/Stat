using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Framework;
using System.Security.Principal;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Test
{
    public class BaseTest
    {

        [TestInitialize()]
        public void BaseTestInitialize()
        {

            string name = "bret";
            bool isUserAuthenticated = WindowsIdentity.GetCurrent().IsAuthenticated;
            string database = "Test";

            StattracIdentity identity = new StattracIdentity(name, isUserAuthenticated, database);
            StattracPrincipal.CreatePrincipal(identity, null);

            StatEmployeeBR statEmployeeBR = new StatEmployeeBR(name);
            statEmployeeBR.SelectDataSet();
            StatEmployeeDS.StatEmployeeDataTable statEmployeeDataTable = ((StatEmployeeDS)statEmployeeBR.AssociatedDataSet).StatEmployee;
            if (statEmployeeDataTable.Count == 1)
            {
                identity.UserId = statEmployeeDataTable[0].StatEmployeeID;
                identity.UserOrganizationId = statEmployeeDataTable[0].OrganizationID;
            }


            //call inherited objects
            TestInitialize();
        }

        protected virtual void TestInitialize() { }
    }
}
