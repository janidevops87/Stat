﻿// The following code was generated by Microsoft Visual Studio 2005.
// The test owner should check each test for validity.
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Text;
using System.Collections.Generic;
namespace Test
{
    /// <summary>
    ///This is a test class for Statline.StatTrac.TimeZoneOffSet and is intended
    ///to contain all Statline.StatTrac.TimeZoneOffSet Unit Tests
    ///</summary>
    [TestClass()]
    public class TimeZoneOffSetTest
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
        //
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion


        /// <summary>
        ///A test for MountainTimeZoneOffSet (string, DateTime)
        ///</summary>
        [TestMethod()]
        public void MountainTimeZoneOffSetTestMTNonDayLight()
        {
            string timeZone = "MT"; 

            DateTime activtyDate = new DateTime(2009, 6, 1); 

            MountainTimeZoneOffSetTest(timeZone, activtyDate, 0);

        }
        [TestMethod()]
        public void MountainTimeZoneOffSetTestMTDayLight()
        {
            string timeZone = "MT"; 

            DateTime activtyDate = new DateTime(2009, 1, 1); 

            MountainTimeZoneOffSetTest(timeZone, activtyDate, 0);

        }
        [TestMethod()]
        public void MountainTimeZoneOffSetTestMSNonDayLight()
        {
            string timeZone = "MS"; 

            DateTime activtyDate = new DateTime(2009, 1, 1); 

            MountainTimeZoneOffSetTest(timeZone, activtyDate, 0);

        }
        [TestMethod()]
        public void MountainTimeZoneOffSetTestMSDayLight()
        {
            string timeZone = "MS"; 

            DateTime activtyDate = new DateTime(2009, 6, 1); 

            MountainTimeZoneOffSetTest(timeZone, activtyDate, -1);

        }


        [TestMethod()]
        public void MountainTimeZoneOffSetTestETNonDayLight()
        {
            string timeZone = "ET";

            DateTime activtyDate = new DateTime(2009, 6, 1);

            MountainTimeZoneOffSetTest(timeZone, activtyDate, 2);

        }
        [TestMethod()]
        public void MountainTimeZoneOffSetTestETDayLight()
        {
            string timeZone = "ET";

            DateTime activtyDate = new DateTime(2009, 1, 1);

            MountainTimeZoneOffSetTest(timeZone, activtyDate, 2);

        }
        [TestMethod()]
        public void MountainTimeZoneOffSetTestESNonDayLight()
        {
            string timeZone = "ES";

            DateTime activtyDate = new DateTime(2009, 1, 1);

            MountainTimeZoneOffSetTest(timeZone, activtyDate, 2);

        }
        [TestMethod()]
        public void MountainTimeZoneOffSetTestESDayLight()
        {
            string timeZone = "ES";

            DateTime activtyDate = new DateTime(2009, 6, 1);

            MountainTimeZoneOffSetTest(timeZone, activtyDate, 1);

        }


        private void MountainTimeZoneOffSetTest(string timeZone, DateTime activtyDate, double expected)
        {
            double actual;

            actual = Statline.StatTrac.TimeZoneOffSet.MountainTimeZoneOffSet(timeZone, activtyDate);

            Assert.AreEqual(expected, actual, "Statline.StatTrac.TimeZoneOffSet.MountainTimeZoneOffSet did not return the expect" +
                    "ed value.");
        }

    }


}
