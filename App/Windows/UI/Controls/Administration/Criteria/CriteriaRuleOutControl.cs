using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Collections;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Data.Types.Criteria;
using Statline.Stattrac.BusinessRules.Criteria;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    public partial class CriteriaRuleOutControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {   
        private CriteriaDS criteriaDS; 
        private CurrencyManager _currencyManager;

        private DataView criteriaAgeMaleUpperUMv;
        private DataView criteriaAgeMaleLowerUMv;
        private DataView criteriaAgeFemaleUpperUMv;
        private DataView criteriaAgeFemaleLowerUMv;
        private DataView criteriaWeightMaleUpperUMv;
        private DataView criteriaWeightMaleLowerUMv;
        private DataView criteriaWeightFemaleUpperUMv;
        private DataView criteriaWeightFemaleLowerUMv;
        private DataView criteriaWeightFetalDemiseUpperUMv;
        private DataView criteriaWeightFetalDemiseLowerUMv;


        #region Properties

        private string idColumn = "";
        private Type _columnList = null;

        //[Description("This is used to pass the parameters for searching back to the BR/DA for")]
        //public SearchParameter IndicationSearchParameter
        //{
        //    get { return indicationSearchParameter.BRSearchParameter; }
        //    set { indicationSearchParameter.BRSearchParameter = value; }
        //}

        public string IdColumn
        {
            get { return idColumn; }
            set { idColumn = value; }
        }
        [Description("Name of DataTable to bind to. The table must have a Hidden field. Rows with a Hidden Field of False will display in the selected grid.")]
        public string DataMember
        {
            get { return availableSelectedControl.DataMember; }
            set
            {
                availableSelectedControl.DataMember = value;
                availableSelectedControl.DataMember = value;
            }
        }

        public object DataSource
        {
            get { return availableSelectedControl.DataSource; }
            set
            {
                availableSelectedControl.DataSource = value;
                availableSelectedControl.DataSource = value;

            }

        }
        public string TextAvailable
        {
            get { return availableSelectedControl.TextAvailable; }
            set
            {

                availableSelectedControl.TextAvailable = value;
            }
        }
        public string TextSelected
        {
            get { return availableSelectedControl.TextSelected; }
            set
            {

                availableSelectedControl.TextSelected = value;
            }
        }
        [Description("Used to set the Visible columns for a DataTable.\n" +
            "Set before setting DataMember.")]
        public Type ColumnList
        {
            get { return availableSelectedControl.ColumnList; }
            set { availableSelectedControl.ColumnList = value; }
        }

        #endregion
  

        public CriteriaRuleOutControl()
        {
            InitializeComponent();
            BindValueList();
        }

        public void PositionCurrencyManager(Int32 criteriaId)
        {
            CriteriaDS criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;
            _currencyManager.Position = criteriaDS.Criteria.Rows.IndexOf(criteriaDS.Criteria.FindByCriteriaID(criteriaId));
        
        }


        /// <summary>
        /// Bind data to UI
        /// </summary>
        public override void BindDataToUI()
        {
            criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;

            cbCriteriaGroup.DisplayMember = criteriaDS.Criteria.CriteriaGroupNameColumn.ColumnName;
            cbCriteriaGroup.ValueMember = criteriaDS.Criteria.CriteriaIDColumn.ColumnName;
            cbCriteriaGroup.DataSource = criteriaDS.Criteria.DefaultView;

            criteriaAgeMaleUpperUMv = new DataView(criteriaDS.CriteriaAgeUnit);
            criteriaAgeMaleLowerUMv = new DataView(criteriaDS.CriteriaAgeUnit);
            criteriaAgeFemaleUpperUMv = new DataView(criteriaDS.CriteriaAgeUnit);
            criteriaAgeFemaleLowerUMv = new DataView(criteriaDS.CriteriaAgeUnit);
            criteriaWeightMaleUpperUMv = new DataView(criteriaDS.CriteriaWeightUnit);
            criteriaWeightMaleLowerUMv = new DataView(criteriaDS.CriteriaWeightUnit);
            criteriaWeightFemaleUpperUMv = new DataView(criteriaDS.CriteriaWeightUnit);
            criteriaWeightFemaleLowerUMv = new DataView(criteriaDS.CriteriaWeightUnit);
            criteriaWeightFetalDemiseUpperUMv = new DataView(criteriaDS.CriteriaWeightUnit);
            criteriaWeightFetalDemiseLowerUMv = new DataView(criteriaDS.CriteriaWeightUnit);

            //Rule Out information
            string tableName = criteriaDS.Criteria.TableName.ToString();
            string criteriaAgeUnitName = "CriteriaAgeUnitName";
            string criteriaAgeUnitID = "CriteriaAgeUnitID";
            string criteriaWeightUnitName = "CriteriaWeightUnitName";
            string criteriaWeightUnitID = "CriteriaWeightUnitID";

            //Bind Age Unit of Measure
            cbAgeMaleLower.DisplayMember = criteriaAgeUnitName;
            cbAgeMaleLower.ValueMember = criteriaAgeUnitID;
            cbAgeMaleLower.DataSource = criteriaAgeMaleUpperUMv;

            cbAgeMaleUpper.DisplayMember = criteriaAgeUnitName;
            cbAgeMaleUpper.ValueMember = criteriaAgeUnitID;
            cbAgeMaleUpper.DataSource = criteriaAgeMaleLowerUMv;

            cbAgeFemaleUpper.DisplayMember = criteriaAgeUnitName;
            cbAgeFemaleUpper.ValueMember = criteriaAgeUnitID;
            cbAgeFemaleUpper.DataSource = criteriaAgeFemaleUpperUMv;

            cbAgeFemaleLower.DisplayMember = criteriaAgeUnitName;
            cbAgeFemaleLower.ValueMember = criteriaAgeUnitID;
            cbAgeFemaleLower.DataSource = criteriaAgeFemaleLowerUMv;
            
            //Bind Weight Unit of Measure
            cbMaleWeightUpper.DisplayMember = criteriaWeightUnitName;
            cbMaleWeightUpper.ValueMember = criteriaWeightUnitID;
            cbMaleWeightUpper.DataSource = criteriaWeightMaleUpperUMv;

            cbMaleWeightLower.DisplayMember = criteriaWeightUnitName;
            cbMaleWeightLower.ValueMember = criteriaWeightUnitID;
            cbMaleWeightLower.DataSource = criteriaWeightMaleLowerUMv;

            cbFemaleWeightUpper.DisplayMember = criteriaWeightUnitName;
            cbFemaleWeightUpper.ValueMember = criteriaWeightUnitID;
            cbFemaleWeightUpper.DataSource = criteriaWeightFemaleUpperUMv;

            cbFemaleWeightLower.DisplayMember = criteriaWeightUnitName;
            cbFemaleWeightLower.ValueMember = criteriaWeightUnitID;
            cbFemaleWeightLower.DataSource = criteriaWeightFemaleLowerUMv;

            cbFetalDemiseWeightUpper.DisplayMember = criteriaWeightUnitName;
            cbFetalDemiseWeightUpper.ValueMember = criteriaWeightUnitID;
            cbFetalDemiseWeightUpper.DataSource = criteriaWeightFetalDemiseUpperUMv;

            cbFetalDemiseWeightLower.DisplayMember = criteriaWeightUnitName;
            cbFetalDemiseWeightLower.ValueMember = criteriaWeightUnitID;
            cbFetalDemiseWeightLower.DataSource = criteriaWeightFetalDemiseLowerUMv;

            chkInactive.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.InactiveColumn.ColumnName);
            txtCriteriaGroupName.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaGroupNameColumn.ColumnName);
            chkMaleNotAppropriate.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaMaleNotAppropriateColumn.ColumnName);
            chkFemaleNotAppropriate.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFemaleNotAppropriateColumn.ColumnName);
            txtAgeMaleLower.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaMaleLowerAgeColumn.ColumnName);
            txtAgeMaleUpper.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaMaleUpperAgeColumn.ColumnName);
            txtAgeFemaleLower.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFemaleLowerAgeColumn.ColumnName);
            txtAgeFemaleUpper.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFemaleUpperAgeColumn.ColumnName);
            txtAgeFetalDemiseLower.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFetalDemiseLowerAgeColumn.ColumnName);
            txtAgeFetalDemiseUpper.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFetalDemiseUpperAgeColumn.ColumnName);

            txtMaleWeightLower.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaMaleLowerWeightColumn.ColumnName);
            txtMaleWeightUpper.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaMaleUpperWeightColumn.ColumnName);
            txtFemaleWeightLower.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFemaleLowerWeightColumn.ColumnName);
            txtFemaleWeightUpper.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFemaleUpperWeightColumn.ColumnName);
            txtFetalDemiseWeightLower.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFetalDemiseLowerAgeColumn.ColumnName);
            txtFetalDemiseWeightUpper.BindDataSet(criteriaDS, tableName, criteriaDS.Criteria.CriteriaFetalDemiseUpperAgeColumn.ColumnName);

            availableSelectedControl.DataMember = criteriaDS.CriteriaIndication.TableName;
            availableSelectedControl.ColumnList = typeof(CriteriaIndication);
            availableSelectedControl.DataSource = criteriaDS;


            _currencyManager = (CurrencyManager)BindingContext[criteriaDS, criteriaDS.Criteria.TableName];
        
        }

        private void BindValueList()
        {
            Hashtable paramList = new Hashtable();

            string criteriaCallTypeGroup = BaseConfiguration.GetSetting(SettingName.CriteriaCallTypeGroup);

            paramList.Add("CallTypeGroups", criteriaCallTypeGroup);
            cbCallType.BindData("CallTypeGroupListSelect", paramList);
            cbServiceLevel.BindData("ServiceLevelListSelect");
            cbTriageCategory.BindData("DonorCategoryListSelect");
        }

        private void lblFemaleWeightUpper_Click(object sender, EventArgs e)
        {

        }

        private void txtFemaleWeightUpper_TextChanged(object sender, EventArgs e)
        {

        }


        private void gbRuleOutIndications_Enter(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void cbCallType_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cbServiceLevel_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cbTriageCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Apply Triage Category filter 
            CriteriaDS criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;
            if (cbTriageCategory.SelectedIndex > 0)
            {
                GRConstant.DonorCategoryId = Convert.ToInt32(cbTriageCategory.SelectedValue);
                CriteriaFilter(criteriaDS);
            }
        }

        private void cbCriteriaGroup_SelectedIndexChanged(object sender, EventArgs e)
        {
            CriteriaDS criteriaDS = (CriteriaDS)BusinessRule.AssociatedDataSet;
            if (criteriaDS == null)
                return;
            if (cbCriteriaGroup.SelectedIndex > 0)
            {
                GRConstant.CriteriaId = Convert.ToInt32(cbCriteriaGroup.SelectedValue);
                //If the following is enabled, both sets of controls will be joined:
                _currencyManager.Position = criteriaDS.Criteria.Rows.IndexOf(criteriaDS.Criteria.FindByCriteriaID(Convert.ToInt32(cbCriteriaGroup.SelectedValue)));
            }

        }

        private void cbProcessorFSCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void CriteriaFilter(CriteriaDS criteriaDS)
        {
            string criteriaFilterString = string.Format("{0} = {1}",
                                                        criteriaDS.Criteria.DonorCategoryIDColumn.ColumnName,
                                                        GRConstant.DonorCategoryId
                                                        );

            criteriaDS.Criteria.DefaultView.RowFilter = criteriaFilterString;

        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            cbCallType.SelectedIndex = 0;
            cbServiceLevel.SelectedIndex = 0;
            cbTriageCategory.SelectedIndex = 0;
            cbCriteriaGroup.SelectedIndex = -1;
            cbProcessorFSCategory.SelectedIndex = -1;

        }
        public void RowFilter(int bands, string columnName, int fieldValue, FilterComparisionOperator filterComparisonOperator)
        {
            availableSelectedControl.RowFilter(bands, columnName, fieldValue, filterComparisonOperator);
        }
        private void btnSearch_Click(object sender, EventArgs e)
        {
            CriteriaBR criteriaBR = (CriteriaBR)BusinessRule;
            criteriaBR.SearchIndication();

        }
    }
}
