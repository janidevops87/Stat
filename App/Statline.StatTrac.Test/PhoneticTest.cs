using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for PhoneticTest and is intended
    ///to contain all PhoneticTest Unit Tests
    ///</summary>
    [TestClass()]
    public class PhoneticTest
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
        ///A test for Soundex
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void SoundexTest()
        {
            string data = string.Empty; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = Phonetic.Soundex(data);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for Difference
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void DifferenceTest()
        {
            string data1 = string.Empty; // TODO: Initialize to an appropriate value
            string data2 = string.Empty; // TODO: Initialize to an appropriate value
            int expected = 0; // TODO: Initialize to an appropriate value
            int actual;
            actual = Phonetic.Difference(data1, data2);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for Phonetic Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void PhoneticConstructorTest()
        {
            Phonetic target = new Phonetic();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
