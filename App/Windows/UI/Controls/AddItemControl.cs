using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig;
using Statline.Stattrac.Constant;


namespace Statline.Stattrac.Windows.UI
{
    public partial class AddItemControl : Statline.Stattrac.Windows.UI.BaseUserControl
    {
        //if you use this control, follow the moreDataControl example to call back to your parent
        private MoreDataControl moreDataControl;
        //private Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig.MoreDataControl moreDataControl;
        public MoreDataControl MoreDataControl
        {
            get { return moreDataControl; }
            set { moreDataControl = value; }
        }
        public AddItemControl()
        {
            InitializeComponent();
            textBox1.Text = null;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            this.Hide();
            GRConstant.ComboBoxValue = textBox1.Text;
            moreDataControl.addItem();

        }
    }
}
