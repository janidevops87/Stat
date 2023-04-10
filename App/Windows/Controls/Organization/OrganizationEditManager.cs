using System;
using System.Windows.Forms;
using Infragistics.Win.UltraWinTabControl;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.UI;
using Statline.Stattrac.Windows.Utility;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class OrganizationEditManager : BaseManagerControl
    {
        private OrganizationPropertiesControl organizationPropertiesControl;
        private OrganizationBaseConfigurationControl organizationBaseConfigurationControl;
        private OrganizationOrganizationNumbersControl organizationOrganizationNumbersControl;
        private OrganizationAliasesControl organizationAliasesControl;
        private OrganizationContactsControl organizationContactsControl;
        
        private SecurityHelper securityHelper;
                
        public OrganizationEditManager()
        {
            InitializeComponent();
            
            organizationPropertiesControl = new OrganizationPropertiesControl();
            organizationBaseConfigurationControl = new OrganizationBaseConfigurationControl();
            organizationOrganizationNumbersControl = new OrganizationOrganizationNumbersControl();
            organizationAliasesControl = new OrganizationAliasesControl();
            organizationContactsControl = new OrganizationContactsControl();
            securityHelper = SecurityHelper.GetInstance();

            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationProperties, "Organization Properties", organizationPropertiesControl);
            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationBaseConfiguration, "Base Configuration", organizationBaseConfigurationControl);                    
            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationOrganizationNumbers, "Organization Numbers", organizationOrganizationNumbersControl);
            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationAliases, "Aliases", organizationAliasesControl);
            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationContacts, "Contacts", organizationContactsControl);
            if (securityHelper.Authorized(SecurityRule.All_Roles.ToString()))
                GRConstant.AllPermissions = true;
            BusinessRule = new OrganizationBR();
            
            //Bret 05/20/2011 WI 12213 moving from BindDataToUI so active tab is not changed.
            SetActiveTab();

            //By Default the form is readonly
            //if the organizaiton is newly created allow edits
            SetOrganizationPermissions();


        }
        /// <summary>
        /// Update the parameters when the control comes into view
        /// </summary>
        protected override void UpdateParameters()
        {
            ((OrganizationBR)BusinessRule).OrganizationId = GRConstant.OrganizationId;
            ((OrganizationBR)BusinessRule).ContactId = GRConstant.ContactId;

        }

        /// <summary>
        /// Navigate Back To Parent Control
        /// </summary>
        protected override void NavigateBackToParent()
        {
            //reset the two boolean value in GeneralConstants
            GRConstant.IsNewCallOrganization = false;
            GRConstant.OpenOrganization = AppScreenType.OrganizationsOrganizationProperties;
            BusinessRule.AssociatedDataSet.Clear();
            if (((BaseForm)FindForm()).Name == "SecureForm")
            {
                GRConstant.OrganizationId = Int32.MinValue;
                GRConstant.ContactId = Int32.MinValue;
                GRConstant.ContactPhoneId = Int32.MinValue;

                ((BaseForm)FindForm()).LoadSubControl(AppScreenType.Organizations, AppScreenType.OrganizationsOrganizationSearch);
            }
            else
            {
                ((BaseForm)FindForm()).Close();            
            }

            
        }
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        protected override void BindDataToUI()
        {
            organizationPropertiesControl.InitializeBR(BusinessRule);            
            organizationBaseConfigurationControl.InitializeBR(BusinessRule);
            organizationOrganizationNumbersControl.InitializeBR(BusinessRule);
            organizationAliasesControl.InitializeBR(BusinessRule);
            organizationContactsControl.InitializeBR(BusinessRule);

            organizationPropertiesControl.BindDataToUI();
            organizationBaseConfigurationControl.BindDataToUI();
            organizationOrganizationNumbersControl.BindDataToUI();
            organizationAliasesControl.BindDataToUI();
            organizationContactsControl.BindDataToUI();

            
            OrganizationDS organizationDS = ((OrganizationDS)BusinessRule.AssociatedDataSet);
            
            ShowBaseConfigurationTab();
                    
            

        }
        /// <summary>
        /// This method controls the editing permissions for Organization controls
        /// Contact Controls will be controlled from OrganizationContact
        /// </summary>
        private void SetOrganizationPermissions()
        {
            //Disable all User Controls and Enable Controls where appropriate

            ControlHelper.EnableAllControls(organizationPropertiesControl,false);
            ControlHelper.EnableAllControls(organizationBaseConfigurationControl, false);
            ControlHelper.EnableAllControls(organizationOrganizationNumbersControl, false);
            ControlHelper.EnableAllControls(organizationAliasesControl, false);

            if ((GRConstant.OrganizationId < 1 
                && securityHelper.Authorized(SecurityRule.Add_Organizations.ToString()))
                ||
                GRConstant.OrganizationId > 0
                && (securityHelper.Authorized(SecurityRule.Edit_Organizations.ToString()))
                )
            {
                ControlHelper.EnableAllControls(organizationPropertiesControl, true);
                ControlHelper.EnableAllControls(organizationBaseConfigurationControl, true);
                ControlHelper.EnableAllControls(organizationOrganizationNumbersControl, true);
                ControlHelper.EnableAllControls(organizationAliasesControl, true);
                //callback to control to do local form permission
                organizationPropertiesControl.SetLocalPermissions();
            }

        }

        private void SetActiveTab()
        {
            UltraTab activeTab ;
            string key = "";
            //make Contacts the active tab
            switch (GRConstant.OpenOrganization)
            {
                case AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup:
                case AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup:
                    key = ((int)AppScreenType.OrganizationsOrganizationContacts).ToString(GRConstant.StattracCulture);
                    break;
                default:
                    key = ((int)AppScreenType.OrganizationsOrganizationProperties).ToString(GRConstant.StattracCulture);
                    break;
            }
            

            if (key.Length == 0)
                return;
            activeTab = tabControl.Tabs[key];

            activeTab.Active = true;
            activeTab.Selected = true;
            

        }

        /// <summary>
        /// Created By: Bret Knoll
        /// Created On: 10/28/2010
        /// 
        /// Used to hide Base Configuration Tab. Tabs do not show if current organization does not have a base configuration.
        /// </summary>
        private void HideTabs()
        {
            ////delete this
            UltraTab tabBaseConfig = tabControl.Tabs[((int)AppScreenType.OrganizationsOrganizationBaseConfiguration).ToString()];
            if (tabBaseConfig == null)
                return;
            
            tabBaseConfig.Visible = false;

        }
        /// <summary>
        /// Created By: Bret Knoll
        /// Created On: 10/28/2010
        /// 
        /// Used to show Base Configuration Tab. If user has access they it will show.
        /// </summary>        
        private void ShowBaseConfigurationTab()
        {
            Boolean ShowTab = false;

            if (securityHelper != null)                
                if (securityHelper.Authorized(SecurityRule.Base_Configuration.ToString()))
                    ShowTab = true;

            // ShowTab == true the user has access
            // ShowTab == false the user does not have access 
            // if the organization does not a StatTarc Organization set showTab = false so it will not show.
            if (BusinessRule.AssociatedDataSet.organizationDs().Organization.Rows.Count > 0)
            {
                if (!BusinessRule.AssociatedDataSet.organizationDs().Organization[GRConstant.FirstRow].StatTracOrganization == true)
                    ShowTab = false;
            }
            else
                ShowTab = false;


            UltraTab tabBaseConfig = tabControl.Tabs[((int)AppScreenType.OrganizationsOrganizationBaseConfiguration).ToString()];

            if (tabBaseConfig == null)
                return;

            tabBaseConfig.Visible = ShowTab;
        }
        
        protected override void LoadDataFromUI()
        {
            organizationBaseConfigurationControl.LoadDataFromUI();
            organizationContactsControl.LoadDataFromUI();

            if (GRConstant.IsNewCallOrganization &&
                GRConstant.OpenOrganization == AppScreenType.OrganizationsOrganizationEditPopup)
            {
                //Give notice : This is a secure form popup and the user is adding an organization.
                BaseMessageBox.ShowWarning("You are about to save an unverified organization." + Environment.NewLine +
                                "Contact a Service Consultant or other Administrator " + Environment.NewLine +
                                "to ensure the automatic administration group " + Environment.NewLine +
                                "assignments are correct.");
            }
        }
                  
    }
}
