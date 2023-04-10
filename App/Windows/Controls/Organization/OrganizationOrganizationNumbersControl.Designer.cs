namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class OrganizationOrganizationNumbersControl
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
            this.lblOrganizationName = new Statline.Stattrac.Windows.Forms.Label();
            this.ugPhoneNumber = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.chkDisplayAllNumbers = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.label9 = new Statline.Stattrac.Windows.Forms.Label();
            this.label8 = new Statline.Stattrac.Windows.Forms.Label();
            this.cbCountryCode = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbInternationalDirectDialing = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.btnViewAssociatedReferrals = new Statline.Stattrac.Windows.Forms.Button();
            this.gbAssociatedNumbers = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.organizationAssociatedCall = new Statline.Stattrac.Windows.Controls.Organization.OrganizationAssociatedCall();
            ((System.ComponentModel.ISupportInitialize)(this.ugPhoneNumber)).BeginInit();
            this.gbAssociatedNumbers.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblOrganizationName
            // 
            this.lblOrganizationName.AutoSize = true;
            this.lblOrganizationName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblOrganizationName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOrganizationName.Location = new System.Drawing.Point(3, 17);
            this.lblOrganizationName.Name = "lblOrganizationName";
            this.lblOrganizationName.Size = new System.Drawing.Size(95, 13);
            this.lblOrganizationName.TabIndex = 1;
            this.lblOrganizationName.Text = "OrganizationName";
            // 
            // ugPhoneNumber
            // 
            this.ugPhoneNumber.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            appearance1.BackColor = System.Drawing.SystemColors.Window;
            appearance1.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugPhoneNumber.DisplayLayout.Appearance = appearance1;
            this.ugPhoneNumber.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugPhoneNumber.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance2.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BorderColor = System.Drawing.SystemColors.Window;
            this.ugPhoneNumber.DisplayLayout.GroupByBox.Appearance = appearance2;
            appearance3.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugPhoneNumber.DisplayLayout.GroupByBox.BandLabelAppearance = appearance3;
            this.ugPhoneNumber.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance4.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance4.BackColor2 = System.Drawing.SystemColors.Control;
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance4.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugPhoneNumber.DisplayLayout.GroupByBox.PromptAppearance = appearance4;
            this.ugPhoneNumber.DisplayLayout.MaxColScrollRegions = 1;
            this.ugPhoneNumber.DisplayLayout.MaxRowScrollRegions = 1;
            appearance5.BackColor = System.Drawing.SystemColors.Window;
            appearance5.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugPhoneNumber.DisplayLayout.Override.ActiveCellAppearance = appearance5;
            appearance6.BackColor = System.Drawing.SystemColors.Highlight;
            appearance6.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugPhoneNumber.DisplayLayout.Override.ActiveRowAppearance = appearance6;
            this.ugPhoneNumber.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugPhoneNumber.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance7.BackColor = System.Drawing.SystemColors.Window;
            this.ugPhoneNumber.DisplayLayout.Override.CardAreaAppearance = appearance7;
            appearance8.BorderColor = System.Drawing.Color.Silver;
            appearance8.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugPhoneNumber.DisplayLayout.Override.CellAppearance = appearance8;
            this.ugPhoneNumber.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugPhoneNumber.DisplayLayout.Override.CellPadding = 0;
            appearance9.BackColor = System.Drawing.SystemColors.Control;
            appearance9.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance9.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance9.BorderColor = System.Drawing.SystemColors.Window;
            this.ugPhoneNumber.DisplayLayout.Override.GroupByRowAppearance = appearance9;
            appearance10.TextHAlignAsString = "Left";
            this.ugPhoneNumber.DisplayLayout.Override.HeaderAppearance = appearance10;
            this.ugPhoneNumber.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugPhoneNumber.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance11.BackColor = System.Drawing.SystemColors.Window;
            appearance11.BorderColor = System.Drawing.Color.Silver;
            this.ugPhoneNumber.DisplayLayout.Override.RowAppearance = appearance11;
            this.ugPhoneNumber.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugPhoneNumber.DisplayLayout.Override.TemplateAddRowAppearance = appearance12;
            this.ugPhoneNumber.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugPhoneNumber.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugPhoneNumber.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugPhoneNumber.Location = new System.Drawing.Point(6, 39);
            this.ugPhoneNumber.Name = "ugPhoneNumber";
            this.ugPhoneNumber.Size = new System.Drawing.Size(961, 249);
            this.ugPhoneNumber.TabIndex = 3;
            this.ugPhoneNumber.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugPhoneNumber.BeforeRowDeactivate += new System.ComponentModel.CancelEventHandler(this.ugPhoneNumber_BeforeRowDeactivate);
            this.ugPhoneNumber.AfterRowUpdate += new Infragistics.Win.UltraWinGrid.RowEventHandler(this.ugPhoneNumber_AfterRowUpdate);
            this.ugPhoneNumber.AfterRowInsert += new Infragistics.Win.UltraWinGrid.RowEventHandler(this.ugPhoneNumber_AfterRowInsert);
            this.ugPhoneNumber.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugPhoneNumber_InitializeLayout);
            this.ugPhoneNumber.Validating += new System.ComponentModel.CancelEventHandler(this.ugPhoneNumber_Validating);
            // 
            // chkDisplayAllNumbers
            // 
            this.chkDisplayAllNumbers.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkDisplayAllNumbers.AutoSize = true;
            this.chkDisplayAllNumbers.Checked = false;
            this.chkDisplayAllNumbers.Font = new System.Drawing.Font("Tahoma", 8F);
            this.chkDisplayAllNumbers.Location = new System.Drawing.Point(848, 11);
            this.chkDisplayAllNumbers.Name = "chkDisplayAllNumbers";
            this.chkDisplayAllNumbers.Size = new System.Drawing.Size(119, 17);
            this.chkDisplayAllNumbers.TabIndex = 2;
            this.chkDisplayAllNumbers.Text = "Display All Numbers";
            this.chkDisplayAllNumbers.UseVisualStyleBackColor = true;
            this.chkDisplayAllNumbers.CheckedChanged += new System.EventHandler(this.chkDisplayAllNumbers_CheckedChanged);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label9.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label9.Location = new System.Drawing.Point(54, 57);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(71, 13);
            this.label9.TabIndex = 17;
            this.label9.Text = "Country IDD:";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label8.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label8.Location = new System.Drawing.Point(11, 81);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(115, 13);
            this.label8.TabIndex = 16;
            this.label8.Text = "Country Calling Code :";
            // 
            // cbCountryCode
            // 
            this.cbCountryCode.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbCountryCode.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbCountryCode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbCountryCode.Font = new System.Drawing.Font("Tahoma", 7F);
            this.cbCountryCode.FormattingEnabled = true;
            this.cbCountryCode.Location = new System.Drawing.Point(125, 77);
            this.cbCountryCode.Name = "cbCountryCode";
            this.cbCountryCode.Required = false;
            this.cbCountryCode.Size = new System.Drawing.Size(129, 19);
            this.cbCountryCode.TabIndex = 1;
            // 
            // cbInternationalDirectDialing
            // 
            this.cbInternationalDirectDialing.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbInternationalDirectDialing.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbInternationalDirectDialing.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbInternationalDirectDialing.Font = new System.Drawing.Font("Tahoma", 7F);
            this.cbInternationalDirectDialing.FormattingEnabled = true;
            this.cbInternationalDirectDialing.Location = new System.Drawing.Point(125, 53);
            this.cbInternationalDirectDialing.Name = "cbInternationalDirectDialing";
            this.cbInternationalDirectDialing.Required = false;
            this.cbInternationalDirectDialing.Size = new System.Drawing.Size(129, 19);
            this.cbInternationalDirectDialing.TabIndex = 0;
            // 
            // btnViewAssociatedReferrals
            // 
            this.btnViewAssociatedReferrals.Location = new System.Drawing.Point(385, 744);
            this.btnViewAssociatedReferrals.Name = "btnViewAssociatedReferrals";
            this.btnViewAssociatedReferrals.Size = new System.Drawing.Size(159, 23);
            this.btnViewAssociatedReferrals.TabIndex = 19;
            this.btnViewAssociatedReferrals.Text = "View Associated Referrals";
            this.btnViewAssociatedReferrals.UseVisualStyleBackColor = true;
            this.btnViewAssociatedReferrals.Click += new System.EventHandler(this.btnViewAssociatedReferrals_Click);
            // 
            // gbAssociatedNumbers
            // 
            this.gbAssociatedNumbers.Controls.Add(this.chkDisplayAllNumbers);
            this.gbAssociatedNumbers.Controls.Add(this.ugPhoneNumber);
            this.gbAssociatedNumbers.Location = new System.Drawing.Point(8, 102);
            this.gbAssociatedNumbers.Name = "gbAssociatedNumbers";
            this.gbAssociatedNumbers.Size = new System.Drawing.Size(973, 305);
            this.gbAssociatedNumbers.TabIndex = 20;
            this.gbAssociatedNumbers.TabStop = false;
            this.gbAssociatedNumbers.Text = "Associated Numbers:";
            // 
            // organizationAssociatedCall
            // 
            this.organizationAssociatedCall.Enabled = false;
            this.organizationAssociatedCall.Location = new System.Drawing.Point(12, 413);
            this.organizationAssociatedCall.Name = "organizationAssociatedCall";
            this.organizationAssociatedCall.Size = new System.Drawing.Size(969, 325);
            this.organizationAssociatedCall.TabIndex = 18;
            // 
            // OrganizationOrganizationNumbersControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.gbAssociatedNumbers);
            this.Controls.Add(this.btnViewAssociatedReferrals);
            this.Controls.Add(this.organizationAssociatedCall);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.cbCountryCode);
            this.Controls.Add(this.cbInternationalDirectDialing);
            this.Controls.Add(this.lblOrganizationName);
            this.Name = "OrganizationOrganizationNumbersControl";
            this.Size = new System.Drawing.Size(983, 800);
            this.Validating += new System.ComponentModel.CancelEventHandler(this.OrganizationOrganizationNumbersControl_Validating);
            ((System.ComponentModel.ISupportInitialize)(this.ugPhoneNumber)).EndInit();
            this.gbAssociatedNumbers.ResumeLayout(false);
            this.gbAssociatedNumbers.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Label lblOrganizationName;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugPhoneNumber;
        private Statline.Stattrac.Windows.Forms.CheckBox chkDisplayAllNumbers;
        private Statline.Stattrac.Windows.Forms.Label label9;
        private Statline.Stattrac.Windows.Forms.Label label8;
        private Statline.Stattrac.Windows.Forms.ComboBox cbCountryCode;
        private Statline.Stattrac.Windows.Forms.ComboBox cbInternationalDirectDialing;
        private OrganizationAssociatedCall organizationAssociatedCall;
        private Statline.Stattrac.Windows.Forms.Button btnViewAssociatedReferrals;
        private Statline.Stattrac.Windows.Forms.GroupBox gbAssociatedNumbers;
    }
}
