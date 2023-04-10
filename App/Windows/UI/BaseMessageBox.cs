using System;
using System.Windows.Forms;

namespace Statline.Stattrac.Windows.UI
{
    public sealed class BaseMessageBox
    {
        private BaseMessageBox() { }


        public static void Show(string message, IWin32Window owner = null)
        {
            MessageBox.Show(owner, message, string.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error,
                MessageBoxDefaultButton.Button1);
        }

        public static DialogResult ShowYesNo(string message, string caption = "", MessageBoxDefaultButton defaultButton = MessageBoxDefaultButton.Button1, IWin32Window owner = null)
        {
            return MessageBox.Show(owner, message, caption, MessageBoxButtons.YesNo, MessageBoxIcon.Question, defaultButton);
        }

        public static DialogResult ShowOkCancel(string message, IWin32Window owner = null)
        {
            return MessageBox.Show(owner, message, string.Empty, MessageBoxButtons.OKCancel);
        }

        public static DialogResult ShowWarning(string message, string caption = "Warning", MessageBoxDefaultButton defaultButton = MessageBoxDefaultButton.Button1, IWin32Window owner = null)
        {
            return MessageBox.Show(owner, message, caption, MessageBoxButtons.OK, MessageBoxIcon.Warning, defaultButton);

        }
        public static void ShowError(string message, string caption = "Unexpected Error", IWin32Window owner = null)
        {
            MessageBox.Show(owner, message, caption, MessageBoxButtons.OK, MessageBoxIcon.Error,
                MessageBoxDefaultButton.Button1);
        }
        public static void ShowInformation(string message, string caption = "Information", IWin32Window owner = null)
        {
            MessageBox.Show(owner, message, caption, MessageBoxButtons.OK, MessageBoxIcon.Information,
                MessageBoxDefaultButton.Button1);

        }
        public static DialogResult ShowQuestion(string message, string caption = "Please Respond", IWin32Window owner = null)
        {
            return MessageBox.Show(owner, message, caption, MessageBoxButtons.OKCancel, MessageBoxIcon.Warning,
                MessageBoxDefaultButton.Button1);
        }


    }
}
