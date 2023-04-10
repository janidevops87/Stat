using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Data;
using System.Data.Common;
using System;
using System.Collections.ObjectModel;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseDATest and is intended
    ///to contain all BaseDATest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseDATest
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
        ///A test for SpSelect
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void SpSelectTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            target.SpSelect = expected;
            actual = target.SpSelect;
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for ListTableSave
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void ListTableSaveTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            Collection<TableSave> actual;
            actual = target.ListTableSave;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for SetTablesSelect
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void SetTablesSelectTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            string[] tablesToSelect = null; // TODO: Initialize to an appropriate value
            target.SetTablesSelect(tablesToSelect);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for SetParameterToOutput
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void SetParameterToOutputTest()
        {
            BaseCommand command = null; // TODO: Initialize to an appropriate value
            string parameterName = string.Empty; // TODO: Initialize to an appropriate value
            BaseDA_Accessor.SetParameterToOutput(command, parameterName);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for SetDateTimeToUtc
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void SetDateTimeToUtcTest()
        {
            DataTable dataTable = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor.SetDateTimeToUtc(dataTable);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for SetDateTimeToLocal
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void SetDateTimeToLocalTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            DataSet dataSet = null; // TODO: Initialize to an appropriate value
            target.SetDateTimeToLocal(dataSet);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for Select
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void SelectTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            DataSet dataSet = null; // TODO: Initialize to an appropriate value
            target.Select(dataSet);
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
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            DataSet dataSet = null; // TODO: Initialize to an appropriate value
            DbTransaction transaction = null; // TODO: Initialize to an appropriate value
            target.Save(dataSet, transaction);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for HandleSaveException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void HandleSaveExceptionTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            TableSave tableSave = null; // TODO: Initialize to an appropriate value
            Exception ex = null; // TODO: Initialize to an appropriate value
            target.HandleSaveException(tableSave, ex);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for GetParameterValuesPostExecuteNonQuery
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void GetParameterValuesPostExecuteNonQueryTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            DbParameterCollection dbParameters = null; // TODO: Initialize to an appropriate value
            target.GetParameterValuesPostExecuteNonQuery(dbParameters);
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
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            target.ExecuteNonQuery();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for AddParameterForUpdate
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void AddParameterForUpdateTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            DataTable table = null; // TODO: Initialize to an appropriate value
            BaseCommand commandWrapper = null; // TODO: Initialize to an appropriate value
            target.AddParameterForUpdate(table, commandWrapper);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for AddParameterForSelectDataSet
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void AddParameterForSelectDataSetTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            BaseCommand commandWrapper = null; // TODO: Initialize to an appropriate value
            target.AddParameterForSelectDataSet(commandWrapper);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for AddParameterForSave
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void AddParameterForSaveTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            DataTable table = null; // TODO: Initialize to an appropriate value
            BaseCommand commandWrapper = null; // TODO: Initialize to an appropriate value
            target.AddParameterForSave(table, commandWrapper);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for AddParameterForInsert
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void AddParameterForInsertTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            DataTable table = null; // TODO: Initialize to an appropriate value
            BaseCommand commandWrapper = null; // TODO: Initialize to an appropriate value
            target.AddParameterForInsert(table, commandWrapper);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for AddParameterForDelete
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void AddParameterForDeleteTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(param0); // TODO: Initialize to an appropriate value
            DataTable table = null; // TODO: Initialize to an appropriate value
            BaseCommand commandWrapper = null; // TODO: Initialize to an appropriate value
            target.AddParameterForDelete(table, commandWrapper);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BaseDA Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BaseDAConstructorTest()
        {
            string selectSprocName = string.Empty; // TODO: Initialize to an appropriate value
            BaseDA_Accessor target = new BaseDA_Accessor(selectSprocName);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
