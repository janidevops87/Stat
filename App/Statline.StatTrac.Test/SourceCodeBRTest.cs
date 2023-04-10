using Statline.Stattrac.BusinessRules.SourceCode;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for SourceCodeBRTest and is intended
    ///to contain all SourceCodeBRTest Unit Tests
    ///</summary>
    [TestClass()]
    public class SourceCodeBRTest : BaseTest
    {
        SourceCodeBR _sourceCodeBR;

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
        protected override void TestInitialize()
        {
            _sourceCodeBR = new SourceCodeBR();
        }
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
        ///A test for SourceCodeBR Constructor
        ///</summary>
        [TestMethod()]
        public void SourceCodeBRConstructorTest()
        {
            SourceCodeBR target = new SourceCodeBR();
            
        }
        [TestMethod()]
        public void AddSourceCodeOrganizationDefaultsTest()
        {
            int organizationID = 5;

            _sourceCodeBR.AddOrganizationDefault(organizationID);

        }
    }
}
