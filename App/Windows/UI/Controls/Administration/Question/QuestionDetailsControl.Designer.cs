namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    partial class QuestionDetailsControl
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
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance17 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance18 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance19 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance20 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance21 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance22 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance23 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance24 = new Infragistics.Win.Appearance();
            this.cbQuestionCategory = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.chkInactive = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.txtQuestion = new Statline.Stattrac.Windows.Forms.TextBox();
            this.cbDisplayNA = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbDisplayComments = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbTrackEventLog = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbIfYes = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.ugAssocGroups = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.lblAssocGroups = new Statline.Stattrac.Windows.Forms.Label();
            this.lblAssocAdditionalQuestions = new Statline.Stattrac.Windows.Forms.Label();
            this.lblIfYes = new Statline.Stattrac.Windows.Forms.Label();
            this.lblTrackinEventLog = new Statline.Stattrac.Windows.Forms.Label();
            this.lblDisplayComments = new Statline.Stattrac.Windows.Forms.Label();
            this.lblDisplayNA = new Statline.Stattrac.Windows.Forms.Label();
            this.label7 = new Statline.Stattrac.Windows.Forms.Label();
            this.lblQuestion = new Statline.Stattrac.Windows.Forms.Label();
            this.ugAssocQuestions = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.pnlBody.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssocGroups)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssocQuestions)).BeginInit();
            this.SuspendLayout();
            // 
            // pnlBody
            // 
            this.pnlBody.Controls.Add(this.ugAssocQuestions);
            this.pnlBody.Controls.Add(this.lblAssocAdditionalQuestions);
            this.pnlBody.Size = new System.Drawing.Size(872, 539);
            // 
            // cbQuestionCategory
            // 
            this.cbQuestionCategory.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbQuestionCategory.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbQuestionCategory.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbQuestionCategory.FormattingEnabled = true;
            this.cbQuestionCategory.Location = new System.Drawing.Point(139, 63);
            this.cbQuestionCategory.Name = "cbQuestionCategory";
            this.cbQuestionCategory.Size = new System.Drawing.Size(369, 21);
            this.cbQuestionCategory.TabIndex = 3;
            // 
            // chkInactive
            // 
            this.chkInactive.AutoSize = true;
            this.chkInactive.Checked = false;
            this.chkInactive.Location = new System.Drawing.Point(139, 4);
            this.chkInactive.Name = "chkInactive";
            this.chkInactive.Size = new System.Drawing.Size(64, 17);
            this.chkInactive.TabIndex = 1;
            this.chkInactive.Text = "Inactive";
            this.chkInactive.UseVisualStyleBackColor = true;
            // 
            // txtQuestion
            // 
            this.txtQuestion.Location = new System.Drawing.Point(139, 32);
            this.txtQuestion.MaxLength = 250;
            this.txtQuestion.Name = "txtQuestion";
            this.txtQuestion.Required = false;
            this.txtQuestion.Size = new System.Drawing.Size(694, 20);
            this.txtQuestion.SpellCheckEnabled = true;
            this.txtQuestion.TabIndex = 2;
            // 
            // cbDisplayNA
            // 
            this.cbDisplayNA.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbDisplayNA.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbDisplayNA.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbDisplayNA.FormattingEnabled = true;
            this.cbDisplayNA.Location = new System.Drawing.Point(139, 95);
            this.cbDisplayNA.Name = "cbDisplayNA";
            this.cbDisplayNA.Size = new System.Drawing.Size(121, 21);
            this.cbDisplayNA.TabIndex = 4;
            // 
            // cbDisplayComments
            // 
            this.cbDisplayComments.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbDisplayComments.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbDisplayComments.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbDisplayComments.FormattingEnabled = true;
            this.cbDisplayComments.Location = new System.Drawing.Point(139, 127);
            this.cbDisplayComments.Name = "cbDisplayComments";
            this.cbDisplayComments.Size = new System.Drawing.Size(121, 21);
            this.cbDisplayComments.TabIndex = 5;
            // 
            // cbTrackEventLog
            // 
            this.cbTrackEventLog.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbTrackEventLog.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbTrackEventLog.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbTrackEventLog.FormattingEnabled = true;
            this.cbTrackEventLog.Location = new System.Drawing.Point(139, 159);
            this.cbTrackEventLog.Name = "cbTrackEventLog";
            this.cbTrackEventLog.Size = new System.Drawing.Size(121, 21);
            this.cbTrackEventLog.TabIndex = 6;
            // 
            // cbIfYes
            // 
            this.cbIfYes.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbIfYes.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbIfYes.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbIfYes.FormattingEnabled = true;
            this.cbIfYes.Location = new System.Drawing.Point(139, 191);
            this.cbIfYes.Name = "cbIfYes";
            this.cbIfYes.Size = new System.Drawing.Size(369, 21);
            this.cbIfYes.TabIndex = 7;
            this.cbIfYes.SelectedIndexChanged += new System.EventHandler(this.cbIfYes_SelectedIndexChanged);
            // 
            // ugAssocGroups
            // 
            appearance1.BackColor = System.Drawing.SystemColors.Window;
            appearance1.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugAssocGroups.DisplayLayout.Appearance = appearance1;
            this.ugAssocGroups.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugAssocGroups.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance2.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssocGroups.DisplayLayout.GroupByBox.Appearance = appearance2;
            appearance3.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssocGroups.DisplayLayout.GroupByBox.BandLabelAppearance = appearance3;
            this.ugAssocGroups.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugAssocGroups.DisplayLayout.GroupByBox.Hidden = true;
            appearance4.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssocGroups.DisplayLayout.GroupByBox.PromptAppearance = appearance4;
            this.ugAssocGroups.DisplayLayout.MaxColScrollRegions = 1;
            this.ugAssocGroups.DisplayLayout.MaxRowScrollRegions = 1;
            appearance5.BackColor = System.Drawing.SystemColors.Window;
            appearance5.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugAssocGroups.DisplayLayout.Override.ActiveCellAppearance = appearance5;
            appearance6.BackColor = System.Drawing.SystemColors.Highlight;
            appearance6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugAssocGroups.DisplayLayout.Override.ActiveRowAppearance = appearance6;
            this.ugAssocGroups.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugAssocGroups.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            this.ugAssocGroups.DisplayLayout.Override.CardAreaAppearance = appearance7;
            appearance8.BorderColor = System.Drawing.Color.Silver;
            appearance8.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugAssocGroups.DisplayLayout.Override.CellAppearance = appearance8;
            this.ugAssocGroups.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugAssocGroups.DisplayLayout.Override.CellPadding = 0;
            appearance9.BackColor = System.Drawing.SystemColors.Control;
            appearance9.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance9.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance9.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssocGroups.DisplayLayout.Override.GroupByRowAppearance = appearance9;
            appearance10.TextHAlignAsString = "Left";
            this.ugAssocGroups.DisplayLayout.Override.HeaderAppearance = appearance10;
            this.ugAssocGroups.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugAssocGroups.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance11.BackColor = System.Drawing.SystemColors.Window;
            appearance11.BorderColor = System.Drawing.Color.Silver;
            this.ugAssocGroups.DisplayLayout.Override.RowAppearance = appearance11;
            this.ugAssocGroups.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugAssocGroups.DisplayLayout.Override.TemplateAddRowAppearance = appearance12;
            this.ugAssocGroups.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugAssocGroups.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugAssocGroups.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugAssocGroups.Location = new System.Drawing.Point(83, 401);
            this.ugAssocGroups.Name = "ugAssocGroups";
            this.ugAssocGroups.Size = new System.Drawing.Size(750, 80);
            this.ugAssocGroups.TabIndex = 9;
            this.ugAssocGroups.Text = "ultraGrid1";
            this.ugAssocGroups.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            this.ugAssocGroups.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugAssocGroups_InitializeLayout);
            // 
            // lblAssocGroups
            // 
            this.lblAssocGroups.AutoSize = true;
            this.lblAssocGroups.Location = new System.Drawing.Point(80, 385);
            this.lblAssocGroups.Name = "lblAssocGroups";
            this.lblAssocGroups.Size = new System.Drawing.Size(99, 13);
            this.lblAssocGroups.TabIndex = 8;
            this.lblAssocGroups.Text = "Associated Groups:";
            // 
            // lblAssocAdditionalQuestions
            // 
            this.lblAssocAdditionalQuestions.AutoSize = true;
            this.lblAssocAdditionalQuestions.Location = new System.Drawing.Point(80, 277);
            this.lblAssocAdditionalQuestions.Name = "lblAssocAdditionalQuestions";
            this.lblAssocAdditionalQuestions.Size = new System.Drawing.Size(161, 13);
            this.lblAssocAdditionalQuestions.TabIndex = 9;
            this.lblAssocAdditionalQuestions.Text = "Associated Additional Questions:";
            // 
            // lblIfYes
            // 
            this.lblIfYes.AutoSize = true;
            this.lblIfYes.Location = new System.Drawing.Point(90, 199);
            this.lblIfYes.Name = "lblIfYes";
            this.lblIfYes.Size = new System.Drawing.Size(37, 13);
            this.lblIfYes.TabIndex = 10;
            this.lblIfYes.Text = "If Yes:";
            // 
            // lblTrackinEventLog
            // 
            this.lblTrackinEventLog.AutoSize = true;
            this.lblTrackinEventLog.Location = new System.Drawing.Point(30, 167);
            this.lblTrackinEventLog.Name = "lblTrackinEventLog";
            this.lblTrackinEventLog.Size = new System.Drawing.Size(101, 13);
            this.lblTrackinEventLog.TabIndex = 11;
            this.lblTrackinEventLog.Text = "Track in Event Log:";
            // 
            // lblDisplayComments
            // 
            this.lblDisplayComments.AutoSize = true;
            this.lblDisplayComments.Location = new System.Drawing.Point(31, 135);
            this.lblDisplayComments.Name = "lblDisplayComments";
            this.lblDisplayComments.Size = new System.Drawing.Size(96, 13);
            this.lblDisplayComments.TabIndex = 12;
            this.lblDisplayComments.Text = "Display Comments:";
            // 
            // lblDisplayNA
            // 
            this.lblDisplayNA.AutoSize = true;
            this.lblDisplayNA.Location = new System.Drawing.Point(60, 103);
            this.lblDisplayNA.Name = "lblDisplayNA";
            this.lblDisplayNA.Size = new System.Drawing.Size(67, 13);
            this.lblDisplayNA.TabIndex = 13;
            this.lblDisplayNA.Text = "Display N/A:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(30, 71);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(97, 13);
            this.label7.TabIndex = 14;
            this.label7.Text = "Question Category:";
            // 
            // lblQuestion
            // 
            this.lblQuestion.AutoSize = true;
            this.lblQuestion.Location = new System.Drawing.Point(74, 39);
            this.lblQuestion.Name = "lblQuestion";
            this.lblQuestion.Size = new System.Drawing.Size(52, 13);
            this.lblQuestion.TabIndex = 15;
            this.lblQuestion.Text = "Question:";
            // 
            // ugAssocQuestions
            // 
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugAssocQuestions.DisplayLayout.Appearance = appearance13;
            this.ugAssocQuestions.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugAssocQuestions.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance14.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance14.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance14.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssocQuestions.DisplayLayout.GroupByBox.Appearance = appearance14;
            appearance15.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssocQuestions.DisplayLayout.GroupByBox.BandLabelAppearance = appearance15;
            this.ugAssocQuestions.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugAssocQuestions.DisplayLayout.GroupByBox.Hidden = true;
            appearance16.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance16.BackColor2 = System.Drawing.SystemColors.Control;
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance16.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssocQuestions.DisplayLayout.GroupByBox.PromptAppearance = appearance16;
            this.ugAssocQuestions.DisplayLayout.MaxColScrollRegions = 1;
            this.ugAssocQuestions.DisplayLayout.MaxRowScrollRegions = 1;
            appearance17.BackColor = System.Drawing.SystemColors.Window;
            appearance17.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugAssocQuestions.DisplayLayout.Override.ActiveCellAppearance = appearance17;
            appearance18.BackColor = System.Drawing.SystemColors.Highlight;
            appearance18.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugAssocQuestions.DisplayLayout.Override.ActiveRowAppearance = appearance18;
            this.ugAssocQuestions.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugAssocQuestions.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance19.BackColor = System.Drawing.SystemColors.Window;
            this.ugAssocQuestions.DisplayLayout.Override.CardAreaAppearance = appearance19;
            appearance20.BorderColor = System.Drawing.Color.Silver;
            appearance20.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugAssocQuestions.DisplayLayout.Override.CellAppearance = appearance20;
            this.ugAssocQuestions.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugAssocQuestions.DisplayLayout.Override.CellPadding = 0;
            appearance21.BackColor = System.Drawing.SystemColors.Control;
            appearance21.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance21.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance21.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance21.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssocQuestions.DisplayLayout.Override.GroupByRowAppearance = appearance21;
            appearance22.TextHAlignAsString = "Left";
            this.ugAssocQuestions.DisplayLayout.Override.HeaderAppearance = appearance22;
            this.ugAssocQuestions.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugAssocQuestions.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance23.BackColor = System.Drawing.SystemColors.Window;
            appearance23.BorderColor = System.Drawing.Color.Silver;
            this.ugAssocQuestions.DisplayLayout.Override.RowAppearance = appearance23;
            this.ugAssocQuestions.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance24.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugAssocQuestions.DisplayLayout.Override.TemplateAddRowAppearance = appearance24;
            this.ugAssocQuestions.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugAssocQuestions.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugAssocQuestions.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugAssocQuestions.Location = new System.Drawing.Point(83, 293);
            this.ugAssocQuestions.Name = "ugAssocQuestions";
            this.ugAssocQuestions.Size = new System.Drawing.Size(550, 80);
            this.ugAssocQuestions.TabIndex = 8;
            this.ugAssocQuestions.Text = "ultraGrid2";
            this.ugAssocQuestions.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugAssocQuestions.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugAssocQuestions_InitializeLayout);
            // 
            // QuestionDetailsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.lblQuestion);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.lblDisplayNA);
            this.Controls.Add(this.lblDisplayComments);
            this.Controls.Add(this.lblTrackinEventLog);
            this.Controls.Add(this.lblIfYes);
            this.Controls.Add(this.lblAssocGroups);
            this.Controls.Add(this.ugAssocGroups);
            this.Controls.Add(this.cbIfYes);
            this.Controls.Add(this.cbTrackEventLog);
            this.Controls.Add(this.cbDisplayComments);
            this.Controls.Add(this.cbDisplayNA);
            this.Controls.Add(this.txtQuestion);
            this.Controls.Add(this.chkInactive);
            this.Controls.Add(this.cbQuestionCategory);
            this.Name = "QuestionDetailsControl";
            this.Size = new System.Drawing.Size(872, 565);
            this.Controls.SetChildIndex(this.pnlBody, 0);
            this.Controls.SetChildIndex(this.cbQuestionCategory, 0);
            this.Controls.SetChildIndex(this.chkInactive, 0);
            this.Controls.SetChildIndex(this.txtQuestion, 0);
            this.Controls.SetChildIndex(this.cbDisplayNA, 0);
            this.Controls.SetChildIndex(this.cbDisplayComments, 0);
            this.Controls.SetChildIndex(this.cbTrackEventLog, 0);
            this.Controls.SetChildIndex(this.cbIfYes, 0);
            this.Controls.SetChildIndex(this.ugAssocGroups, 0);
            this.Controls.SetChildIndex(this.lblAssocGroups, 0);
            this.Controls.SetChildIndex(this.lblIfYes, 0);
            this.Controls.SetChildIndex(this.lblTrackinEventLog, 0);
            this.Controls.SetChildIndex(this.lblDisplayComments, 0);
            this.Controls.SetChildIndex(this.lblDisplayNA, 0);
            this.Controls.SetChildIndex(this.label7, 0);
            this.Controls.SetChildIndex(this.lblQuestion, 0);
            this.pnlBody.ResumeLayout(false);
            this.pnlBody.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssocGroups)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssocQuestions)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.ComboBox cbQuestionCategory;
        private Statline.Stattrac.Windows.Forms.CheckBox chkInactive;
        private Statline.Stattrac.Windows.Forms.TextBox txtQuestion;
        private Statline.Stattrac.Windows.Forms.ComboBox cbDisplayNA;
        private Statline.Stattrac.Windows.Forms.ComboBox cbDisplayComments;
        private Statline.Stattrac.Windows.Forms.ComboBox cbTrackEventLog;
        private Statline.Stattrac.Windows.Forms.ComboBox cbIfYes;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugAssocGroups;
        private Statline.Stattrac.Windows.Forms.Label lblAssocGroups;
        private Statline.Stattrac.Windows.Forms.Label lblAssocAdditionalQuestions;
        private Statline.Stattrac.Windows.Forms.Label lblIfYes;
        private Statline.Stattrac.Windows.Forms.Label lblTrackinEventLog;
        private Statline.Stattrac.Windows.Forms.Label lblDisplayComments;
        private Statline.Stattrac.Windows.Forms.Label lblDisplayNA;
        private Statline.Stattrac.Windows.Forms.Label label7;
        private Statline.Stattrac.Windows.Forms.Label lblQuestion;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugAssocQuestions;
    }
}
