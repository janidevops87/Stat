using Statline.Stattrac.BusinessRules.NewCall;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Framework;
using System.Security.Principal;
using System.Linq;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for ReferralBRTest and is intended
    ///to contain all ReferralBRTest Unit Tests
    ///</summary>
    [TestClass()]
    public class ReferralBRTest
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
        [TestInitialize()]
        public void MyTestInitialize()
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
        }
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for SelectReferral
        ///</summary>
        [TestMethod()]
        [WorkItem(3370)]
        public void SelectReferralTest()
        {
            ReferralBR target = new ReferralBR();
            ReferralDS.ReferralRow referralRow;
            int callID = 6760625;
            int expected = callID;
            target.SelectReferral(callID);
            referralRow = ((ReferralDS)target.AssociatedDataSet).Referral.First(row => row.CallID == callID);
            int actual = referralRow.CallID;
            string message = string.Format("Expected CallIDs to match {0} and {1}", expected, actual);
            Assert.AreEqual(expected, actual, message);
        }

        /// <summary>
        ///A test for ReassignCall
        ///</summary>
        [TestMethod()]
        [WorkItem(3370)]
        public void ReassignFieldReferralOrganizationIDTest()
        {
            ReferralBR target = new ReferralBR();
            ReferralDS referralDS = (ReferralDS)target.AssociatedDataSet;
            ReferralDS.CallRow callRow = referralDS.Call.NewCallRow();
            referralDS.Call.Rows.Add(callRow);
            
            ReferralDS.ReferralRow newReferralRow = referralDS.Referral.NewReferralRow();
            newReferralRow.CallID = callRow.CallID;
            newReferralRow.ReferralCallerOrganizationID = 1;
            referralDS.Referral.Rows.Add(newReferralRow);

            int callID = -1;
            DataColumn organizationColumn = referralDS.Referral.ReferralCallerOrganizationIDColumn;
            DataColumn callIDColumn = referralDS.Referral.CallIDColumn;
            int orginalOrganizationID = 1; 
            int newOrganizationID = 10;
            int expected = newOrganizationID;
            target.ReassignField(callID, callIDColumn, organizationColumn, orginalOrganizationID, newOrganizationID);

            ReferralDS.ReferralRow actualRow = referralDS.Referral.First(referralRow => referralRow.CallID == callID);
            int actual = actualRow.ReferralCallerOrganizationID;

            string message = string.Format("The method was a suppose change the value {0} to value {1}", expected, actual);
            Assert.AreEqual(expected, actual, message);

        }

        /// <summary>
        ///A test for NextIndex
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        [WorkItem(3370)]
        public void NextIndexTest()
        {
            ReferralBR_Accessor target = new ReferralBR_Accessor(); // TODO: Initialize to an appropriate value
            DataTable dataTable = new DataTable(); // TODO: Initialize to an appropriate value
            int expected = 0; // TODO: Initialize to an appropriate value
            int actual;
            actual = target.NextIndex(dataTable);
            string message = string.Format("expected to get {0} and received {1}", expected, actual);
            Assert.AreEqual(expected, actual, message);
            expected = 1;
            dataTable.Rows.Add();
            actual = target.NextIndex(dataTable);
            message = string.Format("expected to get {0} and received {1}", expected, actual);
            Assert.AreEqual(expected, actual, message);

            
        }

        /// <summary>
        ///A test for ReferralBR Constructor
        ///</summary>
        [TestMethod()]
        [WorkItem(3370)]
        public void ReferralBRConstructorTest()
        {
            ReferralBR target = new ReferralBR();
        }
    }
}
