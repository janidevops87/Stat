using System.Linq;
using System.Security.Principal;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Security;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for SecurityHelperTest and is intended
    ///to contain all SecurityHelperTest Unit Tests
    ///</summary>
    [TestClass()]
    public class SecurityHelperTest
    {


        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for GetInstance
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetInstanceTest()
        {
            SecurityHelper expected = null; // TODO: Initialize to an appropriate value
            SecurityHelper actual;
            actual = SecurityHelper.GetInstance();
            Assert.AreNotEqual(expected, actual);
        }

        /// <summary>
        ///A test for Authorized
        ///</summary>
        [TestMethod()]
        public void AuthorizedHasAccessTest()
        {
            
            string rule = SecurityRule.Edit_Exclusive_Calls.ToString() ; 
            bool expected = true; 
            bool actual;
            string userName = "rapaisley";
            //string userName = "kalexander";
            //string userName = "gmarpin";
            string databaseName = "Development";
            UpdatePrincipal(userName, databaseName);
            SecurityHelper securityHelper = SecurityHelper.GetInstance();
            actual = securityHelper.Authorized(rule);
            Assert.AreEqual(expected, actual);
        }
        [TestMethod()]
	[Ignore()]
        public void AuthorizedNoAccessTest()
        {

            string rule = SecurityRule.Response_Interval.ToString(); 
            bool expected = false; 
            bool actual;
            string userName = "b_r_e_t";
            string databaseName = "Test";
            UpdatePrincipal(userName, databaseName);
            SecurityHelper securityHelper = SecurityHelper.GetInstance();
            actual = securityHelper.Authorized(rule);
            Assert.AreEqual(expected, actual);
        }

        /// <summary>
        ///A test for SecurityHelper Constructor
        ///</summary>
        //[TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Security.dll")]
        public void SecurityHelperConstructorTest()
        {
            SecurityHelper_Accessor target = new SecurityHelper_Accessor();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        private void UpdatePrincipal(string userName, string databaseName )
        {
            string name = userName;
            bool isUserAuthenticated = WindowsIdentity.GetCurrent().IsAuthenticated;
            string database = databaseName;
            string[] statEmployeeRoles = new string[1];

            StattracIdentity identity = new StattracIdentity(name, isUserAuthenticated, database);
            StattracPrincipal.CreatePrincipal(identity, null);
            StatEmployeeBR statEmployeeBR = new StatEmployeeBR(name);
            statEmployeeBR.SelectDataSet();
            StatEmployeeDS.StatEmployeeDataTable statEmployeeDataTable = ((StatEmployeeDS)statEmployeeBR.AssociatedDataSet).StatEmployee;
            if (statEmployeeDataTable.Count == 1)
            {
                identity.UserId = statEmployeeDataTable[0].StatEmployeeID;
                identity.UserName = string.Format("{0} {1}",
                                        ReplaceNull(statEmployeeDataTable[0].StatEmployeeFirstName.ToString()),
                                        ReplaceNull(statEmployeeDataTable[0].StatEmployeeLastName.ToString())
                                                );
                identity.UserOrganizationId = statEmployeeDataTable[0].OrganizationID;
                identity.UserOrganizationName = statEmployeeDataTable[0].OrganizationName.ToString();
            }
            else
            {
                //Employee not found
                //UserNotFound = true;
                //BaseMessageBox.Show(generalConstant.InvalidUserName);
            }
            //bret 10/20/2010, build the roles list
            StatEmployeeDS StatEmployeeDS;
            StatEmployeeDS = ((StatEmployeeDS)statEmployeeBR.AssociatedDataSet);
            if (StatEmployeeDS.StatEmployeeRole.Count > 0)
            {

                var query = from row in StatEmployeeDS.StatEmployeeRole.ToList()
                            select row.RoleName;

                if (query.Count() > 0)
                {
                    statEmployeeRoles = query.ToArray();
                }
            }

            //bret 10/20/2010 moved this down. Need to build the roles list first.

            StattracPrincipal.CreatePrincipal(identity, statEmployeeRoles);
        }
        private static string ReplaceNull(string s)
        {
            if (string.IsNullOrEmpty(s) == true)
                return "";
            else
                return s;
        }
    }
}
