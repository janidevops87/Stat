namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class ContactPermissionMainControl
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
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.lblContactFirstName = new Statline.Stattrac.Windows.Forms.Label();
            this.lblContactLastName = new Statline.Stattrac.Windows.Forms.Label();
            this.tabControl = new Statline.Stattrac.Windows.Forms.UltraTabControl();
            this.ultraTabSharedControlsPage1 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
            this.panel1 = new Statline.Stattrac.Windows.Forms.Panel();
            this.groupBox1 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.groupBox2 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.panelPasswordInvalid = new Statline.Stattrac.Windows.Forms.Panel();
            this.label3 = new Statline.Stattrac.Windows.Forms.Label();
            this.lblPasswordInvalid = new Statline.Stattrac.Windows.Forms.Label();
            this.chkBoxStatTracLogin = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.txtBoxPasswordConfirm = new Statline.Stattrac.Windows.Forms.MaskedTextBox();
            this.txtBoxWebPassword = new Statline.Stattrac.Windows.Forms.MaskedTextBox();
            this.label2 = new Statline.Stattrac.Windows.Forms.Label();
            this.txtBoxUserName = new Statline.Stattrac.Windows.Forms.TextBox();
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            this.flowLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).BeginInit();
            this.tabControl.SuspendLayout();
            this.panel1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.panelPasswordInvalid.SuspendLayout();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.SuspendLayout();
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.flowLayoutPanel1.Controls.Add(this.lblContactFirstName);
            this.flowLayoutPanel1.Controls.Add(this.lblContactLastName);
            this.flowLayoutPanel1.Location = new System.Drawing.Point(5, 12);
            this.flowLayoutPanel1.Margin = new System.Windows.Forms.Padding(0, 3, 3, 3);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(230, 13);
            this.flowLayoutPanel1.TabIndex = 9;
            // 
            // lblContactFirstName
            // 
            this.lblContactFirstName.AutoSize = true;
            this.lblContactFirstName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblContactFirstName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblContactFirstName.Location = new System.Drawing.Point(3, 0);
            this.lblContactFirstName.Margin = new System.Windows.Forms.Padding(3, 0, 0, 0);
            this.lblContactFirstName.Name = "lblContactFirstName";
            this.lblContactFirstName.Size = new System.Drawing.Size(20, 13);
            this.lblContactFirstName.TabIndex = 0;
            this.lblContactFirstName.Text = "FN";
            // 
            // lblContactLastName
            // 
            this.lblContactLastName.AutoSize = true;
            this.lblContactLastName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblContactLastName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblContactLastName.Location = new System.Drawing.Point(23, 0);
            this.lblContactLastName.Margin = new System.Windows.Forms.Padding(0, 0, 3, 0);
            this.lblContactLastName.Name = "lblContactLastName";
            this.lblContactLastName.Size = new System.Drawing.Size(19, 13);
            this.lblContactLastName.TabIndex = 0;
            this.lblContactLastName.Text = "LN";
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.ultraTabSharedControlsPage1);
            this.tabControl.Location = new System.Drawing.Point(0, 0);
            this.tabControl.Margin = new System.Windows.Forms.Padding(3, 5, 3, 3);
            this.tabControl.Name = "tabControl";
            this.tabControl.SharedControlsPage = this.ultraTabSharedControlsPage1;
            this.tabControl.Size = new System.Drawing.Size(566, 484);
            this.tabControl.TabIndex = 0;
            // 
            // ultraTabSharedControlsPage1
            // 
            this.ultraTabSharedControlsPage1.AutoScroll = true;
            this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(1, 20);
            this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
            this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(562, 461);
            this.ultraTabSharedControlsPage1.Tag = "";
            // 
            // panel1
            // 
            this.panel1.AutoScroll = true;
            this.panel1.Controls.Add(this.tabControl);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(3, 16);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(627, 484);
            this.panel1.TabIndex = 11;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.panel1);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox1.Location = new System.Drawing.Point(0, 0);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(633, 503);
            this.groupBox1.TabIndex = 12;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Security Access";
            // 
            // groupBox2
            // 
            this.groupBox2.AutoSize = true;
            this.groupBox2.Controls.Add(this.panelPasswordInvalid);
            this.groupBox2.Controls.Add(this.chkBoxStatTracLogin);
            this.groupBox2.Controls.Add(this.txtBoxPasswordConfirm);
            this.groupBox2.Controls.Add(this.txtBoxWebPassword);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.txtBoxUserName);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBox2.Location = new System.Drawing.Point(0, 0);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(633, 79);
            this.groupBox2.TabIndex = 13;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Login";
            // 
            // panelPasswordInvalid
            // 
            this.panelPasswordInvalid.Controls.Add(this.label3);
            this.panelPasswordInvalid.Controls.Add(this.lblPasswordInvalid);
            this.panelPasswordInvalid.Location = new System.Drawing.Point(302, 32);
            this.panelPasswordInvalid.Name = "panelPasswordInvalid";
            this.panelPasswordInvalid.Size = new System.Drawing.Size(309, 41);
            this.panelPasswordInvalid.TabIndex = 4;
            this.panelPasswordInvalid.Visible = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Dock = System.Windows.Forms.DockStyle.Top;
            this.label3.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label3.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label3.Location = new System.Drawing.Point(0, 19);
            this.label3.Margin = new System.Windows.Forms.Padding(3);
            this.label3.Name = "label3";
            this.label3.Padding = new System.Windows.Forms.Padding(0, 3, 0, 3);
            this.label3.Size = new System.Drawing.Size(85, 19);
            this.label3.TabIndex = 5;
            this.label3.Text = "Please re-enter.";
            // 
            // lblPasswordInvalid
            // 
            this.lblPasswordInvalid.AutoSize = true;
            this.lblPasswordInvalid.Dock = System.Windows.Forms.DockStyle.Top;
            this.lblPasswordInvalid.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblPasswordInvalid.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblPasswordInvalid.Location = new System.Drawing.Point(0, 0);
            this.lblPasswordInvalid.Margin = new System.Windows.Forms.Padding(3);
            this.lblPasswordInvalid.Name = "lblPasswordInvalid";
            this.lblPasswordInvalid.Padding = new System.Windows.Forms.Padding(0, 3, 0, 3);
            this.lblPasswordInvalid.Size = new System.Drawing.Size(267, 19);
            this.lblPasswordInvalid.TabIndex = 4;
            this.lblPasswordInvalid.Text = "The Web or Confirmation Password entered is invalid. ";
            // 
            // chkBoxStatTracLogin
            // 
            this.chkBoxStatTracLogin.AutoSize = true;
            this.chkBoxStatTracLogin.Checked = false;
            this.chkBoxStatTracLogin.Font = new System.Drawing.Font("Tahoma", 8F);
            this.chkBoxStatTracLogin.Location = new System.Drawing.Point(198, 29);
            this.chkBoxStatTracLogin.Name = "chkBoxStatTracLogin";
            this.chkBoxStatTracLogin.Size = new System.Drawing.Size(95, 17);
            this.chkBoxStatTracLogin.TabIndex = 1;
            this.chkBoxStatTracLogin.Text = "StatTrac Login";
            this.chkBoxStatTracLogin.UseVisualStyleBackColor = true;
            this.chkBoxStatTracLogin.CheckedChanged += new System.EventHandler(this.chkBoxStatTracLogin_CheckedChanged);
            // 
            // txtBoxPasswordConfirm
            // 
            this.txtBoxPasswordConfirm.Location = new System.Drawing.Point(196, 51);
            this.txtBoxPasswordConfirm.Name = "txtBoxPasswordConfirm";
            this.txtBoxPasswordConfirm.Size = new System.Drawing.Size(100, 20);
            this.txtBoxPasswordConfirm.TabIndex = 3;
            this.txtBoxPasswordConfirm.UseSystemPasswordChar = true;
            this.txtBoxPasswordConfirm.Validating += new System.ComponentModel.CancelEventHandler(this.WebPassword_Validating);
            this.txtBoxPasswordConfirm.TextChanged += new System.EventHandler(this.WebPassword_TextChanged);
            // 
            // txtBoxWebPassword
            // 
            this.txtBoxWebPassword.Location = new System.Drawing.Point(91, 51);
            this.txtBoxWebPassword.Name = "txtBoxWebPassword";
            this.txtBoxWebPassword.Size = new System.Drawing.Size(100, 20);
            this.txtBoxWebPassword.TabIndex = 2;
            this.txtBoxWebPassword.UseSystemPasswordChar = true;
            this.txtBoxWebPassword.Validating += new System.ComponentModel.CancelEventHandler(this.WebPassword_Validating);
            this.txtBoxWebPassword.TextChanged += new System.EventHandler(this.WebPassword_TextChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label2.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label2.Location = new System.Drawing.Point(11, 55);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(82, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Web Password:";
            // 
            // txtBoxUserName
            // 
            this.txtBoxUserName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtBoxUserName.Location = new System.Drawing.Point(91, 27);
            this.txtBoxUserName.Name = "txtBoxUserName";
            this.txtBoxUserName.Required = false;
            this.txtBoxUserName.Size = new System.Drawing.Size(100, 20);
            this.txtBoxUserName.SpellCheckEnabled = false;
            this.txtBoxUserName.TabIndex = 0;
            this.txtBoxUserName.Leave += new System.EventHandler(this.txtBoxUserName_Leave);
            this.txtBoxUserName.Validating += new System.ComponentModel.CancelEventHandler(this.txtBoxUserName_Validating);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label1.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label1.Location = new System.Drawing.Point(30, 31);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(63, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "User Name:";
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.flowLayoutPanel1);
            this.splitContainer1.Panel1.Controls.Add(this.groupBox2);
            this.splitContainer1.Panel1MinSize = 75;
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.groupBox1);
            this.splitContainer1.Size = new System.Drawing.Size(633, 586);
            this.splitContainer1.SplitterDistance = 79;
            this.splitContainer1.TabIndex = 14;
            // 
            // ContactPermissionMainControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoSize = true;
            this.Controls.Add(this.splitContainer1);
            this.Location = new System.Drawing.Point(3, 15);
            this.Name = "ContactPermissionMainControl";
            this.Size = new System.Drawing.Size(633, 586);
            this.flowLayoutPanel1.ResumeLayout(false);
            this.flowLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).EndInit();
            this.tabControl.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.panelPasswordInvalid.ResumeLayout(false);
            this.panelPasswordInvalid.PerformLayout();
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel1.PerformLayout();
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private Statline.Stattrac.Windows.Forms.Label lblContactFirstName;
        private Statline.Stattrac.Windows.Forms.Label lblContactLastName;
        private Statline.Stattrac.Windows.Forms.UltraTabControl tabControl;
        private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;
        private Statline.Stattrac.Windows.Forms.Panel panel1;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox1;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox2;
        private Statline.Stattrac.Windows.Forms.MaskedTextBox txtBoxWebPassword;
        private Statline.Stattrac.Windows.Forms.Label label2;
        private Statline.Stattrac.Windows.Forms.TextBox txtBoxUserName;
        private Statline.Stattrac.Windows.Forms.Label label1;
        private Statline.Stattrac.Windows.Forms.MaskedTextBox txtBoxPasswordConfirm;
        private System.Windows.Forms.SplitContainer splitContainer1;
        private Statline.Stattrac.Windows.Forms.CheckBox chkBoxStatTracLogin;
        private Statline.Stattrac.Windows.Forms.Label lblPasswordInvalid;
        private Statline.Stattrac.Windows.Forms.Panel panelPasswordInvalid;
        private Statline.Stattrac.Windows.Forms.Label label3;

    }
}
