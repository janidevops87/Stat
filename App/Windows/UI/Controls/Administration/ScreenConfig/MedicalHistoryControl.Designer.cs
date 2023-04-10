namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    partial class MedicalHistoryControl
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
            this.groupBox1 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.ultraGrid1 = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.lblDisplayMedHistory = new Statline.Stattrac.Windows.Forms.Label();
            this.cbDisplayMedHistory = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.groupBox2 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.chkAttending = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.chkPronouncing = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.lblBasedonText = new Statline.Stattrac.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid1)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.ultraGrid1);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(4, 74);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(854, 263);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Field Settings";
            // 
            // ultraGrid1
            // 
            appearance1.BackColor = System.Drawing.SystemColors.Window;
            appearance1.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ultraGrid1.DisplayLayout.Appearance = appearance1;
            this.ultraGrid1.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ultraGrid1.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance2.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BorderColor = System.Drawing.SystemColors.Window;
            this.ultraGrid1.DisplayLayout.GroupByBox.Appearance = appearance2;
            appearance3.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ultraGrid1.DisplayLayout.GroupByBox.BandLabelAppearance = appearance3;
            this.ultraGrid1.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ultraGrid1.DisplayLayout.GroupByBox.Hidden = true;
            appearance4.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ultraGrid1.DisplayLayout.GroupByBox.PromptAppearance = appearance4;
            this.ultraGrid1.DisplayLayout.MaxColScrollRegions = 1;
            this.ultraGrid1.DisplayLayout.MaxRowScrollRegions = 1;
            appearance5.BackColor = System.Drawing.SystemColors.Window;
            appearance5.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ultraGrid1.DisplayLayout.Override.ActiveCellAppearance = appearance5;
            appearance6.BackColor = System.Drawing.SystemColors.Highlight;
            appearance6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ultraGrid1.DisplayLayout.Override.ActiveRowAppearance = appearance6;
            this.ultraGrid1.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ultraGrid1.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            this.ultraGrid1.DisplayLayout.Override.CardAreaAppearance = appearance7;
            appearance8.BorderColor = System.Drawing.Color.Silver;
            appearance8.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ultraGrid1.DisplayLayout.Override.CellAppearance = appearance8;
            this.ultraGrid1.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ultraGrid1.DisplayLayout.Override.CellPadding = 0;
            appearance9.BackColor = System.Drawing.SystemColors.Control;
            appearance9.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance9.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance9.BorderColor = System.Drawing.SystemColors.Window;
            this.ultraGrid1.DisplayLayout.Override.GroupByRowAppearance = appearance9;
            appearance10.TextHAlignAsString = "Left";
            this.ultraGrid1.DisplayLayout.Override.HeaderAppearance = appearance10;
            this.ultraGrid1.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ultraGrid1.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance11.BackColor = System.Drawing.SystemColors.Window;
            appearance11.BorderColor = System.Drawing.Color.Silver;
            this.ultraGrid1.DisplayLayout.Override.RowAppearance = appearance11;
            this.ultraGrid1.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ultraGrid1.DisplayLayout.Override.TemplateAddRowAppearance = appearance12;
            this.ultraGrid1.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ultraGrid1.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ultraGrid1.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ultraGrid1.Location = new System.Drawing.Point(7, 20);
            this.ultraGrid1.Name = "ultraGrid1";
            this.ultraGrid1.Size = new System.Drawing.Size(841, 224);
            this.ultraGrid1.TabIndex = 0;
            this.ultraGrid1.Text = "ultraGrid1";
            this.ultraGrid1.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.None;
            this.ultraGrid1.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ultraGrid1_InitializeLayout);
            // 
            // lblDisplayMedHistory
            // 
            this.lblDisplayMedHistory.AutoSize = true;
            this.lblDisplayMedHistory.Location = new System.Drawing.Point(4, 41);
            this.lblDisplayMedHistory.Name = "lblDisplayMedHistory";
            this.lblDisplayMedHistory.Size = new System.Drawing.Size(141, 13);
            this.lblDisplayMedHistory.TabIndex = 1;
            this.lblDisplayMedHistory.Text = "Display Medical History Tab:";
            // 
            // cbDisplayMedHistory
            // 
            this.cbDisplayMedHistory.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbDisplayMedHistory.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbDisplayMedHistory.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbDisplayMedHistory.FormattingEnabled = true;
            this.cbDisplayMedHistory.Location = new System.Drawing.Point(149, 33);
            this.cbDisplayMedHistory.Name = "cbDisplayMedHistory";
            this.cbDisplayMedHistory.Size = new System.Drawing.Size(121, 21);
            this.cbDisplayMedHistory.TabIndex = 2;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.chkAttending);
            this.groupBox2.Controls.Add(this.chkPronouncing);
            this.groupBox2.Controls.Add(this.lblBasedonText);
            this.groupBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.Location = new System.Drawing.Point(4, 362);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(266, 108);
            this.groupBox2.TabIndex = 3;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Display Based on Vent Status";
            // 
            // chkAttending
            // 
            this.chkAttending.AutoSize = true;
            this.chkAttending.Checked = false;
            this.chkAttending.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chkAttending.Location = new System.Drawing.Point(51, 80);
            this.chkAttending.Name = "chkAttending";
            this.chkAttending.Size = new System.Drawing.Size(71, 17);
            this.chkAttending.TabIndex = 2;
            this.chkAttending.Text = "Attending";
            this.chkAttending.UseVisualStyleBackColor = true;
            // 
            // chkPronouncing
            // 
            this.chkPronouncing.AutoSize = true;
            this.chkPronouncing.Checked = false;
            this.chkPronouncing.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chkPronouncing.Location = new System.Drawing.Point(51, 56);
            this.chkPronouncing.Name = "chkPronouncing";
            this.chkPronouncing.Size = new System.Drawing.Size(86, 17);
            this.chkPronouncing.TabIndex = 1;
            this.chkPronouncing.Text = "Pronouncing";
            this.chkPronouncing.UseVisualStyleBackColor = true;
            // 
            // lblBasedonText
            // 
            this.lblBasedonText.AutoSize = true;
            this.lblBasedonText.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBasedonText.Location = new System.Drawing.Point(7, 20);
            this.lblBasedonText.Name = "lblBasedonText";
            this.lblBasedonText.Size = new System.Drawing.Size(9, 13);
            this.lblBasedonText.TabIndex = 0;
            this.lblBasedonText.Text = "l";
            // 
            // MedicalHistoryControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.cbDisplayMedHistory);
            this.Controls.Add(this.lblDisplayMedHistory);
            this.Controls.Add(this.groupBox1);
            this.Name = "MedicalHistoryControl";
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid1)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.GroupBox groupBox1;
        private Statline.Stattrac.Windows.Forms.Label lblDisplayMedHistory;
        private Statline.Stattrac.Windows.Forms.UltraGrid ultraGrid1;
        private Statline.Stattrac.Windows.Forms.ComboBox cbDisplayMedHistory;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox2;
        private Statline.Stattrac.Windows.Forms.CheckBox chkAttending;
        private Statline.Stattrac.Windows.Forms.CheckBox chkPronouncing;
        private Statline.Stattrac.Windows.Forms.Label lblBasedonText;
    }
}
