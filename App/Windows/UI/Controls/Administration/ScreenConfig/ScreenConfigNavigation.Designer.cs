namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    partial class ScreenConfigNavigation
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
            this.tabControl = new Statline.Stattrac.Windows.Forms.UltraTabControl();
            this.ultraTabSharedControlsPage1 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
            this.cbCallType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbScreenConfig = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.chkDisplayAll = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.btnApplyScreenConfig = new Statline.Stattrac.Windows.Forms.Button();
            this.lblScreenConfig = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCallType = new Statline.Stattrac.Windows.Forms.Label();
            this.pnlBody.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).BeginInit();
            this.tabControl.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlBody
            // 
            this.pnlBody.Controls.Add(this.lblCallType);
            this.pnlBody.Controls.Add(this.lblScreenConfig);
            this.pnlBody.Controls.Add(this.btnApplyScreenConfig);
            this.pnlBody.Controls.Add(this.chkDisplayAll);
            this.pnlBody.Controls.Add(this.cbScreenConfig);
            this.pnlBody.Controls.Add(this.cbCallType);
            this.pnlBody.Size = new System.Drawing.Size(962, 739);
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.ultraTabSharedControlsPage1);
            this.tabControl.Location = new System.Drawing.Point(3, 100);
            this.tabControl.Name = "tabControl";
            this.tabControl.SharedControlsPage = this.ultraTabSharedControlsPage1;
            this.tabControl.Size = new System.Drawing.Size(901, 544);
            this.tabControl.TabIndex = 0;
            // 
            // ultraTabSharedControlsPage1
            // 
            this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(2, 21);
            this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
            this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(897, 521);
            // 
            // cbCallType
            // 
            this.cbCallType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbCallType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbCallType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbCallType.FormattingEnabled = true;
            this.cbCallType.Location = new System.Drawing.Point(119, 22);
            this.cbCallType.Name = "cbCallType";
            this.cbCallType.Size = new System.Drawing.Size(311, 21);
            this.cbCallType.TabIndex = 0;
            this.cbCallType.SelectedIndexChanged += new System.EventHandler(this.cbCallType_SelectedIndexChanged);
            // 
            // cbScreenConfig
            // 
            this.cbScreenConfig.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbScreenConfig.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbScreenConfig.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbScreenConfig.FormattingEnabled = true;
            this.cbScreenConfig.Location = new System.Drawing.Point(119, 50);
            this.cbScreenConfig.Name = "cbScreenConfig";
            this.cbScreenConfig.Size = new System.Drawing.Size(311, 21);
            this.cbScreenConfig.TabIndex = 1;
            this.cbScreenConfig.SelectedIndexChanged += new System.EventHandler(this.cbScreenConfig_SelectedIndexChanged);
            // 
            // chkDisplayAll
            // 
            this.chkDisplayAll.AutoSize = true;
            this.chkDisplayAll.Checked = false;
            this.chkDisplayAll.Location = new System.Drawing.Point(119, 77);
            this.chkDisplayAll.Name = "chkDisplayAll";
            this.chkDisplayAll.Size = new System.Drawing.Size(181, 17);
            this.chkDisplayAll.TabIndex = 2;
            this.chkDisplayAll.Text = "Display All Screen Configurations";
            this.chkDisplayAll.UseVisualStyleBackColor = true;
            this.chkDisplayAll.CheckedChanged += new System.EventHandler(this.chkDisplayAll_CheckedChanged);
            // 
            // btnApplyScreenConfig
            // 
            this.btnApplyScreenConfig.Location = new System.Drawing.Point(455, 47);
            this.btnApplyScreenConfig.Name = "btnApplyScreenConfig";
            this.btnApplyScreenConfig.Size = new System.Drawing.Size(225, 23);
            this.btnApplyScreenConfig.TabIndex = 3;
            this.btnApplyScreenConfig.Text = "Apply Screen Configuration Multiple Screens";
            this.btnApplyScreenConfig.UseVisualStyleBackColor = true;
            this.btnApplyScreenConfig.Click += new System.EventHandler(this.btnApplyScreenConfig_Click);
            // 
            // lblScreenConfig
            // 
            this.lblScreenConfig.AutoSize = true;
            this.lblScreenConfig.Location = new System.Drawing.Point(4, 57);
            this.lblScreenConfig.Name = "lblScreenConfig";
            this.lblScreenConfig.Size = new System.Drawing.Size(109, 13);
            this.lblScreenConfig.TabIndex = 4;
            this.lblScreenConfig.Text = "Screen Configuration:";
            // 
            // lblCallType
            // 
            this.lblCallType.AutoSize = true;
            this.lblCallType.Location = new System.Drawing.Point(50, 27);
            this.lblCallType.Name = "lblCallType";
            this.lblCallType.Size = new System.Drawing.Size(54, 13);
            this.lblCallType.TabIndex = 5;
            this.lblCallType.Text = "Call Type:";
            // 
            // ScreenConfigNavigation
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.tabControl);
            this.Name = "ScreenConfigNavigation";
            this.Size = new System.Drawing.Size(962, 765);
            this.Controls.SetChildIndex(this.pnlBody, 0);
            this.Controls.SetChildIndex(this.tabControl, 0);
            this.pnlBody.ResumeLayout(false);
            this.pnlBody.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).EndInit();
            this.tabControl.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.UltraTabControl tabControl;
        private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;
        private Statline.Stattrac.Windows.Forms.Label lblCallType;
        private Statline.Stattrac.Windows.Forms.Label lblScreenConfig;
        private Statline.Stattrac.Windows.Forms.Button btnApplyScreenConfig;
        private Statline.Stattrac.Windows.Forms.CheckBox chkDisplayAll;
        private Statline.Stattrac.Windows.Forms.ComboBox cbScreenConfig;
        private Statline.Stattrac.Windows.Forms.ComboBox cbCallType;
    }
}
