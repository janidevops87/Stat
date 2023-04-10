using Statline.Stattrac.BusinessRules.Schedule;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using Statline.Stattrac.Data.Types.Schedule;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Data.Types.Organization;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for ScheduleBRTest and is intended
    ///to contain all ScheduleBRTest Unit Tests
    ///</summary>
    [TestClass()]
    public class ScheduleBRTest : BaseTest
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
        ///A test for ToDate
        ///</summary>
        [TestMethod()]
        public void ToDateTest()
        {
            ScheduleBR target = new ScheduleBR(); // TODO: Initialize to an appropriate value
            DateTime expected = new DateTime(); // TODO: Initialize to an appropriate value
            DateTime actual;
            target.ToDate = expected;
            actual = target.ToDate;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for TimeZoneDif
        ///</summary>
        [TestMethod()]
        public void TimeZoneDifTest()
        {
            ScheduleBR target = new ScheduleBR(); // TODO: Initialize to an appropriate value
            int expected = 0; // TODO: Initialize to an appropriate value
            int actual;
            target.TimeZoneDif = expected;
            actual = target.TimeZoneDif;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ScheduleGroupID
        ///</summary>
        [TestMethod()]
        public void ScheduleGroupIDTest()
        {
            ScheduleBR target = new ScheduleBR(); // TODO: Initialize to an appropriate value
            int expected = 0; // TODO: Initialize to an appropriate value
            int actual;
            target.ScheduleGroupID = expected;
            actual = target.ScheduleGroupID;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for FromDate
        ///</summary>
        [TestMethod()]
        public void FromDateTest()
        {
            ScheduleBR target = new ScheduleBR(); // TODO: Initialize to an appropriate value
            DateTime expected = new DateTime(); // TODO: Initialize to an appropriate value
            DateTime actual;
            target.FromDate = expected;
            actual = target.FromDate;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ScheduleBR Constructor
        ///</summary>
        [TestMethod()]
        public void ScheduleBRConstructorTest()
        {
            ScheduleBR target = new ScheduleBR();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
        [TestMethod()]
        public void ScheduleBRTestsaveScheduleLog()
        {
            ScheduleBR target = new ScheduleBR();
            ((ScheduleDS)target.AssociatedDataSet).ScheduleLog.AddScheduleLogRow(1, DateTime.Now, 45, "Insert", "test", "Added new person", DateTime.Now);


            target.SaveDataSet();
        }
        [TestMethod()]
        public void ScheduleBRTestofOrganizationBR()
        {
            OrganizationBR br = new OrganizationBR();
            ((OrganizationDS)br.AssociatedDataSet).EnforceConstraints = false;
            br.PersonSelect(47313);
            
            Assert.IsTrue(((OrganizationDS)br.AssociatedDataSet).Person.Rows.Count == 1, "No records");
            br.PersonSelect(47313);
            Assert.IsTrue(((OrganizationDS)br.AssociatedDataSet).Person.Rows.Count == 1, "No records");




        
        }

    }
}
