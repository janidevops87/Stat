namespace Statline.Stattrac.Windows.UI.Controls.Administration.RuleOutIndications
{
    partial class RuleOutIndicationsDetailControl
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
            this.chkInactive = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.lblRuleOutName = new Statline.Stattrac.Windows.Forms.Label();
            this.txtRuleOutName = new Statline.Stattrac.Windows.Forms.TextBox();
            this.cbResponse = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblResponse = new Statline.Stattrac.Windows.Forms.Label();
            this.ugAssociatedAdditionalQuestions = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.lblAssociatedAdditionalQuestions = new Statline.Stattrac.Windows.Forms.Label();
            this.lblAssociatedCriteriaGroups = new Statline.Stattrac.Windows.Forms.Label();
            this.ugAssociatedCriteriaGroups = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.pnlBody.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedAdditionalQuestions)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedCriteriaGroups)).BeginInit();
            this.SuspendLayout();
            // 
            // pnlBody
            // 
            this.pnlBody.Controls.Add(this.ugAssociatedCriteriaGroups);
            this.pnlBody.Controls.Add(this.lblAssociatedCriteriaGroups);
            this.pnlBody.Controls.Add(this.lblAssociatedAdditionalQuestions);
            this.pnlBody.Controls.Add(this.ugAssociatedAdditionalQuestions);
            this.pnlBody.Controls.Add(this.lblResponse);
            this.pnlBody.Controls.Add(this.cbResponse);
            this.pnlBody.Controls.Add(this.txtRuleOutName);
            this.pnlBody.Controls.Add(this.lblRuleOutName);
            this.pnlBody.Controls.Add(this.chkInactive);
            // 
            // chkInactive
            // 
            this.chkInactive.AutoSize = true;
            this.chkInactive.Checked = false;
            this.chkInactive.Location = new System.Drawing.Point(163, 30);
            this.chkInactive.Name = "chkInactive";
            this.chkInactive.Size = new System.Drawing.Size(64, 17);
            this.chkInactive.TabIndex = 0;
            this.chkInactive.Text = "Inactive";
            this.chkInactive.UseVisualStyleBackColor = true;
            // 
            // lblRuleOutName
            // 
            this.lblRuleOutName.AutoSize = true;
            this.lblRuleOutName.Location = new System.Drawing.Point(74, 54);
            this.lblRuleOutName.Name = "lblRuleOutName";
            this.lblRuleOutName.Size = new System.Drawing.Size(83, 13);
            this.lblRuleOutName.TabIndex = 1;
            this.lblRuleOutName.Text = "Rule Out Name:";
            // 
            // txtRuleOutName
            // 
            this.txtRuleOutName.Location = new System.Drawing.Point(163, 54);
            this.txtRuleOutName.Name = "txtRuleOutName";
            this.txtRuleOutName.Required = false;
            this.txtRuleOutName.Size = new System.Drawing.Size(400, 20);
            this.txtRuleOutName.SpellCheckEnabled = false;
            this.txtRuleOutName.TabIndex = 2;
            // 
            // cbResponse
            // 
            this.cbResponse.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbResponse.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbResponse.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbResponse.FormattingEnabled = true;
            this.cbResponse.Location = new System.Drawing.Point(163, 81);
            this.cbResponse.Name = "cbResponse";
            this.cbResponse.Size = new System.Drawing.Size(250, 21);
            this.cbResponse.TabIndex = 3;
            this.cbResponse.SelectionChangeCommitted += new System.EventHandler(this.cbResponse_SelectionChangeCommitted);
            // 
            // lblResponse
            // 
            this.lblResponse.AutoSize = true;
            this.lblResponse.Location = new System.Drawing.Point(99, 81);
            this.lblResponse.Name = "lblResponse";
            this.lblResponse.Size = new System.Drawing.Size(58, 13);
            this.lblResponse.TabIndex = 4;
            this.lblResponse.Text = "Response:";
            // 
            // ugAssociatedAdditionalQuestions
            // 
            appearance1.BackColor = System.Drawing.SystemColors.Window;
            appearance1.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Appearance = appearance1;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance2.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.GroupByBox.Appearance = appearance2;
            appearance3.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.GroupByBox.BandLabelAppearance = appearance3;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance4.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.GroupByBox.PromptAppearance = appearance4;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.MaxColScrollRegions = 1;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.MaxRowScrollRegions = 1;
            appearance5.BackColor = System.Drawing.SystemColors.Window;
            appearance5.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.ActiveCellAppearance = appearance5;
            appearance6.BackColor = System.Drawing.SystemColors.Highlight;
            appearance6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.ActiveRowAppearance = appearance6;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.CardAreaAppearance = appearance7;
            appearance8.BorderColor = System.Drawing.Color.Silver;
            appearance8.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.CellAppearance = appearance8;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.CellPadding = 0;
            appearance9.BackColor = System.Drawing.SystemColors.Control;
            appearance9.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance9.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance9.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.GroupByRowAppearance = appearance9;
            appearance10.TextHAlignAsString = "Left";
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.HeaderAppearance = appearance10;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance11.BackColor = System.Drawing.SystemColors.Window;
            appearance11.BorderColor = System.Drawing.Color.Silver;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.RowAppearance = appearance11;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.Override.TemplateAddRowAppearance = appearance12;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugAssociatedAdditionalQuestions.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugAssociatedAdditionalQuestions.Location = new System.Drawing.Point(163, 143);
            this.ugAssociatedAdditionalQuestions.Name = "ugAssociatedAdditionalQuestions";
            this.ugAssociatedAdditionalQuestions.Size = new System.Drawing.Size(550, 139);
            this.ugAssociatedAdditionalQuestions.TabIndex = 5;
            this.ugAssociatedAdditionalQuestions.Text = "ultraGrid1";
            this.ugAssociatedAdditionalQuestions.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugAssociatedAdditionalQuestions.AfterRowUpdate += new Infragistics.Win.UltraWinGrid.RowEventHandler(this.ugAssociatedAdditionalQuestions_AfterRowUpdate);
            this.ugAssociatedAdditionalQuestions.AfterRowInsert += new Infragistics.Win.UltraWinGrid.RowEventHandler(this.ugAssociatedAdditionalQuestions_AfterRowInsert);
            this.ugAssociatedAdditionalQuestions.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugAssociatedAdditionalQuestions_InitializeLayout);
            // 
            // lblAssociatedAdditionalQuestions
            // 
            this.lblAssociatedAdditionalQuestions.AutoSize = true;
            this.lblAssociatedAdditionalQuestions.Location = new System.Drawing.Point(99, 127);
            this.lblAssociatedAdditionalQuestions.Name = "lblAssociatedAdditionalQuestions";
            this.lblAssociatedAdditionalQuestions.Size = new System.Drawing.Size(161, 13);
            this.lblAssociatedAdditionalQuestions.TabIndex = 6;
            this.lblAssociatedAdditionalQuestions.Text = "Associated Additional Questions:";
            // 
            // lblAssociatedCriteriaGroups
            // 
            this.lblAssociatedCriteriaGroups.AutoSize = true;
            this.lblAssociatedCriteriaGroups.Location = new System.Drawing.Point(102, 302);
            this.lblAssociatedCriteriaGroups.Name = "lblAssociatedCriteriaGroups";
            this.lblAssociatedCriteriaGroups.Size = new System.Drawing.Size(134, 13);
            this.lblAssociatedCriteriaGroups.TabIndex = 7;
            this.lblAssociatedCriteriaGroups.Text = "Associated Criteria Groups:";
            // 
            // ugAssociatedCriteriaGroups
            // 
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Appearance = appearance13;
            this.ugAssociatedCriteriaGroups.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugAssociatedCriteriaGroups.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance14.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance14.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance14.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedCriteriaGroups.DisplayLayout.GroupByBox.Appearance = appearance14;
            appearance15.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssociatedCriteriaGroups.DisplayLayout.GroupByBox.BandLabelAppearance = appearance15;
            this.ugAssociatedCriteriaGroups.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance16.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance16.BackColor2 = System.Drawing.SystemColors.Control;
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance16.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssociatedCriteriaGroups.DisplayLayout.GroupByBox.PromptAppearance = appearance16;
            this.ugAssociatedCriteriaGroups.DisplayLayout.MaxColScrollRegions = 1;
            this.ugAssociatedCriteriaGroups.DisplayLayout.MaxRowScrollRegions = 1;
            appearance17.BackColor = System.Drawing.SystemColors.Window;
            appearance17.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.ActiveCellAppearance = appearance17;
            appearance18.BackColor = System.Drawing.SystemColors.Highlight;
            appearance18.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.ActiveRowAppearance = appearance18;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance19.BackColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.CardAreaAppearance = appearance19;
            appearance20.BorderColor = System.Drawing.Color.Silver;
            appearance20.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.CellAppearance = appearance20;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.CellPadding = 0;
            appearance21.BackColor = System.Drawing.SystemColors.Control;
            appearance21.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance21.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance21.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance21.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.GroupByRowAppearance = appearance21;
            appearance22.TextHAlignAsString = "Left";
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.HeaderAppearance = appearance22;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance23.BackColor = System.Drawing.SystemColors.Window;
            appearance23.BorderColor = System.Drawing.Color.Silver;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.RowAppearance = appearance23;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance24.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugAssociatedCriteriaGroups.DisplayLayout.Override.TemplateAddRowAppearance = appearance24;
            this.ugAssociatedCriteriaGroups.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugAssociatedCriteriaGroups.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugAssociatedCriteriaGroups.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugAssociatedCriteriaGroups.Location = new System.Drawing.Point(163, 319);
            this.ugAssociatedCriteriaGroups.Name = "ugAssociatedCriteriaGroups";
            this.ugAssociatedCriteriaGroups.Size = new System.Drawing.Size(661, 122);
            this.ugAssociatedCriteriaGroups.TabIndex = 8;
            this.ugAssociatedCriteriaGroups.Text = "ultraGrid2";
            this.ugAssociatedCriteriaGroups.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            this.ugAssociatedCriteriaGroups.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugAssociatedCriteriaGroups_InitializeLayout);
            // 
            // RuleOutIndicationsDetailControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Name = "RuleOutIndicationsDetailControl";
            this.Paint += new System.Windows.Forms.PaintEventHandler(this.pnlBody_Paint);
            this.pnlBody.ResumeLayout(false);
            this.pnlBody.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedAdditionalQuestions)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedCriteriaGroups)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.CheckBox chkInactive;
        private Statline.Stattrac.Windows.Forms.Label lblResponse;
        private Statline.Stattrac.Windows.Forms.ComboBox cbResponse;
        private Statline.Stattrac.Windows.Forms.TextBox txtRuleOutName;
        private Statline.Stattrac.Windows.Forms.Label lblRuleOutName;
        private Statline.Stattrac.Windows.Forms.Label lblAssociatedAdditionalQuestions;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugAssociatedAdditionalQuestions;
        private Statline.Stattrac.Windows.Forms.Label lblAssociatedCriteriaGroups;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugAssociatedCriteriaGroups;
    }
}
