using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data;
using System.Data.Common;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseBRTest and is intended
    ///to contain all BaseBRTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseBRTest
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
        ///A test for BRConstant
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BRConstantTest()
        {
            BusinessRulesConstant actual;
            actual = BaseBR_Accessor.BRConstant;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for AssociatedDataSet
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void AssociatedDataSetTest()
        {
            BaseBR target = new BaseBR(); // TODO: Initialize to an appropriate value
            DataSet expected = null; // TODO: Initialize to an appropriate value
            DataSet actual;
            target.AssociatedDataSet = expected;
            actual = target.AssociatedDataSet;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for AssociatedDA
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void AssociatedDATest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            BaseDA expected = null; // TODO: Initialize to an appropriate value
            BaseDA actual;
            target.AssociatedDA = expected;
            actual = target.AssociatedDA;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for SelectDataSet
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void SelectDataSetTest1()
        {
            BaseBR target = new BaseBR(); // TODO: Initialize to an appropriate value
            DataSet expected = null; // TODO: Initialize to an appropriate value
            DataSet actual;
            actual = target.SelectDataSet();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for SelectDataSet
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void SelectDataSetTest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            bool clearDataSet = false; // TODO: Initialize to an appropriate value
            DataSet expected = null; // TODO: Initialize to an appropriate value
            DataSet actual;
            actual = target.SelectDataSet(clearDataSet);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for Select
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void SelectTest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            DataSet expected = null; // TODO: Initialize to an appropriate value
            DataSet actual;
            actual = target.Select();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for SaveDataSet
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void SaveDataSetTest()
        {
            BaseBR target = new BaseBR(); // TODO: Initialize to an appropriate value
            target.SaveDataSet();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for Save
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void SaveTest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            DataSet saveDataSet = null; // TODO: Initialize to an appropriate value
            DbTransaction transaction = null; // TODO: Initialize to an appropriate value
            target.Save(saveDataSet, transaction);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for ExecuteNonQuery
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void ExecuteNonQueryTest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            target.ExecuteNonQuery();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BusinessRulesBeforeSelect
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BusinessRulesBeforeSelectTest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            target.BusinessRulesBeforeSelect();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BusinessRulesBeforeSave
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BusinessRulesBeforeSaveTest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            target.BusinessRulesBeforeSave();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BusinessRulesAfterSelect
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BusinessRulesAfterSelectTest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            target.BusinessRulesAfterSelect();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BusinessRulesAfterSave
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BusinessRulesAfterSaveTest()
        {
            BaseBR_Accessor target = new BaseBR_Accessor(); // TODO: Initialize to an appropriate value
            target.BusinessRulesAfterSave();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BaseBR Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void BaseBRConstructorTest()
        {
            BaseBR target = new BaseBR();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
