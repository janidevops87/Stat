using Statline.Stattrac.BusinessRules.Organization;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Organization;
using System.Security.Principal;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Framework;
using System.Collections;
using Statline.Stattrac.Data.Types.Framework;
namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for OrganizationDeleteBRTest and is intended
    ///to contain all OrganizationDeleteBRTest Unit Tests
    ///</summary>
    [TestClass()]
    public class OrganizationDeleteBRTest
    {


        private TestContext testContextInstance;
        private OrganizationAssociatedCallDS _organizationDeleteDS;
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
        [WorkItem(2959)]
        public void SelectReferralTest()
        {
            OrganizationAssociatedCallBR target = new OrganizationAssociatedCallBR();
            _organizationDeleteDS = ((OrganizationAssociatedCallDS)target.AssociatedDataSet);
            int assert = 0;
            string errorMessage;
            //load associated referrals and select the first referral.
            target.OrganizationID = 8319; //DetroitReceiving
            target.SelectDataSet();

            int callID = _organizationDeleteDS.OrganizationDelete[GeneralConstant.CreateInstance().FirstRow].CallID;
            
            target.SelectReferral(callID);
            errorMessage = string.Format("table referral has {0} records.", _organizationDeleteDS.Referral.Count);
            Assert.IsTrue(_organizationDeleteDS.Referral.Count > assert, errorMessage);
        }

        /// <summary>
        ///A test for SelectOrganizationPhone
        ///</summary>
        [TestMethod()]
        [WorkItem(2959)]
        [Ignore()]
        public void SelectOrganizationPhoneTest()
        {
            OrganizationAssociatedCallBR target = new OrganizationAssociatedCallBR(); // TODO: Initialize to an appropriate value
            //load associated referrals and select the first referral.
            target.OrganizationID = 8319; //DetroitReceiving            
            target.SelectDataSet();
            


            //target.SelectOrganizationPhone(organizationID);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for SelectMessage
        ///</summary>
        [TestMethod()]
        [WorkItem(2959)]
        public void SelectMessageTest()
        {
            OrganizationAssociatedCallBR target = new OrganizationAssociatedCallBR();
            _organizationDeleteDS = (OrganizationAssociatedCallDS)target.AssociatedDataSet;
            target.OrganizationID = 2309; //GOLM
            target.SelectDataSet();

            string errorMessage;
            int assert = 0;

            int callID = _organizationDeleteDS.OrganizationDelete[GeneralConstant.CreateInstance().FirstRow].CallID;

            target.SelectMessage(callID);
            int actual = _organizationDeleteDS.Message.Count;
            errorMessage = string.Format("The table Message contains {0} records and more than {1} were expected", actual, assert);
            Assert.IsTrue(actual > assert, errorMessage);
        }

        /// <summary>
        ///A test for OrganizationDeleteBR Constructor
        ///</summary>
        [TestMethod()]
        [WorkItem(2959)]
        public void OrganizationDeleteBRConstructorTest()
        {
            int assert = 0;
            string failMessage;
            OrganizationAssociatedCallBR target = new OrganizationAssociatedCallBR();
            _organizationDeleteDS = ((OrganizationAssociatedCallDS)target.AssociatedDataSet);
            target.OrganizationID = 8319; //DetroitReceiving
            target.SelectDataSet();

            int actual = _organizationDeleteDS.OrganizationDelete.Count;
            failMessage = string.Format("organization has {0} records and more than {1}.", actual, assert);

            Assert.IsTrue(actual > assert, failMessage);
        }
        /// <summary>
        /// Tests that OrganizationDeleteBR can reassign records
        /// </summary>        
        [TestMethod()]
        [WorkItem(2959)]
        public void ReassignCallReferralTest()
        { 
            //1. get count of referral List before testing and reassign 2 values and confirm the the count has shrunk.
            int assert = 0;
            int orginalOrganizationId = 8319;
            string failMessage;
            OrganizationAssociatedCallBR target = new OrganizationAssociatedCallBR();
            _organizationDeleteDS = ((OrganizationAssociatedCallDS)target.AssociatedDataSet);
            target.OrganizationID = orginalOrganizationId; //DetroitReceiving
            target.SelectDataSet();

            int actual = _organizationDeleteDS.OrganizationDelete.Count;
            failMessage = string.Format("organization has {0} records and more than {1}.", actual, assert);

            //test OrganizationDeleteBR dataset has records
            Assert.IsTrue(actual > assert, failMessage);
             
            //reset test values
            assert = _organizationDeleteDS.OrganizationDelete.Count;
            actual = 0;

            //process first row
            OrganizationAssociatedCallDS.OrganizationDeleteRow deleteRow1 = _organizationDeleteDS.OrganizationDelete[GeneralConstant.CreateInstance().FirstRow];
            Hashtable paramList = new Hashtable();
            paramList.Add("SourceCodeID", deleteRow1.SourceCodeID);            
            ListControlBR listControlBR1 = new ListControlBR("OrganizationListSelect", paramList);
            listControlBR1.SelectDataSet();
            int deleteRow1OrganizationID = ((ListControlDS)listControlBR1.AssociatedDataSet).ListControl[GeneralConstant.CreateInstance().FirstRow].ListId;
            int deleteRow1CallID = deleteRow1.CallID;
            target.ReassignCall(deleteRow1, orginalOrganizationId, deleteRow1OrganizationID);

            //process second row
            OrganizationAssociatedCallDS.OrganizationDeleteRow deleteRow2 = _organizationDeleteDS.OrganizationDelete[GeneralConstant.CreateInstance().FirstRow + 1];
            paramList = new Hashtable();
            paramList.Add("SourceCodeID", deleteRow2.SourceCodeID);
            ListControlBR listControlBR2 = new ListControlBR("OrganizationListSelect", paramList);
            listControlBR2.SelectDataSet();
            int deleteRow2OrganizationID = ((ListControlDS)listControlBR2.AssociatedDataSet).ListControl[GeneralConstant.CreateInstance().FirstRow].ListId;
            target.ReassignCall(deleteRow2, orginalOrganizationId, deleteRow2OrganizationID);
            
            target.SaveDataSet();
            target.SelectDataSet();

            //2. Confirm the count of referrals increases as more records are reassigned.
            actual = _organizationDeleteDS.OrganizationDelete.Count;
            failMessage = string.Format("It was expected the record count {0} would have decreased from {1}", assert, actual);

            Assert.IsTrue(actual < assert, failMessage);
            
            //confirm the organization ID for each of the calls is not the same as the original 
            target.SelectReferral(deleteRow1CallID);
            failMessage = string.Format("Assertion: The call can be reselected after reassigning OrganizaztionID count should equal 1, count equals {0}", _organizationDeleteDS.Referral.Count);
            Assert.IsTrue(_organizationDeleteDS.Referral.Count > 0, failMessage);


            failMessage = string.Format("callid {0} should be assigned to organizationID {1} not {2}", deleteRow1CallID, deleteRow1OrganizationID, orginalOrganizationId);
            int currentOrganizationID = _organizationDeleteDS.Referral[GeneralConstant.CreateInstance().FirstRow].ReferralCallerOrganizationID;
            Assert.IsTrue(currentOrganizationID != orginalOrganizationId, failMessage);





        }
        /// <summary>
        /// Tests that OrganizationDeleteBR can reassign records
        /// </summary>        
        [TestMethod()]
        [WorkItem(2959)]
        public void ReassignCallMessageTest()
        {
            //1. get count of message List before testing and reassign 2 values and confirm the the count has shrunk.
            int assert = 0;
            int orginalOrganizationId = 2309;
            string failMessage;
            OrganizationAssociatedCallBR target = new OrganizationAssociatedCallBR();
            _organizationDeleteDS = ((OrganizationAssociatedCallDS)target.AssociatedDataSet);
            target.OrganizationID = orginalOrganizationId; //DetroitReceiving
            target.SelectDataSet();

            int actual = _organizationDeleteDS.OrganizationDelete.Count;
            failMessage = string.Format("organization has {0} records and more than {1}.", actual, assert);

            //test OrganizationDeleteBR dataset has records
            Assert.IsTrue(actual > assert, failMessage);

            //reset test values
            assert = _organizationDeleteDS.OrganizationDelete.Count;
            actual = 0;

            //process first row
            OrganizationAssociatedCallDS.OrganizationDeleteRow deleteRow1 = _organizationDeleteDS.OrganizationDelete[GeneralConstant.CreateInstance().FirstRow];
            Hashtable paramList = new Hashtable();
            paramList.Add("SourceCodeID", deleteRow1.SourceCodeID);
            ListControlBR listControlBR1 = new ListControlBR("OrganizationListSelect", paramList);
            listControlBR1.SelectDataSet();
            int deleteRow1OrganizationID = ((ListControlDS)listControlBR1.AssociatedDataSet).ListControl[GeneralConstant.CreateInstance().FirstRow].ListId;
            int deleteRow1CallID = deleteRow1.CallID;
            if(deleteRow1OrganizationID == orginalOrganizationId )
                deleteRow1OrganizationID = ((ListControlDS)listControlBR1.AssociatedDataSet).ListControl[GeneralConstant.CreateInstance().FirstRow + 1].ListId;
            target.ReassignCall(deleteRow1, orginalOrganizationId, deleteRow1OrganizationID);

            //process second row
            OrganizationAssociatedCallDS.OrganizationDeleteRow deleteRow2 = _organizationDeleteDS.OrganizationDelete[GeneralConstant.CreateInstance().FirstRow + 1];
            paramList = new Hashtable();
            paramList.Add("SourceCodeID", deleteRow2.SourceCodeID);
            ListControlBR listControlBR2 = new ListControlBR("OrganizationListSelect", paramList);
            listControlBR2.SelectDataSet();
            int deleteRow2OrganizationID = ((ListControlDS)listControlBR2.AssociatedDataSet).ListControl[GeneralConstant.CreateInstance().FirstRow].ListId;
            if (orginalOrganizationId == deleteRow2OrganizationID)
                deleteRow2OrganizationID = ((ListControlDS)listControlBR2.AssociatedDataSet).ListControl[GeneralConstant.CreateInstance().FirstRow + 1].ListId;
            target.ReassignCall(deleteRow2, orginalOrganizationId, deleteRow2OrganizationID);

            target.SaveDataSet();
            target.SelectDataSet();

            //2. Confirm the count of messages decreases increases as more records are reassigned.
            actual = _organizationDeleteDS.OrganizationDelete.Count;
            failMessage = string.Format("It was expected the record count {0} would have decreased from {1}", assert, actual);

            Assert.IsTrue(actual < assert, failMessage);

            //confirm the organization ID for each of the calls is not the same as the original 
            target.SelectMessage(deleteRow1CallID);
            failMessage = string.Format("Assertion: The call can be reselected after reassigning OrganizaztionID count should equal 1, count equals {0}", _organizationDeleteDS.Message.Count);
            Assert.IsTrue(_organizationDeleteDS.Message.Count > 0, failMessage);

            failMessage = string.Format("callid {0} should be assigned to organizationID {1} not {2}", deleteRow1CallID, deleteRow1OrganizationID, orginalOrganizationId);
            int currentOrganizationID = _organizationDeleteDS.Message[GeneralConstant.CreateInstance().FirstRow].OrganizationID;
            Assert.IsTrue(currentOrganizationID != orginalOrganizationId, failMessage);


        }
    }
}
