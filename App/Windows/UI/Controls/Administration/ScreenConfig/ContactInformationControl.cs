using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.ScreenConfig;
using Statline.Stattrac.BusinessRules.ScreenConfig;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;


namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    public partial class ContactInformationControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private ScreenConfigNavigation screenConfigNavigation;

        public ScreenConfigNavigation ScreenConfigNavigation
        {
            get { return screenConfigNavigation; }
            set { screenConfigNavigation = value; }
        }

        public ContactInformationControl()
        {
            InitializeComponent();
            //BusinessRule = new ScreenConfigBR();
            //BindDataToUI();
        }

        public override void BindDataToUI()
        {
            cbScreen.BindData("ScreenListSelect");
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            ultraGrid1.DataMember = screenConfigDS.ScreenFieldAttribute.TableName;
            ultraGrid1.DataSource = screenConfigDS;
            //string displayAll = ScreenConfigNavigation.callBackCKDisplayAll();
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Clear();
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, ScreenConstant.Screen.ContactInformation);
            ////FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(questionGroup));
            //if (displayAll == "False")
            //{
            //    FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
            //    ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            //}
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Add(newfilter);
            
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig), screenConfigDS.ScreenFieldAttribute);
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            turnOnAddBtn();
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            ScreenConfigDS.ScreenConfigRow row = screenConfigDS.ScreenConfig.NewScreenConfigRow();
            string serviceLevelID = ScreenConfigNavigation.callBackScreenConfig();
            row.ServiceLevelID = Convert.ToInt32(serviceLevelID);
            row.ScreenConfig = txtScreenConfig.Text;
            row.ScreenID = Convert.ToInt32(cbScreen.SelectedValue.ToString());
            row.LastModified = GRConstant.CurrentDateTime;
            row.Inactive = Convert.ToBoolean(chkInactive.Checked);
            screenConfigDS.ScreenConfig.Rows.Add(row);
        }

        public void turnOnAddBtn()
        {
            if (cbScreen.SelectedIndex < 1 || cbScreen.SelectedItem == null)
                return;
            string serviceLevelID = ScreenConfigNavigation.callBackScreenConfig();
            if (serviceLevelID == "0")
                return;
            if (string.IsNullOrEmpty(txtScreenConfig.Text))
                return;
            btnAdd.Enabled = true;
        }

        private void cbScreen_SelectedIndexChanged(object sender, EventArgs e)
        {
           turnOnAddBtn();
        }

        private void txtScreenConfig_TextChanged(object sender, EventArgs e)
        {
            turnOnAddBtn();
        }
    }
}
