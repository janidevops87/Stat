using System;
using System.Diagnostics;
using System.Globalization;
using System.Windows.Forms;
using Infragistics.Win.UltraWinExplorerBar;
using Infragistics.Win.UltraWinTabControl;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.CSharpUIMap;
using Statline.Stattrac.Windows.UI.Controls;
using Statline.Stattrac.Windows.UI.Controls.Dashboard;
using Statline.Stattrac.Windows.UI.Controls.NewCall.FamilyServices;
using Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss;
using Statline.Stattrac.Windows.UI.Header;
using Statline.Stattrac.Data.Types.Framework;



namespace Statline.Stattrac.Windows.UI
{
	public partial class SecureForm : Statline.Stattrac.Windows.UI.BaseForm
	{
        #region Private Fields
        private AppScreenDS dataSet;
		private AppScreenBR br;
        private CommitClientChangesBR br1;
		private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
		private UserControl selectedUserControl;
        private AppScreenType selectedType;
        private SecurityHelper securityHelper;
        private DashboardControl dasboardControl;
        private BaseManagerControl baseManagerControl;
		#endregion

		#region Constructor
		public SecureForm()
		{
			InitializeComponent();
            this.WindowState = FormWindowState.Maximized;
			br = new AppScreenBR();
            dataSet = (AppScreenDS)br.SelectDataSet();
            this.Text = "StatTrac:  " + StattracIdentity.Identity.UserName;
			BindHeaderControl(null, null);
            securityHelper = Security.SecurityHelper.GetInstance();
			BindDataToNavigationControl();
            ultraDockManager.DockAreas[0].Unpin();
            //open with dashboard referrals...2/10 are the hardcoded parms
            DisplayPanel("2", "10");
            baseManagerControl = new BaseManagerControl();
            GeneralConstant.CreateInstance().IsPerformanceCounterCounterAvailable = DetermineIsPerformanceCounterCounterAvailable();
        }
		#endregion

		#region Private Methods
		/// <summary>
		/// Bind the header control
		/// </summary>
		private void BindHeaderControl(string groupKey, string itemKey)
		{
			if (groupKey == "3" && itemKey == "22")
			{
				//this was changed to handle reloading TcssHeader with a new Dataset
				// by passing in a BR
				//pnlMainHeader.Controls.Add(new TcssHeader());
			}
			else
			{
				for (int index = 0; index < pnlMainHeader.Controls.Count; index++)
				{
					pnlMainHeader.Controls[index].Dispose();
				}
                LoadHeaderControl(new MainHeader());
			}
		}

        private bool DetermineIsPerformanceCounterCounterAvailable()
        {
            //Check for availiability of performance counters
            string performanceCategory = "Memory";
            string performanceCounter = "Available MBytes";
            bool isPerformanceCounterCategoryAvailable = PerformanceCounterCategory.Exists(performanceCategory);
            bool isPerformanceCounterCounterAvailable = isPerformanceCounterCategoryAvailable && PerformanceCounterCategory.CounterExists(performanceCounter, performanceCategory);

            return isPerformanceCounterCounterAvailable;
        }

        /// <summary>
        /// Bind the controls to the navigation pane
        /// </summary>
        private void BindDataToNavigationControl()
        {            
            InitializeSecurityHelper();
			AppScreenDS.AppScreenRow[] dataRowParentList = (AppScreenDS.AppScreenRow[])dataSet.AppScreen.Select("ParentId=1", "SortOrder");
			for (int parentIndex = 0; parentIndex < dataRowParentList.Length; parentIndex++)
			{
				string thisId = dataRowParentList[parentIndex].AppScreenId.ToString(generalConstant.StattracCulture);
				UltraExplorerBarGroup group = uebMainNavigation.AddGroup(thisId, dataRowParentList[parentIndex].ScreenName);
				AppScreenDS.AppScreenRow[] dataRowChildList = (AppScreenDS.AppScreenRow[])dataSet.AppScreen.Select("ParentId=" + thisId, "SortOrder");
				for (int childIndex = 0; childIndex < dataRowChildList.Length; childIndex++)
				{
                    if (dataRowParentList[parentIndex].ScreenName == "Dashboard")
                    {
                        if (dataRowChildList[childIndex].ScreenName == "Referrals (F1)" || dataRowChildList[childIndex].ScreenName == "Msgs & Imports (F2)" || dataRowChildList[childIndex].ScreenName == "No Calls (F9)")
                        {//always add referrals, msgs/imports and no calls
                            Statline.Stattrac.Windows.Forms.UltraExplorerBar.AddItem(group,
                                  dataRowChildList[childIndex].AppScreenId.ToString(generalConstant.StattracCulture), dataRowChildList[childIndex].ScreenName);
                        }
                        else
                        {//these libraries need permissions
                            if (
                                (dataRowChildList[childIndex].ScreenName == "Family Services (F4)" && securityHelper.Authorized(SecurityRule.Family_Services.ToString())) ||
                                (dataRowChildList[childIndex].ScreenName == "FS Active Cases (F5)" && securityHelper.Authorized(SecurityRule.FS_Active_Cases.ToString())) ||
                                (dataRowChildList[childIndex].ScreenName == "OASIS Active Cases (F6)" && securityHelper.Authorized(SecurityRule.OASIS.ToString())) ||
                                (dataRowChildList[childIndex].ScreenName == "Updates (F7)" && securityHelper.Authorized(SecurityRule.ST_Update.ToString())) ||
                                (dataRowChildList[childIndex].ScreenName == "Recycled Cases (F8)" && securityHelper.Authorized(SecurityRule.Recycled_Cases.ToString())))
                            {
                                Statline.Stattrac.Windows.Forms.UltraExplorerBar.AddItem(group,
                                  dataRowChildList[childIndex].AppScreenId.ToString(generalConstant.StattracCulture), dataRowChildList[childIndex].ScreenName);
                            }
                        }
                    }
                    else
                    {//do anything not dashboard here
                        if (dataRowParentList[parentIndex].ScreenName == "Administration")
                        {
                            if (securityHelper.Authorized(SecurityRule.Administration_Access.ToString()))
                            {
                                if (dataRowChildList[childIndex].ScreenName != "Rule Out Indications" && dataRowChildList[childIndex].ScreenName != "View ASP Calls")
                                {
                                    Statline.Stattrac.Windows.Forms.UltraExplorerBar.AddItem(group,
                                        dataRowChildList[childIndex].AppScreenId.ToString(generalConstant.StattracCulture), dataRowChildList[childIndex].ScreenName);
                                }
                                else
                                {
                                    if (dataRowChildList[childIndex].ScreenName == "Rule Out Indications" && securityHelper.Authorized(SecurityRule.Rule_Out_Indications.ToString()))
                                    {
                                        Statline.Stattrac.Windows.Forms.UltraExplorerBar.AddItem(group,
                                                dataRowChildList[childIndex].AppScreenId.ToString(generalConstant.StattracCulture), dataRowChildList[childIndex].ScreenName);
                                    }
                                    if (dataRowChildList[childIndex].ScreenName == "View ASP Calls" && securityHelper.Authorized(SecurityRule.View_ASP_Organizations.ToString()))
                                    {
                                        Statline.Stattrac.Windows.Forms.UltraExplorerBar.AddItem(group,
                                                dataRowChildList[childIndex].AppScreenId.ToString(generalConstant.StattracCulture), dataRowChildList[childIndex].ScreenName);
                                    }
                                }
                            }
                        }
                        else if (dataRowParentList[parentIndex].ScreenName == "Key Codes" && securityHelper.Authorized(SecurityRule.Administration_Access.ToString()))
                        {
                            Statline.Stattrac.Windows.Forms.UltraExplorerBar.AddItem(group,
                             dataRowChildList[childIndex].AppScreenId.ToString(generalConstant.StattracCulture), dataRowChildList[childIndex].ScreenName);
                        }
                        else if (dataRowParentList[parentIndex].ScreenName != "Key Codes" && dataRowParentList[parentIndex].ScreenName != "Administration")
                        {
                            Statline.Stattrac.Windows.Forms.UltraExplorerBar.AddItem(group,
                             dataRowChildList[childIndex].AppScreenId.ToString(generalConstant.StattracCulture), dataRowChildList[childIndex].ScreenName);
                        }
                    }
				}
			}
		}
        /// <summary>
        /// Check the local instance of securityHelper and gets the singleton version if null
        /// </summary>
        private void InitializeSecurityHelper()
        {
            if (securityHelper == null)
                securityHelper = SecurityHelper.GetInstance();
        }
        /// <summary>
        /// disposis and sets selectUserControl to null for .net case forms.
        /// call when Family Serives or Tcss or any other .net form navigate to parent and call SelectUserControl.
        /// </summary>        
        private void ResetSubControl()
        {

            if (selectedUserControl != null)
                switch (selectedUserControl.GetType().ToString())
                {
                    case "Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss.TcssManager":
                        selectedUserControl.Dispose();
                        break;
                    case "Statline.Stattrac.Windows.UI.Controls.NewCall.FamilyServices.FamilyServicesManager":
                        selectedUserControl.Dispose();
                        break;

                }

            selectedUserControl = null;
        }
        
		/// <summary>
		/// Gets the usercontrol that is associated with the AppScreenType
		/// </summary>
		/// <param name="selectedType"></param>
		/// <returns></returns>
		private void CreateControlInstance(AppScreenType selectedType)
		{
            InitializeSecurityHelper();

            if (selectedUserControl != null)
            {
                 //After disposing the object we want to call the garbage collection 
                 //explicitly to clear up the resources
                switch (selectedUserControl.GetType().ToString() )
                {
                    case "Statline.Stattrac.Windows.UI.Controls.DashboardControl":
                        break;
                    default:
                    selectedUserControl.Dispose();
                    break;
                    
                }
                //GC.Collect();
                //GC.WaitForPendingFinalizers();
            }
            
			switch (selectedType)
            {
                case AppScreenType.DashboardReferrals:
                    selectedUserControl = CreateDashBoardControl(selectedType);
                    break;
                case AppScreenType.DashboardMessagesImports:
                    selectedUserControl = CreateDashBoardControl(selectedType);
                    break;
                case AppScreenType.DashboardRecycledCases:
                    if (securityHelper.Authorized(SecurityRule.Recycled_Cases.ToString()))
                    {
                        selectedUserControl = CreateDashBoardControl(selectedType);
                    }
                    break;
                case AppScreenType.DashboardNoCalls:
                    selectedUserControl = CreateDashBoardControl(selectedType);
                    break;
                case AppScreenType.DashboardFamilyServiceView:
                    if (securityHelper.Authorized(SecurityRule.Family_Services.ToString()))
                    {
                        selectedUserControl = CreateDashBoardControl(selectedType);
                    }
                    break;
				case AppScreenType.DashboardFSActiveCases:
                    //if (securityHelper.Authorized(SecurityRule.FS_Active_Cases.ToString()))
                    //{
                    selectedUserControl = CreateDashBoardControl(selectedType);
                    //}
                    break;
				case AppScreenType.DashboardTCSSActiveCases:
                    if (securityHelper.Authorized(SecurityRule.OASIS.ToString()))
                    {
                        selectedUserControl = CreateDashBoardControl(selectedType);
                    }
                    break;
                case AppScreenType.DashboardUpdates:
                    if (securityHelper.Authorized(SecurityRule.ST_Update.ToString()))
                    {
                        selectedUserControl = CreateDashBoardControl(selectedType);
                    }
                    break;
				case AppScreenType.NewCallFamilyServices:
					selectedUserControl = new FamilyServicesManager();
					break;
				case AppScreenType.Organizations:
                case AppScreenType.OrganizationsOrganizationSearch:                                        
                    selectedUserControl = OpenStatTracCSharpForms.CreateInstance().Create(selectedType);
					break;
                case AppScreenType.AdministrationSourceCode:
                    if (securityHelper.Authorized(SecurityRule.Administration_Access.ToString()))
                    {
                        selectedUserControl = OpenStatTracCSharpForms.CreateInstance().Create(selectedType);
                    }
                    else
                    {
                        selectedUserControl = new UserControl();
                    }
                    break;
				case AppScreenType.Tcss:
					selectedUserControl = TcssManager.CreateInstance();
					break;
				case AppScreenType.OrganizationsOrganizationEdit:
					selectedUserControl = OpenStatTracCSharpForms.CreateInstance().Create(selectedType);
					break;
				case AppScreenType.OrganizationsOrganizationDelete:
                    selectedUserControl = OpenStatTracCSharpForms.CreateInstance().Create(selectedType);
                    break;
                default:
                    selectedUserControl = new UserControl();
                    break;
            }
            selectedUserControl.Dock = System.Windows.Forms.DockStyle.Fill;
        }

		/// <summary>
		/// Display the control based on the event
		/// </summary>
		/// <param name="groupKey"></param>
		/// <param name="itemKey"></param>
		private void DisplayPanel(string groupKey, string itemKey)
		{
            //do not navigate away if 
            if (selectedUserControl != null)
            switch (selectedUserControl.GetType().ToString())
            {
                case "Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss.TcssManager":
                    return;
                case "Statline.Stattrac.Windows.UI.Controls.NewCall.FamilyServices.FamilyServicesManager":
                    return;

            }


			//add code to automatically route groups to a start page
            if (itemKey == null)
                itemKey = DefaultItemKey((AppScreenType)Enum.Parse(typeof(AppScreenType), groupKey));
            // Only change the panel if the item key exists
			if (itemKey != null)
			{
				// Create the control based on the itemKey
				selectedType = (AppScreenType)int.Parse(itemKey, generalConstant.StattracCulture);
                //if a vb app is selected from nav bar call vb method, otherwise do the usual c# stuff
                if (selectedType.ToString().Contains("VB"))
                {
                    if (selectedType.ToString().Equals("VBCommitClientChanges"))
                    {
                        br1 = new CommitClientChangesBR();
                        br1.ExecuteNonQuery();
                        BaseMessageBox.ShowInformation("The job was started successfully.", "StatTrac");
                    }
                    {
                        NavigateToVBScreen(selectedType);
                    }
                }
                else
                {
                    CreateControlInstance(selectedType);
                    // Remove previous controls and add a new control
                    pnlBody.Controls.Clear();
                    if (selectedUserControl != null)
                    {
                        pnlBody.Controls.Add(selectedUserControl);
                        // If the item is a DashBoard then select the correct tab for the dashboard
                        if (selectedUserControl is DashboardControl)
                        {
                            DashboardControl dashboardControl = selectedUserControl as DashboardControl;
                            if (dashboardControl != null)
                            {
                                dashboardControl.SetSelectedTabItem(itemKey);
                            }
                        }
                        //Bind the header for the control
                        BindHeaderControl(groupKey, itemKey);
                    }
                }
			}
            
            // Set the Group item in the navigation that should be selected
            uebMainNavigation.Groups[groupKey].Selected = true;

            //04/25/2011 ccarroll - activate the user control to avoid navigation bar freeze.
            selectedUserControl.Select();
		}

        private string DefaultItemKey(AppScreenType groupKey)
        {
            string returnValue = null;
            switch (groupKey)
            { 
                case AppScreenType.Organizations:
                    returnValue = ((int)AppScreenType.OrganizationsOrganizationSearch).ToString();
                    break;
            }

            return returnValue;

        }
		#endregion

		#region Private Events
		/// <summary>
		/// Event when the group node is clicked
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void uebMainNavigation_GroupClick(object sender, GroupEventArgs e)
		{
			DisplayPanel(e.Group.Key, null);
		}

		/// <summary>
		/// Event when the Item is cliked
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void uebMainNavigation_ItemClick(object sender, ItemEventArgs e)
        {            
	        DisplayPanel(e.Item.Group.Key, e.Item.Key);
		}

		/// <summary>
		/// Event when the user clicks on the shortcut key
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void SecureForm_KeyDown(object sender, KeyEventArgs e)
		{
            //this handles left Panel Navigation
            if (e.Control && (e.KeyCode == Keys.D) )
            {
                DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.Dashboard).ToString(), null);
            }
            if (e.Control && (e.KeyCode == Keys.N))
            {
                DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.NewCall).ToString(), null);
            }
            if (e.Control && (e.KeyCode == Keys.S))
            {
                DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.Schedules).ToString(), null);
            }
            if (e.Control && (e.KeyCode == Keys.K))
            {
                DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.KeyCodes).ToString(), null);
            }
            if (e.Control && (e.KeyCode == Keys.O))
            {
                DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.Organizations).ToString(),null);
            }
            if (e.Control && (e.KeyCode == Keys.A))
            {
                DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.Admin).ToString(), null);
            }
            if (e.Control && (e.KeyCode == Keys.H))
            {
                DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.Help).ToString(), null);
            }
            if (e.Alt && (e.KeyCode == Keys.O))
            {//Alt O is going to organization search
                //specs say alt O goes to oncall jth 2/10
                NavigateToVBScreen(AppScreenType.VBOnCall);
                //DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.Organizations).ToString(), "30");
            }
            if (e.Alt && (e.KeyCode == Keys.G))
            {
                DisplayPanel(Convert.ToInt32(GeneralConstant.PanelNavigation.Organizations).ToString(), "30");
            }
            if (e.Alt && (e.KeyCode == Keys.L))
                NavigateToVBScreen(AppScreenType.VBSearch);
            //function keys is only for the dashboard search
             DashboardControl dashboardControl = selectedUserControl as DashboardControl;
             if (dashboardControl != null)
             {
                 string filterExpression = string.Format(generalConstant.StattracCulture, "ShortCutKey='{0}'", e.KeyData.ToString());
                 AppScreenDS.AppScreenRow[] rowArray = (AppScreenDS.AppScreenRow[])dataSet.AppScreen.Select(filterExpression);                 
                 if (rowArray.Length == 1)
                 {
                     if (e.KeyData.ToString() == "F4" && securityHelper.Authorized(SecurityRule.Family_Services.ToString()))
                         DisplayPanel(rowArray[0].ParentId.ToString(generalConstant.StattracCulture), rowArray[0].AppScreenId.ToString(CultureInfo.CurrentCulture));
                     if (e.KeyData.ToString() == "F5" && securityHelper.Authorized(SecurityRule.FS_Active_Cases.ToString()))
                         DisplayPanel(rowArray[0].ParentId.ToString(generalConstant.StattracCulture), rowArray[0].AppScreenId.ToString(CultureInfo.CurrentCulture));
                     if (e.KeyData.ToString() == "F6" && securityHelper.Authorized(SecurityRule.OASIS.ToString()))
                         DisplayPanel(rowArray[0].ParentId.ToString(generalConstant.StattracCulture), rowArray[0].AppScreenId.ToString(CultureInfo.CurrentCulture));
                     if (e.KeyData.ToString() == "F7" && securityHelper.Authorized(SecurityRule.ST_Update.ToString()))
                         DisplayPanel(rowArray[0].ParentId.ToString(generalConstant.StattracCulture), rowArray[0].AppScreenId.ToString(CultureInfo.CurrentCulture));
                     if (e.KeyData.ToString() == "F8" && securityHelper.Authorized(SecurityRule.Recycled_Cases.ToString()))
                         DisplayPanel(rowArray[0].ParentId.ToString(generalConstant.StattracCulture), rowArray[0].AppScreenId.ToString(CultureInfo.CurrentCulture));
                     if (e.KeyData.ToString() == "F1" || e.KeyData.ToString() == "F2" || e.KeyData.ToString() == "F9")
                     {
                         DisplayPanel(rowArray[0].ParentId.ToString(generalConstant.StattracCulture), rowArray[0].AppScreenId.ToString(CultureInfo.CurrentCulture));
                     }
                 }
                 if  (e.KeyCode == Keys.Return)
                     HandleKeysPressed(dashboardControl);
             }
		}

        #endregion

		#region Public Methods
		public override void LoadSubControl(AppScreenType groupType, AppScreenType screenTypes)
		{
            ResetSubControl();
			DisplayPanel(((int)groupType).ToString(generalConstant.StattracCulture),
				((int)screenTypes).ToString(generalConstant.StattracCulture));
		}

		public override void LoadHeaderControl(Control control)
		{
			pnlMainHeader.Controls.Clear();
            control.Dock = System.Windows.Forms.DockStyle.Fill;
            pnlMainHeader.Controls.Add(control);
            
        }
        public override void NavigateToVBScreen(AppScreenType appScreenType)
        { 
            int recordID =0;
            NavigateToVBScreen(appScreenType, recordID);
        }
        public override void NavigateToVBScreen(AppScreenType appScreenType, int recordID)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(appScreenType, recordID);
        }
        public void HandleKeysPressed(DashboardControl dashboardControl)
        {//this handles the alt and key pressed for the dashboard
            Control[] foundAllTabControls = dashboardControl.Controls.Find("tcDashboard", true);
            UltraTabControl tcTab = foundAllTabControls[0] as UltraTabControl;
            Control[] foundTabControls;
            string activeTab = tcTab.ActiveTab.Text;
            switch (activeTab)
            {
                case "Referrals (F1)":
                    foundTabControls = dashboardControl.Controls.Find("ReferralsControl", true);
                    ReferralsControl activeRefTabControl = foundTabControls[0] as ReferralsControl;
                    activeRefTabControl.Reload();
                    break;
                case "Msgs & Imports (F2)":
                    foundTabControls = dashboardControl.Controls.Find("MessageandImportControl", true);
                    MessageandImportControl activeMsgTabControl = foundTabControls[0] as MessageandImportControl;
                    activeMsgTabControl.Reload();
                    break;
                case "FS Active Cases (F5)":
                    foundTabControls = dashboardControl.Controls.Find("FamilyServiceActiveCaseControl", true);
                    FamilyServiceActiveCaseControl activeFSActiveTabControl = foundTabControls[0] as FamilyServiceActiveCaseControl;
                    activeFSActiveTabControl.Reload();
                    break;
                case "OASIS Active Cases (F6)":
                    foundTabControls = dashboardControl.Controls.Find("TcssActiveCasesControl", true);
                    TcssActiveCasesControl activeOASISTabControl = foundTabControls[0] as TcssActiveCasesControl;
                    activeOASISTabControl.Reload();
                    break;
                case "Updates (F7)":
                    foundTabControls = dashboardControl.Controls.Find("UpdateControl", true);
                    UpdateControl activeUpdateTabControl = foundTabControls[0] as UpdateControl;
                    activeUpdateTabControl.Reload();
                    break;
                case "Recycled Cases (F8)":
                    foundTabControls = dashboardControl.Controls.Find("RecycledCasesControl", true);
                    RecycledCasesControl activeRecycledTabControl = foundTabControls[0] as RecycledCasesControl;
                    activeRecycledTabControl.Reload();
                    break;
                case "No Calls (F9)":
                    foundTabControls = dashboardControl.Controls.Find("NoCallsControl", true);
                    NoCallsControl activeNoCallsTabControl = foundTabControls[0] as NoCallsControl;
                    activeNoCallsTabControl.Reload();
                    break;
            }
        }
        /// <summary>
        /// pops a form and user control when the current screen cannot replaced
        /// </summary>
        /// <param name="appscreenType"></param>
        public override void LoadInFormPromptForm(AppScreenType groupType, AppScreenType screenType)
        {

            InFormPrompt informPrompt = InFormPrompt.CreateInstance();
            informPrompt.LoadSubControl(groupType, screenType);

            informPrompt.ShowDialog();
        }
        #endregion

        public UserControl CreateDashBoardControl(AppScreenType selectedType)
        {
            if (dasboardControl == null)
                dasboardControl = new DashboardControl();

            ////add call to select tab
            //switch (selectedType)
            //{
            //    //case AppScreenType.DashboardReferrals:
            //    //    ((BaseForm)FindForm()).LoadSubControl(AppScreenType.Dashboard, AppScreenType.DashboardReferrals);
            //    //    break;
            //}
            return dasboardControl;
        }
        #region Public Property
        public override String SelectedUserControlName
        {
            get 
            { 
                return selectedUserControl.Name; 
            }
        }
        #endregion
    }
}
