namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    partial class CriteriaFSUpdateControl
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.panel = new Statline.Stattrac.Windows.Forms.Panel();
            this.cbProcessorFSCategory = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblProcessorFSCategory = new Statline.Stattrac.Windows.Forms.Label();
            this.chkFamilyServicesCategoryNotUsedForProcessor = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.tabControl = new Statline.Stattrac.Windows.Forms.UltraTabControl();
            this.ultraTabSharedControlsPage1 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
            this.panel.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).BeginInit();
            this.tabControl.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel
            // 
            this.panel.Controls.Add(this.cbProcessorFSCategory);
            this.panel.Controls.Add(this.lblProcessorFSCategory);
            this.panel.Controls.Add(this.chkFamilyServicesCategoryNotUsedForProcessor);
            this.panel.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel.Location = new System.Drawing.Point(0, 0);
            this.panel.Name = "panel";
            this.panel.Size = new System.Drawing.Size(876, 44);
            this.panel.TabIndex = 0;
            // 
            // cbProcessorFSCategory
            // 
            this.cbProcessorFSCategory.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbProcessorFSCategory.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbProcessorFSCategory.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbProcessorFSCategory.FormattingEnabled = true;
            this.cbProcessorFSCategory.Location = new System.Drawing.Point(129, 15);
            this.cbProcessorFSCategory.Name = "cbProcessorFSCategory";
            this.cbProcessorFSCategory.Size = new System.Drawing.Size(247, 21);
            this.cbProcessorFSCategory.TabIndex = 2;
            // 
            // lblProcessorFSCategory
            // 
            this.lblProcessorFSCategory.AutoSize = true;
            this.lblProcessorFSCategory.Location = new System.Drawing.Point(3, 19);
            this.lblProcessorFSCategory.Name = "lblProcessorFSCategory";
            this.lblProcessorFSCategory.Size = new System.Drawing.Size(120, 13);
            this.lblProcessorFSCategory.TabIndex = 1;
            this.lblProcessorFSCategory.Text = "Processor/FS Category:";
            // 
            // chkFamilyServicesCategoryNotUsedForProcessor
            // 
            this.chkFamilyServicesCategoryNotUsedForProcessor.AutoSize = true;
            this.chkFamilyServicesCategoryNotUsedForProcessor.Checked = false;
            this.chkFamilyServicesCategoryNotUsedForProcessor.Location = new System.Drawing.Point(390, 18);
            this.chkFamilyServicesCategoryNotUsedForProcessor.Name = "chkFamilyServicesCategoryNotUsedForProcessor";
            this.chkFamilyServicesCategoryNotUsedForProcessor.Size = new System.Drawing.Size(257, 17);
            this.chkFamilyServicesCategoryNotUsedForProcessor.TabIndex = 0;
            this.chkFamilyServicesCategoryNotUsedForProcessor.Text = "Family Services Category Not Used for Processor";
            this.chkFamilyServicesCategoryNotUsedForProcessor.UseVisualStyleBackColor = true;
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.ultraTabSharedControlsPage1);
            this.tabControl.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl.Location = new System.Drawing.Point(0, 44);
            this.tabControl.Name = "tabControl";
            this.tabControl.SharedControlsPage = this.ultraTabSharedControlsPage1;
            this.tabControl.Size = new System.Drawing.Size(876, 541);
            this.tabControl.TabIndex = 1;
            // 
            // ultraTabSharedControlsPage1
            // 
            this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(1, 20);
            this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
            this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(872, 518);
            // 
            // CriteriaFSUpdateControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.tabControl);
            this.Controls.Add(this.panel);
            this.Name = "CriteriaFSUpdateControl";
            this.Load += new System.EventHandler(this.CriteriaFSUpdateControl_Load);
            this.panel.ResumeLayout(false);
            this.panel.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).EndInit();
            this.tabControl.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Panel panel;
        private Statline.Stattrac.Windows.Forms.CheckBox chkFamilyServicesCategoryNotUsedForProcessor;
        private Statline.Stattrac.Windows.Forms.ComboBox cbProcessorFSCategory;
        private Statline.Stattrac.Windows.Forms.Label lblProcessorFSCategory;
        private Statline.Stattrac.Windows.Forms.UltraTabControl tabControl;
        private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;
    }
}
