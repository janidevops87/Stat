namespace Statline.Stattrac.Windows.Controls.Common
{
    partial class ReportIssueFeedback
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.txtComment = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblComment = new Statline.Stattrac.Windows.Forms.Label();
            this.btnSubmitComment = new Statline.Stattrac.Windows.Forms.Button();
            this.pnlThankYou = new Statline.Stattrac.Windows.Forms.Panel();
            this.lblThankYou = new Statline.Stattrac.Windows.Forms.Label();
            this.pnlInitial = new Statline.Stattrac.Windows.Forms.Panel();
            this.pnlThankYou.SuspendLayout();
            this.pnlInitial.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtComment
            // 
            this.txtComment.Location = new System.Drawing.Point(32, 54);
            this.txtComment.MaxLength = 1000;
            this.txtComment.Multiline = true;
            this.txtComment.Name = "txtComment";
            this.txtComment.Required = false;
            this.txtComment.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtComment.Size = new System.Drawing.Size(367, 123);
            this.txtComment.SpellCheckEnabled = false;
            this.txtComment.TabIndex = 0;
            // 
            // lblComment
            // 
            this.lblComment.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblComment.Location = new System.Drawing.Point(32, 28);
            this.lblComment.Name = "lblComment";
            this.lblComment.Size = new System.Drawing.Size(367, 20);
            this.lblComment.TabIndex = 1;
            this.lblComment.Text = "Please add comments or information helpful to resolve or identify an issue.";
            // 
            // btnSubmitComment
            // 
            this.btnSubmitComment.Location = new System.Drawing.Point(32, 183);
            this.btnSubmitComment.Name = "btnSubmitComment";
            this.btnSubmitComment.Size = new System.Drawing.Size(367, 23);
            this.btnSubmitComment.TabIndex = 2;
            this.btnSubmitComment.Text = "Submit Comment";
            this.btnSubmitComment.UseVisualStyleBackColor = true;
            this.btnSubmitComment.Click += new System.EventHandler(this.btnSubmitComment_Click);
            // 
            // pnlThankYou
            // 
            this.pnlThankYou.Controls.Add(this.lblThankYou);
            this.pnlThankYou.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlThankYou.Location = new System.Drawing.Point(0, 0);
            this.pnlThankYou.Name = "pnlThankYou";
            this.pnlThankYou.Size = new System.Drawing.Size(502, 258);
            this.pnlThankYou.TabIndex = 3;
            this.pnlThankYou.Visible = false;
            // 
            // lblThankYou
            // 
            this.lblThankYou.AutoSize = true;
            this.lblThankYou.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblThankYou.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblThankYou.Location = new System.Drawing.Point(90, 96);
            this.lblThankYou.Name = "lblThankYou";
            this.lblThankYou.Size = new System.Drawing.Size(323, 13);
            this.lblThankYou.TabIndex = 0;
            this.lblThankYou.Text = "Thank you for your feedback, we appreciate your input.";
            // 
            // pnlInitial
            // 
            this.pnlInitial.Controls.Add(this.btnSubmitComment);
            this.pnlInitial.Controls.Add(this.lblComment);
            this.pnlInitial.Controls.Add(this.txtComment);
            this.pnlInitial.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlInitial.Location = new System.Drawing.Point(0, 0);
            this.pnlInitial.Name = "pnlInitial";
            this.pnlInitial.Size = new System.Drawing.Size(502, 258);
            this.pnlInitial.TabIndex = 4;
            // 
            // ReportIssueFeedback
            // 
            this.Controls.Add(this.pnlInitial);
            this.Controls.Add(this.pnlThankYou);
            this.Name = "ReportIssueFeedback";
            this.Size = new System.Drawing.Size(502, 258);
            this.pnlThankYou.ResumeLayout(false);
            this.pnlThankYou.PerformLayout();
            this.pnlInitial.ResumeLayout(false);
            this.pnlInitial.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.TextBox txtComment;
        private Statline.Stattrac.Windows.Forms.Label lblComment;
        private Statline.Stattrac.Windows.Forms.Button btnSubmitComment;
        private Statline.Stattrac.Windows.Forms.Panel pnlThankYou;
        private Statline.Stattrac.Windows.Forms.Panel pnlInitial;
        private Statline.Stattrac.Windows.Forms.Label lblThankYou;
    }
}
