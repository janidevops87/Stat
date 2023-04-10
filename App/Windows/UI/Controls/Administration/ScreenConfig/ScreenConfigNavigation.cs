using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.SourceCode;
using Statline.Stattrac.BusinessRules.ScreenConfig;
using Statline.Stattrac.BusinessRules.SourceCode;
using Statline.Stattrac.Data.Types.ScreenConfig;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Constant.GridColumns;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    public partial class ScreenConfigNavigation : Statline.Stattrac.Windows.UI.BaseManagerControl
    {
        private ContactInformationControl contactInformationControl;
        private PatientInformationControl patientInformationControl;
        private MedicalHistoryControl medicalHistoryControl;
        private RegistryControl registryControl;
        private NextofKinControl nextofKinControl;
        private ApplyScreenConfigControl applyScreenConfigControl;
        private AuthorizationControl authorizationControl;
        private CoronerMEControl coronerMEControl;
        private FuneralHomeControl funeralHomeControl;
        private MoreDataControl moreDataControl;
        private UpdateControl updateControl;
        private OverallDispoControl overallDispoControl;
        private TCSSControl tCSSControl;
        private ImportOfferControl importOfferControl;
        private MessageControl messageControl;
        private ReferralEventLogControl referralEventLogControl;
        private OtherEventLogControl otherEventLogControl;
        //private AssociatedOrganizationsControl associatedOrganizationsControl;
        private FamilyServicesNavigation familyServicesNavigation;
        private AssociatedSourceCodeControl associatedSourceCodeControl;
        //private Statline.Stattrac.Windows.UI.Controls.Common.OrganizationSearchParameter organizationSearchParameter;

        //public SearchParameter OrganizationSearchParameter
        //{
        //    get { return organizationSearchParameter.BRSearchParameter; }
        //    set { organizationSearchParameter.BRSearchParameter = value; }
        //}

        public ScreenConfigNavigation()
        {
            InitializeComponent();
            BusinessRule = new ScreenConfigBR();
            ScreenConfigBR screenConfigBR = (ScreenConfigBR)BusinessRule;
            //ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            screenConfigBR.SelectDataSet();
            
            contactInformationControl = new ContactInformationControl();
            patientInformationControl = new PatientInformationControl();
            medicalHistoryControl = new MedicalHistoryControl();
            registryControl = new RegistryControl();
            nextofKinControl = new NextofKinControl();
            applyScreenConfigControl = new ApplyScreenConfigControl();
            authorizationControl = new AuthorizationControl();
            coronerMEControl = new CoronerMEControl();
            funeralHomeControl = new FuneralHomeControl();
            moreDataControl = new MoreDataControl();
            updateControl = new UpdateControl();
            overallDispoControl = new OverallDispoControl();
            referralEventLogControl = new ReferralEventLogControl();
            tCSSControl = new TCSSControl();
            importOfferControl = new ImportOfferControl();
            messageControl = new MessageControl();
            referralEventLogControl = new ReferralEventLogControl();
            otherEventLogControl = new OtherEventLogControl();
            //associatedOrganizationsControl = new AssociatedOrganizationsControl();
            familyServicesNavigation = new FamilyServicesNavigation();
            associatedSourceCodeControl = new AssociatedSourceCodeControl();
            //referral
            tabControl.AddTabItem(AppScreenType.ContactInformation, "Contact Information", contactInformationControl);
            tabControl.AddTabItem(AppScreenType.ApplyScreenConfig, "Apply Screen Configuration", applyScreenConfigControl);
            tabControl.AddTabItem(AppScreenType.PatientInformation, "Patient Information", patientInformationControl);
            tabControl.AddTabItem(AppScreenType.MedicalHistory, "Medical History", medicalHistoryControl);
            tabControl.AddTabItem(AppScreenType.Registry, "Registry", registryControl);
            tabControl.AddTabItem(AppScreenType.NextofKin, "Next of Kin", nextofKinControl);
            tabControl.AddTabItem(AppScreenType.Authorization, "Authorization", authorizationControl);
            tabControl.AddTabItem(AppScreenType.CoronerME, "Coroner/ME", coronerMEControl);
            tabControl.AddTabItem(AppScreenType.FuneralHome, "Funeral Home", funeralHomeControl);
            tabControl.AddTabItem(AppScreenType.MoreData, "More Data", moreDataControl);
            tabControl.AddTabItem(AppScreenType.Update, "Update", updateControl);
            tabControl.AddTabItem(AppScreenType.OverallDisposition, "Overall Disposition", overallDispoControl);
            tabControl.AddTabItem(AppScreenType.FamilyServices, "Family Services", familyServicesNavigation);
            tabControl.AddTabItem(AppScreenType.ReferralEventLog, "Event Log", referralEventLogControl);
            
            //messages
            tabControl.AddTabItem(AppScreenType.Message, "Messages", messageControl);
            //import
            tabControl.AddTabItem(AppScreenType.ImportOffer, "Import Offers", importOfferControl);
            //tcss
            tabControl.AddTabItem(AppScreenType.TCSS, "TCSS", tCSSControl);
            //other eventlog
            tabControl.AddTabItem(AppScreenType.OtherEventLog, "Event Log", otherEventLogControl);
            //tabControl.AddTabItem(AppScreenType.AssociatedOrganizations, "Associated Organizations", associatedOrganizationsControl);
            tabControl.AddTabItem(AppScreenType.AssociatedSourceCodes, "Associated Source Codes", associatedSourceCodeControl);

            tabControl.Tabs[((int)AppScreenType.ContactInformation).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.PatientInformation).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.MedicalHistory).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.Registry).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.NextofKin).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.Authorization).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.CoronerME).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.FuneralHome).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.MoreData).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.Update).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.OverallDisposition).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.ReferralEventLog).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.Message).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.ImportOffer).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.TCSS).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.OtherEventLog).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.AssociatedOrganizations).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.FamilyServices).ToString()].Visible = false;
            tabControl.Tabs[((int)AppScreenType.AssociatedSourceCodes).ToString()].Visible = false;
            applyScreenConfigControl.ScreenConfigNavigation = this;
            contactInformationControl.ScreenConfigNavigation = this;
            patientInformationControl.ScreenConfigNavigation = this;
            medicalHistoryControl.ScreenConfigNavigation = this;
            nextofKinControl.ScreenConfigNavigation = this;
            associatedSourceCodeControl.ScreenConfigNavigation = this;
            moreDataControl.ScreenConfigNavigation = this;
            registryControl.ScreenConfigNavigation = this;
            otherEventLogControl.ScreenConfigNavigation = this;
        }

        protected override void BindDataToUI()
        {
            cbCallType.BindData("CallTypeListSelect");
            cbScreenConfig.BindData("ServiceLevelListSelect");
            contactInformationControl.InitializeBR(BusinessRule);
            patientInformationControl.InitializeBR(BusinessRule); ;
            medicalHistoryControl.InitializeBR(BusinessRule); ;
            registryControl.InitializeBR(BusinessRule);
            nextofKinControl.InitializeBR(BusinessRule);
            applyScreenConfigControl.InitializeBR(BusinessRule);
            authorizationControl.InitializeBR(BusinessRule);
            coronerMEControl.InitializeBR(BusinessRule);
            funeralHomeControl.InitializeBR(BusinessRule);
            moreDataControl.InitializeBR(BusinessRule);
            updateControl.InitializeBR(BusinessRule);
            overallDispoControl.InitializeBR(BusinessRule);
            referralEventLogControl.InitializeBR(BusinessRule);
            tCSSControl.InitializeBR(BusinessRule);
            importOfferControl.InitializeBR(BusinessRule);
            messageControl.InitializeBR(BusinessRule);
            referralEventLogControl.InitializeBR(BusinessRule);
            otherEventLogControl.InitializeBR(BusinessRule);
            //associatedOrganizationsControl.InitializeBR(BusinessRule);
            associatedSourceCodeControl.InitializeBR(BusinessRule);


            contactInformationControl.BindDataToUI();
            patientInformationControl.BindDataToUI();
            medicalHistoryControl.BindDataToUI();
            registryControl.BindDataToUI();
            nextofKinControl.BindDataToUI();
            applyScreenConfigControl.BindDataToUI();
            authorizationControl.BindDataToUI();
            coronerMEControl.BindDataToUI();
            funeralHomeControl.BindDataToUI();
            moreDataControl.BindDataToUI();
            updateControl.BindDataToUI();
            overallDispoControl.BindDataToUI();
            referralEventLogControl.BindDataToUI();
            tCSSControl.BindDataToUI();
            importOfferControl.BindDataToUI();
            messageControl.BindDataToUI();
            referralEventLogControl.BindDataToUI();
            //associatedOrganizationsControl.BindDataToUI();
            associatedSourceCodeControl.BindDataToUI();
            otherEventLogControl.BindDataToUI();

            //The following code configures the AssociatedOrganizationControl
            //Before the control can be used the BR needs to implement the IOrganizationSearch Interface
            //and the BR and DA need to implement a SearchParameter
            //1. Initialize
            //2. BindDataToUI
            //3. Set the OrganizationSeachParameter
            //4. Available Selected Visule Column List
            //5. DataTable
            //6. DataSet
            //BusinessRule = new SourceCodeBR();
            //SourceCodeBR sourceCodeBR = (SourceCodeBR)BusinessRule;
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            //associatedOrganizationsControl.InitializeBR(BusinessRule);
            //associatedOrganizationsControl.BindDataToUI();
            //associatedOrganizationsControl.OrganizationSearchParameter =
            //    ((ScreenConfigBR)BusinessRule).OrganizationSearchParameter;
            //associatedOrganizationsControl.ColumnList = typeof(SourceCodeOrganization);
            //associatedOrganizationsControl.DataMember = screenConfigDS.SourceCodeOrganization.TableName;
            //associatedOrganizationsControl.DataSource = screenConfigDS;
        }

        private void btnApplyScreenConfig_Click(object sender, EventArgs e)
        {
            tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Visible = true;
            tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Selected = true;
        }

        public string callBackCallType()
        {
            if (cbCallType.SelectedValue != null)
            {
                return cbCallType.SelectedValue.ToString();
            }
            else
            {
                return null;
            }
        }

        public string callBackScreenConfig()
        {
            if (cbScreenConfig.SelectedValue != null)
            {
                return cbScreenConfig.SelectedValue.ToString();
            }
            else
            {
                return null;
            }
        }

        public string callBackCKDisplayAll()
        {
            return chkDisplayAll.Checked.ToString();
        }

        private void cbCallType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbCallType.SelectedIndex < 1 || cbCallType.SelectedItem == null)
                return;
            switch (cbCallType.Text)
            {
                case "Referral":
                    tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Selected = true;
                    tabControl.Tabs[((int)AppScreenType.ContactInformation).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.PatientInformation).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.MedicalHistory).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.Registry).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.NextofKin).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.Authorization).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.CoronerME).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.FuneralHome).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.MoreData).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.Update).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.OverallDisposition).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.ReferralEventLog).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.Message).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ImportOffer).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.TCSS).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.OtherEventLog).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.AssociatedOrganizations).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.AssociatedSourceCodes).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.FamilyServices).ToString()].Visible = true;
                    break;
                case "Message":
                    tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Selected = true;
                    tabControl.Tabs[((int)AppScreenType.ContactInformation).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.PatientInformation).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.MedicalHistory).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Registry).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.NextofKin).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Authorization).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.CoronerME).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.FuneralHome).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.MoreData).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Update).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.OverallDisposition).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ReferralEventLog).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Message).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.ImportOffer).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.TCSS).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.OtherEventLog).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.AssociatedOrganizations).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.AssociatedSourceCodes).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.FamilyServices).ToString()].Visible = false;
                    break;
                case "Import":
                    tabControl.Tabs[((int)AppScreenType.ContactInformation).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.PatientInformation).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.MedicalHistory).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Registry).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.NextofKin).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Authorization).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.CoronerME).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.FuneralHome).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.MoreData).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Update).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.OverallDisposition).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ReferralEventLog).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Message).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ImportOffer).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.ImportOffer).ToString()].Selected = true;
                    tabControl.Tabs[((int)AppScreenType.TCSS).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.OtherEventLog).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.AssociatedOrganizations).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.AssociatedSourceCodes).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.FamilyServices).ToString()].Visible = false;
                    break;
                case "OASIS":
                    tabControl.Tabs[((int)AppScreenType.ContactInformation).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.PatientInformation).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.MedicalHistory).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Registry).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.NextofKin).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Authorization).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.CoronerME).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.FuneralHome).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.MoreData).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Update).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.OverallDisposition).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ReferralEventLog).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Message).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ImportOffer).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.TCSS).ToString()].Selected = true;
                    tabControl.Tabs[((int)AppScreenType.TCSS).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.OtherEventLog).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.AssociatedOrganizations).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.AssociatedSourceCodes).ToString()].Visible = true;
                    tabControl.Tabs[((int)AppScreenType.FamilyServices).ToString()].Visible = false;
                    break;
                default:
                    tabControl.Tabs[((int)AppScreenType.ContactInformation).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.PatientInformation).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.MedicalHistory).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Registry).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.NextofKin).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Authorization).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.CoronerME).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.FuneralHome).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.MoreData).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Update).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.OverallDisposition).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ReferralEventLog).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.Message).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.ImportOffer).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.TCSS).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.OtherEventLog).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.AssociatedOrganizations).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.AssociatedSourceCodes).ToString()].Visible = false;
                    tabControl.Tabs[((int)AppScreenType.FamilyServices).ToString()].Visible = false;
                    break;
            }
            tabControl.Tabs[((int)AppScreenType.ApplyScreenConfig).ToString()].Visible = false;
            associatedSourceCodeControl.BindDataToUI();
            otherEventLogControl.BindDataToUI();
            //applyScreenConfigControl.BindDataToUI();
        }

        private void cbScreenConfig_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbScreenConfig.SelectedIndex < 1 || cbScreenConfig.SelectedItem == null)
                return;
            //BusinessRule = new ScreenConfigBR();
            ScreenConfigBR screenConfigBR = (ScreenConfigBR)BusinessRule;
            
            screenConfigBR.SelectServiceLevel(Convert.ToInt32(cbScreenConfig.SelectedValue.ToString()));
            patientInformationControl.BindDataToUI();
            medicalHistoryControl.BindDataToUI();
            nextofKinControl.BindDataToUI();
            screenConfigBR.SelectServiceLevelCustomField(Convert.ToInt32(cbScreenConfig.SelectedValue.ToString()));
            screenConfigBR.SelectServiceLevelCustomList(Convert.ToInt32(cbScreenConfig.SelectedValue.ToString()));
            moreDataControl.BindDataToUI();
            screenConfigBR.SelectRegistryServiceLevel(Convert.ToInt32(cbScreenConfig.SelectedValue.ToString()));
            registryControl.BindDataToUI();
            contactInformationControl.turnOnAddBtn();
        }

        private void chkDisplayAll_CheckedChanged(object sender, EventArgs e)
        {
            contactInformationControl.BindDataToUI();
        }

        private void tabControl_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
           //control tabs here
        }
    }
}

