using System;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Windows.UI;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class OrganizationBaseConfigurationControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        
        private DataView _organizationPhoneDataView;
        private OrganizationDS _organizationDS;
        public OrganizationBaseConfigurationControl()
        {
            InitializeComponent();
        }
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        public override void BindDataToUI()
        {
            _organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;
            cbAutoDisplaySourceCode.BindData("SourceCodeByOrganizationIdListSelect");
            cbASPSettingType.BindData("ASPSettingTypeListSelect");

            lblOrganizationName.Text = _organizationDS.Organization[GeneralConstant.CreateInstance().FirstRow].OrganizationName;
            string tableName;

            tableName = _organizationDS.OrganizationASPSetting.TableName;
            cbASPSettingType.BindDataSet(_organizationDS, tableName, _organizationDS.OrganizationASPSetting.AspSettingTypeIDColumn.ColumnName);
            cbAutoDisplaySourceCode.BindDataSet(_organizationDS, tableName, _organizationDS.OrganizationASPSetting.AutoDisplaySourceCodeIDColumn.ColumnName);
            chkLinkToStatlinePhoneSystem.BindDataSet(_organizationDS, tableName, _organizationDS.OrganizationASPSetting.LinkToStatlinePhoneSystemColumn.ColumnName);
            chkAutoDisplaySourceCode.BindDataSet(_organizationDS, tableName, _organizationDS.OrganizationASPSetting.AutoDisplaySourceCodeColumn.ColumnName);

            string organizationPhoneFilter = string.Format("PhoneType = '{0}'", "Call Back");
            _organizationPhoneDataView = _organizationDS.OrganizationPhone.DefaultView;
            _organizationPhoneDataView.RowFilter = organizationPhoneFilter;
            txtAspPhone.BindDataSet(_organizationPhoneDataView, _organizationDS.OrganizationPhone.PhoneColumn.ColumnName);

            // make sure to bindValueList before adding data
            ugSourceCodeMappingFamilyServicesASP.DataMember = _organizationDS.OrganizationFsSourceCode.TableName;
            ugSourceCodeMappingFamilyServicesASP.DataSource = _organizationDS;
            ugSourceCodeMappingFamilyServicesASP.BindValueList(
                "SourceCodeByOrganizationIdListSelect", 
                _organizationDS.OrganizationFsSourceCode.SourceCodeIDColumn.ColumnName,
                _organizationDS.OrganizationFsSourceCode, 
                _organizationDS.OrganizationFsSourceCode.SourceCodeColumn.ColumnName);
            ugSourceCodeMappingFamilyServicesASP.BindValueList(
                "SourceCodeByOrganizationIdListSelect", 
                _organizationDS.OrganizationFsSourceCode.FsSourceCodeIDColumn.ColumnName,
                _organizationDS.OrganizationFsSourceCode,                
                _organizationDS.OrganizationFsSourceCode.FsSourceCodeColumn.ColumnName);
            
            ugCaseReviewPercentage.DataMember = _organizationDS.OrganizationCaseReview.TableName;
            ugCaseReviewPercentage.DataSource = _organizationDS;
            ugCaseReviewPercentage.BindValueList(
                "CaseTypeListSelect", 
                _organizationDS.OrganizationCaseReview.CaseTypeIDColumn.ColumnName,
                _organizationDS.OrganizationCaseReview, _organizationDS.OrganizationCaseReview.CaseTypeColumn.ColumnName);


            ugCallEventExpiration.DataMember = _organizationDS.OrganizationDashBoardTimer.TableName;
            ugCallEventExpiration.DataSource = _organizationDS;
            ugCallEventExpiration.BindValueList(
                "DashBoardWindowListSelect",
                _organizationDS.OrganizationDashBoardTimer.DashBoardWindowIDColumn.ColumnName,
                _organizationDS.OrganizationDashBoardTimer,
                _organizationDS.OrganizationDashBoardTimer.DashBoardWindowColumn.ColumnName);
            ugCallEventExpiration.BindValueList(
                "DashBoardTimerTypeListSelect",
                _organizationDS.OrganizationDashBoardTimer.DashBoardTimerTypeIDColumn.ColumnName,
                _organizationDS.OrganizationDashBoardTimer,
                _organizationDS.OrganizationDashBoardTimer.DashBoardTimerTypeColumn.ColumnName);

            ugDuplicateSearchSettings.DataMember = _organizationDS.OrganizationDuplicateSearchRule.TableName;
            ugDuplicateSearchSettings.DataSource = _organizationDS;
            ugDuplicateSearchSettings.BindValueList(
                "CallTypeListSelect",
                _organizationDS.OrganizationDuplicateSearchRule.CallTypeIDColumn.ColumnName,
                _organizationDS.OrganizationDuplicateSearchRule,
                _organizationDS.OrganizationDuplicateSearchRule.CallTypeColumn.ColumnName);
            ugDuplicateSearchSettings.BindValueList(
                "DuplicateSearchRuleListSelect",
                _organizationDS.OrganizationDuplicateSearchRule.DuplicateSearchRuleIDColumn.ColumnName,
                _organizationDS.OrganizationDuplicateSearchRule,
                _organizationDS.OrganizationDuplicateSearchRule.DuplicateSearchRuleColumn.ColumnName);

            availableSelectedControl.DataMember = _organizationDS.OrganizationDisplaySetting.TableName;
            availableSelectedControl.ColumnList = typeof (OrganizationDisplaySetting);
            availableSelectedControl.DataSource = _organizationDS;
        }
        /// <summary>
        /// Load Data from UI
        /// </summary>
        public override void LoadDataFromUI()
        {
            if (_organizationPhoneDataView.Count > 0)
            {
                if (_organizationPhoneDataView[0].Row.RowState == DataRowState.Added || _organizationPhoneDataView[0].Row.RowState == DataRowState.Modified)
                {
                    string conflictingMessage = ((OrganizationBR)BusinessRule).CheckForDuplicatePhoneNumbers();
                    if (conflictingMessage.Length > 0)
                    {
                        BaseMessageBox.Show(conflictingMessage);
                    }
                }
            }
            else
            {
                if (!string.IsNullOrEmpty(txtAspPhone.Text))
                {
                    string callBack = txtAspPhone.Text;
                    ((OrganizationBR)BusinessRule).OrganizationPhoneCallBack(callBack);

                }
            }
        }

        private void ugSourceCodeMappingFamilyServicesASP_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            OrganizationDS organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;
            int band = 0;
            ugSourceCodeMappingFamilyServicesASP.ColumnDisplay(band, typeof(OrganizationFsSourceCode), organizationDS.OrganizationFsSourceCode);

        }

        private void ugCaseReviewPercentage_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            OrganizationDS organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;

            const int band = 0;
            ugCaseReviewPercentage.ColumnDisplay(band, typeof(OrganizationCaseReview), organizationDS.OrganizationCaseReview);
            ugCaseReviewPercentage.DisplayLayout.Bands[band].Columns[organizationDS.OrganizationCaseReview.CaseReviewPercentageColumn.ColumnName.ToString()].MinValue = 0;
            ugCaseReviewPercentage.DisplayLayout.Bands[band].Columns[organizationDS.OrganizationCaseReview.CaseReviewPercentageColumn.ColumnName.ToString()].MaxValue = 100;
            ugCaseReviewPercentage.DisplayLayout.Bands[band].Columns[organizationDS.OrganizationCaseReview.CaseReviewPercentageColumn.ColumnName.ToString()].InvalidValueBehavior = Infragistics.Win.UltraWinGrid.InvalidValueBehavior.RevertValueAndRetainFocus;
            
        }

        private void ugCallEventExpiration_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            OrganizationDS organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ugCallEventExpiration.ColumnDisplay(band, typeof(OrganizationDashBoardTimer), organizationDS.OrganizationDashBoardTimer);
            
        }

        private void ugDuplicateSearchSettings_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            OrganizationDS organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;

            const int band = 0;
            ugDuplicateSearchSettings.ColumnDisplay(band, typeof(OrganizationDuplicateSearchRule), organizationDS.OrganizationDuplicateSearchRule);
        }

        private void ugSourceCodeMappingFamilyServicesASP_Validating(object sender, CancelEventArgs e)
        {
            if(cbASPSettingType.Text != GeneralConstant.FamilyServicesAspOnly)
            {

                ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Appearance.BackColor = Color.White;
                e.Cancel = false;
                return;
            }
                

            if(ugSourceCodeMappingFamilyServicesASP.Rows.Count > 0)
            {
                ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Appearance.BackColor = Color.White;
                e.Cancel = false;
            }
            else
            {
                ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Appearance.BackColor = Color.Yellow;
                e.Cancel = true;
            }
                

        }

        private void cbAutoDisplaySourceCode_Validating(object sender, CancelEventArgs e)
        {
            // if not checked
            if(!(bool)chkAutoDisplaySourceCode.Checked)
            {
                cbAutoDisplaySourceCode.BackColor = Color.White;
                e.Cancel = false;
                return;
            }
            // if a value is selected

            if(Convert.ToInt32(cbAutoDisplaySourceCode.SelectedIndex) > 0 )
            {
                cbAutoDisplaySourceCode.BackColor = Color.White;
                e.Cancel = false;
            }
            else
            {
                cbAutoDisplaySourceCode.BackColor = Color.Yellow;
                e.Cancel = true;
                
            }
            
        }

        private void OrganizationBaseConfigurationControl_Validating(object sender, CancelEventArgs e)
        {
            if (_organizationDS == null)
                return;
            if (!_organizationDS.Organization[GRConstant.FirstRow].ContractedStatlineClient)
            {
                CausesValidation = false;
                

            }

        }

        private void chkAutoDisplaySourceCode_CheckedChanged(object sender, EventArgs e)
        {
            if ((bool)chkAutoDisplaySourceCode.Checked)
                return;

            cbAutoDisplaySourceCode.SelectedIndex = -1;

        }

        private void txtAspPhone_Leave(object sender, EventArgs e)
        {


        }

        private void txtAspPhone_TextChanged(object sender, EventArgs e)
        {

            
        }

        private void txtAspPhone_Validated(object sender, EventArgs e)
        {
            if (_organizationPhoneDataView.Count == 0)
                return;
            _organizationPhoneDataView[0].Row.EndEdit();

        }

    }
}
