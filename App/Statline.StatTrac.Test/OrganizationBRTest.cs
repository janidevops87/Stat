using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using System.Data;
using System.Security.Principal;
using System.Linq;
using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Test;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for OrganizationBRTest and is intended
    ///to contain all OrganizationBRTest Unit Tests
    ///</summary>
    [TestClass()]
    public class OrganizationBRTest : BaseTest
    {
        OrganizationBR organizationBR;
        BaseBR baseBr;
        OrganizationDS _organizationDS;
        GeneralConstant generalConstant;
        int organizationId;
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
        [ClassInitialize()]
        public static void MyClassInitialize(TestContext testContext)
        {

        }
        
        //Use ClassCleanup to run code after all tests in a class have run
        [ClassCleanup()]
        public static void MyClassCleanup()
        {
        }
        //
        //Use TestInitialize to run code before running each test
        //This is now called by BaseTest
        //[TestInitialize()]
        protected override void TestInitialize()
        {
            // int organizationId = 0;
            //string name = "bret";
            //bool isUserAuthenticated = WindowsIdentity.GetCurrent().IsAuthenticated;
            //string database = "Production";

            //StattracIdentity identity = new StattracIdentity(name, isUserAuthenticated, database);
            //StattracPrincipal.CreatePrincipal(identity, null);

            //StatEmployeeBR statEmployeeBR = new StatEmployeeBR(name);
            //statEmployeeBR.SelectDataSet();
            //StatEmployeeDS.StatEmployeeDataTable statEmployeeDataTable = ((StatEmployeeDS)statEmployeeBR.AssociatedDataSet).StatEmployee;
            //if (statEmployeeDataTable.Count == 1)
            //{
            //    identity.UserId = statEmployeeDataTable[0].StatEmployeeID;
            //    identity.UserOrganizationId = statEmployeeDataTable[0].OrganizationID;
            //}

            organizationBR = new OrganizationBR();
            baseBr = organizationBR;

            if (generalConstant == null) 
                generalConstant = GeneralConstant.CreateInstance();

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
        /// Test OrganizationId Property
        ///</summary>
        [TestMethod()]
        public void OrganizationIdPropertyTest()
        {
            OrganizationBR target = new OrganizationBR(); // TODO: Initialize to an appropriate value
            target.OrganizationId = 2257;
            int expected = 2257; // TODO: Initialize to an appropriate value
            int actual;
            target.OrganizationId = expected;
            actual = target.OrganizationId;
            Assert.AreEqual(expected, actual);
            
        }
        [TestMethod()]
        public void WebPersonMethodWithExistingRecord()
        {
            organizationBR = new OrganizationBR();
            int organizationID = 2257;
            InitializeApplication(organizationID);
            OrganizationDS.PersonRow personRow = ((OrganizationDS)organizationBR.AssociatedDataSet).Person.First(currentPersonRow => 
            {
                return (currentPersonRow.Inactive == false && ((OrganizationDS)organizationBR.AssociatedDataSet).WebPerson.Count(currentWebPersonRow => currentWebPersonRow.PersonID == currentPersonRow.PersonID) > 0);
            });
            OrganizationDS.WebPersonRow expected = ((OrganizationDS)organizationBR.AssociatedDataSet).WebPerson.First(currentWebPersonRow => currentWebPersonRow.PersonID == personRow.PersonID);
            OrganizationDS.WebPersonRow actual = organizationBR.WebPersonRow(personRow.PersonID);
            Assert.AreEqual(expected.WebPersonID, actual.WebPersonID, "WebPerson row is not the same. ");

        }
        [TestMethod()]
        public void WebPersonMethodWithNonExistingRecord()
        {
            organizationBR = new OrganizationBR();
            int organizationID = 2257;
            InitializeApplication(organizationID);
            OrganizationDS.PersonRow personRow = ((OrganizationDS)organizationBR.AssociatedDataSet).Person.First(currentPersonRow =>
            {
                return (currentPersonRow.Inactive == false && ((OrganizationDS)organizationBR.AssociatedDataSet).WebPerson.Count(currentWebPersonRow => currentWebPersonRow.PersonID == currentPersonRow.PersonID) == 0);
            });
            // create a new WebPersonRow            
            OrganizationDS.WebPersonRow actual = organizationBR.WebPersonRow(personRow.PersonID);
            Assert.IsNull(actual, "WebPerson row exists");

        }
        [TestMethod()]
        public void PersonMethodExistingRecord()
        { 
            organizationBR = new OrganizationBR();
            int organizationID = 2257;
            InitializeApplication(organizationID);
            OrganizationDS.PersonRow expected = ((OrganizationDS)organizationBR.AssociatedDataSet).Person.First(currentPersonRow =>
            {
                return (currentPersonRow.Inactive == false);
            });
            // create a new PersonRow            
            OrganizationDS.PersonRow actual = organizationBR.PersonRow(expected.PersonID);
            Assert.AreSame(expected, actual, "Person rows are not the same");


        }
        [TestMethod()]
        public void PersonMethodNonExistingRecord()
        {
            organizationBR = new OrganizationBR();
            int organizationID = 2257;
            InitializeApplication(organizationID);
            int personId = -99999;
            // create a new PersonRow            
            OrganizationDS.PersonRow actual = organizationBR.PersonRow(personId);
            Assert.IsNull(actual, "Person rows Exists");


        }

        /// <summary>
        ///A test for SetDefaultValue
        ///</summary>
        //[TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void SetDefaultValueTest()
        {
            OrganizationBR_Accessor target = new OrganizationBR_Accessor(); // TODO: Initialize to an appropriate value
            target.SetDefaultValue();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for SelectDuplicateSearchRuleDefault
        ///</summary>
        //[TestMethod()]
        public void SelectDuplicateSearchRuleDefaultTest()
        {
            OrganizationBR target = new OrganizationBR(); // TODO: Initialize to an appropriate value
            target.SelectDuplicateSearchRuleDefault();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for SelectAssociatedReferral
        ///</summary>
        //[TestMethod()]
        //public void SelectAssociatedReferralTest()
        //{
        //    OrganizationBR target = new OrganizationBR(); // TODO: Initialize to an appropriate value
        //    int phoneId = 0; // TODO: Initialize to an appropriate value
        //    target.SelectAssociatedReferral(phoneId);
        //    Assert.Inconclusive("A method that does not return a value cannot be verified.");
        //}

        //[TestMethod()]
        //public void GiftOfLifeHasAssociatedReferrals()
        //{
        //    OrganizationBR target = new OrganizationBR(); // TODO: Initialize to an appropriate value

        //    int organizationID = 2309;
            
        //    target.SelectOrganizationReferrals(organizationID);
        //    Assert.IsTrue((((OrganizationDS)target.AssociatedDataSet).OrganizationReferrals.Rows.Count > 0), string.Format("There are no associated Referrals for OrganizationID: {0}", organizationID));

        //}
        //[TestMethod()]
        //public void DetroitReceivingHasAssociatedReferrals()
        //{
        //    OrganizationBR target = new OrganizationBR(); // TODO: Initialize to an appropriate value

        //    int organizationID = 8319;

        //    target.SelectOrganizationReferrals(organizationID);
        //    Assert.IsTrue((((OrganizationDS)target.AssociatedDataSet).OrganizationReferrals.Rows.Count > 0), string.Format("There are no associated Referrals for OrganizationID: {0}", organizationID));

        //}
        //[TestMethod()]
        //public void NonOrganizationHasNoAssociatedReferrals()
        //{
        //    OrganizationBR target = new OrganizationBR(); // TODO: Initialize to an appropriate value

        //    int organizationID = -99999;
            
        //    target.SelectOrganizationReferrals(organizationID);
        //    Assert.IsTrue((((OrganizationDS)target.AssociatedDataSet).OrganizationReferrals.Rows.Count == 0), string.Format("This organization ({0}) has an associated referral.", organizationID));

        //}
        /// <summary>
        ///A test for BusinessRulesBeforeSelect
        ///</summary>
        //[TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void BusinessRulesBeforeSelectTest()
        {
            OrganizationBR_Accessor target = new OrganizationBR_Accessor(); // TODO: Initialize to an appropriate value
            target.BusinessRulesBeforeSelect();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }
      
        /// <summary>
        ///A test for BusinessRulesCreateRecord
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void BusinessRulesCreateRecord()
        {
            InitializeApplication(0);
            CreateTestOrganization(_organizationDS);
            DateTime initialValue = _organizationDS.Organization[0].LastModified;
            string initialAddressValue = _organizationDS.Organization[0].OrganizationAddress2;
            baseBr.SaveDataSet();
            baseBr.SelectDataSet();

            Assert.AreNotEqual(initialValue, _organizationDS.Organization[0].LastModified, "LastModified was not updated during save");

            _organizationDS.Organization[0].OrganizationAddress2 = "";

            baseBr.SaveDataSet();
            baseBr.SelectDataSet();

            Assert.AreNotEqual(initialAddressValue, _organizationDS.Organization[0].OrganizationAddress2, "Organization Address change was not saved");

        }
        /// <summary>
        ///A test for BusinessRulesCreateRecord
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void BusinessRulesCreateOrganizatonPhoneRecord()
        {
            InitializeApplication(0);
            DateTime initialValue = _organizationDS.Organization[0].LastModified;
            CreateTestOrganization(_organizationDS);

            CreateOrganizationPhoneRecord(1, _organizationDS);
            CreateOrganizationPhoneRecord(2, _organizationDS);
            CreateOrganizationPhoneRecord(3, _organizationDS);

            baseBr.SaveDataSet();
            baseBr.SelectDataSet();

            int assertion = 3; // 3 phone records
            Assert.AreEqual(assertion, _organizationDS.OrganizationPhone.Rows.Count);                                

        }
        private void CreateBillToRecord(int billToInstance, OrganizationDS _organizationDS)
        {            
            _organizationDS.BillTo.OrganizationIDColumn.DefaultValue = _organizationDS.Organization[generalConstant.FirstRow].OrganizationID;
            OrganizationDS.BillToRow billToRow = _organizationDS.BillTo.NewBillToRow();
            switch (billToInstance)
            {
                case 1:
                    
                    billToRow.Address1 = "1234 Street";
                    billToRow.City = "My City";
                    billToRow.CountryID = 1;
                    billToRow.Countryname = "My Country";
                    billToRow.PostalCode = "88888-888";
                    break;
            }
            _organizationDS.BillTo.AddBillToRow(billToRow);
        }
        private void CreateContactRecord(int personInstance, OrganizationDS organizationDS)
        {
            _organizationDS.Person.OrganizationIDColumn.DefaultValue = _organizationDS.Organization[generalConstant.FirstRow].OrganizationID;
            OrganizationDS.PersonRow personRow = organizationDS.Person.NewPersonRow();
            
            //add a new case switch branch to add a new person
            switch(personInstance)
            {

                case 1:
            
                    personRow.PersonFirst = "Terry";          
                    personRow.PersonMI = "T";
                    personRow.PersonLast = "Aki";
                    personRow.PersonTypeID = 55;
                    // personRow.OrganizationID = organizationDS.Organization[or;
                    personRow.PersonNotes = "Test User";
                    personRow.PersonBusy = 0;
                    personRow.Verified = 0;
                    personRow.Inactive = false;
                    /// personRow.LastModified = "";
                    // personRow.PersonBusyUntil = "";
                    // personRow.PersonTempNoteActive = "";
                    // personRow.PersonTempNoteExpires = "";
                    //personRow.PersonTempNote = "";
                    //personRow.Unused = "";
                    //personRow.UpdatedFlag = "";
                    // personRow.AllowInternetScheduleAccess = "";
                    // personRow.PersonSecurity = "";
                    // personRow.PersonArchive = "";
                    personRow.LastStatEmployeeID = 45;
                    personRow.AuditLogTypeID = 1;
                    personRow.GenderID = 2;
                    personRow.RaceID = 6;
                    personRow.Credential = "";
                    // personRow.TrainedRequestorID = "";
                    break;
         }   
            organizationDS.Person.AddPersonRow(personRow);
        
        }
        private void CreateOrganizationPhoneRecord(int phoneInstance1, OrganizationDS organizationDS)
        {
            string phoneNumber = "";
            switch (phoneInstance1)
            {
                case 1:
                    phoneNumber = "(303)303-3030";
                break;
                case 2:
                    phoneNumber = "(303)303-3031";
                break;
                case 3:
                    phoneNumber = "(303)303-3032";
                break;

            }

            OrganizationDS.OrganizationPhoneRow row = _organizationDS.OrganizationPhone.NewOrganizationPhoneRow();
            row.Phone = phoneNumber;
            row.PhoneTypeID = 1;
            row.SubLocationID = 1;
            row.SubLocationLevelID = 1;
            row.Inactive = false;
            organizationDS.OrganizationPhone.AddOrganizationPhoneRow(row);

        }
        private void CreateTestOrganization(OrganizationDS organizationDS)
        { 
            int stateId = 1;
            int countyId = 1;
            string organizationCity = "TestCity";
            CreateTestOrganization(organizationDS, stateId, countyId, organizationCity);
        }
        private void CreateTestOrganization(OrganizationDS organizationDS, int stateId, int countyId, string organizationCity)
        {
            organizationDS.Organization[0].OrganizationName = "Test Organization";
            organizationDS.Organization[0].OrganizationAddress1 = "TestAddress1";
            organizationDS.Organization[0].OrganizationAddress2 = "TestAddress2";

            organizationDS.Organization[0].OrganizationCity = "TestCity";
            organizationDS.Organization[0].OrganizationStatusID = 1;
            organizationDS.Organization[0].StateID = 1;
            organizationDS.Organization[0].OrganizationZipCode = "00000-000";
            organizationDS.Organization[0].OrganizationTimeZone = "MT";
            organizationDS.Organization[0].OrganizationNotes = "";
            organizationDS.Organization[0].OrganizationNoPatientName = 0;
            organizationDS.Organization[0].OrganizationNoRecordNum = 0;
            organizationDS.Organization[0].OrganizationConfCallCust = 0;
            organizationDS.Organization[0].OrganizationReferralNotes = "";
            organizationDS.Organization[0].OrganizationMessageNotes = "";
            organizationDS.Organization[0].OrganizationConsentInterval = 0;
            organizationDS.Organization[0].OrganizationLOType = 0;
            organizationDS.Organization[0].OrganizationLOTriageEnabled = 0;
            organizationDS.Organization[0].OrganizationLOFSEnabled = 0;
            organizationDS.Organization[0].OrganizationArchive = 0;
            organizationDS.Organization[0].CountryCodeID = 1;
            organizationDS.Organization[0].CountryID = 1;
            organizationDS.Organization[0].CountyID = 1;
            organizationDS.Organization[0].OrganizationTypeID = 1;
            organizationDS.Organization[0].PhoneID = 1;
            organizationDS.Organization[0].Verified = 1;
            organizationDS.Organization[0].Inactive = 1;
            organizationDS.Organization[0].OrganizationPageInterval = 10;
            organizationDS.Organization[0].TimeZoneID = 1;
            organizationDS.Organization[0].IDdID = 1;
            organizationDS.Organization[0].LastModified = DateTime.Now;
        }
        /// <summary>
        ///A test for BusinessRulesBeforeSave
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void BusinessRulesBeforeSaveTest()
        {
            InitializeApplication(2257);
            DateTime initialValue = _organizationDS.Organization[0].LastModified;
            _organizationDS.Organization[0].OrganizationAddress2 = "TestAddress";
           
            baseBr.SaveDataSet();
            baseBr.SelectDataSet();
            
            Assert.AreNotEqual(initialValue, _organizationDS.Organization[0].LastModified);

            _organizationDS.Organization[0].OrganizationAddress2 = "";

            baseBr.SaveDataSet();
            baseBr.SelectDataSet();

        }

        /// <summary>
        ///A test for BusinessRulesAfterSelect
        ///</summary>
        [TestMethod()]
        [TestProperty("organizationId", "2257")]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void BusinessRulesAfterSelectTest()
        {
            // Get the current tyep
            Type testProperty = GetType();

            organizationId = 2257; //Convert.ToInt32(testProperty.GetMethod("organizationId"));

            InitializeApplication(organizationId);

            //NOTE: multiple things can be tested only the first thing that fails will be returned. 
            Assert.IsTrue(_organizationDS.Organization.Rows.Count > 0, "Organization was not selected.");
            //Assert.IsTrue(organizationDS.BillTo.Rows.Count > 0);
            //Assert.IsTrue(_organizationDS.OrganizationDuplicateSearchRule.Rows.Count > 0,  "OrganizationDuplicateSearchRule was not selected.");
            //Assert.IsTrue(_organizationDS.OrganizationDashBoardTimer.Rows.Count > 0,  "OrganizationDashBoardTimer was not selected.");
            Assert.IsTrue(_organizationDS.County.Rows.Count > 0, "County Table was not selected.");

            //OrganizationBR_Accessor target = new OrganizationBR_Accessor(); // TODO: Initialize to an appropriate value
            //target.OrganizationId = 2257;
            //baseBr.SelectDataSet();            
            //target.BusinessRulesAfterSelect();

            
        }

        /// <summary>
        ///A test for AddEmptyRow
        ///</summary>
        //  [TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void AddEmptyRowTest1()
        {
            OrganizationBR_Accessor target = new OrganizationBR_Accessor(); // TODO: Initialize to an appropriate value
            DataTable table = null; // TODO: Initialize to an appropriate value
            DataRow expected = null; // TODO: Initialize to an appropriate value
            DataRow actual;
            actual = target.AddEmptyRow(table);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for AddEmptyRow
        ///</summary>
        // [TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void AddEmptyRowTest()
        {
            OrganizationBR_Accessor target = new OrganizationBR_Accessor(); // TODO: Initialize to an appropriate value
            target.AddEmptyRow();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for AddEmptRow
        ///</summary>
        //[TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void AddEmptRowTest()
        {
            //OrganizationBR_Accessor target = new OrganizationBR_Accessor(); // TODO: Initialize to an appropriate value
            //organizationDS.OrganizationDuplicateSearchRuleDataTable table = null; // TODO: Initialize to an appropriate value
            //target.AddEmptyRow(table);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for OrganizationBR Constructor
        ///</summary>
        // [TestMethod()]
        public void OrganizationBRConstructorTest()
        {
            OrganizationBR target = new OrganizationBR();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
        /// <summary>
        /// 
        /// </summary>
        /// 
        /// <param name="organizationId"></param>
        [TestMethod()]
        public void OrganizationBRCheckForUserNameDuplicatesUserNameDoesNotExistTest()
        {
         
            //set the expected value
            int expected = 0; // i expect there are no duplicate names 
            int actual = -1;
            int organizationID = 2309; // gift of life
            InitializeApplication(organizationID);
            int webPersonID = -1;
            string webPersonUserName = "ChrisNULLAnderson";
            int personId = ((OrganizationDS)organizationBR.AssociatedDataSet).Person.First(row => row.Inactive == false).PersonID;

            actual = organizationBR.CheckForUserNameDuplicates(webPersonUserName, webPersonID, personId );
            string message = string.Format("The value of  organizationBR.CheckForUserNameDuplicatesResults is {0}", organizationBR.CheckForUserNameDuplicatesResults);

            Assert.AreEqual(expected, actual, message);
        }

        [TestMethod()]
        public void OrganizationBRSelectOrganizationDupesOrginzationNameOnly()
        { 
            
            string organizationName = "st john";
            int countyId=0;
            int stateId=0;
            int expected = 0; // expect there are more than zero
            int actual = -1;
            int organizationID = 0; // new organization
            InitializeApplication(organizationID);

            organizationBR.SelectOrganizationDupes(organizationName, stateId, countyId );

            actual = _organizationDS.OrganizationSearch.Count;

            Assert.IsTrue(actual > expected, "No Organizations Were found");

        }
        [TestMethod()]
        public void OrganizationBRValidFieldBillToDoesNotExistContractedClients()
        {
            int firstRow = 0;
            bool expected = false;
            bool actual;
            InitializeApplication(0);
            //create an instance of the OrganizationDS
            CreateTestOrganization(_organizationDS);
            //set the Contracted Contract Clients
            _organizationDS.Organization[firstRow].ContractedStatlineClient = true;
            _organizationDS.BillTo.Clear();

            actual = organizationBR.ValidField(OrganizationFields.BillTo);

            string message = string.Format("The billing address is empty. The ValidField Check expected {0} but received {1} ", expected, actual);
            Assert.AreEqual(expected, actual, message);

        }
        [TestMethod()]
        public void OrganizationBRValidFieldBillToDoesExistContractedClients()
        {
            int firstRow = 0;
            bool expected = true;
            bool actual;


            InitializeApplication(0);
            //create an instance of the OrganizationDS
            CreateTestOrganization(_organizationDS);
            //set the Contracted Contract Clients
            _organizationDS.Organization[firstRow].ContractedStatlineClient = true;
            int billToInstance = 1;
            CreateBillToRecord(billToInstance, _organizationDS);

            actual = organizationBR.ValidField(OrganizationFields.BillTo);

            string message = string.Format("The billing address exists. The ValidField Check expected {0} but received {1} ", expected, actual);
            Assert.AreEqual(expected, actual, message);

        }



        [TestMethod()]
        public void OrganizationBRValidFieldBillToDoesNotExistNonContractedClients()
        {
            int firstRow = 0;
            bool expected = true;
            bool actual;
            InitializeApplication(0);
            //create an instance of the OrganizationDS
            CreateTestOrganization(_organizationDS);
            //set the Contracted Contract Clients
            _organizationDS.Organization[firstRow].ContractedStatlineClient = false;
            _organizationDS.BillTo.Clear();

            actual = organizationBR.ValidField(OrganizationFields.BillTo);

            string message = string.Format("Billing Address is not Required. The ValidField Check expected {0} but received {1} ", expected, actual);
            Assert.AreEqual(expected, actual, message);

        }
        [TestMethod()]
        public void OrganizationBRValidFieldBillToDoesExistNonContractedClients()
        {
            int firstRow = 0;
            bool expected = true;
            bool actual;


            InitializeApplication(0);
            //create an instance of the OrganizationDS
            CreateTestOrganization(_organizationDS);
            //set the Contracted Contract Clients
            _organizationDS.Organization[firstRow].ContractedStatlineClient = false;
            _organizationDS.BillTo.OrganizationIDColumn.DefaultValue = _organizationDS.Organization[firstRow].OrganizationID;
            OrganizationDS.BillToRow billToRow = _organizationDS.BillTo.NewBillToRow();
            billToRow.Address1 = "1234 Street";
            billToRow.City = "My City";
            billToRow.CountryID = 1;
            billToRow.Countryname = "My Country";
            billToRow.PostalCode = "88888-888";

            _organizationDS.BillTo.AddBillToRow(billToRow);

            actual = organizationBR.ValidField(OrganizationFields.BillTo);

            string message = string.Format("Billing Address is not Required. The ValidField Check expected {0} but received {1} ", expected, actual);
            Assert.AreEqual(expected, actual, message);

        }

        [TestMethod()]
        public void OrganizationBRSelectOrganizationDupesOrginzationName()
        {

            string organizationName = "st john";
            int countyId = 0;
            int stateId = 0;
            int expected = 0; // expect there are more than zero
            int actual = -1;
            int organizationID = 0; // new organization
            InitializeApplication(organizationID);

            organizationBR.SelectOrganizationDupes(organizationName, stateId, countyId);

            expected = _organizationDS.OrganizationSearch.Count;
            countyId = 1;
            stateId = 6;
            organizationBR.SelectOrganizationDupes(organizationName, stateId, countyId);
            actual = _organizationDS.OrganizationSearch.Count;

            string message = string.Format("State and County did not reduce the Count {0} < {1}", actual, expected);

            Assert.IsTrue(actual < expected, message);

        }

        [TestMethod()]
        public void OrganizationBRCheckForUserNameDuplicatesUserNameDoesExistTest()
        {

            //set the expected value
            int expected = 2; // i expect there are no duplicate names 
            int actual = -1;
            int organizationID = 2309; // gift of life
            InitializeApplication(organizationID);
            int webPersonID = -1;
            string webPersonUserName = "bret";
            int personId = ((OrganizationDS)organizationBR.AssociatedDataSet).Person.First(row => row.Inactive == false).PersonID;

            actual = organizationBR.CheckForUserNameDuplicates(webPersonUserName, webPersonID, personId);
            string message = string.Format("The value of  organizationBR.CheckForUserNameDuplicatesResults is {0}", organizationBR.CheckForUserNameDuplicatesResults);

            Assert.AreEqual(expected, actual , message);
        }
        [TestMethod()]
        [WorkItem(3330)]
        [Description("Tests that TimeZone can be Loaded")]
        public void OrganizationBRSelectTimeZone()
        {
            //set the expected value
            int expected = 0; // Expect value to be greater than expected  
            int actual = 0;
            int organizationID = 0; // default
            InitializeApplication(organizationID);

            actual = ((OrganizationDS)organizationBR.AssociatedDataSet).TimeZone.Count();
            string preCheckMessage = string.Format("TimeZone should have {0} records, but has {1}", expected, actual);
            Assert.AreEqual(expected, actual, preCheckMessage);

            organizationBR.SelectTimeZone();

            actual = ((OrganizationDS)organizationBR.AssociatedDataSet).TimeZone.Count();
            string message = string.Format("TimeZone should have more than {0} records, but has {1}", expected, actual);

            Assert.AreNotEqual(expected, actual, message);

        
        }
        [TestMethod()]
        [WorkItem(3330)]
        [Description("Tests that TimeZone ObservesDaylightSavings")]
        public void OrganizationBRObservesDaylightSavings()
        {
            //set the expected value
            Boolean expected = true;
            Boolean  actual = false;
            int organizationID = 0; // default
            InitializeApplication(organizationID);
            /*
             *  1	Atlantic	AT	1
                2	Eastern	ET	1
                3	Central	CT	1
                4	Mountain	MT	1
                5	Arizona	AZ	0
                6	Pacific	PT	1
                7	Alaska	AK	1
                8	Hawaii-Aleutian	HT	0
             * 
             */
            expected = true;
            actual = false;
            actual =  organizationBR.ObservesDayLightSavings(1);
            string observesTrueMessage = string.Format("Observes should be {0}, but is {1}", expected, actual);
            Assert.AreEqual(expected, actual, observesTrueMessage);

            expected = false;
            actual = true;
            actual = organizationBR.ObservesDayLightSavings(5);
            string observesFalseMessage = string.Format("Observes should be {0}, but is {1}", expected, actual);
            Assert.AreEqual(expected, actual, observesFalseMessage);

            expected = false;
            actual = true;
            actual = organizationBR.ObservesDayLightSavings(-1);
            string timeZoneNotSetMessage = string.Format("Observes should be {0}, but is {1}", expected, actual);
            Assert.AreEqual(expected, actual, timeZoneNotSetMessage);



        }
        [TestMethod()]
        [WorkItem(3367)]
        [WorkItem(3336)]
        [Description("Tests that a List of OrganizationPhones can be selected and a row ca be selected if it does not exist ")]
        public void OrganizationBRSelectOrganizationPhone()
        {
            //set the expected value
            int expected = 0;
            int actual = 0;
            string organizationType = "Call Back";
            //int organizationID = 2309; // default
            List<OrganizationDS.OrganizationPhoneRow> organizationPhoneList;
            organizationPhoneList = organizationBR.SelectOrganizationPhone(organizationType);
            actual = organizationPhoneList.Count();
            string observesTrueMessage = string.Format("Expect record count to be greater than {0}, value is {1}", expected, actual);
            Assert.IsTrue(actual > expected , observesTrueMessage);

        }        
        public void InitializeApplication(int organizationId)
        {
            
            organizationBR.OrganizationId = organizationId;
            organizationBR.SelectDataSet();
            _organizationDS = ((OrganizationDS)organizationBR.AssociatedDataSet);

        }
        public void InitializeApplication()
        {

            organizationBR.OrganizationId = generalConstant.OrganizationId;
            organizationBR.ContactId = generalConstant.ContactId;

            organizationBR.SelectDataSet();
            _organizationDS = ((OrganizationDS)organizationBR.AssociatedDataSet);

        }
        
        /// <summary>
        ///A test for CheckConflictingOrganizationPhone
        ///</summary>
        [TestMethod()]
        [WorkItem(3367)]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void CheckConflictingOrganizationPhoneTest1()
        {
            OrganizationBR_Accessor target = new OrganizationBR_Accessor(); // TODO: Initialize to an appropriate value
            target.OrganizationId = 2309;
            InitializeApplication(target.OrganizationId);
                        
            //create a new records
            CreateOrganizationPhoneRecord(1, _organizationDS);           
             

            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = target.CheckConflictingOrganizationPhone(_organizationDS);
            string failMessage = string.Format("It is expected the actual string will have text it is currently {0}", actual);

            Assert.IsTrue( actual.Length > 0, failMessage);
            

        }

        /// <summary>
        ///A test for CheckConflictingOrganizationPhone
        ///</summary>
        [TestMethod()]
        [WorkItem(3367)]
        public void CheckConflictingOrganizationPhoneTest()
        {
            
            bool sendEmail = true; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            int organizationId = 2309;
            InitializeApplication(organizationId );
            CreateOrganizationPhoneRecord(1, _organizationDS); 

            string actual;
            actual = organizationBR.CheckConflictingOrganizationPhone(sendEmail);
            string failMessage = string.Format("It is expected the actual string will have text it is currently {0}", actual);

            Assert.IsTrue(actual.Length > 0, failMessage);

        }
        /// <summary>
        ///A test for CheckConflictingOrganizationPhone
        ///</summary>
        [TestMethod()]
        [WorkItem(3367)]
        [Description("Test when number does not exist")]
        public void CheckConflictingOrganizationPhoneTest2()
        {

            bool sendEmail = true; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            int organizationId = 2309;
            InitializeApplication(organizationId);
            _organizationDS.OrganizationPhone.Clear();
            CreateOrganizationPhoneRecord(1, _organizationDS);
            if (_organizationDS.OrganizationPhone.Count > 0)
                _organizationDS.OrganizationPhone[0].Phone = "(999) 999-zzzz";
            string actual;
            actual = organizationBR.CheckConflictingOrganizationPhone(sendEmail);
            string failMessage = string.Format("It is expected the actual string will have text it is currently {0}", actual);

            Assert.IsTrue(actual.Length == 0, failMessage);

        }
        /// <summary>
        /// Test Delete an organization
        /// </summary>
        [TestMethod()]
        [WorkItem(2959)]
        [Description("Test Delete an organization")]
        public void DeleteOrganization()
        {
            int organizationId = 15774;
            InitializeApplication(organizationId);

            if (_organizationDS.Organization.Count > 0)
            {
                _organizationDS.Organization[GeneralConstant.CreateInstance().FirstRow].Delete();

                organizationBR.SaveDataSet();
            }


        }
        [TestMethod()]
        [WorkItem(3375)]
        public void SetContactIDTest()
        {
            int organizationID = 0;
            InitializeApplication(organizationID);
            CreateTestOrganization(_organizationDS);
            CreateContactRecord(1, _organizationDS);

            int original = generalConstant.ContactId;

            organizationBR.SaveDataSet();

            int actual = generalConstant.ContactId;
            string errorMessage = string.Format("It was expected these values would be different {0} and {1}", original, actual);
            Assert.AreNotEqual(original, actual, errorMessage);
            


        }
        [TestMethod()]
        [WorkItem(5373)]
        public void OrganizationOpenByContactStatlineUser()
        {
            int expected = 194;
            generalConstant.OrganizationId = Int32.MinValue;
            generalConstant.ContactId = 47313;
            InitializeApplication();

            int actual = _organizationDS.Organization[generalConstant.FirstRow].OrganizationID;

            string errorMessage = string.Format("It was expected these two Organization values would be same {0} and {1}", expected, actual);
            Assert.AreEqual(expected, actual, errorMessage);



        }
        [TestMethod()]        
        public void SelectSingleOrganizationTableOnlyTest()
        {
            int organizationId = 2257;

            organizationBR.OrganizationId = organizationId;
            organizationBR.SelectOrganization();
            _organizationDS = ((OrganizationDS)organizationBR.AssociatedDataSet);




        }

        [TestMethod()]
        [WorkItem(9376)]
        public void AddOrganizationAdministrationDefaultsTest()
        {
            int CO = 14;
            
            InitializeApplication();
            int stateId = 6;
            int countyId = 1;
            string organizationCity = "Denver";
            CreateTestOrganization(_organizationDS, stateId, countyId, organizationCity);

            generalConstant.SourceCodeId = CO;
            generalConstant.IsNewCallOrganization = true;
            organizationBR.SaveDataSet();                          
            


        }

        [TestMethod()]
        public void TestEachTableRowAfterSaveTest()
        {
            
            int organizationID = 2257;
            InitializeApplication(organizationID);
            _organizationDS.Organization[generalConstant.FirstRow].ProviderNumber = "test1234";
            organizationBR.SaveDataSet();
            organizationBR.SelectDataSet();

            string tableMessage = "";
            string rowMessage = "";

            foreach (DataTable dataTable in _organizationDS.Tables)
            {
                tableMessage = string.Format("Table {0} has errors.", dataTable.TableName);
                Assert.IsFalse(dataTable.HasErrors, tableMessage);

                for(int rowIndex =0; rowIndex < dataTable.Rows.Count; rowIndex++)
                {
                    DataRow dataRow = dataTable.Rows[rowIndex];

                    rowMessage = string.Format("Table {0} has errors on row {1} {2}\n{3}\n{4}", dataTable.TableName, rowIndex, dataRow.ToString(), dataRow.RowError, dataRow.RowState);
                    Assert.IsFalse(dataRow.HasErrors, rowMessage);

                    
                }
            
            }
        }
        [TestMethod()]
        public void ContactRoleSelectTest()
        {
            int organizationID = 194;
            InitializeApplication(organizationID);

            int expectedCount = 0;            
            int actualCount;
            string emptyTableMessage;
            actualCount = _organizationDS.ContactRole.Rows.Count;
            emptyTableMessage = string.Format("The table ContactRole is expected to contain {0} records but contains {1}.", expectedCount, actualCount);
            Assert.AreEqual(expectedCount, actualCount, emptyTableMessage);

            //find first record in 
            int contactId = _organizationDS.Person[generalConstant.FirstRow].PersonID;

            organizationBR.ContactRoleSelect(contactId);
            expectedCount = 0;
            actualCount = 0;
            actualCount = _organizationDS.ContactRole.Rows.Count;
            string  multiRecordTableMessage = string.Format("The table ContactRole is expected to contain more than {0} records but contains {1}.", expectedCount, actualCount);
            Assert.AreNotEqual(expectedCount, actualCount, multiRecordTableMessage);

        }
        [TestMethod()]
        public void OrganizationContactsInactiveTest()
        {
            int organizationID = 194;
            InitializeApplication(organizationID);

            int expectedCount = 0;
            int actualCount;
            string emptyTableMessage;
            actualCount = _organizationDS.Person.Where(personRow => personRow.Inactive == true).Count();
            emptyTableMessage = string.Format("The table Personis expected to contain {0} Inactive records but it contains {1}.", expectedCount, actualCount);
            Assert.AreEqual(expectedCount, actualCount, emptyTableMessage);

            organizationBR.PersonSelect();

            actualCount = _organizationDS.Person.Where(personRow => personRow.Inactive == true).Count();
            emptyTableMessage = string.Format("The table Person is expected to contain more than {0} Inactive records but it contains {1}.", expectedCount, actualCount);
            Assert.AreNotEqual(expectedCount, actualCount, emptyTableMessage);

            
        }
        [TestMethod()]
        public void OrganizationContactsCreateTest()
        {
            int organizationID = 194;
            InitializeApplication(organizationID);
            int personInstance = 1;

            CreateContactRecord(personInstance, _organizationDS);
            organizationBR.SaveDataSet();


        }
        [TestMethod()]
        public void OrganizationUserTest()
        {
            int organizationID = 194;
            InitializeApplication(organizationID);
            int personInstance = 1;
            CreateContactRecord(personInstance, _organizationDS);

            int personID = 0;
            string userName = Guid.NewGuid().ToString().Substring(0, 7).ToString();

            int webPersonID =  organizationBR.WebPersonRow(personID, userName);

            organizationBR.SelectContactRoles(webPersonID, personID);
            organizationBR.CheckForUserNameDuplicates(userName, webPersonID, personID);
            organizationBR.SaveDataSet();


        }

        [TestMethod()]
        public void OrganizationContactsUpdateRaceTest()
        {
            int organizationID = 194;
            InitializeApplication(organizationID);

            
            //find a person with no race set
            _organizationDS.Person.ToList().ForEach(updateRow =>
            {
                try 
                {
                    if (updateRow.RaceID < 1)
                        updateRow.RaceID = 0;
                }
                catch 
                {
                    updateRow.RaceID = 0;
                }
                updateRow.AcceptChanges();
            });
            List<OrganizationDS.PersonRow> personRow = _organizationDS.Person.Where(checkPersonRow => checkPersonRow.RaceID < 1).ToList();

            int actual = personRow.Count();
            string assertmessage = string.Format("it was expected to find multiple records but only {0} was found", actual);

            personRow[0].RaceID = 1;
           
            
            organizationBR.SaveDataSet();


        }
        [TestMethod()]
        [DeploymentItem("Statline.Stattrac.BusinessRules.dll")]
        public void PersonTempNoteAndBusyTest()
        {
            InitializeApplication(194);
            DateTime current = DateTime.Now.AddMinutes(10);
            OrganizationDS.PersonRow person =  _organizationDS.Person.First(personRow => personRow.Inactive == false);
            int personID = person.PersonID;

            person.PersonBusyUntil = current;
            person.PersonBusy = 1;
            person.PersonTempNoteExpires = current;
            person.PersonTempNoteActive = 1;

            int personBusyExpected = person.PersonBusy;
            int personTempNoteActiveExpected = person.PersonTempNoteActive;
            DateTime personTempNoteExpiresExpected = person.PersonTempNoteExpires;
            DateTime personBusyUntilExpected = person.PersonBusyUntil;
            

            baseBr.SaveDataSet();
            baseBr.SelectDataSet();

            person = organizationBR.PersonRow(personID);

            int personBusyActual = person.PersonBusy;
            int personTempNoteActiveActual = person.PersonTempNoteActive;
            DateTime personTempNoteExpiresActual = person.PersonTempNoteExpires;
            DateTime personBusyUntilActual = person.PersonBusyUntil;

            string PersonBusyActualMessage = string.Format("PersonBusy is expected {0} but equals {1}.", personBusyExpected, personBusyActual) ;

            Assert.AreEqual(personBusyExpected, personBusyActual, PersonBusyActualMessage);

            string PersonTempNoteActiveActualMessage = string.Format("PersonTempNoteActive is expected {0} but equals {1}.", personTempNoteActiveExpected, personTempNoteActiveActual) ;

            Assert.AreEqual(personTempNoteActiveExpected, personTempNoteActiveActual, PersonTempNoteActiveActualMessage);

            string PersonTempNoteExpiresActualMessage = string.Format("PersonTempNoteExpires is expected {0} but equals {1}.", personTempNoteExpiresExpected , personTempNoteExpiresActual);

            Assert.AreEqual(PersonTempNoteExpiresActualMessage, personTempNoteExpiresExpected, PersonTempNoteExpiresActualMessage);

            string PersonBusyUntilActualMessage = string.Format("PersonBusyUntil is expected {0} but equals {1}.", personBusyUntilExpected, personBusyUntilActual);

            Assert.AreEqual(PersonBusyUntilActualMessage, personBusyUntilExpected, PersonBusyUntilActualMessage);

            
        }
        [TestMethod()]
        public void OrganizationCreateFromCall()
        {
            int organizationID = 0;
            InitializeApplication(organizationID);
            int personInstance = 1;
            CreateContactRecord(personInstance, _organizationDS);
            generalConstant.SourceCodeId = 315 ;
            generalConstant.IsNewCallOrganization = true;

            OrganizationDS.OrganizationRow org = organizationBR.AssociatedDataSet.organizationDs().Organization[generalConstant.FirstRow];
            org.OrganizationName = String.Format("Bret TestOrg{0}", DateTime.Now.ToLocalTime() );
            //org.OrganizationAddress1 = "123 Test Street";
            //org.OrganizationZipCode = "78701";
            //org.CountyID = 1491;
            //org.StateID = 41;
            //org.OrganizationTypeID = 10; // Hospital
            //org.TimeZoneID = 2; //eastern
            //org.CountryID = 1;
            org.OrganizationAddress1 = "123 Test Street";
            org.OrganizationZipCode = "92411";
            org.CountyID = 1894;
            org.StateID = 5; //CA
            org.OrganizationCity = "Los Angeles";
            org.OrganizationTypeID = 10; // Hospital
            org.TimeZoneID = 6; //pacific
            org.CountryID = 1;



            organizationBR.SaveDataSet();


        }

    }
}
