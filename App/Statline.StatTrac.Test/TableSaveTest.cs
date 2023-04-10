using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for TableSaveTest and is intended
    ///to contain all TableSaveTest Unit Tests
    ///</summary>
    [TestClass()]
    public class TableSaveTest
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
        ///A test for UpdateSproc
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void UpdateSprocTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            TableSave_Accessor target = new TableSave_Accessor(param0); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.UpdateSproc;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for TableName
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void TableNameTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            TableSave_Accessor target = new TableSave_Accessor(param0); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.TableName;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for InsertSproc
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void InsertSprocTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            TableSave_Accessor target = new TableSave_Accessor(param0); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.InsertSproc;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for DeleteSproc
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void DeleteSprocTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            TableSave_Accessor target = new TableSave_Accessor(param0); // TODO: Initialize to an appropriate value
            string actual;
            actual = target.DeleteSproc;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for TableSave Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void TableSaveConstructorTest()
        {
            string tableName = string.Empty; // TODO: Initialize to an appropriate value
            string insertSproc = string.Empty; // TODO: Initialize to an appropriate value
            string updateSproc = string.Empty; // TODO: Initialize to an appropriate value
            string deleteSproc = string.Empty; // TODO: Initialize to an appropriate value
            TableSave target = new TableSave(tableName, insertSproc, updateSproc, deleteSproc);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
