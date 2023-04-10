namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    partial class MessageControl
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
            this.btnAdd = new Statline.Stattrac.Windows.Forms.Button();
            this.txtScreenConfig = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblScreenConfig = new Statline.Stattrac.Windows.Forms.Label();
            this.chkDefaultSourceCode = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.chkInactive = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.groupBox1 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.ultraGrid1 = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid1)).BeginInit();
            this.SuspendLayout();
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(320, 59);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(75, 23);
            this.btnAdd.TabIndex = 11;
            this.btnAdd.Text = "&Add";
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // txtScreenConfig
            // 
            this.txtScreenConfig.Location = new System.Drawing.Point(132, 62);
            this.txtScreenConfig.MaxLength = 80;
            this.txtScreenConfig.Name = "txtScreenConfig";
            this.txtScreenConfig.Required = false;
            this.txtScreenConfig.Size = new System.Drawing.Size(172, 20);
            this.txtScreenConfig.SpellCheckEnabled = false;
            this.txtScreenConfig.TabIndex = 10;
            // 
            // lblScreenConfig
            // 
            this.lblScreenConfig.AutoSize = true;
            this.lblScreenConfig.Location = new System.Drawing.Point(17, 65);
            this.lblScreenConfig.Name = "lblScreenConfig";
            this.lblScreenConfig.Size = new System.Drawing.Size(109, 13);
            this.lblScreenConfig.TabIndex = 9;
            this.lblScreenConfig.Text = "Screen Configuration:";
            // 
            // chkDefaultSourceCode
            // 
            this.chkDefaultSourceCode.AutoSize = true;
            this.chkDefaultSourceCode.Checked = false;
            this.chkDefaultSourceCode.Location = new System.Drawing.Point(132, 39);
            this.chkDefaultSourceCode.Name = "chkDefaultSourceCode";
            this.chkDefaultSourceCode.Size = new System.Drawing.Size(172, 17);
            this.chkDefaultSourceCode.TabIndex = 8;
            this.chkDefaultSourceCode.Text = "Default Group for Source Code";
            this.chkDefaultSourceCode.UseVisualStyleBackColor = true;
            // 
            // chkInactive
            // 
            this.chkInactive.AutoSize = true;
            this.chkInactive.Checked = false;
            this.chkInactive.Location = new System.Drawing.Point(132, 15);
            this.chkInactive.Name = "chkInactive";
            this.chkInactive.Size = new System.Drawing.Size(64, 17);
            this.chkInactive.TabIndex = 7;
            this.chkInactive.Text = "Inactive";
            this.chkInactive.UseVisualStyleBackColor = true;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.ultraGrid1);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(20, 99);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(831, 357);
            this.groupBox1.TabIndex = 6;
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
            this.ultraGrid1.Location = new System.Drawing.Point(19, 29);
            this.ultraGrid1.Name = "ultraGrid1";
            this.ultraGrid1.Size = new System.Drawing.Size(795, 294);
            this.ultraGrid1.TabIndex = 0;
            this.ultraGrid1.Text = "ultraGrid1";
            this.ultraGrid1.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.None;
            this.ultraGrid1.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ultraGrid1_InitializeLayout);
            // 
            // MessageControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.btnAdd);
            this.Controls.Add(this.txtScreenConfig);
            this.Controls.Add(this.lblScreenConfig);
            this.Controls.Add(this.chkDefaultSourceCode);
            this.Controls.Add(this.chkInactive);
            this.Controls.Add(this.groupBox1);
            this.Name = "MessageControl";
            this.Load += new System.EventHandler(this.MessageControl_Load);
            this.groupBox1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Button btnAdd;
        private Statline.Stattrac.Windows.Forms.TextBox txtScreenConfig;
        private Statline.Stattrac.Windows.Forms.Label lblScreenConfig;
        private Statline.Stattrac.Windows.Forms.CheckBox chkDefaultSourceCode;
        private Statline.Stattrac.Windows.Forms.CheckBox chkInactive;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox1;
        private Statline.Stattrac.Windows.Forms.UltraGrid ultraGrid1;
    }
}
