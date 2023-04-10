using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using System.Windows.Forms;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseLoggerTest and is intended
    ///to contain all BaseLoggerTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseLoggerTest
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
        ///A test for LogSqlScript
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LogSqlScriptTest1()
        {
            BaseCommand cmdSelect = null; // TODO: Initialize to an appropriate value
            BaseLogger_Accessor.LogSqlScript(cmdSelect);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogSqlScript
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LogSqlScriptTest()
        {
            DataSet dataSet = null; // TODO: Initialize to an appropriate value
            string tableName = string.Empty; // TODO: Initialize to an appropriate value
            BaseCommand baseCommand = null; // TODO: Initialize to an appropriate value
            DataRowState state = new DataRowState(); // TODO: Initialize to an appropriate value
            BaseLogger_Accessor.LogSqlScript(dataSet, tableName, baseCommand, state);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogLoadDataFromUnosException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void LogLoadDataFromUnosExceptionTest1()
        {
            Exception ex = null; // TODO: Initialize to an appropriate value
            string tableName = string.Empty; // TODO: Initialize to an appropriate value
            string columnName = string.Empty; // TODO: Initialize to an appropriate value
            BaseLogger.LogLoadDataFromUnosException(ex, tableName, columnName);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogLoadDataFromUnosException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void LogLoadDataFromUnosExceptionTest()
        {
            Exception ex = null; // TODO: Initialize to an appropriate value
            string controlId = string.Empty; // TODO: Initialize to an appropriate value
            BaseLogger.LogLoadDataFromUnosException(ex, controlId);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogInnerException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LogInnerExceptionTest()
        {
            LogEntry logEntry = null; // TODO: Initialize to an appropriate value
            Exception ex = null; // TODO: Initialize to an appropriate value
            int level = 0; // TODO: Initialize to an appropriate value
            BaseLogger_Accessor.LogInnerException(logEntry, ex, level);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogFormUnhandledException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void LogFormUnhandledExceptionTest1()
        {
            Exception ex = null; // TODO: Initialize to an appropriate value
            Control control = null; // TODO: Initialize to an appropriate value
            BaseLogger.LogFormUnhandledException(ex, control);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogFormUnhandledException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void LogFormUnhandledExceptionTest()
        {
            Exception ex = null; // TODO: Initialize to an appropriate value
            BaseLogger.LogFormUnhandledException(ex);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogControl
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LogControlTest()
        {
            LogEntry logEntry = null; // TODO: Initialize to an appropriate value
            Control control = null; // TODO: Initialize to an appropriate value
            BaseLogger_Accessor.LogControl(logEntry, control);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogBaseDaSelectException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LogBaseDaSelectExceptionTest()
        {
            Exception ex = null; // TODO: Initialize to an appropriate value
            BaseCommand command = null; // TODO: Initialize to an appropriate value
            BaseLogger_Accessor.LogBaseDaSelectException(ex, command);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogBaseDaSaveException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LogBaseDaSaveExceptionTest()
        {
            Exception ex = null; // TODO: Initialize to an appropriate value
            DataSet dataSet = null; // TODO: Initialize to an appropriate value
            string tableName = string.Empty; // TODO: Initialize to an appropriate value
            BaseCommand command = null; // TODO: Initialize to an appropriate value
            DataRowState dataRowState = new DataRowState(); // TODO: Initialize to an appropriate value
            BaseLogger_Accessor.LogBaseDaSaveException(ex, dataSet, tableName, command, dataRowState);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogBaseDaException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LogBaseDaExceptionTest()
        {
            Exception ex = null; // TODO: Initialize to an appropriate value
            string sql = string.Empty; // TODO: Initialize to an appropriate value
            string spName = string.Empty; // TODO: Initialize to an appropriate value
            BaseLogger_Accessor.LogBaseDaException(ex, sql, spName);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for LogBaseBrException
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void LogBaseBrExceptionTest()
        {
            Exception ex = null; // TODO: Initialize to an appropriate value
            DataSet dataSet = null; // TODO: Initialize to an appropriate value
            BaseLogger_Accessor.LogBaseBrException(ex, dataSet);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for Log
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void LogTest()
        {
            string message = string.Empty; // TODO: Initialize to an appropriate value
            string str = string.Empty; // TODO: Initialize to an appropriate value
            BaseLogger.Log(message, str);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for EmailClientServices
        ///</summary>
        [TestMethod()]	
        
        public void EmailClientServicesTest()
        {
            string message = "My Message\n Bob Bromlin changed Organization x"; // TODO: Initialize to an appropriate value
           
            //LoggingCategories loggingCategory = new LoggingCategories(); // TODO: Initialize to an appropriate value
            
            BaseLogger.EmailClientServices(message, LoggingCategories.ClientServicesNotification);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BaseLogger Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BaseLoggerConstructorTest()
        {
            BaseLogger_Accessor target = new BaseLogger_Accessor();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
