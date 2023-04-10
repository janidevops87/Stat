using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.SourceCode;
using Statline.Stattrac.BusinessRules.SourceCode;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using GroupBox=System.Windows.Forms.GroupBox;
using Statline.Stattrac.Windows.UI;
using Infragistics.Win;
using Infragistics.Win.UltraWinTabs;
using Infragistics.Win.UltraWinTabControl;

namespace Statline.Stattrac.Windows.Controls.Administration.SourceCode
{
    public partial class SourceCodeEditManager : Statline.Stattrac.Windows.UI.BaseManagerControl
    {
        public int SourceCodeID { get; set; }
        private SourceCodeSourceCodeControl sourcecodeSourceCodeControl;
        private AssociatedOrganizationsControl associatedOrganizationControl;
        private CurrencyManager _currencyManager;

        public SourceCodeEditManager()
        {
            InitializeComponent();

            sourcecodeSourceCodeControl = new SourceCodeSourceCodeControl();            
            associatedOrganizationControl = new AssociatedOrganizationsControl();
            
            sourcecodeSourceCodeControl.TabIndex = 0;
            sourcecodeSourceCodeControl.TabStop = true;
            associatedOrganizationControl.TabIndex = 1;
            associatedOrganizationControl.TabStop = true;

            tabControl.AddTabItem(AppScreenType.SourceCodeSourceCode, "Source Code", sourcecodeSourceCodeControl);
            tabControl.AddTabItem(AppScreenType.SourceCodeAssociatedOrganizations, "Associated Organizations", associatedOrganizationControl);

            BusinessRule = new SourceCodeBR();
            BindValueList();

            SelectSourceCodeCallTypeList();
            // Create instance of security roles
            Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();
            
            // Set default access 
            btnAdd.Enabled = false;
            
            // Check if User has permission
            if (securityHelper.Authorized(SecurityRule.Add_Source_Code.ToString()))
            {
                btnAdd.Enabled = true;
            }

            // Set Default values if existing
            if (GRConstant.SourceCodeCallTypeId > 0)
            {
                cbCallType.SelectedValue = GRConstant.SourceCodeCallTypeId.ToString();
            }
            
        }


        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        protected override void BindDataToUI()
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
            if (sourceCodeDS == null)
                return;

            //The following code configures the AssociatedOrganizationControl
            //Before the control can be used the BR needs to implement the IOrganizationSearch Interface
            //and the BR and DA need to implement a SearchParameter
            //1. Initialize
            //2. BindDataToUI
            //3. Set the OrganizationSeachParameter
            //4. Available Selected Visule Column List
            //5. DataTable
            //6. DataSet
            associatedOrganizationControl.InitializeBR(BusinessRule);
            associatedOrganizationControl.BindDataToUI();
            associatedOrganizationControl.OrganizationSearchParameter =
                ((SourceCodeBR) BusinessRule).OrganizationSearchParameter;
            associatedOrganizationControl.ColumnList = typeof(SourceCodeOrganization);
            associatedOrganizationControl.DataMember = sourceCodeDS.SourceCodeOrganization.TableName;
            associatedOrganizationControl.DataSource = sourceCodeDS;

            sourcecodeSourceCodeControl.InitializeBR(BusinessRule);
            sourcecodeSourceCodeControl.BindDataToUI();

            _currencyManager = (CurrencyManager)BindingContext[sourceCodeDS, sourceCodeDS.SourceCode.TableName];


            if (GRConstant.SourceCodeId > 0)
            {
                LocateNewSourceCodeCallTypeList();
                sourcecodeSourceCodeControl.SetCurrentRow();
                _currencyManager.Position = sourceCodeDS.SourceCode.Rows.IndexOf(sourceCodeDS.SourceCode.FindBySourceCodeID(Convert.ToInt32(GRConstant.SourceCodeId)));

            }
        }

        private void SourceCodeOrganizationFilter(SourceCodeDS sourceCodeDS)
        {
            //filter the SourceCodeOrganization rows using the associatedOrganizationControl Row Filter
            associatedOrganizationControl.RowFilter(GRConstant.FirstRow,
                                               sourceCodeDS.SourceCodeOrganization.SourceCodeIDColumn.ColumnName,
                                               GRConstant.SourceCodeId, FilterComparisionOperator.Equals);
        }

        private void BindValueList()
        { 
            if (cbCallType.Items.Count == 0)
                cbCallType.BindData("SourceCodeTypeListSelect");
        }

        private void cbCallType_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (cbCallType.SelectedIndex > 0)
            {
                GRConstant.SourceCodeCallTypeId = Convert.ToInt32(cbCallType.SelectedValue);
                GRConstant.SourceCodeId = 0;
                BusinessRule.AssociatedDataSet.Clear();
                SelectSourceCodeCallTypeList();
                

                sourcecodeSourceCodeControl.DisplayAssociatedImportOfferTransplantCenters();
            }
        }
        /// <summary>
        /// Navigate Back To Dashboard
        /// </summary>
        protected override void NavigateBackToParent()
        {
            //reset boolean value in GeneralConstants
            GRConstant.IsNewCallOrganization = false;
            BusinessRule.AssociatedDataSet.Clear();
            if (((BaseForm)FindForm()).Name == "SecureForm")
            {

                ((BaseForm)FindForm()).LoadSubControl(AppScreenType.Organizations, AppScreenType.DashboardReferrals);
            }
            else
            {
                ((BaseForm)FindForm()).Close();
            }

        }
        protected override void LoadDataFromUI()
        {
            //End Edit of the currency manager before save
            _currencyManager.EndCurrentEdit();

            //Reset security for Add SourceCode
            sourcecodeSourceCodeControl.CheckSourceCodeAccess();

            //If current record is inactive reset sourcecode dropdown

        }

        private void SelectSourceCodeCallTypeList()
        {
            Hashtable paramList = new Hashtable();
            paramList.Add("SourceCodeCallTypeID", GRConstant.SourceCodeCallTypeId);
            paramList.Add("DisplayAllSourceCodes", (bool)(chkDisplayAllSourceCodes.Checked));
            paramList.Add("StatEmployeeUserId", StattracIdentity.Identity.UserId);
            cbSourceCode.BindData("SourceCodeCallTypeListSelect", paramList);
            paramList.Clear();
        }

        private void btnAdd_Click(object sender, System.EventArgs e)
        {
            // If this is a secure form pop-up(OpenSourceCode) we are only grabing the source code
            // to enter it in another form. We can cancel. (wi:12034) 
            if (GRConstant.OpenSourceCode == AppScreenType.AdministrationSourceCodeEditPopup)
            {
                ((BaseForm)FindForm()).Close();
                return;
            }

            
            if (cbCallType.SelectedIndex > 0)
            {
                
                //This is a new Record. Clear the current SourceCodeID
                //and get a new ID from the BR
                GRConstant.SourceCodeId = 0;

                //Uncheck DisplayAllSourceCodes
                chkDisplayAllSourceCodes.Checked = false;

                //Add empty row and set default values
                ((SourceCodeBR)BusinessRule).AddEmptyRow();
                
                //Bind Default Alert to new SourceCode Record
                sourcecodeSourceCodeControl.BindSourceCodeDefaultAlertNewRecord();

                //Get list of Organization Full Names
                sourcecodeSourceCodeControl.BindSelectSourceCodeOrganizationValueList();

                //Direct user to correct input area 
                sourcecodeSourceCodeControl.IsNewSourceCode = true;
                sourcecodeSourceCodeControl.SetDefaultDonorTracURL();
                sourcecodeSourceCodeControl.DisplayPanels();
                sourcecodeSourceCodeControl.SetSourceCodeFocus();



            }
            else
            { 
                //Give notice to select a CallType
                BaseMessageBox.ShowWarning("Please select a CallType");
            }

        }


        private void cbSourceCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
            if (sourceCodeDS == null)
                return;

            if (cbSourceCode.SelectedIndex > 0)
            {
                //Set Constants
                GRConstant.SourceCodeId = Convert.ToInt32(cbSourceCode.SelectedValue);
                GRConstant.CallTypeId = Convert.ToInt32(cbCallType.SelectedValue);

                //SourceCodeOrganization filter the SourceCodeOrganizations table
                SourceCodeOrganizationFilter(sourceCodeDS);

                sourcecodeSourceCodeControl.SetCurrentRow();

                _currencyManager.Position = sourceCodeDS.SourceCode.Rows.IndexOf(sourceCodeDS.SourceCode.FindBySourceCodeID(Convert.ToInt32(GRConstant.SourceCodeId)));

                //Set SourceCodeName and 
                GRConstant.SourceCodeName = cbSourceCode.Text.ToString();
                GRConstant.SourceCodeCallTypeName = cbCallType.Text.ToString();


                //If index changed and sourceCodeAssociaedOrganizations tab is visable
                LoadSourceCodeAssociatedOrganizations();
            }

            // Display Panels
            sourcecodeSourceCodeControl.DisplayPanels();
        }

        private void chkDisplayAllSourceCodes_CheckedChanged(object sender, EventArgs e)
        {
            SelectSourceCodeCallTypeList();
        }

        private void tabControl_SelectedTabChanged(object sender, Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventArgs e)
        {
            LoadSourceCodeAssociatedOrganizations();

        }

        private void LoadSourceCodeAssociatedOrganizations()
        {
            if (tabControl.SelectedTab.Key == AppScreenType.SourceCodeAssociatedOrganizations.GetHashCode().ToString())
            {
                if (GRConstant.SourceCodeId == 0)
                {
                    DisplaySourceCodeSaveMessage();
                    UltraTabsCollection tabs = tabControl.Tabs;
                    tabControl.SelectedTab = tabs[AppScreenType.SourceCodeSourceCode.GetHashCode().ToString()];
                    return;
                }

                // Load SourceCode Organizations only when tab and SourceCode are selected.
                SourceCodeDS sourceCodeDS = (SourceCodeDS)BusinessRule.AssociatedDataSet;
                if (sourceCodeDS == null)
                    return;

                if (cbSourceCode.SelectedIndex > 0)
                {
                    GRConstant.SourceCodeId = Convert.ToInt32(cbSourceCode.SelectedValue);
                    
                    GRConstant.SourceCodeOrganizationGetSelected = true;
                    ((SourceCodeBR)BusinessRule).SelectSourceCodeOrganization(GRConstant.SourceCodeId);

                    //SourceCodeOrganization filter the SourceCodeOrganizations table
                    SourceCodeOrganizationFilter(sourceCodeDS);
                }
            }
        }

        private static void DisplaySourceCodeSaveMessage()
        {
            StringBuilder message = new StringBuilder();
            message.Append("Please save this Source Code before adding an");
            message.AppendLine();
            message.Append("Associated Organization.");
            message.AppendLine();
            message.Append("Note: This Source Code must also be added to a Report Group");
            message.AppendLine();
            message.Append("before it will appear in the Source Code list above.");
            message.AppendLine();

            BaseMessageBox.ShowWarning(message.ToString(), "Warning: New Source Code");
        }

        private void LocateNewSourceCodeCallTypeList()
        {
            if (cbCallType.SelectedIndex > 0)
            {
                SelectSourceCodeCallTypeList();
                cbSourceCode.SelectedValue = GRConstant.SourceCodeId;

                if (cbSourceCode.SelectedValue == null)
                {   
                    // Check for null value 
                    // This can occur if the source code is no-longer active. 
                    cbSourceCode.SelectedValue = 0;
                    GRConstant.SourceCodeId = 0;
                    
                    // De-activate the panels.
                    sourcecodeSourceCodeControl.DisplayPanels();
                }
            }
        }

    }
}
