using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    public partial class ApplyScreenConfigControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private ScreenConfigNavigation screenConfigNavigation;
        public ScreenConfigNavigation ScreenConfigNavigation
        {
            get { return screenConfigNavigation; }
            set { screenConfigNavigation = value; }
        }

        public ApplyScreenConfigControl()
        {
            InitializeComponent();
        }

        //public override void BindDataToUI()
        //{
        //    string callType = ScreenConfigNavigation.callBackCallType();
        //}

        private void ultraGrid1_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {

        }
    }
}
