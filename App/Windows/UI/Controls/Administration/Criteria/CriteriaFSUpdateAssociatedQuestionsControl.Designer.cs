namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    partial class CriteriaFSUpdateAssociatedQuestionsControl
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
            this.gbCreateEditQuestions = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.chkDisplayAllQuestions = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.btnAdd = new Statline.Stattrac.Windows.Forms.Button();
            this.btnSearchExistingConfigurations = new Statline.Stattrac.Windows.Forms.Button();
            this.ugAssociatedQuestions = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.gbCreateEditQuestions.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedQuestions)).BeginInit();
            this.SuspendLayout();
            // 
            // gbCreateEditQuestions
            // 
            this.gbCreateEditQuestions.Controls.Add(this.ugAssociatedQuestions);
            this.gbCreateEditQuestions.Controls.Add(this.btnSearchExistingConfigurations);
            this.gbCreateEditQuestions.Controls.Add(this.btnAdd);
            this.gbCreateEditQuestions.Controls.Add(this.chkDisplayAllQuestions);
            this.gbCreateEditQuestions.Dock = System.Windows.Forms.DockStyle.Fill;
            this.gbCreateEditQuestions.Location = new System.Drawing.Point(0, 0);
            this.gbCreateEditQuestions.Name = "gbCreateEditQuestions";
            this.gbCreateEditQuestions.Size = new System.Drawing.Size(876, 585);
            this.gbCreateEditQuestions.TabIndex = 0;
            this.gbCreateEditQuestions.TabStop = false;
            this.gbCreateEditQuestions.Text = "Create/Edit Questions";
            // 
            // chkDisplayAllQuestions
            // 
            this.chkDisplayAllQuestions.AutoSize = true;
            this.chkDisplayAllQuestions.Checked = false;
            this.chkDisplayAllQuestions.Location = new System.Drawing.Point(7, 20);
            this.chkDisplayAllQuestions.Name = "chkDisplayAllQuestions";
            this.chkDisplayAllQuestions.Size = new System.Drawing.Size(124, 17);
            this.chkDisplayAllQuestions.TabIndex = 0;
            this.chkDisplayAllQuestions.Text = "Display All Questions";
            this.chkDisplayAllQuestions.UseVisualStyleBackColor = true;
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(139, 14);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(52, 23);
            this.btnAdd.TabIndex = 1;
            this.btnAdd.Text = "Add";
            this.btnAdd.UseVisualStyleBackColor = true;
            // 
            // btnSearchExistingConfigurations
            // 
            this.btnSearchExistingConfigurations.Location = new System.Drawing.Point(197, 14);
            this.btnSearchExistingConfigurations.Name = "btnSearchExistingConfigurations";
            this.btnSearchExistingConfigurations.Size = new System.Drawing.Size(182, 23);
            this.btnSearchExistingConfigurations.TabIndex = 2;
            this.btnSearchExistingConfigurations.Text = "Search Existing Configurations";
            this.btnSearchExistingConfigurations.UseVisualStyleBackColor = true;
            // 
            // ugAssociatedQuestions
            // 
            appearance1.BackColor = System.Drawing.SystemColors.Window;
            appearance1.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugAssociatedQuestions.DisplayLayout.Appearance = appearance1;
            this.ugAssociatedQuestions.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugAssociatedQuestions.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance2.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedQuestions.DisplayLayout.GroupByBox.Appearance = appearance2;
            appearance3.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssociatedQuestions.DisplayLayout.GroupByBox.BandLabelAppearance = appearance3;
            this.ugAssociatedQuestions.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance4.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssociatedQuestions.DisplayLayout.GroupByBox.PromptAppearance = appearance4;
            this.ugAssociatedQuestions.DisplayLayout.MaxColScrollRegions = 1;
            this.ugAssociatedQuestions.DisplayLayout.MaxRowScrollRegions = 1;
            appearance5.BackColor = System.Drawing.SystemColors.Window;
            appearance5.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugAssociatedQuestions.DisplayLayout.Override.ActiveCellAppearance = appearance5;
            appearance6.BackColor = System.Drawing.SystemColors.Highlight;
            appearance6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugAssociatedQuestions.DisplayLayout.Override.ActiveRowAppearance = appearance6;
            this.ugAssociatedQuestions.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugAssociatedQuestions.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedQuestions.DisplayLayout.Override.CardAreaAppearance = appearance7;
            appearance8.BorderColor = System.Drawing.Color.Silver;
            appearance8.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugAssociatedQuestions.DisplayLayout.Override.CellAppearance = appearance8;
            this.ugAssociatedQuestions.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugAssociatedQuestions.DisplayLayout.Override.CellPadding = 0;
            appearance9.BackColor = System.Drawing.SystemColors.Control;
            appearance9.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance9.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance9.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedQuestions.DisplayLayout.Override.GroupByRowAppearance = appearance9;
            appearance10.TextHAlignAsString = "Left";
            this.ugAssociatedQuestions.DisplayLayout.Override.HeaderAppearance = appearance10;
            this.ugAssociatedQuestions.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugAssociatedQuestions.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance11.BackColor = System.Drawing.SystemColors.Window;
            appearance11.BorderColor = System.Drawing.Color.Silver;
            this.ugAssociatedQuestions.DisplayLayout.Override.RowAppearance = appearance11;
            this.ugAssociatedQuestions.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugAssociatedQuestions.DisplayLayout.Override.TemplateAddRowAppearance = appearance12;
            this.ugAssociatedQuestions.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugAssociatedQuestions.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugAssociatedQuestions.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugAssociatedQuestions.Location = new System.Drawing.Point(7, 44);
            this.ugAssociatedQuestions.Name = "ugAssociatedQuestions";
            this.ugAssociatedQuestions.Size = new System.Drawing.Size(841, 250);
            this.ugAssociatedQuestions.TabIndex = 3;
            this.ugAssociatedQuestions.Text = "ultraGrid1";
            this.ugAssociatedQuestions.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.None;
            // 
            // CriteriaFSUpdateAssociatedQuestionsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.gbCreateEditQuestions);
            this.Name = "CriteriaFSUpdateAssociatedQuestionsControl";
            this.gbCreateEditQuestions.ResumeLayout(false);
            this.gbCreateEditQuestions.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedQuestions)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.GroupBox gbCreateEditQuestions;
        private Statline.Stattrac.Windows.Forms.CheckBox chkDisplayAllQuestions;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugAssociatedQuestions;
        private Statline.Stattrac.Windows.Forms.Button btnSearchExistingConfigurations;
        private Statline.Stattrac.Windows.Forms.Button btnAdd;
    }
}
