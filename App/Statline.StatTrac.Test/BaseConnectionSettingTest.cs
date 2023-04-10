using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseConnectionSettingTest and is intended
    ///to contain all BaseConnectionSettingTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseConnectionSettingTest
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
        ///A test for DefaultDatabase
        ///</summary>
        //[TestMethod()]
	[Ignore()]
        public void DefaultDatabaseTest()
        {
            BaseConnectionSetting target = new BaseConnectionSetting(); // TODO: Initialize to an appropriate value
            string test = "Development";
            string actual;
            actual = target.DefaultDatabase;
            Assert.AreEqual(test, actual);
            
        }

        /// <summary>
        ///A test for BaseConnectionSetting Constructor
        ///</summary>        
        public void BaseConnectionSettingConstructorTest()
        {
            BaseConnectionSetting target = new BaseConnectionSetting();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        /// <summary>
        ///A test for DefaultDatabase
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void DefaultDatabaseTest1()
        {
            BaseConnectionSetting target = new BaseConnectionSetting(); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.DefaultDatabase;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ConnectionStrings
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void ConnectionStringsTest()
        {
            BaseConnectionSetting target = new BaseConnectionSetting(); // TODO: Initialize to an appropriate value
            ArrayList actual;
            actual = target.ConnectionStrings;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for BaseConnectionSetting Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void BaseConnectionSettingConstructorTest1()
        {
            BaseConnectionSetting target = new BaseConnectionSetting();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
