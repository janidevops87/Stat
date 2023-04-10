using System.Windows.Forms;
using System;
using Statline.Stattrac.Windows.UI.Controls.Dashboard;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.Enum;

namespace Statline.Stattrac.Windows.UI.Controls
{
	public partial class DashboardControl : BaseUserControl 
	{
        private UserControl dashBoardMainControl;        
        private MessageandImportControl messageandImportControl;
        private FamilyServiceViewControl familyServiceViewControl;
        private FamilyServiceActiveCaseControl familyServiceActiveCaseControl;
        private TcssActiveCasesControl tcssActiveCasesControl;
        private UpdateControl updateControl;
        private RecycledCasesControl recycledCasesControl;
        private NoCallsControl noCallsControl;
        private ReferralsControl referralsControl;
        
		public DashboardControl()
		{   
            Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();
			InitializeComponent();
            messageandImportControl = new MessageandImportControl();
            updateControl = new UpdateControl();
            recycledCasesControl = new RecycledCasesControl();
            noCallsControl= new NoCallsControl();
            familyServiceActiveCaseControl = new FamilyServiceActiveCaseControl();
            tcssActiveCasesControl = new TcssActiveCasesControl();
            familyServiceViewControl = new FamilyServiceViewControl();
            referralsControl = new ReferralsControl();

            tcDashboard.AddTabItem(AppScreenType.DashboardReferrals, "Referrals (F1)", referralsControl);
            tcDashboard.AddTabItem(AppScreenType.DashboardMessagesImports, "Msgs & Imports (F2)", messageandImportControl);
            if (securityHelper.Authorized(SecurityRule.Family_Services.ToString()))
                tcDashboard.AddTabItem(AppScreenType.DashboardFamilyServiceView, "Family Services (F4)", familyServiceViewControl);
            if (securityHelper.Authorized(SecurityRule.FS_Active_Cases.ToString()))
                tcDashboard.AddTabItem(AppScreenType.DashboardFSActiveCases, "FS Active Cases (F5)", familyServiceActiveCaseControl);
            if (securityHelper.Authorized(SecurityRule.OASIS.ToString()))
                tcDashboard.AddTabItem(AppScreenType.DashboardTCSSActiveCases, "OASIS Active Cases (F6)", tcssActiveCasesControl);
            if (securityHelper.Authorized(SecurityRule.ST_Update.ToString()))
                tcDashboard.AddTabItem(AppScreenType.DashboardUpdates, "Updates (F7)", updateControl);
            if (securityHelper.Authorized(SecurityRule.Recycled_Cases.ToString()))
                tcDashboard.AddTabItem(AppScreenType.DashboardRecycledCases, "Recycled Cases (F8)", recycledCasesControl);
            tcDashboard.AddTabItem(AppScreenType.DashboardNoCalls, "No Calls (F9)", noCallsControl);
            dashBoardMainControl = new MainControl();
            dashBoardMainControl.Dock = System.Windows.Forms.DockStyle.Top;
            this.Controls.Add(dashBoardMainControl);
		}

		public void SetSelectedTabItem(string key)
		{
			if (!string.IsNullOrEmpty(key) && tcDashboard.Tabs.Exists(key))
			{
                tcDashboard.Tabs[key].Selected = true;
			}
		}

        private void tcDashboard_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
            dashBoardMainControl.Visible = true;
            string selectedTab = tcDashboard.SelectedTab.Text;
            GRConstant.SelectedTab = tcDashboard.SelectedTab.Text;
            switch (selectedTab)
            {
                case "Referrals (F1)":
                    //((BaseForm)FindForm()).LoadSubControl(AppScreenType.Dashboard, AppScreenType.DashboardReferrals);
                    GRConstant.SelectedTab = "Referrals (F1)";
                    break;
                case "Msgs & Imports (F2)":
                    //if (messageandImportControl == null)
                        //messageandImportControl = new MessageandImportControl();
                    messageandImportControl.Reload();
                    //((BaseForm)FindForm()).LoadSubControl(AppScreenType.Dashboard, AppScreenType.DashboardMessagesImports);
                    break;
                case "Family Services (F4)":
                    //((BaseForm)FindForm()).LoadSubControl(AppScreenType.Dashboard, AppScreenType.DashboardFamilyServiceView);
                    familyServiceViewControl.BindDataToUI();
                    dashBoardMainControl.Visible = false;
                    break;
                case "FS Active Cases (F5)":
                    //((BaseForm)FindForm()).LoadSubControl(AppScreenType.Dashboard, AppScreenType.DashboardFSActiveCases);
                    dashBoardMainControl.Visible = false;
                    familyServiceActiveCaseControl.Reload();
                    break;
                case "OASIS Active Cases (F6)":
                    //((BaseForm)FindForm()).LoadSubControl(AppScreenType.Dashboard, AppScreenType.DashboardTCSSActiveCases);
                    dashBoardMainControl.Visible = false;
                    tcssActiveCasesControl.ReloadGridEnter();
                    break;
                case "Updates (F7)":
                    updateControl.Reload();
                    break;
                case "Recycled Cases (F8)":
                    recycledCasesControl.Reload();
                    break;
                case "No Calls (F9)":
                    noCallsControl.Reload();
                    break;
            }

            //if (tcDashboard.SelectedTab.Text == "FS Active Cases (F5)" || tcDashboard.SelectedTab.Text == "OASIS Active Cases (F6)" || tcDashboard.SelectedTab.Text == "Family Services (F4)")
            //{
            //    dashBoardMainControl.Visible = false;
            //}
            //else
            //{
            //    dashBoardMainControl.Visible = true;
            //}
            
            
        }
	}
}
