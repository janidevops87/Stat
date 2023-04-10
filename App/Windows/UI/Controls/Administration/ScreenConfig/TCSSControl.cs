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
    public partial class TCSSControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public TCSSControl()
        {
            InitializeComponent();
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(TCSS), screenConfigDS.TcssListVitalSign);
            e.Layout.Bands[0].Columns["FieldValue"].CellActivation = Activation.NoEdit;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {

        }

        private void ultraGrid2_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid2.ColumnDisplay(band, typeof(TCSS), screenConfigDS.TcssListLab);
            e.Layout.Bands[0].Columns["FieldValue"].CellActivation = Activation.NoEdit;
        }

        public override void BindDataToUI()
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            ScreenConfigBR screenConfigBR = (ScreenConfigBR)BusinessRule;
            screenConfigBR.SelectVitalSigns(0);
            screenConfigBR.SelectLabProfile(0);

            ultraGrid1.DataMember = screenConfigDS.TcssListVitalSign.TableName;
            ultraGrid1.DataSource = screenConfigDS;

            ultraGrid2.DataMember = screenConfigDS.TcssListLab.TableName;
            ultraGrid2.DataSource = screenConfigDS;
            //string displayAll = ScreenConfigNavigation.callBackCKDisplayAll();
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Clear();
            ////ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            ////int screenValue = ScreenConstant.Screen.NextofKin;
            //FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, ScreenConstant.Screen.NextofKin);
            ////FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(questionGroup));
            //if (displayAll == "False")
            //{
            //    FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
            //    ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            //}
            
        }
    }
}
