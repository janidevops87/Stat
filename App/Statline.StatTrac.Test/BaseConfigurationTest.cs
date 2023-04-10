using Statline.Stattrac.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for BaseConfigurationTest and is intended
    ///to contain all BaseConfigurationTest Unit Tests
    ///</summary>
    [TestClass()]
    public class BaseConfigurationTest
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
        ///A test for SetKey
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void SetKeyTest1()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            string settingKey = string.Empty; // TODO: Initialize to an appropriate value
            BaseConfiguration.SetKey(settingName, settingKey);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for SetKey
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void SetKeyTest()
        {
            Enum settingName = null; // TODO: Initialize to an appropriate value
            string settingKey = string.Empty; // TODO: Initialize to an appropriate value
            BaseConfiguration.SetKey(settingName, settingKey);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for GetSettingShort
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingShortTest1()
        {
            Enum settingName = null; // TODO: Initialize to an appropriate value
            short expected = 0; // TODO: Initialize to an appropriate value
            short actual;
            actual = BaseConfiguration.GetSettingShort(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingShort
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingShortTest()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            short expected = 0; // TODO: Initialize to an appropriate value
            short actual;
            actual = BaseConfiguration.GetSettingShort(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingRaw
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingRawTest()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = BaseConfiguration.GetSettingRaw(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingLong
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingLongTest1()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            long expected = 0; // TODO: Initialize to an appropriate value
            long actual;
            actual = BaseConfiguration.GetSettingLong(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingLong
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingLongTest()
        {
            Enum settingName = null; // TODO: Initialize to an appropriate value
            long expected = 0; // TODO: Initialize to an appropriate value
            long actual;
            actual = BaseConfiguration.GetSettingLong(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingKey
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void GetSettingKeyTest()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = BaseConfiguration_Accessor.GetSettingKey(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingInt
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingIntTest1()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            int expected = 0; // TODO: Initialize to an appropriate value
            int actual;
            actual = BaseConfiguration.GetSettingInt(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingInt
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingIntTest()
        {
            Enum settingName = null; // TODO: Initialize to an appropriate value
            int expected = 0; // TODO: Initialize to an appropriate value
            int actual;
            actual = BaseConfiguration.GetSettingInt(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingByte
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingByteTest1()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            byte expected = 0; // TODO: Initialize to an appropriate value
            byte actual;
            actual = BaseConfiguration.GetSettingByte(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingByte
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingByteTest()
        {
            Enum settingName = null; // TODO: Initialize to an appropriate value
            byte expected = 0; // TODO: Initialize to an appropriate value
            byte actual;
            actual = BaseConfiguration.GetSettingByte(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingBool
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingBoolTest1()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = BaseConfiguration.GetSettingBool(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSettingBool
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingBoolTest()
        {
            Enum settingName = null; // TODO: Initialize to an appropriate value
            bool expected = false; // TODO: Initialize to an appropriate value
            bool actual;
            actual = BaseConfiguration.GetSettingBool(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSetting
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingTest2()
        {
            string settingName = string.Empty; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = BaseConfiguration.GetSetting(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSetting
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingTest1()
        {
            Enum settingName = null; // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = BaseConfiguration.GetSetting(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for GetSetting
        ///</summary>
        [TestMethod()]
	[Ignore()]
        public void GetSettingTest()
        {
            SettingName settingName = new SettingName(); // TODO: Initialize to an appropriate value
            string expected = string.Empty; // TODO: Initialize to an appropriate value
            string actual;
            actual = BaseConfiguration.GetSetting(settingName);
            Assert.AreEqual(expected, actual);
            Assert.Inconclusive("Verify the correctness of this test method.");
        }

        /// <summary>
        ///A test for BaseConfiguration Constructor
        ///</summary>
        [TestMethod()]
	[Ignore()]
        [DeploymentItem("Statline.Stattrac.Framework.dll")]
        public void BaseConfigurationConstructorTest()
        {
            BaseConfiguration_Accessor target = new BaseConfiguration_Accessor();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
