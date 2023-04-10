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
using Statline.Stattrac.Data.Types.Organization;
using System.Collections;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    public partial class RegistryControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private ScreenConfigNavigation screenConfigNavigation;
        private CurrencyManager _currencyManager;

        public ScreenConfigNavigation ScreenConfigNavigation
        {
            get { return screenConfigNavigation; }
            set { screenConfigNavigation = value; }
        }
        private int orgID = 0;
        public RegistryControl()
        {
            InitializeComponent();
            BusinessRule = new ScreenConfigBR();
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig), screenConfigDS.ScreenFieldAttribute);
        }

        public override void BindDataToUI()
        {
            string serviceLevelID = ScreenConfigNavigation.callBackScreenConfig();
            Hashtable paramList = new Hashtable();
            paramList.Add("ServiceLevelID", serviceLevelID);
            cbOrganization.BindData("OrganizationRegistryListSelect", paramList);

            cbDisplayRegistry.BindData("DisplayScreenListSelect");

            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            //ScreenConfigBR screenConfigBR = (ScreenConfigBR)BusinessRule;

            rbAlwaysDisplay.BindDataSet(screenConfigDS, "ServiceLevel", screenConfigDS.ServiceLevel.ServiceLevelAlwaysPopRegistryColumn.ColumnName);

            ultraGrid1.DataMember = screenConfigDS.ScreenFieldAttribute.TableName;
            ultraGrid1.DataSource = screenConfigDS;
            //string displayAll = ScreenConfigNavigation.callBackCKDisplayAll();
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Clear();
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, ScreenConstant.Screen.Registry);
            ////FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(questionGroup));
            //if (displayAll == "False")
            //{
            //    FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
            //    ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            //}
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Add(newfilter);
            
            _currencyManager = (CurrencyManager)BindingContext[screenConfigDS, screenConfigDS.ServiceLevel.TableName];
            _currencyManager.Position = screenConfigDS.ServiceLevel.Rows.IndexOf(screenConfigDS.ServiceLevel.FindByServiceLevelID(Convert.ToInt32(serviceLevelID)));
            txtDocument.BindDataSet(screenConfigDS, "ServiceLevel", screenConfigDS.ServiceLevel.ServiceLevelDonorIntentDocumentNameColumn.ColumnName);
            if (serviceLevelID != "0")
            {

                availableSelectedControl1.RowFilter(GRConstant.FirstRow,
                                               screenConfigDS.ServiceLevelDRDSN.ServiceLevelIDColumn.ColumnName,
                                               Convert.ToInt32(serviceLevelID), FilterComparisionOperator.Equals);
            }
            availableSelectedControl1.ColumnList = typeof(RegistryField);
            availableSelectedControl1.DataMember = screenConfigDS.ServiceLevelDRDSN.TableName;
            availableSelectedControl1.DataSource = screenConfigDS;
            
        }


        private void cbOrganization_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbOrganization.SelectedItem == null)
                return;
            if ((int)((DataRowView)cbOrganization.SelectedItem).Row[0] == 0)
                return;
            Hashtable paramList = new Hashtable();


            //set the orgID and reset the county
            orgID = (int)cbOrganization.SelectedValue;
            paramList.Add("OrganizationID", orgID);
            cbPerson.BindData("PersonListSelect", paramList);
        }

        private void cbDisplayMedHistory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
