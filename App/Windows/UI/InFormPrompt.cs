using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.CSharpUIMap;
using Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Windows.UI
{
    public partial class InFormPrompt : Statline.Stattrac.Windows.UI.BaseForm
    {
        #region Private Fields
        private AppScreenDS dataSet;
        private AppScreenBR br;
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        private UserControl selectedUserControl;
        private AppScreenType selectedType;
        private SecurityHelper securityHelper;
        private static InFormPrompt inFormPrompt;
        #endregion

        #region Constructor
        protected InFormPrompt()
        {
            InitializeComponent();
            br = new AppScreenBR();
            dataSet = (AppScreenDS)br.SelectDataSet();
            InitializeSecurityHelper();
        }
        public static InFormPrompt CreateInstance() 
        {
            if (inFormPrompt == null)
                inFormPrompt = new InFormPrompt();

            return inFormPrompt;

        }
        #endregion
        public override void LoadSubControl(AppScreenType groupType, AppScreenType screenTypes)
        {
            DisplayPanel(((int)groupType).ToString(generalConstant.StattracCulture),
                ((int)screenTypes).ToString(generalConstant.StattracCulture));
            BringToFront();
        }
        /// <summary>
        /// Display the control based on the event
        /// </summary>
        /// <param name="groupKey"></param>
        /// <param name="itemKey"></param>
        private void DisplayPanel(string groupKey, string itemKey)
        {

            // Only change the panel if the item key exists
            if (itemKey != null)
            {
                // Create the control based on the itemKey
                selectedType = (AppScreenType)int.Parse(itemKey, generalConstant.StattracCulture);
                CreateControlInstance(selectedType);
                AutoSize = false;
                Width = selectedUserControl.Width;
                Height = selectedUserControl.Height;
                // Remove previous controls and add a new control
                pnlBody.Controls.Clear();
                if (selectedUserControl != null)
                {
                    pnlBody.Controls.Add(selectedUserControl);
                }
                
            }
        }
        /// <summary>
        /// Gets the usercontrol that is associated with the AppScreenType
        /// </summary>
        /// <param name="selectedType"></param>
        /// <returns></returns>
        private void CreateControlInstance(AppScreenType selectedType)
        {
            InitializeSecurityHelper();

            //this code is causing the timer datasets to blow up jth 10/20/10...don't know if we need it
            if (selectedUserControl != null)
            {
                //After disposing the object we want to call the garbage collection 
                //explicitly to clear up the resources
                selectedUserControl.Dispose();
                //GC.Collect();
                //GC.WaitForPendingFinalizers();
            }

            switch (selectedType)
            {
                //case AppScreenType.DashboardReferrals:
                //    selectedUserControl = new DashboardControl();
                //    break;
                //case AppScreenType.DashboardMessagesImports:
                //    selectedUserControl = new DashboardControl();
                //    break;
                //case AppScreenType.DashboardRecycledCases:
                //    if (securityHelper.Authorized(SecurityRule.Recycled_Cases.ToString()))
                //    {
                //        selectedUserControl = new DashboardControl();
                //    }
                //    break;
                //case AppScreenType.DashboardNoCalls:
                //    selectedUserControl = new DashboardControl();
                //    break;
                //case AppScreenType.DashboardFamilyServiceView:
                //    if (securityHelper.Authorized(SecurityRule.Family_Services.ToString()))
                //    {
                //        selectedUserControl = new DashboardControl();
                //    }
                //    break;
                //case AppScreenType.DashboardFSActiveCases:
                //    if (securityHelper.Authorized(SecurityRule.FS_Active_Cases.ToString()))
                //    {
                //        selectedUserControl = new DashboardControl();
                //    }
                //    break;
                //case AppScreenType.DashboardTCSSActiveCases:
                //    if (securityHelper.Authorized(SecurityRule.OASIS.ToString()))
                //    {
                //        selectedUserControl = new DashboardControl();
                //    }
                //    break;
                //case AppScreenType.DashboardUpdates:
                //    if (securityHelper.Authorized(SecurityRule.Update.ToString()))
                //    {
                //        selectedUserControl = new DashboardControl();
                //    }
                //    break;
                //case AppScreenType.NewCallFamilyServices:
                //    selectedUserControl = new FamilyServicesManager();
                //    break;
                //case AppScreenType.Organizations:
                //case AppScreenType.OrganizationsOrganizationSearch:
                //    selectedUserControl = new OrganizationSearchControl();
                //    break;
                //case AppScreenType.AdministrationSourceCode:
                //    if (securityHelper.Authorized(SecurityRule.Administration_Access.ToString()))
                //    {
                //        selectedUserControl = new SourceCodeEditManager();
                //    }
                //    else
                //    {
                //        selectedUserControl = new UserControl();
                //    }
                //    break;
                case AppScreenType.Tcss:
                    selectedUserControl = TcssManager.CreateInstance();
                    break;
                case AppScreenType.ReportIssueFeedbackup:
                    selectedUserControl = OpenStatTracCSharpForms.CreateInstance().Create(AppScreenType.ReportIssueFeedbackup);
                    break;
                //case AppScreenType.OrganizationsOrganizationDelete:
                //    selectedUserControl = new OrganizationDeleteControl();
                //    break;
                default:
                    selectedUserControl = new UserControl();
                    break;
            }

            selectedUserControl.Dock = System.Windows.Forms.DockStyle.Fill;

        }
        /// <summary>
        /// Check the local instance of securityHelper and gets the singleton version if null
        /// </summary>
        private void InitializeSecurityHelper()
        {
            if (securityHelper == null)
                securityHelper = SecurityHelper.GetInstance();
        }
    }
}
