using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data.Common;
using System.Data;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseDatabaseTest and is intended
    ///to contain all BaseDatabaseTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseDatabaseTest
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
        ///A test for UpdateDataSet
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void UpdateDataSetTest()
        {
            BaseDatabase_Accessor target = new BaseDatabase_Accessor(); // TODO: Initialize to an appropriate value
            DataSet dataSet = null; // TODO: Initialize to an appropriate value
            string tableName = string.Empty; // TODO: Initialize to an appropriate value
            BaseCommand insertCommand = null; // TODO: Initialize to an appropriate value
            BaseCommand updateCommand = null; // TODO: Initialize to an appropriate value
            BaseCommand deleteCommand = null; // TODO: Initialize to an appropriate value
            DbTransaction transaction = null; // TODO: Initialize to an appropriate value
            target.UpdateDataSet(dataSet, tableName, insertCommand, updateCommand, deleteCommand, transaction);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LoadDataSet
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LoadDataSetTest()
        {
            BaseDatabase_Accessor target = new BaseDatabase_Accessor(); // TODO: Initialize to an appropriate value
            BaseCommand thiscommand = null; // TODO: Initialize to an appropriate value
            DataSet dataSet = null; // TODO: Initialize to an appropriate value
            string[] tableName = null; // TODO: Initialize to an appropriate value
            target.LoadDataSet(thiscommand, dataSet, tableName);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for GetStoredProcCommandWrapper
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void GetStoredProcCommandWrapperTest()
        {
            BaseDatabase_Accessor target = new BaseDatabase_Accessor(); // TODO: Initialize to an appropriate value
            string storedProcedureName = string.Empty; // TODO: Initialize to an appropriate value
            BaseCommand expected = null; // TODO: Initialize to an appropriate value
            BaseCommand actual;
            actual = target.GetStoredProcCommandWrapper(storedProcedureName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ExecuteNonQuery
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void ExecuteNonQueryTest()
        {
            BaseDatabase_Accessor target = new BaseDatabase_Accessor(); // TODO: Initialize to an appropriate value
            BaseCommand baseCommand = null; // TODO: Initialize to an appropriate value
            target.ExecuteNonQuery(baseCommand);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for CommitTransaction
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void CommitTransactionTest()
        {
            IDbTransaction txn = null; // TODO: Initialize to an appropriate value
            BaseDatabase_Accessor.CommitTransaction(txn);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BeginTransaction
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BeginTransactionTest()
        {
            BaseDatabase_Accessor target = new BaseDatabase_Accessor(); // TODO: Initialize to an appropriate value
            DbTransaction expected = null; // TODO: Initialize to an appropriate value
            DbTransaction actual;
            actual = target.BeginTransaction();
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for BaseDatabase Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BaseDatabaseConstructorTest()
        {
            BaseDatabase_Accessor target = new BaseDatabase_Accessor();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
