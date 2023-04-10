using System;
using Statline.Stattrac.Constant;
using System.Windows.Forms;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class RestoreOASISPopUp : BaseForm
    {
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        public RestoreOASISPopUp()
        {
            InitializeComponent();
            this.StartPosition = FormStartPosition.CenterScreen;
            BindDataToUIRecycleRestoreInfo();
            generalConstant.RestoreCall = false;
        }
        public void BindDataToUIRecycleRestoreInfo()
        {
            lblMatchIDData.Text = generalConstant.OasisMatchID;
            lblOPTNData.Text = generalConstant.OasisOPTN;
            lblOrganData.Text = generalConstant.OasisOrgan;
            lblOasisNoData.Text = generalConstant.RecycleCallID.ToString();
        }
        private void btnRestoreCase_Click(object sender, EventArgs e)
        {
            DialogResult dialogResult = BaseMessageBox.ShowYesNo(
                    "Are you sure you want to restore this call");
            switch (dialogResult)
            {
                case DialogResult.Yes:
                    generalConstant.RestoreCall = true;
                    Close();
                    break;
                default:
                    break;
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            generalConstant.RestoreCall = false;
            Close();
        }
    }
}
