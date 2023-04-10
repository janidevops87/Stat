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
    public partial class UpdateControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public UpdateControl()
        {
            InitializeComponent();
        }

        private void cbDisplayUpdate_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cbEventType_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.ScreenConfig), screenConfigDS.ScreenFieldAttribute);
        }

        public override void BindDataToUI()
        {
            cbDisplayUpdate.BindData("DisplayScreenListSelect");
            cbEventType.BindData("LogEventTypeListSelect");
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            ultraGrid1.DataMember = screenConfigDS.ScreenFieldAttribute.TableName;
            ultraGrid1.DataSource = screenConfigDS;
            //string displayAll = ScreenConfigNavigation.callBackCKDisplayAll();
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Clear();
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, ScreenConstant.Screen.Update);
            ////FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(questionGroup));
            //if (displayAll == "False")
            //{
            //    FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
            //    ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            //}
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["ScreenID"].FilterConditions.Add(newfilter);
            ScreenConfigBR screenConfigBR = (ScreenConfigBR)BusinessRule;
            screenConfigBR.SelectScreenField(Convert.ToInt32(ScreenConstant.Screen.Update));
            
            //if (callTypeID != "0")
            //{

            //    availableSelectedControl2.RowFilter(GRConstant.FirstRow,
            //                                   screenConfigDS.DRDSN.ServiceLevelIDColumn.ColumnName,
            //                                   Convert.ToInt32(callTypeID), FilterComparisionOperator.Equals);
            //}
            availableSelectedControl1.ColumnList = typeof(ScreenFields);
            availableSelectedControl1.DataMember = screenConfigDS.ScreenField.TableName;
            availableSelectedControl1.DataSource = screenConfigDS;
        }
    }
}
