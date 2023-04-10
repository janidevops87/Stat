using System;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Dashboard;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class RestoreCasesPopUp : BaseForm
    {
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        public RestoreCasesPopUp()
        {
            InitializeComponent();
            BindDataToUIRecycleRestoreInfo();
            this.StartPosition = FormStartPosition.CenterScreen;
            lblFirstNameData.Text = ugRestoreCase.Rows[0].Cells["ReferralDonorFirstName"].Value.ToString();
            lblLastNameData.Text = ugRestoreCase.Rows[0].Cells["ReferralDonorLastName"].Value.ToString();
            lblMiddleIntData.Text = ugRestoreCase.Rows[0].Cells["ReferralDonorNameMI"].Value.ToString();
            lblMedRecordData.Text = ugRestoreCase.Rows[0].Cells["ReferralDonorRecNumber"].Value.ToString();
            lblReferralNoData.Text = generalConstant.RecycleCallID.ToString();
            generalConstant.RestoreCall = false;
        }

        public void BindDataToUIRecycleRestoreInfo()
        {
            RestoreCasesBR restoreCasesBR = new RestoreCasesBR();
            restoreCasesBR.callID = generalConstant.RecycleCallID;
            recycledRestoreDS1 = (RecycledRestoreDS)restoreCasesBR.SelectDataSet();
            ugRestoreCase.DataMember = recycledRestoreDS1.RecycleRestoreList.TableName;
            ugRestoreCase.DataSource = recycledRestoreDS1;
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
        {//set to false just in case
            generalConstant.RestoreCall = false;
            Close();
        }

        private void ugRestoreCase_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {

        }
    }
}
