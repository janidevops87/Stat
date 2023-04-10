namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    partial class CriteriaEditManager
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
            this.panel1 = new Statline.Stattrac.Windows.Forms.Panel();
            this.cbCriteriaGroup = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbTriageCategory = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbServiceLevel = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbCallType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.chkDisplayAllCriteraGroups = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.btnApplyCriteriaToMultipleGroups = new Statline.Stattrac.Windows.Forms.Button();
            this.lblCriteriaGroup = new Statline.Stattrac.Windows.Forms.Label();
            this.btnAdd = new Statline.Stattrac.Windows.Forms.Button();
            this.lblTriageCategory = new Statline.Stattrac.Windows.Forms.Label();
            this.lblServiceLevel = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCallType = new Statline.Stattrac.Windows.Forms.Label();
            this.tabControl = new Statline.Stattrac.Windows.Forms.UltraTabControl();
            this.ultraTabSharedControlsPage1 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
            this.pnlBody.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).BeginInit();
            this.tabControl.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlBody
            // 
            this.pnlBody.Controls.Add(this.tabControl);
            this.pnlBody.Controls.Add(this.panel1);
            this.pnlBody.Paint += new System.Windows.Forms.PaintEventHandler(this.pnlBody_Paint);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.cbCriteriaGroup);
            this.panel1.Controls.Add(this.cbTriageCategory);
            this.panel1.Controls.Add(this.cbServiceLevel);
            this.panel1.Controls.Add(this.cbCallType);
            this.panel1.Controls.Add(this.chkDisplayAllCriteraGroups);
            this.panel1.Controls.Add(this.btnApplyCriteriaToMultipleGroups);
            this.panel1.Controls.Add(this.lblCriteriaGroup);
            this.panel1.Controls.Add(this.btnAdd);
            this.panel1.Controls.Add(this.lblTriageCategory);
            this.panel1.Controls.Add(this.lblServiceLevel);
            this.panel1.Controls.Add(this.lblCallType);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(843, 138);
            this.panel1.TabIndex = 1;
            // 
            // cbCriteriaGroup
            // 
            this.cbCriteriaGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbCriteriaGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbCriteriaGroup.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbCriteriaGroup.FormattingEnabled = true;
            this.cbCriteriaGroup.Location = new System.Drawing.Point(95, 83);
            this.cbCriteriaGroup.Name = "cbCriteriaGroup";
            this.cbCriteriaGroup.Size = new System.Drawing.Size(200, 21);
            this.cbCriteriaGroup.TabIndex = 11;
            this.cbCriteriaGroup.SelectedIndexChanged += new System.EventHandler(this.cbCriteriaGroup_SelectedIndexChanged);
            // 
            // cbTriageCategory
            // 
            this.cbTriageCategory.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbTriageCategory.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbTriageCategory.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbTriageCategory.FormattingEnabled = true;
            this.cbTriageCategory.Location = new System.Drawing.Point(95, 58);
            this.cbTriageCategory.Name = "cbTriageCategory";
            this.cbTriageCategory.Size = new System.Drawing.Size(200, 21);
            this.cbTriageCategory.TabIndex = 10;
            this.cbTriageCategory.SelectedIndexChanged += new System.EventHandler(this.cbTriageCategory_SelectedIndexChanged);
            // 
            // cbServiceLevel
            // 
            this.cbServiceLevel.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbServiceLevel.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbServiceLevel.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbServiceLevel.FormattingEnabled = true;
            this.cbServiceLevel.Location = new System.Drawing.Point(95, 33);
            this.cbServiceLevel.Name = "cbServiceLevel";
            this.cbServiceLevel.Size = new System.Drawing.Size(200, 21);
            this.cbServiceLevel.TabIndex = 9;
            this.cbServiceLevel.SelectedIndexChanged += new System.EventHandler(this.cbServiceLevel_SelectedIndexChanged);
            // 
            // cbCallType
            // 
            this.cbCallType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbCallType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbCallType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbCallType.FormattingEnabled = true;
            this.cbCallType.Location = new System.Drawing.Point(95, 8);
            this.cbCallType.Name = "cbCallType";
            this.cbCallType.Size = new System.Drawing.Size(200, 21);
            this.cbCallType.TabIndex = 8;
            this.cbCallType.SelectedIndexChanged += new System.EventHandler(this.cbCallType_SelectedIndexChanged);
            // 
            // chkDisplayAllCriteraGroups
            // 
            this.chkDisplayAllCriteraGroups.AutoSize = true;
            this.chkDisplayAllCriteraGroups.Checked = false;
            this.chkDisplayAllCriteraGroups.Location = new System.Drawing.Point(95, 110);
            this.chkDisplayAllCriteraGroups.Name = "chkDisplayAllCriteraGroups";
            this.chkDisplayAllCriteraGroups.Size = new System.Drawing.Size(146, 17);
            this.chkDisplayAllCriteraGroups.TabIndex = 7;
            this.chkDisplayAllCriteraGroups.Text = "Display All Criteria Groups";
            this.chkDisplayAllCriteraGroups.UseVisualStyleBackColor = true;
            // 
            // btnApplyCriteriaToMultipleGroups
            // 
            this.btnApplyCriteriaToMultipleGroups.Location = new System.Drawing.Point(350, 81);
            this.btnApplyCriteriaToMultipleGroups.Name = "btnApplyCriteriaToMultipleGroups";
            this.btnApplyCriteriaToMultipleGroups.Size = new System.Drawing.Size(187, 23);
            this.btnApplyCriteriaToMultipleGroups.TabIndex = 6;
            this.btnApplyCriteriaToMultipleGroups.Text = "Apply Criteria to Multiple Groups";
            this.btnApplyCriteriaToMultipleGroups.UseVisualStyleBackColor = true;
            // 
            // lblCriteriaGroup
            // 
            this.lblCriteriaGroup.AutoSize = true;
            this.lblCriteriaGroup.Location = new System.Drawing.Point(15, 91);
            this.lblCriteriaGroup.Name = "lblCriteriaGroup";
            this.lblCriteriaGroup.Size = new System.Drawing.Size(74, 13);
            this.lblCriteriaGroup.TabIndex = 4;
            this.lblCriteriaGroup.Text = "Criteria Group:";
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(301, 81);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(43, 23);
            this.btnAdd.TabIndex = 3;
            this.btnAdd.Text = "Add";
            this.btnAdd.UseVisualStyleBackColor = true;
            // 
            // lblTriageCategory
            // 
            this.lblTriageCategory.AutoSize = true;
            this.lblTriageCategory.Location = new System.Drawing.Point(4, 66);
            this.lblTriageCategory.Name = "lblTriageCategory";
            this.lblTriageCategory.Size = new System.Drawing.Size(85, 13);
            this.lblTriageCategory.TabIndex = 2;
            this.lblTriageCategory.Text = "Triage Category:";
            // 
            // lblServiceLevel
            // 
            this.lblServiceLevel.AutoSize = true;
            this.lblServiceLevel.Location = new System.Drawing.Point(14, 43);
            this.lblServiceLevel.Name = "lblServiceLevel";
            this.lblServiceLevel.Size = new System.Drawing.Size(75, 13);
            this.lblServiceLevel.TabIndex = 1;
            this.lblServiceLevel.Text = "Service Level:";
            // 
            // lblCallType
            // 
            this.lblCallType.AutoSize = true;
            this.lblCallType.Location = new System.Drawing.Point(35, 16);
            this.lblCallType.Name = "lblCallType";
            this.lblCallType.Size = new System.Drawing.Size(54, 13);
            this.lblCallType.TabIndex = 0;
            this.lblCallType.Text = "Call Type:";
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.ultraTabSharedControlsPage1);
            this.tabControl.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl.Location = new System.Drawing.Point(0, 138);
            this.tabControl.Name = "tabControl";
            this.tabControl.SharedControlsPage = this.ultraTabSharedControlsPage1;
            this.tabControl.Size = new System.Drawing.Size(843, 363);
            this.tabControl.TabIndex = 2;
            // 
            // ultraTabSharedControlsPage1
            // 
            this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(1, 20);
            this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
            this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(839, 340);
            // 
            // CriteriaEditManager
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Name = "CriteriaEditManager";
            this.pnlBody.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).EndInit();
            this.tabControl.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Panel panel1;
        private Statline.Stattrac.Windows.Forms.UltraTabControl tabControl;
        private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;
        private Statline.Stattrac.Windows.Forms.Label lblCallType;
        private Statline.Stattrac.Windows.Forms.CheckBox chkDisplayAllCriteraGroups;
        private Statline.Stattrac.Windows.Forms.Button btnApplyCriteriaToMultipleGroups;
        private Statline.Stattrac.Windows.Forms.Label lblCriteriaGroup;
        private Statline.Stattrac.Windows.Forms.Button btnAdd;
        private Statline.Stattrac.Windows.Forms.Label lblTriageCategory;
        private Statline.Stattrac.Windows.Forms.Label lblServiceLevel;
        private Statline.Stattrac.Windows.Forms.ComboBox cbCriteriaGroup;
        private Statline.Stattrac.Windows.Forms.ComboBox cbTriageCategory;
        private Statline.Stattrac.Windows.Forms.ComboBox cbServiceLevel;
        private Statline.Stattrac.Windows.Forms.ComboBox cbCallType;
    }
}
