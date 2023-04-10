using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.ScreenConfig;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.ScreenConfig;
using Infragistics.Win.UltraWinGrid;


namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    public partial class OtherEventLogControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private ScreenConfigNavigation screenConfigNavigation;

        public ScreenConfigNavigation ScreenConfigNavigation
        {
            get { return screenConfigNavigation; }
            set { screenConfigNavigation = value; }
        }

        public OtherEventLogControl()
        {
            InitializeComponent();
        }
        public override void BindDataToUI()
        {
            string screenid = "99";
            Hashtable paramList = new Hashtable();
            string callTypeID = ScreenConfigNavigation.callBackCallType();
            switch (callTypeID)
            {
                case "2":
                    screenid = Convert.ToInt32(ScreenConstant.Screen.MsgEventLog).ToString();
                    break;
                case "4":
                    screenid = Convert.ToInt32(ScreenConstant.Screen.IOOtherEventLog).ToString();
                    break;
                case "6":
                    screenid = Convert.ToInt32(ScreenConstant.Screen.TCEventLog).ToString();
                    break;
                default:
                    screenid = "99";
                    break;
            }

            paramList.Add("ScreenID", screenid);
            cbInclude.BindData("ScreenConfigListSelect", paramList);
        }

        private void cbInclude_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbInclude.SelectedIndex < 1 || cbInclude.SelectedItem == null)
                return;
            ScreenConfigDS screenConfigDS = (ScreenConfigDS)BusinessRule.AssociatedDataSet;
            //string callTypeID = ScreenConfigNavigation.callBackCallType();

            //call screen config for event log
            ScreenConfigBR screenConfigBR = (ScreenConfigBR)BusinessRule;
            screenConfigBR.SelectScreenField(Convert.ToInt32(cbInclude.SelectedValue.ToString()));
            
            //if (callTypeID != "0")
            //{

            //    availableSelectedControl2.RowFilter(GRConstant.FirstRow,
            //                                   screenConfigDS.DRDSN.ServiceLevelIDColumn.ColumnName,
            //                                   Convert.ToInt32(callTypeID), FilterComparisionOperator.Equals);
            //}
            availableSelectedControl2.ColumnList = typeof(ScreenFields);
            availableSelectedControl2.DataMember = screenConfigDS.ScreenField.TableName;
            availableSelectedControl2.DataSource = screenConfigDS;
        }
    }
}
