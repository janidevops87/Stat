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
    public partial class AssociatedSourceCodeControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        
        private ScreenConfigNavigation screenConfigNavigation;
        public ScreenConfigNavigation ScreenConfigNavigation
        {
            get { return screenConfigNavigation; }
            set { screenConfigNavigation = value; }
        }

        public AssociatedSourceCodeControl()
        {
            InitializeComponent();
        }

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            const int band = 0;
            ultraGrid1.ColumnDisplay(band, typeof(SourceCodeAssociatedSourceCode), screenConfigDS.SourceCode);
        }

        public override void BindDataToUI()
        {
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            ultraGrid1.DataMember = screenConfigDS.SourceCode.TableName;
            ultraGrid1.DataSource = screenConfigDS;
            //string displayAll = ScreenConfigNavigation.callBackCKDisplayAll();
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["SourceCodeCallTypeID"].FilterConditions.Clear();
            string callTypeID = ScreenConfigNavigation.callBackCallType();
            //ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Clear();
            FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, callTypeID);
            ////FilterCondition newfilter1 = new FilterCondition(FilterComparisionOperator.Equals, (int)Convert.ToInt32(questionGroup));
            //if (displayAll == "False")
            //{
            //    FilterCondition newfilter2 = new FilterCondition(FilterComparisionOperator.Equals, 0);
            //    ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["Inactive"].FilterConditions.Add(newfilter2);
            //}
            ultraGrid1.DisplayLayout.Bands[0].ColumnFilters["SourceCodeCallTypeID"].FilterConditions.Add(newfilter);

        }
    }
}
