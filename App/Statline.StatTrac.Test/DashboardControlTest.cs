using Statline.Stattrac.Windows.UI.Controls;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Infragistics.Win.UltraWinTabControl;

namespace Statline.Stattrac.Test
{
    
    
    /// <summary>
    ///This is a test class for DashboardControlTest and is intended
    ///to contain all DashboardControlTest Unit Tests
    ///</summary>
    [TestClass()]
    public class DashboardControlTest
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
        ///A test for tcDashboard_SelectedTabChanged
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Statline.Stattrac.Windows.UI.exe")]
        public void tcDashboard_SelectedTabChangedTest()
        {
            DashboardControl_Accessor target = new DashboardControl_Accessor(); // TODO: Initialize to an appropriate value
            
            object sender = null; // TODO: Initialize to an appropriate value
            SelectedTabChangedEventArgs e = null; // TODO: Initialize to an appropriate value
            target.tcDashboard_SelectedTabChanged(sender, e);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
            
        }

        /// <summary>
        ///A test for SetSelectedTabItem
        ///</summary>
        [TestMethod()]
        public void SetSelectedTabItemTest()
        {
            DashboardControl target = new DashboardControl(); // TODO: Initialize to an appropriate value
            string key = string.Empty; // TODO: Initialize to an appropriate value
            target.SetSelectedTabItem(key);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for InitializeComponent
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Statline.Stattrac.Windows.UI.exe")]
        public void InitializeComponentTest()
        {
            DashboardControl_Accessor target = new DashboardControl_Accessor(); // TODO: Initialize to an appropriate value
            target.InitializeComponent();
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for Dispose
        ///</summary>
        [TestMethod()]
        [DeploymentItem("Statline.Stattrac.Windows.UI.exe")]
        public void DisposeTest()
        {
            DashboardControl_Accessor target = new DashboardControl_Accessor(); // TODO: Initialize to an appropriate value
            bool disposing = false; // TODO: Initialize to an appropriate value
            target.Dispose(disposing);
            Assert.Inconclusive("A method that does not return a value cannot be verified.");
        }

        /// <summary>
        ///A test for DashboardControl Constructor
        ///</summary>
        [TestMethod()]
        public void DashboardControlConstructorTest()
        {
            DashboardControl target = new DashboardControl();
            Assert.Inconclusive("TODO: Implement code to verify target");
        }
    }
}
