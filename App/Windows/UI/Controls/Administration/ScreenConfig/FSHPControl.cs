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
    public partial class FSHPControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public FSHPControl()
        {
            InitializeComponent();
            BusinessRule = new ScreenConfigBR();
            BindDataToUI();
        }
        
        public override void BindDataToUI()
        {
            cbDisplayAutopsy.BindData("DisplayScreenListSelect");
            cbDisplayCoronerME.BindData("DisplayScreenListSelect");
            cbDisplayCultures.BindData("DisplayScreenListSelect");
            cbDisplayMeds.BindData("DisplayScreenListSelect");
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            ScreenConfigBR screenConfigBR = (ScreenConfigBR)BusinessRule;

            screenConfigBR.SelectScreen(Convert.ToInt32(ScreenConstant.Screen.FSHP));
            ultraGrid1.DataMember = screenConfigDS.ScreenFieldAttribute.TableName;
            ultraGrid1.DataSource = screenConfigDS;

            screenConfigBR.SelectScreen(Convert.ToInt32(ScreenConstant.Screen.FSLabProfile));
            ultraGrid2.DataMember = screenConfigDS.ScreenFieldAttribute.TableName;
            ultraGrid2.DataSource = screenConfigDS;

            screenConfigBR.SelectScreen(Convert.ToInt32(ScreenConstant.Screen.FSCulture));
            ultraGrid3.DataMember = screenConfigDS.ScreenFieldAttribute.TableName;
            ultraGrid3.DataSource = screenConfigDS;

            screenConfigBR.SelectScreen(Convert.ToInt32(ScreenConstant.Screen.FSMedications));
            ultraGrid4.DataMember = screenConfigDS.ScreenFieldAttribute.TableName;
            ultraGrid4.DataSource = screenConfigDS;
            //string displayAll = ScreenConfigNavigation.callBackCKDisplayAll();
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Clear();
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            //FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, 2);
            ////FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(questionGroup));
            //if (displayAll == "False")
            //{
            //    FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
            //    ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            //}
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Add(newfilter);
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig), screenConfigDS.ScreenFieldAttribute);
        }

        private void ultraGrid2_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid2.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig), screenConfigDS.ScreenFieldAttribute);
        }

        private void ultraGrid4_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid4.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig), screenConfigDS.ScreenFieldAttribute);
        }

        private void ultraGrid3_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid3.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig), screenConfigDS.ScreenFieldAttribute);
        }
    }
}
