using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Runtime.Serialization;

namespace Statline.StattTrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseExceptionTest and is intended
    ///to contain all BaseExceptionTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseExceptionTest
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
        ///A test for IsExceptionAlreadyLogged
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void IsExceptionAlreadyLoggedTest()
        {
            BaseException target = new BaseException(); // TODO: Initialize to an appropriate value
            bool actual;
            actual = target.IsExceptionAlreadyLogged;
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetObjectData
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetObjectDataTest()
        {
            BaseException target = new BaseException(); // TODO: Initialize to an appropriate value
            SerializationInfo info = null; // TODO: Initialize to an appropriate value
            StreamingContext context = new StreamingContext(); // TODO: Initialize to an appropriate value
            target.GetObjectData(info, context);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for BaseException Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void BaseExceptionConstructorTest4()
        {
            BaseException target = new BaseException();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        /// <summary>
        ///A test for BaseException Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void BaseExceptionConstructorTest3()
        {
            string message = string.Empty; // TODO: Initialize to an appropriate value
            bool isExceptionAlreadyLogged = false; // TODO: Initialize to an appropriate value
            BaseException target = new BaseException(message, isExceptionAlreadyLogged);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        /// <summary>
        ///A test for BaseException Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void BaseExceptionConstructorTest2()
        {
            string message = string.Empty; // TODO: Initialize to an appropriate value
            BaseException target = new BaseException(message);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        /// <summary>
        ///A test for BaseException Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BaseExceptionConstructorTest1()
        {
            SerializationInfo info = null; // TODO: Initialize to an appropriate value
            StreamingContext context = new StreamingContext(); // TODO: Initialize to an appropriate value
            BaseException_Accessor target = new BaseException_Accessor(info, context);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }

        /// <summary>
        ///A test for BaseException Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void BaseExceptionConstructorTest()
        {
            string message = string.Empty; // TODO: Initialize to an appropriate value
            Exception innerException = null; // TODO: Initialize to an appropriate value
            BaseException target = new BaseException(message, innerException);
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
