using System;
using Statline.Stattrac.Constant;
using System.Windows.Forms;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    
    public partial class DeleteCasesPopUp : BaseForm
    {
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        public DeleteCasesPopUp()
        {
            InitializeComponent();
            this.StartPosition = FormStartPosition.CenterScreen;
            generalConstant.DeleteCall = false;
            if (generalConstant.DeletePatientFirstName == "Test" && generalConstant.DeletePatientLastName == "Test")
            {
                label1.Visible = false;
                textBox1.Visible = false;
            }
        }

        private void btnDeleteCase_Click(object sender, EventArgs e)
        {//test,test doesn't need any reason
            if (generalConstant.DeletePatientFirstName == "Test" && generalConstant.DeletePatientLastName == "Test")
            {
                generalConstant.DeleteCall = true;
                generalConstant.DeleteReason = textBox1.Text;
                Close();
            }
            else
            {//everyone else does
                if (!String.IsNullOrEmpty(textBox1.Text))
                {
                    generalConstant.DeleteCall = true;
                    generalConstant.DeleteReason = textBox1.Text;
                    Close();
                }
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            generalConstant.DeleteCall = false;
            Close();
        }
    }
}
