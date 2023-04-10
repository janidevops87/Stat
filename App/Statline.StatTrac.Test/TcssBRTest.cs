using Statline.Stattrac.BusinessRules.NewCall;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for TcssBRTest and is intended
    ///to contain all TcssBRTest Unit Tests
    ///</summary>
    [TestClass()]
    public class TcssBRTest : BaseTest
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
        ///A test for TcssBR Constructor
        ///</summary>
        [TestMethod()]
        public void TcssBRConstructorTest()
        {
            TcssBR target = new TcssBR();
            
        }
        [TestMethod()]
        public void TestSave()
        {
            TcssBR target = new TcssBR();
            target.DonorId = 0;
            target.SelectDataSet();
            
            //target.AssociatedDataSet.ds().ReadXml(@"d:\temp\tcssDataset.xml", System.Data.XmlReadMode.Auto);


            target.SaveDataSet();


        }
    }
}
