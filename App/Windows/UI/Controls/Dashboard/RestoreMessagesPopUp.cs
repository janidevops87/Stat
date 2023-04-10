using System;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Dashboard;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class RestoreMessagesPopUp : BaseForm
    {
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        public RestoreMessagesPopUp()
        {
            InitializeComponent();
            this.StartPosition = FormStartPosition.CenterScreen;
            BindDataToUIRecycleRestoreInfo();
            lblCallerNameData.Text = ugRestoreMessage.Rows[0].Cells["MessageCallerName"].Value.ToString();
            lblMsgForOrgData.Text = ugRestoreMessage.Rows[0].Cells["MessageCallerOrganization"].Value.ToString();
            lblCallerOrgData.Text = ugRestoreMessage.Rows[0].Cells["OrganizationName"].Value.ToString();
            lblTransCenterData.Text = ugRestoreMessage.Rows[0].Cells["SourceCodeName"].Value.ToString();
            lblUnosIDData.Text = ugRestoreMessage.Rows[0].Cells["MessageImportUNOSID"].Value.ToString();
            lblMsgImpNoData.Text = generalConstant.RecycleCallID.ToString();
            generalConstant.RestoreCall = false;
        }

        public void BindDataToUIRecycleRestoreInfo()
        {
            RestoreMessagesBR restoreMessagesBR = new RestoreMessagesBR();
            restoreMessagesBR.callID = generalConstant.RecycleCallID;
            recycledRestoreDS1 = (RecycledRestoreDS)restoreMessagesBR.SelectDataSet();
            ugRestoreMessage.DataMember = recycledRestoreDS1.RecycleRestoreMessagesList.TableName;
            ugRestoreMessage.DataSource = recycledRestoreDS1;
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
    }
}
