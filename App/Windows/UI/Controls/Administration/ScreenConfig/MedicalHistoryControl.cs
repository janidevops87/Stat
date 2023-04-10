﻿using System;
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
    public partial class MedicalHistoryControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {

        private ScreenConfigNavigation screenConfigNavigation;
        private CurrencyManager _currencyManager;

        public ScreenConfigNavigation ScreenConfigNavigation
        {
            get { return screenConfigNavigation; }
            set { screenConfigNavigation = value; }
        }

        public MedicalHistoryControl()
        {
            InitializeComponent();
            lblBasedonText.Text = "Display the following fields only if the vent\n";
            lblBasedonText.Text = lblBasedonText.Text + "status is Current or Previously:";
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig), screenConfigDS.ScreenFieldAttribute);
        }

        public override void BindDataToUI()
        {
            cbDisplayMedHistory.BindData("DisplayScreenListSelect");
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            ultraGrid1.DataMember = screenConfigDS.ScreenFieldAttribute.TableName;
            ultraGrid1.DataSource = screenConfigDS;
            //string displayAll = ScreenConfigNavigation.callBackCKDisplayAll();
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Clear();
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, ScreenConstant.Screen.MedicalHistory);
            ////FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(questionGroup));
            //if (displayAll == "False")
            //{
            //    FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
            //    ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            //}
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Add(newfilter);

            string serviceLevelID = ScreenConfigNavigation.callBackScreenConfig();
            _currencyManager = (CurrencyManager)BindingContext[screenConfigDS, screenConfigDS.ServiceLevel.TableName];
            _currencyManager.Position = screenConfigDS.ServiceLevel.Rows.IndexOf(screenConfigDS.ServiceLevel.FindByServiceLevelID(Convert.ToInt32(serviceLevelID)));
            
            chkAttending.BindDataSet(screenConfigDS, "ServiceLevel", screenConfigDS.ServiceLevel.ServiceLevelAttendingMDColumn.ColumnName);
            chkPronouncing.BindDataSet(screenConfigDS, "ServiceLevel", screenConfigDS.ServiceLevel.ServiceLevelPronouncingMDColumn.ColumnName);
        }
    }
}
