using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Security.Principal;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BasePrincipalTest and is intended
    ///to contain all BasePrincipalTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BasePrincipalTest
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
        ///A test for Identity
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void IdentityTest()
        {
            BaseIdentity identity = null; // TODO: Initialize to an appropriate value
            string[] roles = null; // TODO: Initialize to an appropriate value
            BasePrincipal target = new BasePrincipal(identity, roles); // TODO: Initialize to an appropriate value
            IIdentity actual;
            actual = target.Identity;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for IsInRole
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void IsInRoleTest()
        {
            BaseIdentity identity = null; // TODO: Initialize to an appropriate value
            string[] roles = null; // TODO: Initialize to an appropriate value
            BasePrincipal target = new BasePrincipal(identity, roles); // TODO: Initialize to an appropriate value
            string role = string.Empty; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = target.IsInRole(role);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for BasePrincipal Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void BasePrincipalConstructorTest()
        {
            BaseIdentity identity = null; // TODO: Initialize to an appropriate value
            string[] roles = null; // TODO: Initialize to an appropriate value
            BasePrincipal target = new BasePrincipal(identity, roles);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
