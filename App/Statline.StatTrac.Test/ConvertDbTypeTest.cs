using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for ConvertDbTypeTest and is intended
    ///to contain all ConvertDbTypeTest Unit Tests
    ///</summary>
    [TestClass()]
    public class ConvertDbTypeTest
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
        ///A test for GetDbType
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void GetDbTypeTest()
        {
            Type type = null; // TODO: Initialize to an appropriate value
            DbType expected = new DbType(); // TODO: Initialize to an appropriate value
            DbType actual;
            actual = ConvertDbType_Accessor.GetDbType(type);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ConvertDbType Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void ConvertDbTypeConstructorTest()
        {
            ConvertDbType_Accessor target = new ConvertDbType_Accessor();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
