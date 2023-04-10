using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Windows.UI;
using System.Drawing.Imaging;
using System.IO;
using System.Net.Mail;
using System.Reflection;
using System.Net;

namespace Statline.Stattrac.Windows.Controls.Common
{
    public partial class ReportIssueFeedback : Statline.Stattrac.Windows.UI.BaseUserControl
    {
        private ReportIssueFeedbackHelper reportIssueFeedbackHelper;
        public ReportIssueFeedback()
        {
            
            InitializeComponent();
            pnlThankYou.Visible = false;
            pnlInitial.Visible = true;
        }
        
        /// <summary>
        /// 1. Get a list of open forms
        /// 2. Take a snapshot of each screen
        /// 3. Create and Send the Email Message
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnSubmitComment_Click(object sender, EventArgs e)
        {
            pnlThankYou.Visible = true;
            pnlInitial.Visible = false;
            
            reportIssueFeedbackHelper = new ReportIssueFeedbackHelper();

            FindForm().Opacity = 0.01;
            Boolean successful =  reportIssueFeedbackHelper.SendReport(txtComment.Text);
            FindForm().Opacity = 1;
            
            if (!successful)
                lblThankYou.Text = "We were unable to send your message;";
            Refresh();

            //Wait for the the user to see the thank you.
            System.Threading.Thread.Sleep(750);
            
            NavigateBackToParent();

        }
        /// <summary>
        /// Navigate Back To Parent Control
        /// </summary>
        protected void NavigateBackToParent()
        {
                ((BaseForm)FindForm()).Close();

        }

    }
}
