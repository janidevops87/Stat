namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    partial class CriteriaTriageCriteriaControl
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
            this.chkInactive = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.chkDefaultGroupForSourceCode = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.txtCriteriaGroup = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblCriteriaGroup = new Statline.Stattrac.Windows.Forms.Label();
            this.criteriaRuleOutControl1 = new Statline.Stattrac.Windows.UI.Controls.Administration.Criteria.CriteriaRuleOutControl();
            this.SuspendLayout();
            // 
            // chkInactive
            // 
            this.chkInactive.AutoSize = true;
            this.chkInactive.Checked = false;
            this.chkInactive.Location = new System.Drawing.Point(105, 13);
            this.chkInactive.Name = "chkInactive";
            this.chkInactive.Size = new System.Drawing.Size(64, 17);
            this.chkInactive.TabIndex = 1;
            this.chkInactive.Text = "Inactive";
            this.chkInactive.UseVisualStyleBackColor = true;
            // 
            // chkDefaultGroupForSourceCode
            // 
            this.chkDefaultGroupForSourceCode.AutoSize = true;
            this.chkDefaultGroupForSourceCode.Checked = false;
            this.chkDefaultGroupForSourceCode.Location = new System.Drawing.Point(105, 37);
            this.chkDefaultGroupForSourceCode.Name = "chkDefaultGroupForSourceCode";
            this.chkDefaultGroupForSourceCode.Size = new System.Drawing.Size(172, 17);
            this.chkDefaultGroupForSourceCode.TabIndex = 2;
            this.chkDefaultGroupForSourceCode.Text = "Default Group for Source Code";
            this.chkDefaultGroupForSourceCode.UseVisualStyleBackColor = true;
            // 
            // txtCriteriaGroup
            // 
            this.txtCriteriaGroup.Location = new System.Drawing.Point(105, 61);
            this.txtCriteriaGroup.Name = "txtCriteriaGroup";
            this.txtCriteriaGroup.Required = false;
            this.txtCriteriaGroup.Size = new System.Drawing.Size(225, 20);
            this.txtCriteriaGroup.SpellCheckEnabled = false;
            this.txtCriteriaGroup.TabIndex = 3;
            // 
            // lblCriteriaGroup
            // 
            this.lblCriteriaGroup.AutoSize = true;
            this.lblCriteriaGroup.Location = new System.Drawing.Point(25, 64);
            this.lblCriteriaGroup.Name = "lblCriteriaGroup";
            this.lblCriteriaGroup.Size = new System.Drawing.Size(74, 13);
            this.lblCriteriaGroup.TabIndex = 4;
            this.lblCriteriaGroup.Text = "Criteria Group:";
            // 
            // criteriaRuleOutControl1
            // 
            this.criteriaRuleOutControl1.AutoScroll = true;
            this.criteriaRuleOutControl1.AutoScrollMargin = new System.Drawing.Size(0, 30);
            this.criteriaRuleOutControl1.AutoSize = true;
            this.criteriaRuleOutControl1.Location = new System.Drawing.Point(0, 87);
            this.criteriaRuleOutControl1.Name = "criteriaRuleOutControl1";
            this.criteriaRuleOutControl1.Size = new System.Drawing.Size(733, 673);
            this.criteriaRuleOutControl1.TabIndex = 0;
            // 
            // CriteriaTriageCriteriaControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.lblCriteriaGroup);
            this.Controls.Add(this.txtCriteriaGroup);
            this.Controls.Add(this.chkDefaultGroupForSourceCode);
            this.Controls.Add(this.chkInactive);
            this.Controls.Add(this.criteriaRuleOutControl1);
            this.Name = "CriteriaTriageCriteriaControl";
            this.Size = new System.Drawing.Size(757, 791);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private CriteriaRuleOutControl criteriaRuleOutControl1;
        private Statline.Stattrac.Windows.Forms.CheckBox chkInactive;
        private Statline.Stattrac.Windows.Forms.CheckBox chkDefaultGroupForSourceCode;
        private Statline.Stattrac.Windows.Forms.TextBox txtCriteriaGroup;
        private Statline.Stattrac.Windows.Forms.Label lblCriteriaGroup;

    }
}
