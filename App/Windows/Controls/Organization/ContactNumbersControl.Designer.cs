namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class ContactNumbersControl
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
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.lblContactFirstName = new Statline.Stattrac.Windows.Forms.Label();
            this.lblContactLastName = new Statline.Stattrac.Windows.Forms.Label();
            this.ugPersonPhone = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.flowLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugPersonPhone)).BeginInit();
            this.SuspendLayout();
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.flowLayoutPanel1.Controls.Add(this.lblContactFirstName);
            this.flowLayoutPanel1.Controls.Add(this.lblContactLastName);
            this.flowLayoutPanel1.Location = new System.Drawing.Point(0, 15);
            this.flowLayoutPanel1.Margin = new System.Windows.Forms.Padding(0, 3, 3, 3);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(230, 13);
            this.flowLayoutPanel1.TabIndex = 10;
            // 
            // lblContactFirstName
            // 
            this.lblContactFirstName.AutoSize = true;
            this.lblContactFirstName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblContactFirstName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblContactFirstName.Location = new System.Drawing.Point(3, 0);
            this.lblContactFirstName.Margin = new System.Windows.Forms.Padding(3, 0, 0, 0);
            this.lblContactFirstName.Name = "lblContactFirstName";
            this.lblContactFirstName.Size = new System.Drawing.Size(20, 13);
            this.lblContactFirstName.TabIndex = 0;
            this.lblContactFirstName.Text = "FN";
            // 
            // lblContactLastName
            // 
            this.lblContactLastName.AutoSize = true;
            this.lblContactLastName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblContactLastName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblContactLastName.Location = new System.Drawing.Point(23, 0);
            this.lblContactLastName.Margin = new System.Windows.Forms.Padding(0, 0, 3, 0);
            this.lblContactLastName.Name = "lblContactLastName";
            this.lblContactLastName.Size = new System.Drawing.Size(19, 13);
            this.lblContactLastName.TabIndex = 0;
            this.lblContactLastName.Text = "LN";
            // 
            // ugPersonPhone
            // 
            this.ugPersonPhone.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            appearance13.BackColor = System.Drawing.SystemColors.Window;
            appearance13.BorderColor = System.Drawing.SystemColors.InactiveCaption;
            this.ugPersonPhone.DisplayLayout.Appearance = appearance13;
            this.ugPersonPhone.DisplayLayout.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            this.ugPersonPhone.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            appearance14.BackColor = System.Drawing.SystemColors.ActiveBorder;
            appearance14.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance14.BorderColor = System.Drawing.SystemColors.Window;
            this.ugPersonPhone.DisplayLayout.GroupByBox.Appearance = appearance14;
            appearance15.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugPersonPhone.DisplayLayout.GroupByBox.BandLabelAppearance = appearance15;
            this.ugPersonPhone.DisplayLayout.GroupByBox.BorderStyle = Infragistics.Win.UIElementBorderStyle.Solid;
            appearance16.BackColor = System.Drawing.SystemColors.ControlLightLight;
            appearance16.BackColor2 = System.Drawing.SystemColors.Control;
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance16.ForeColor = System.Drawing.SystemColors.GrayText;
            this.ugPersonPhone.DisplayLayout.GroupByBox.PromptAppearance = appearance16;
            this.ugPersonPhone.DisplayLayout.MaxColScrollRegions = 1;
            this.ugPersonPhone.DisplayLayout.MaxRowScrollRegions = 1;
            appearance17.BackColor = System.Drawing.SystemColors.Window;
            appearance17.ForeColor = System.Drawing.SystemColors.ControlText;
            this.ugPersonPhone.DisplayLayout.Override.ActiveCellAppearance = appearance17;
            appearance18.BackColor = System.Drawing.SystemColors.Highlight;
            appearance18.ForeColor = System.Drawing.SystemColors.HighlightText;
            this.ugPersonPhone.DisplayLayout.Override.ActiveRowAppearance = appearance18;
            this.ugPersonPhone.DisplayLayout.Override.BorderStyleCell = Infragistics.Win.UIElementBorderStyle.Dotted;
            this.ugPersonPhone.DisplayLayout.Override.BorderStyleRow = Infragistics.Win.UIElementBorderStyle.Dotted;
            appearance19.BackColor = System.Drawing.SystemColors.Window;
            this.ugPersonPhone.DisplayLayout.Override.CardAreaAppearance = appearance19;
            appearance20.BorderColor = System.Drawing.Color.Silver;
            appearance20.TextTrimming = Infragistics.Win.TextTrimming.EllipsisCharacter;
            this.ugPersonPhone.DisplayLayout.Override.CellAppearance = appearance20;
            this.ugPersonPhone.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.EditAndSelectText;
            this.ugPersonPhone.DisplayLayout.Override.CellPadding = 0;
            appearance21.BackColor = System.Drawing.SystemColors.Control;
            appearance21.BackColor2 = System.Drawing.SystemColors.ControlDark;
            appearance21.BackGradientAlignment = Infragistics.Win.GradientAlignment.Element;
            appearance21.BackGradientStyle = Infragistics.Win.GradientStyle.Horizontal;
            appearance21.BorderColor = System.Drawing.SystemColors.Window;
            this.ugPersonPhone.DisplayLayout.Override.GroupByRowAppearance = appearance21;
            appearance22.TextHAlignAsString = "Left";
            this.ugPersonPhone.DisplayLayout.Override.HeaderAppearance = appearance22;
            this.ugPersonPhone.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugPersonPhone.DisplayLayout.Override.HeaderStyle = Infragistics.Win.HeaderStyle.WindowsXPCommand;
            this.ugPersonPhone.DisplayLayout.Override.InvalidValueBehavior = Infragistics.Win.UltraWinGrid.InvalidValueBehavior.RevertValue;
            appearance23.BackColor = System.Drawing.SystemColors.Window;
            appearance23.BorderColor = System.Drawing.Color.Silver;
            this.ugPersonPhone.DisplayLayout.Override.RowAppearance = appearance23;
            this.ugPersonPhone.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance24.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ugPersonPhone.DisplayLayout.Override.TemplateAddRowAppearance = appearance24;
            this.ugPersonPhone.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugPersonPhone.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugPersonPhone.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ugPersonPhone.Location = new System.Drawing.Point(6, 35);
            this.ugPersonPhone.Name = "ugPersonPhone";
            this.ugPersonPhone.Size = new System.Drawing.Size(966, 178);
            this.ugPersonPhone.TabIndex = 0;
            this.ugPersonPhone.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugPersonPhone.AfterRowUpdate += new Infragistics.Win.UltraWinGrid.RowEventHandler(this.ugPersonPhone_AfterRowUpdate);
            this.ugPersonPhone.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugPersonPhone_InitializeLayout);
            // 
            // ContactNumbersControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScroll = false;
            this.Controls.Add(this.ugPersonPhone);
            this.Controls.Add(this.flowLayoutPanel1);
            this.Name = "ContactNumbersControl";
            this.Size = new System.Drawing.Size(975, 225);
            this.flowLayoutPanel1.ResumeLayout(false);
            this.flowLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugPersonPhone)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private Statline.Stattrac.Windows.Forms.Label lblContactFirstName;
        private Statline.Stattrac.Windows.Forms.Label lblContactLastName;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugPersonPhone;

    }
}
