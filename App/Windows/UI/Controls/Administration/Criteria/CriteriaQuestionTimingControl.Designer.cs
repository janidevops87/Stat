namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    partial class CriteriaQuestionTimingControl
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
            this.gbQuestionTiming = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.cbUpdateField = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.txtTo = new Statline.Stattrac.Windows.Forms.TextBox();
            this.txtSpecifiedTimeRange = new Statline.Stattrac.Windows.Forms.TextBox();
            this.cbDateTimeType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbQuestionTiming = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblTo = new Statline.Stattrac.Windows.Forms.Label();
            this.lblSpecifiedTimeRange = new Statline.Stattrac.Windows.Forms.Label();
            this.lblUpdateField = new Statline.Stattrac.Windows.Forms.Label();
            this.lblDateTimeType = new Statline.Stattrac.Windows.Forms.Label();
            this.lblQuestionTiming = new Statline.Stattrac.Windows.Forms.Label();
            this.lblScreenWhereQuestionsDisplayed = new Statline.Stattrac.Windows.Forms.Label();
            this.cbScreenWhereQuestionsDisplayed = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.gbQuestionTiming.SuspendLayout();
            this.SuspendLayout();
            // 
            // gbQuestionTiming
            // 
            this.gbQuestionTiming.Controls.Add(this.cbUpdateField);
            this.gbQuestionTiming.Controls.Add(this.txtTo);
            this.gbQuestionTiming.Controls.Add(this.txtSpecifiedTimeRange);
            this.gbQuestionTiming.Controls.Add(this.cbDateTimeType);
            this.gbQuestionTiming.Controls.Add(this.cbQuestionTiming);
            this.gbQuestionTiming.Controls.Add(this.lblTo);
            this.gbQuestionTiming.Controls.Add(this.lblSpecifiedTimeRange);
            this.gbQuestionTiming.Controls.Add(this.lblUpdateField);
            this.gbQuestionTiming.Controls.Add(this.lblDateTimeType);
            this.gbQuestionTiming.Controls.Add(this.lblQuestionTiming);
            this.gbQuestionTiming.Location = new System.Drawing.Point(3, 41);
            this.gbQuestionTiming.Name = "gbQuestionTiming";
            this.gbQuestionTiming.Size = new System.Drawing.Size(655, 117);
            this.gbQuestionTiming.TabIndex = 4;
            this.gbQuestionTiming.TabStop = false;
            this.gbQuestionTiming.Text = "Question Timing";
            this.gbQuestionTiming.Enter += new System.EventHandler(this.gbQuestionTiming_Enter);
            // 
            // cbUpdateField
            // 
            this.cbUpdateField.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbUpdateField.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbUpdateField.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbUpdateField.FormattingEnabled = true;
            this.cbUpdateField.Location = new System.Drawing.Point(132, 73);
            this.cbUpdateField.Name = "cbUpdateField";
            this.cbUpdateField.Size = new System.Drawing.Size(121, 21);
            this.cbUpdateField.TabIndex = 9;
            this.cbUpdateField.SelectedIndexChanged += new System.EventHandler(this.comboBox3_SelectedIndexChanged);
            // 
            // txtTo
            // 
            this.txtTo.AcceptsReturn = true;
            this.txtTo.Location = new System.Drawing.Point(592, 47);
            this.txtTo.Name = "txtTo";
            this.txtTo.Required = false;
            this.txtTo.Size = new System.Drawing.Size(40, 20);
            this.txtTo.SpellCheckEnabled = false;
            this.txtTo.TabIndex = 8;
            // 
            // txtSpecifiedTimeRange
            // 
            this.txtSpecifiedTimeRange.AcceptsReturn = true;
            this.txtSpecifiedTimeRange.Location = new System.Drawing.Point(519, 46);
            this.txtSpecifiedTimeRange.Name = "txtSpecifiedTimeRange";
            this.txtSpecifiedTimeRange.Required = false;
            this.txtSpecifiedTimeRange.Size = new System.Drawing.Size(40, 20);
            this.txtSpecifiedTimeRange.SpellCheckEnabled = false;
            this.txtSpecifiedTimeRange.TabIndex = 7;
            // 
            // cbDateTimeType
            // 
            this.cbDateTimeType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbDateTimeType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbDateTimeType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbDateTimeType.FormattingEnabled = true;
            this.cbDateTimeType.Location = new System.Drawing.Point(132, 46);
            this.cbDateTimeType.Name = "cbDateTimeType";
            this.cbDateTimeType.Size = new System.Drawing.Size(256, 21);
            this.cbDateTimeType.TabIndex = 6;
            // 
            // cbQuestionTiming
            // 
            this.cbQuestionTiming.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbQuestionTiming.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbQuestionTiming.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbQuestionTiming.FormattingEnabled = true;
            this.cbQuestionTiming.Location = new System.Drawing.Point(132, 19);
            this.cbQuestionTiming.Name = "cbQuestionTiming";
            this.cbQuestionTiming.Size = new System.Drawing.Size(500, 21);
            this.cbQuestionTiming.TabIndex = 5;
            // 
            // lblTo
            // 
            this.lblTo.AutoSize = true;
            this.lblTo.Location = new System.Drawing.Point(570, 50);
            this.lblTo.Name = "lblTo";
            this.lblTo.Size = new System.Drawing.Size(16, 13);
            this.lblTo.TabIndex = 4;
            this.lblTo.Text = "to";
            // 
            // lblSpecifiedTimeRange
            // 
            this.lblSpecifiedTimeRange.AutoSize = true;
            this.lblSpecifiedTimeRange.Location = new System.Drawing.Point(404, 49);
            this.lblSpecifiedTimeRange.Name = "lblSpecifiedTimeRange";
            this.lblSpecifiedTimeRange.Size = new System.Drawing.Size(109, 13);
            this.lblSpecifiedTimeRange.TabIndex = 3;
            this.lblSpecifiedTimeRange.Text = "SpecifiedTimeRange:";
            // 
            // lblUpdateField
            // 
            this.lblUpdateField.AutoSize = true;
            this.lblUpdateField.Location = new System.Drawing.Point(56, 76);
            this.lblUpdateField.Name = "lblUpdateField";
            this.lblUpdateField.Size = new System.Drawing.Size(70, 13);
            this.lblUpdateField.TabIndex = 2;
            this.lblUpdateField.Text = "Update Field:";
            // 
            // lblDateTimeType
            // 
            this.lblDateTimeType.AutoSize = true;
            this.lblDateTimeType.Location = new System.Drawing.Point(38, 50);
            this.lblDateTimeType.Name = "lblDateTimeType";
            this.lblDateTimeType.Size = new System.Drawing.Size(88, 13);
            this.lblDateTimeType.TabIndex = 1;
            this.lblDateTimeType.Text = "Date/Time Type:";
            // 
            // lblQuestionTiming
            // 
            this.lblQuestionTiming.AutoSize = true;
            this.lblQuestionTiming.Location = new System.Drawing.Point(40, 22);
            this.lblQuestionTiming.Name = "lblQuestionTiming";
            this.lblQuestionTiming.Size = new System.Drawing.Size(86, 13);
            this.lblQuestionTiming.TabIndex = 0;
            this.lblQuestionTiming.Text = "Question Timing:";
            // 
            // lblScreenWhereQuestionsDisplayed
            // 
            this.lblScreenWhereQuestionsDisplayed.AutoSize = true;
            this.lblScreenWhereQuestionsDisplayed.Location = new System.Drawing.Point(3, 17);
            this.lblScreenWhereQuestionsDisplayed.Name = "lblScreenWhereQuestionsDisplayed";
            this.lblScreenWhereQuestionsDisplayed.Size = new System.Drawing.Size(184, 13);
            this.lblScreenWhereQuestionsDisplayed.TabIndex = 5;
            this.lblScreenWhereQuestionsDisplayed.Text = "Screen Where Question(s) Displayed:";
            // 
            // cbScreenWhereQuestionsDisplayed
            // 
            this.cbScreenWhereQuestionsDisplayed.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbScreenWhereQuestionsDisplayed.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbScreenWhereQuestionsDisplayed.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbScreenWhereQuestionsDisplayed.FormattingEnabled = true;
            this.cbScreenWhereQuestionsDisplayed.Location = new System.Drawing.Point(193, 14);
            this.cbScreenWhereQuestionsDisplayed.Name = "cbScreenWhereQuestionsDisplayed";
            this.cbScreenWhereQuestionsDisplayed.Size = new System.Drawing.Size(300, 21);
            this.cbScreenWhereQuestionsDisplayed.TabIndex = 6;
            // 
            // CriteriaQuestionTimingControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = false;
            this.Controls.Add(this.cbScreenWhereQuestionsDisplayed);
            this.Controls.Add(this.lblScreenWhereQuestionsDisplayed);
            this.Controls.Add(this.gbQuestionTiming);
            this.Name = "CriteriaQuestionTimingControl";
            this.Size = new System.Drawing.Size(663, 165);
            this.gbQuestionTiming.ResumeLayout(false);
            this.gbQuestionTiming.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.GroupBox gbQuestionTiming;
        private Statline.Stattrac.Windows.Forms.ComboBox cbUpdateField;
        private Statline.Stattrac.Windows.Forms.TextBox txtTo;
        private Statline.Stattrac.Windows.Forms.TextBox txtSpecifiedTimeRange;
        private Statline.Stattrac.Windows.Forms.ComboBox cbDateTimeType;
        private Statline.Stattrac.Windows.Forms.ComboBox cbQuestionTiming;
        private Statline.Stattrac.Windows.Forms.Label lblTo;
        private Statline.Stattrac.Windows.Forms.Label lblSpecifiedTimeRange;
        private Statline.Stattrac.Windows.Forms.Label lblUpdateField;
        private Statline.Stattrac.Windows.Forms.Label lblDateTimeType;
        private Statline.Stattrac.Windows.Forms.Label lblQuestionTiming;
        private Statline.Stattrac.Windows.Forms.Label lblScreenWhereQuestionsDisplayed;
        private Statline.Stattrac.Windows.Forms.ComboBox cbScreenWhereQuestionsDisplayed;
    }
}
