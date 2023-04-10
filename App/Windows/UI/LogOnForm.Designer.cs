namespace Statline.Stattrac.Windows.UI
{
	partial class LogOnForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(LogOnForm));
            this.lblId = new Statline.Stattrac.Windows.Forms.Label();
            this.lblPassword = new Statline.Stattrac.Windows.Forms.Label();
            this.lblExtension = new Statline.Stattrac.Windows.Forms.Label();
            this.lblDatabase = new Statline.Stattrac.Windows.Forms.Label();
            this.txtId = new Statline.Stattrac.Windows.Forms.TextBox();
            this.txtPassword = new Statline.Stattrac.Windows.Forms.TextBox();
            this.txtExtension = new Statline.Stattrac.Windows.Forms.TextBox();
            this.cblDatabase = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.btnExit = new Statline.Stattrac.Windows.Forms.Button();
            this.btnLogin = new Statline.Stattrac.Windows.Forms.Button();
            this.txtVersion = new Statline.Stattrac.Windows.Forms.Label();
            this.lblVersion = new Statline.Stattrac.Windows.Forms.Label();
            this.pnlControl = new Statline.Stattrac.Windows.Forms.Panel();
            this.pnlLogin = new Statline.Stattrac.Windows.Forms.Panel();
            this.pnlLoginOverride = new Statline.Stattrac.Windows.Forms.Panel();
            this.lblLoginOverrideUserNameValue = new Statline.Stattrac.Windows.Forms.Label();
            this.lblLoginOverideUserName = new Statline.Stattrac.Windows.Forms.Label();
            this.lblOverrideMessage = new Statline.Stattrac.Windows.Forms.Label();
            this.pnlControl.SuspendLayout();
            this.pnlLogin.SuspendLayout();
            this.pnlLoginOverride.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblId
            // 
            this.lblId.AutoSize = true;
            this.lblId.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblId.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblId.Location = new System.Drawing.Point(16, 22);
            this.lblId.Name = "lblId";
            this.lblId.Size = new System.Drawing.Size(63, 13);
            this.lblId.TabIndex = 0;
            this.lblId.Text = "User Name:";
            // 
            // lblPassword
            // 
            this.lblPassword.AutoSize = true;
            this.lblPassword.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblPassword.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblPassword.Location = new System.Drawing.Point(23, 72);
            this.lblPassword.Name = "lblPassword";
            this.lblPassword.Size = new System.Drawing.Size(57, 13);
            this.lblPassword.TabIndex = 1;
            this.lblPassword.Text = "Password:";
            // 
            // lblExtension
            // 
            this.lblExtension.AutoSize = true;
            this.lblExtension.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblExtension.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblExtension.Location = new System.Drawing.Point(23, 48);
            this.lblExtension.Name = "lblExtension";
            this.lblExtension.Size = new System.Drawing.Size(58, 13);
            this.lblExtension.TabIndex = 2;
            this.lblExtension.Text = "Extension:";
            // 
            // lblDatabase
            // 
            this.lblDatabase.AutoSize = true;
            this.lblDatabase.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblDatabase.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblDatabase.Location = new System.Drawing.Point(10, 74);
            this.lblDatabase.Name = "lblDatabase";
            this.lblDatabase.Size = new System.Drawing.Size(71, 13);
            this.lblDatabase.TabIndex = 3;
            this.lblDatabase.Text = "Environment:";
            // 
            // txtId
            // 
            this.txtId.Enabled = false;
            this.txtId.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtId.Location = new System.Drawing.Point(82, 19);
            this.txtId.Name = "txtId";
            this.txtId.Required = false;
            this.txtId.Size = new System.Drawing.Size(121, 20);
            this.txtId.SpellCheckEnabled = false;
            this.txtId.TabIndex = 4;
            this.txtId.TabStop = false;
            this.txtId.Leave += new System.EventHandler(this.txtId_Leave);
            // 
            // txtPassword
            // 
            this.txtPassword.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtPassword.ForeColor = System.Drawing.Color.Red;
            this.txtPassword.Location = new System.Drawing.Point(82, 72);
            this.txtPassword.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.Password;
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.PasswordChar = 'w';
            this.txtPassword.Required = false;
            this.txtPassword.Size = new System.Drawing.Size(121, 20);
            this.txtPassword.SpellCheckEnabled = false;
            this.txtPassword.TabIndex = 5;
            this.txtPassword.Enter += new System.EventHandler(this.txtPassword_Enter);
            // 
            // txtExtension
            // 
            this.txtExtension.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtExtension.Location = new System.Drawing.Point(82, 45);
            this.txtExtension.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.PositiveInteger;
            this.txtExtension.Name = "txtExtension";
            this.txtExtension.Required = false;
            this.txtExtension.Size = new System.Drawing.Size(55, 20);
            this.txtExtension.SpellCheckEnabled = false;
            this.txtExtension.TabIndex = 6;
            // 
            // cblDatabase
            // 
            this.cblDatabase.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cblDatabase.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cblDatabase.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cblDatabase.Font = new System.Drawing.Font("Tahoma", 8F);
            this.cblDatabase.FormattingEnabled = true;
            this.cblDatabase.Items.AddRange(new object[] {
            "Production",
            "Test",
            "Backup",
            "ProductionArchive",
            "Training"});
            this.cblDatabase.Location = new System.Drawing.Point(82, 71);
            this.cblDatabase.Name = "cblDatabase";
            this.cblDatabase.Required = false;
            this.cblDatabase.Size = new System.Drawing.Size(183, 21);
            this.cblDatabase.TabIndex = 7;
            // 
            // btnExit
            // 
            this.btnExit.Location = new System.Drawing.Point(191, 3);
            this.btnExit.Name = "btnExit";
            this.btnExit.Size = new System.Drawing.Size(75, 23);
            this.btnExit.TabIndex = 3;
            this.btnExit.Text = "E&xit";
            this.btnExit.UseVisualStyleBackColor = true;
            this.btnExit.Click += new System.EventHandler(this.btnExit_Click);
            // 
            // btnLogin
            // 
            this.btnLogin.Location = new System.Drawing.Point(108, 3);
            this.btnLogin.Name = "btnLogin";
            this.btnLogin.Size = new System.Drawing.Size(75, 23);
            this.btnLogin.TabIndex = 0;
            this.btnLogin.Text = "&Login";
            this.btnLogin.UseVisualStyleBackColor = true;
            this.btnLogin.Click += new System.EventHandler(this.btnLogin_Click);
            // 
            // txtVersion
            // 
            this.txtVersion.AutoSize = true;
            this.txtVersion.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtVersion.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtVersion.Location = new System.Drawing.Point(57, 27);
            this.txtVersion.Name = "txtVersion";
            this.txtVersion.Size = new System.Drawing.Size(35, 13);
            this.txtVersion.TabIndex = 10;
            this.txtVersion.Text = "label1";
            // 
            // lblVersion
            // 
            this.lblVersion.AutoSize = true;
            this.lblVersion.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblVersion.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblVersion.Location = new System.Drawing.Point(6, 27);
            this.lblVersion.Name = "lblVersion";
            this.lblVersion.Size = new System.Drawing.Size(46, 13);
            this.lblVersion.TabIndex = 11;
            this.lblVersion.Text = "Version:";
            // 
            // pnlControl
            // 
            this.pnlControl.Controls.Add(this.btnExit);
            this.pnlControl.Controls.Add(this.txtVersion);
            this.pnlControl.Controls.Add(this.lblVersion);
            this.pnlControl.Controls.Add(this.btnLogin);
            this.pnlControl.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.pnlControl.Location = new System.Drawing.Point(0, 110);
            this.pnlControl.Name = "pnlControl";
            this.pnlControl.Size = new System.Drawing.Size(285, 45);
            this.pnlControl.TabIndex = 2;
            // 
            // pnlLogin
            // 
            this.pnlLogin.Controls.Add(this.cblDatabase);
            this.pnlLogin.Controls.Add(this.lblExtension);
            this.pnlLogin.Controls.Add(this.lblDatabase);
            this.pnlLogin.Controls.Add(this.txtId);
            this.pnlLogin.Controls.Add(this.txtExtension);
            this.pnlLogin.Controls.Add(this.lblId);
            this.pnlLogin.Location = new System.Drawing.Point(1, 1);
            this.pnlLogin.Name = "pnlLogin";
            this.pnlLogin.Size = new System.Drawing.Size(283, 100);
            this.pnlLogin.TabIndex = 0;
            // 
            // pnlLoginOverride
            // 
            this.pnlLoginOverride.Controls.Add(this.lblLoginOverrideUserNameValue);
            this.pnlLoginOverride.Controls.Add(this.lblLoginOverideUserName);
            this.pnlLoginOverride.Controls.Add(this.lblOverrideMessage);
            this.pnlLoginOverride.Controls.Add(this.txtPassword);
            this.pnlLoginOverride.Controls.Add(this.lblPassword);
            this.pnlLoginOverride.Location = new System.Drawing.Point(1, 1);
            this.pnlLoginOverride.Name = "pnlLoginOverride";
            this.pnlLoginOverride.Size = new System.Drawing.Size(283, 100);
            this.pnlLoginOverride.TabIndex = 14;
            this.pnlLoginOverride.Visible = false;
            // 
            // lblLoginOverrideUserNameValue
            // 
            this.lblLoginOverrideUserNameValue.AutoSize = true;
            this.lblLoginOverrideUserNameValue.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblLoginOverrideUserNameValue.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblLoginOverrideUserNameValue.Location = new System.Drawing.Point(79, 49);
            this.lblLoginOverrideUserNameValue.Name = "lblLoginOverrideUserNameValue";
            this.lblLoginOverrideUserNameValue.Size = new System.Drawing.Size(0, 13);
            this.lblLoginOverrideUserNameValue.TabIndex = 17;
            // 
            // lblLoginOverideUserName
            // 
            this.lblLoginOverideUserName.AutoSize = true;
            this.lblLoginOverideUserName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblLoginOverideUserName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblLoginOverideUserName.Location = new System.Drawing.Point(16, 49);
            this.lblLoginOverideUserName.Name = "lblLoginOverideUserName";
            this.lblLoginOverideUserName.Size = new System.Drawing.Size(63, 13);
            this.lblLoginOverideUserName.TabIndex = 16;
            this.lblLoginOverideUserName.Text = "User Name:";
            // 
            // lblOverrideMessage
            // 
            this.lblOverrideMessage.AutoSize = true;
            this.lblOverrideMessage.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblOverrideMessage.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblOverrideMessage.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOverrideMessage.Location = new System.Drawing.Point(0, 0);
            this.lblOverrideMessage.Name = "lblOverrideMessage";
            this.lblOverrideMessage.Size = new System.Drawing.Size(291, 39);
            this.lblOverrideMessage.TabIndex = 15;
            this.lblOverrideMessage.Text = "You are attempting to log into StatTrac as a different user.\r\nPlease enter your p" +
    "assword for the user name displayed to\r\nverify you have this permission.";
            // 
            // LogOnForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(285, 155);
            this.Controls.Add(this.pnlControl);
            this.Controls.Add(this.pnlLogin);
            this.Controls.Add(this.pnlLoginOverride);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "LogOnForm";
            this.Text = "StatTrac Login";
            this.pnlControl.ResumeLayout(false);
            this.pnlControl.PerformLayout();
            this.pnlLogin.ResumeLayout(false);
            this.pnlLogin.PerformLayout();
            this.pnlLoginOverride.ResumeLayout(false);
            this.pnlLoginOverride.PerformLayout();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.Label lblId;
		private Statline.Stattrac.Windows.Forms.Label lblPassword;
		private Statline.Stattrac.Windows.Forms.Label lblExtension;
		private Statline.Stattrac.Windows.Forms.Label lblDatabase;
		private Statline.Stattrac.Windows.Forms.TextBox txtId;
		private Statline.Stattrac.Windows.Forms.TextBox txtPassword;
		private Statline.Stattrac.Windows.Forms.TextBox txtExtension;
		private Statline.Stattrac.Windows.Forms.ComboBox cblDatabase;
		private Statline.Stattrac.Windows.Forms.Button btnExit;
		private Statline.Stattrac.Windows.Forms.Button btnLogin;
		private Statline.Stattrac.Windows.Forms.Label txtVersion;
		private Statline.Stattrac.Windows.Forms.Label lblVersion;
        private Statline.Stattrac.Windows.Forms.Panel pnlControl;
        private Statline.Stattrac.Windows.Forms.Panel pnlLogin;
        private Statline.Stattrac.Windows.Forms.Panel pnlLoginOverride;
        private Statline.Stattrac.Windows.Forms.Label lblOverrideMessage;
        private Statline.Stattrac.Windows.Forms.Label lblLoginOverideUserName;
        private Statline.Stattrac.Windows.Forms.Label lblLoginOverrideUserNameValue;
	}
}
