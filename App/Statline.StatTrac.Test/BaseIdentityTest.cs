using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseIdentityTest and is intended
    ///to contain all BaseIdentityTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseIdentityTest
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
        ///A test for Name
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void NameTest()
        {
            string name = string.Empty; // TODO: Initialize to an appropriate value
            bool isAuthenticated = false; // TODO: Initialize to an appropriate value
            string databaseInstance = string.Empty; // TODO: Initialize to an appropriate value
            BaseIdentity target = new BaseIdentity(name, isAuthenticated, databaseInstance); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.Name;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for IsAuthenticated
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void IsAuthenticatedTest()
        {
            string name = string.Empty; // TODO: Initialize to an appropriate value
            bool isAuthenticated = false; // TODO: Initialize to an appropriate value
            string databaseInstance = string.Empty; // TODO: Initialize to an appropriate value
            BaseIdentity target = new BaseIdentity(name, isAuthenticated, databaseInstance); // TODO: Initialize to an appropriate value
            bool actual;
            actual = target.IsAuthenticated;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for DatabaseInstance
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void DatabaseInstanceTest()
        {
            string name = string.Empty; // TODO: Initialize to an appropriate value
            bool isAuthenticated = false; // TODO: Initialize to an appropriate value
            string databaseInstance = string.Empty; // TODO: Initialize to an appropriate value
            BaseIdentity target = new BaseIdentity(name, isAuthenticated, databaseInstance); // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            target.DatabaseInstance = expected;
            actual = target.DatabaseInstance;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for CurrentIdentity
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void CurrentIdentityTest()
        {
            BaseIdentity actual;
            actual = BaseIdentity.CurrentIdentity;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for AuthenticationType
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void AuthenticationTypeTest()
        {
            string name = string.Empty; // TODO: Initialize to an appropriate value
            bool isAuthenticated = false; // TODO: Initialize to an appropriate value
            string databaseInstance = string.Empty; // TODO: Initialize to an appropriate value
            BaseIdentity target = new BaseIdentity(name, isAuthenticated, databaseInstance); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.AuthenticationType;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for BaseIdentity Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void BaseIdentityConstructorTest()
        {
            string name = string.Empty; // TODO: Initialize to an appropriate value
            bool isAuthenticated = false; // TODO: Initialize to an appropriate value
            string databaseInstance = string.Empty; // TODO: Initialize to an appropriate value
            BaseIdentity target = new BaseIdentity(name, isAuthenticated, databaseInstance);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
