namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    partial class QuestionGroupsControl
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
            this.lblQuestionGroup = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCallType = new Statline.Stattrac.Windows.Forms.Label();
            this.cbQuestionGroup = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbCallType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.chkDisplayAllQuestionGroup = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.pnlBody.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).BeginInit();
            this.tabControl.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlBody
            // 
            this.pnlBody.AutoScroll = true;
            this.pnlBody.AutoSize = true;
            this.pnlBody.Controls.Add(this.lblQuestionGroup);
            this.pnlBody.Controls.Add(this.lblCallType);
            this.pnlBody.Controls.Add(this.cbQuestionGroup);
            this.pnlBody.Controls.Add(this.cbCallType);
            this.pnlBody.Controls.Add(this.chkDisplayAllQuestionGroup);
            this.pnlBody.Controls.Add(this.tabControl);
            this.pnlBody.Size = new System.Drawing.Size(872, 1736);
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.ultraTabSharedControlsPage1);
            this.tabControl.Location = new System.Drawing.Point(3, 100);
            this.tabControl.Name = "tabControl";
            this.tabControl.SharedControlsPage = this.ultraTabSharedControlsPage1;
            this.tabControl.Size = new System.Drawing.Size(858, 1099);
            this.tabControl.TabIndex = 0;
            this.tabControl.SelectedTabChanged += new Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventHandler(this.tabControl_SelectedTabChanged);
            // 
            // ultraTabSharedControlsPage1
            // 
            this.ultraTabSharedControlsPage1.AutoScroll = true;
            this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(2, 21);
            this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
            this.ultraTabSharedControlsPage1.RightToLeft = System.Windows.Forms.RightToLeft.No;
            this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(854, 1076);
            // 
            // lblQuestionGroup
            // 
            this.lblQuestionGroup.AutoSize = true;
            this.lblQuestionGroup.Location = new System.Drawing.Point(4, 57);
            this.lblQuestionGroup.Name = "lblQuestionGroup";
            this.lblQuestionGroup.Size = new System.Drawing.Size(84, 13);
            this.lblQuestionGroup.TabIndex = 9;
            this.lblQuestionGroup.Text = "Question Group:";
            // 
            // lblCallType
            // 
            this.lblCallType.AutoSize = true;
            this.lblCallType.Location = new System.Drawing.Point(34, 30);
            this.lblCallType.Name = "lblCallType";
            this.lblCallType.Size = new System.Drawing.Size(54, 13);
            this.lblCallType.TabIndex = 8;
            this.lblCallType.Text = "Call Type:";
            // 
            // cbQuestionGroup
            // 
            this.cbQuestionGroup.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbQuestionGroup.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbQuestionGroup.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbQuestionGroup.FormattingEnabled = true;
            this.cbQuestionGroup.Location = new System.Drawing.Point(94, 49);
            this.cbQuestionGroup.Name = "cbQuestionGroup";
            this.cbQuestionGroup.Size = new System.Drawing.Size(311, 21);
            this.cbQuestionGroup.TabIndex = 7;
            this.cbQuestionGroup.SelectedIndexChanged += new System.EventHandler(this.cbQuestionGroup_SelectedIndexChanged);
            // 
            // cbCallType
            // 
            this.cbCallType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbCallType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbCallType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbCallType.FormattingEnabled = true;
            this.cbCallType.Location = new System.Drawing.Point(94, 22);
            this.cbCallType.Name = "cbCallType";
            this.cbCallType.Size = new System.Drawing.Size(311, 21);
            this.cbCallType.TabIndex = 6;
            this.cbCallType.SelectedIndexChanged += new System.EventHandler(this.cbCallType_SelectedIndexChanged);
            // 
            // chkDisplayAllQuestionGroup
            // 
            this.chkDisplayAllQuestionGroup.AutoSize = true;
            this.chkDisplayAllQuestionGroup.Checked = false;
            this.chkDisplayAllQuestionGroup.Location = new System.Drawing.Point(94, 76);
            this.chkDisplayAllQuestionGroup.Name = "chkDisplayAllQuestionGroup";
            this.chkDisplayAllQuestionGroup.Size = new System.Drawing.Size(156, 17);
            this.chkDisplayAllQuestionGroup.TabIndex = 10;
            this.chkDisplayAllQuestionGroup.Text = "Display All Question Groups";
            this.chkDisplayAllQuestionGroup.UseVisualStyleBackColor = true;
            this.chkDisplayAllQuestionGroup.CheckedChanged += new System.EventHandler(this.chkDisplayAllQuestionGroup_CheckedChanged);
            // 
            // QuestionGroupsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScroll = true;
            this.AutoSize = true;
            this.Name = "QuestionGroupsControl";
            this.Size = new System.Drawing.Size(872, 1736);
            this.pnlBody.ResumeLayout(false);
            this.pnlBody.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).EndInit();
            this.tabControl.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.UltraTabControl tabControl;
        private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;
        private Statline.Stattrac.Windows.Forms.Label lblQuestionGroup;
        private Statline.Stattrac.Windows.Forms.Label lblCallType;
        private Statline.Stattrac.Windows.Forms.ComboBox cbQuestionGroup;
        private Statline.Stattrac.Windows.Forms.ComboBox cbCallType;
        private Statline.Stattrac.Windows.Forms.CheckBox chkDisplayAllQuestionGroup;
    }
}
