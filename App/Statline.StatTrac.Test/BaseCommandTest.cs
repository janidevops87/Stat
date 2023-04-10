using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Data;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseCommandTest and is intended
    ///to contain all BaseCommandTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseCommandTest
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
        ///A test for SetParameterToOutput
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void SetParameterToOutputTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseCommand_Accessor target = new BaseCommand_Accessor(param0); // TODO: Initialize to an appropriate value
            string columnName = string.Empty; // TODO: Initialize to an appropriate value
            target.SetParameterToOutput(columnName);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for AddInParameterForSelect
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void AddInParameterForSelectTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseCommand_Accessor target = new BaseCommand_Accessor(param0); // TODO: Initialize to an appropriate value
            string columnName = string.Empty; // TODO: Initialize to an appropriate value
            DbType dbType = new DbType(); // TODO: Initialize to an appropriate value
            object value = null; // TODO: Initialize to an appropriate value
            target.AddInParameterForSelect(columnName, dbType, value);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for AddInParameterForSave
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void AddInParameterForSaveTest()
        {
            PrivateObject param0 = null; // TODO: Initialize to an appropriate value
            BaseCommand_Accessor target = new BaseCommand_Accessor(param0); // TODO: Initialize to an appropriate value
            string columnName = string.Empty; // TODO: Initialize to an appropriate value
            DbType dbType = new DbType(); // TODO: Initialize to an appropriate value
            DataRowVersion dataRowVersion = new DataRowVersion(); // TODO: Initialize to an appropriate value
            target.AddInParameterForSave(columnName, dbType, dataRowVersion);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BaseCommand Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BaseCommandConstructorTest()
        {
            Database database = null; // TODO: Initialize to an appropriate value
            DbCommand CommandWrapper = null; // TODO: Initialize to an appropriate value
            BaseCommand_Accessor target = new BaseCommand_Accessor(database, CommandWrapper);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
