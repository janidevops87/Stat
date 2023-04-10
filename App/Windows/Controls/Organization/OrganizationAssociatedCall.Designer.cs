namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class OrganizationAssociatedCall
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
            this.groupBoxReassignNumbers = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.panel1 = new Statline.Stattrac.Windows.Forms.Panel();
            this.btnClearAssociatedReferrals = new Statline.Stattrac.Windows.Forms.Button();
            this.cbOrganizationPhone = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.ugAssociatedReferrals = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.btnReassign = new Statline.Stattrac.Windows.Forms.Button();
            this.cbOrganization = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.label4 = new Statline.Stattrac.Windows.Forms.Label();
            this.lblReassignToNumber = new Statline.Stattrac.Windows.Forms.Label();
            this.lblReassignToOrganization = new Statline.Stattrac.Windows.Forms.Label();
            this.groupBoxReassignNumbers.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedReferrals)).BeginInit();
            this.SuspendLayout();
            // 
            // groupBoxReassignNumbers
            // 
            this.groupBoxReassignNumbers.Controls.Add(this.panel1);
            this.groupBoxReassignNumbers.Controls.Add(this.cbOrganizationPhone);
            this.groupBoxReassignNumbers.Controls.Add(this.ugAssociatedReferrals);
            this.groupBoxReassignNumbers.Controls.Add(this.btnReassign);
            this.groupBoxReassignNumbers.Controls.Add(this.cbOrganization);
            this.groupBoxReassignNumbers.Controls.Add(this.label4);
            this.groupBoxReassignNumbers.Controls.Add(this.lblReassignToNumber);
            this.groupBoxReassignNumbers.Controls.Add(this.lblReassignToOrganization);
            this.groupBoxReassignNumbers.Dock = System.Windows.Forms.DockStyle.Fill;
            this.groupBoxReassignNumbers.Location = new System.Drawing.Point(0, 0);
            this.groupBoxReassignNumbers.Name = "groupBoxReassignNumbers";
            this.groupBoxReassignNumbers.Size = new System.Drawing.Size(859, 325);
            this.groupBoxReassignNumbers.TabIndex = 5;
            this.groupBoxReassignNumbers.TabStop = false;
            this.groupBoxReassignNumbers.Text = "Reassign Numbers (highlight the numbers you wish to reassign):";
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.btnClearAssociatedReferrals);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.panel1.Location = new System.Drawing.Point(3, 292);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(853, 30);
            this.panel1.TabIndex = 5;
            // 
            // btnClearAssociatedReferrals
            // 
            this.btnClearAssociatedReferrals.Location = new System.Drawing.Point(264, 6);
            this.btnClearAssociatedReferrals.Name = "btnClearAssociatedReferrals";
            this.btnClearAssociatedReferrals.Size = new System.Drawing.Size(75, 23);
            this.btnClearAssociatedReferrals.TabIndex = 4;
            this.btnClearAssociatedReferrals.Text = "Clear";
            this.btnClearAssociatedReferrals.UseVisualStyleBackColor = true;
            this.btnClearAssociatedReferrals.Click += new System.EventHandler(this.btnClearAssociatedReferrals_Click);
            // 
            // cbOrganizationPhone
            // 
            this.cbOrganizationPhone.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cbOrganizationPhone.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbOrganizationPhone.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbOrganizationPhone.Font = new System.Drawing.Font("Tahoma", 7F);
            this.cbOrganizationPhone.FormattingEnabled = true;
            this.cbOrganizationPhone.Location = new System.Drawing.Point(139, 42);
            this.cbOrganizationPhone.Name = "cbOrganizationPhone";
            this.cbOrganizationPhone.Required = false;
            this.cbOrganizationPhone.Size = new System.Drawing.Size(121, 19);
            this.cbOrganizationPhone.TabIndex = 1;
            // 
            // ugAssociatedReferrals
            // 
            this.ugAssociatedReferrals.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugAssociatedReferrals.DisplayLayout.Appearance = appearance13;
            this.ugAssociatedReferrals.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugAssociatedReferrals.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance14.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance14.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance14.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedReferrals.DisplayLayout.GroupByBox.Appearance = appearance14;
            appearance15.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssociatedReferrals.DisplayLayout.GroupByBox.BandLabelAppearance = appearance15;
            this.ugAssociatedReferrals.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance16.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance16.BackColor2 = System.Drawing.SystemColors.Control;
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance16.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugAssociatedReferrals.DisplayLayout.GroupByBox.PromptAppearance = appearance16;
            this.ugAssociatedReferrals.DisplayLayout.MaxColScrollRegions = 1;
            this.ugAssociatedReferrals.DisplayLayout.MaxRowScrollRegions = 1;
            appearance17.BackColor = System.Drawing.SystemColors.Window;
            appearance17.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugAssociatedReferrals.DisplayLayout.Override.ActiveCellAppearance = appearance17;
            appearance18.BackColor = System.Drawing.SystemColors.Highlight;
            appearance18.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugAssociatedReferrals.DisplayLayout.Override.ActiveRowAppearance = appearance18;
            this.ugAssociatedReferrals.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugAssociatedReferrals.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance19.BackColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedReferrals.DisplayLayout.Override.CardAreaAppearance = appearance19;
            appearance20.BorderColor = System.Drawing.Color.Silver;
            appearance20.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugAssociatedReferrals.DisplayLayout.Override.CellAppearance = appearance20;
            this.ugAssociatedReferrals.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugAssociatedReferrals.DisplayLayout.Override.CellPadding = 0;
            appearance21.BackColor = System.Drawing.SystemColors.Control;
            appearance21.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance21.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance21.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance21.BorderColor = System.Drawing.SystemColors.Window;
            this.ugAssociatedReferrals.DisplayLayout.Override.GroupByRowAppearance = appearance21;
            appearance22.TextHAlignAsString = "Left";
            this.ugAssociatedReferrals.DisplayLayout.Override.HeaderAppearance = appearance22;
            this.ugAssociatedReferrals.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugAssociatedReferrals.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            appearance23.BackColor = System.Drawing.SystemColors.Window;
            appearance23.BorderColor = System.Drawing.Color.Silver;
            this.ugAssociatedReferrals.DisplayLayout.Override.RowAppearance = appearance23;
            this.ugAssociatedReferrals.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance24.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugAssociatedReferrals.DisplayLayout.Override.TemplateAddRowAppearance = appearance24;
            this.ugAssociatedReferrals.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugAssociatedReferrals.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugAssociatedReferrals.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugAssociatedReferrals.Location = new System.Drawing.Point(7, 94);
            this.ugAssociatedReferrals.Name = "ugAssociatedReferrals";
            this.ugAssociatedReferrals.Size = new System.Drawing.Size(846, 192);
            this.ugAssociatedReferrals.TabIndex = 3;
            this.ugAssociatedReferrals.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.Search;
            this.ugAssociatedReferrals.DoubleClick += new System.EventHandler(this.ugAssociatedReferrals_DoubleClick);
            this.ugAssociatedReferrals.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugAssociatedReferrals_InitializeLayout);
            // 
            // btnReassign
            // 
            this.btnReassign.Location = new System.Drawing.Point(264, 41);
            this.btnReassign.Name = "btnReassign";
            this.btnReassign.Size = new System.Drawing.Size(75, 23);
            this.btnReassign.TabIndex = 2;
            this.btnReassign.Text = "Reassign";
            this.btnReassign.UseVisualStyleBackColor = true;
            this.btnReassign.Click += new System.EventHandler(this.btnReassign_Click);
            // 
            // cbOrganization
            // 
            this.cbOrganization.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbOrganization.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbOrganization.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbOrganization.Font = new System.Drawing.Font("Tahoma", 7F);
            this.cbOrganization.FormattingEnabled = true;
            this.cbOrganization.Location = new System.Drawing.Point(139, 18);
            this.cbOrganization.Name = "cbOrganization";
            this.cbOrganization.Required = false;
            this.cbOrganization.Size = new System.Drawing.Size(185, 19);
            this.cbOrganization.TabIndex = 0;
            this.cbOrganization.SelectedIndexChanged += new System.EventHandler(this.cbOrganization_SelectedIndexChanged);
            this.cbOrganization.MouseDown += new System.Windows.Forms.MouseEventHandler(this.cbOrganization_MouseDown);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label4.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label4.Location = new System.Drawing.Point(7, 80);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(325, 13);
            this.label4.TabIndex = 2;
            this.label4.Text = "Associated Referrals (highlight the referrals you wish to reassign):";
            // 
            // lblReassignToNumber
            // 
            this.lblReassignToNumber.AutoSize = true;
            this.lblReassignToNumber.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblReassignToNumber.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblReassignToNumber.Location = new System.Drawing.Point(29, 46);
            this.lblReassignToNumber.Name = "lblReassignToNumber";
            this.lblReassignToNumber.Size = new System.Drawing.Size(109, 13);
            this.lblReassignToNumber.TabIndex = 1;
            this.lblReassignToNumber.Text = "Reassign To Number:";
            // 
            // lblReassignToOrganization
            // 
            this.lblReassignToOrganization.AutoSize = true;
            this.lblReassignToOrganization.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblReassignToOrganization.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblReassignToOrganization.Location = new System.Drawing.Point(7, 22);
            this.lblReassignToOrganization.Name = "lblReassignToOrganization";
            this.lblReassignToOrganization.Size = new System.Drawing.Size(133, 13);
            this.lblReassignToOrganization.TabIndex = 0;
            this.lblReassignToOrganization.Text = "Reassign To Organization:";
            // 
            // OrganizationAssociatedCall
            // 
            this.Controls.Add(this.groupBoxReassignNumbers);
            this.Name = "OrganizationAssociatedCall";
            this.Size = new System.Drawing.Size(859, 325);
            this.Load += new System.EventHandler(this.OrganizationAssociatedCall_Load);
            this.groupBoxReassignNumbers.ResumeLayout(false);
            this.groupBoxReassignNumbers.PerformLayout();
            this.panel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedReferrals)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.GroupBox groupBoxReassignNumbers;
        private Statline.Stattrac.Windows.Forms.ComboBox cbOrganizationPhone;
        private Statline.Stattrac.Windows.Forms.Button btnClearAssociatedReferrals;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugAssociatedReferrals;
        private Statline.Stattrac.Windows.Forms.Button btnReassign;
        private Statline.Stattrac.Windows.Forms.ComboBox cbOrganization;
        private Statline.Stattrac.Windows.Forms.Label label4;
        private Statline.Stattrac.Windows.Forms.Label lblReassignToNumber;
        private Statline.Stattrac.Windows.Forms.Label lblReassignToOrganization;
        private Statline.Stattrac.Windows.Forms.Panel panel1;
    }
}
