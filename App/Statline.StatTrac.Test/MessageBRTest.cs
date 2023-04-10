using Statline.Stattrac.BusinessRules.NewCall;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data;
using Statline.Stattrac.Data.Types.NewCall;
using System.Security.Principal;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Framework;
using System.Linq;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for MessageBRTest and is intended
    ///to contain all MessageBRTest Unit Tests
    ///</summary>
    [TestClass()]
    public class MessageBRTest
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
        }        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for SelectMessage
        ///</summary>
        [TestMethod()]
        [WorkItem(3370)]
        public void SelectMessageTest()
        {
            MessageBR target = new MessageBR(); 
            MessageDS.MessageRow messageRow;
            int callID = 6769490; 
            int expected = callID;
            target.SelectMessage(callID);
            messageRow = ((MessageDS)target.AssociatedDataSet).Message.First(row => row.CallID == callID);
            int actual = messageRow.CallID;
            string message = string.Format("Expected CallIDs to match {0} and {1}", expected, actual);
            Assert.AreEqual(expected, actual, message);
            
        }

        /// <summary>
        ///A test for ReassignCall
        ///</summary>
        [TestMethod()]
        [WorkItem(3370)]
        public void ReassignFieldOrganizatinIDTest()
        {
            MessageBR target = new MessageBR(); 
            MessageDS messageDS = (MessageDS)target.AssociatedDataSet;
            MessageDS.MessageRow createMessageRow = messageDS.Message.NewMessageRow();
            MessageDS.CallRow callRow = messageDS.Call.NewCallRow();
            messageDS.Call.Rows.Add(callRow);
            createMessageRow.CallID = callRow.CallID;
            createMessageRow.OrganizationID = 1;

            messageDS.Message.Rows.Add(createMessageRow);
            int callID = -1;
            DataColumn organizationColumn = messageDS.Message.OrganizationIDColumn;
            DataColumn callIDColumn = messageDS.Message.CallIDColumn;
            int orginalOrganizationID = createMessageRow.OrganizationID;
            int newOrganizationID = 10; 
            target.ReassignField(callID, callIDColumn, organizationColumn, orginalOrganizationID, newOrganizationID);
            int expected = newOrganizationID;
            MessageDS.MessageRow actualMessageRow = messageDS.Message.First(messageRow => messageRow.CallID == callID);
            int actual = actualMessageRow.OrganizationID;
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
            MessageBR_Accessor target = new MessageBR_Accessor(); // TODO: Initialize to an appropriate value
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
        ///A test for MessageBR Constructor
        ///</summary>
        [TestMethod()]
        [WorkItem(3370)]
        public void MessageBRConstructorTest()
        {
            MessageBR target = new MessageBR();
        }
    }
}
