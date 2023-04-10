namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class LabProfileSummaryControl
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
            this.ugLabProfileSummary = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.panel1 = new System.Windows.Forms.Panel();
            this.dteAlcHbalcCurrentFromDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteAlcHbalcPeakFromDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteAlcHbalcCurrentToDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteAlcHbalcPeakToDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteAlcHbalcInitialToDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteAlcHbalcInitialFromDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.label2 = new Statline.Stattrac.Windows.Forms.Label();
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            this.txtAlcHbalcCurrent = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblAlcHbalcCurrent = new Statline.Stattrac.Windows.Forms.Label();
            this.txtAlcHbalcPeak = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblAlcHbalcPeak = new Statline.Stattrac.Windows.Forms.Label();
            this.txtAlcHbalcInitial = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblAlcHbalcInitial = new Statline.Stattrac.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.ugLabProfileSummary)).BeginInit();
            this.tableLayoutPanel1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcCurrentFromDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcPeakFromDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcCurrentToDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcPeakToDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcInitialToDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcInitialFromDate)).BeginInit();
            this.SuspendLayout();
            // 
            // ugLabProfileSummary
            // 
            appearance1.BackColor = System.Drawing.Color.White;
            this.ugLabProfileSummary.DisplayLayout.Appearance = appearance1;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ugLabProfileSummary.DisplayLayout.Override.CardAreaAppearance = appearance2;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.FontData.BoldAsString = "True";
            appearance3.FontData.Name = "Arial";
            appearance3.FontData.SizeInPoints = 10F;
            appearance3.ForeColor = System.Drawing.Color.White;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugLabProfileSummary.DisplayLayout.Override.HeaderAppearance = appearance3;
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugLabProfileSummary.DisplayLayout.Override.RowSelectorAppearance = appearance4;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugLabProfileSummary.DisplayLayout.Override.SelectedRowAppearance = appearance5;
            this.ugLabProfileSummary.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugLabProfileSummary.Location = new System.Drawing.Point(3, 103);
            this.ugLabProfileSummary.Name = "ugLabProfileSummary";
            this.ugLabProfileSummary.Size = new System.Drawing.Size(785, 404);
            this.ugLabProfileSummary.TabIndex = 0;
            this.ugLabProfileSummary.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.VerticalReadOnly;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.panel1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.ugLabProfileSummary, 0, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 100F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel1.Size = new System.Drawing.Size(791, 510);
            this.tableLayoutPanel1.TabIndex = 1;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.dteAlcHbalcCurrentFromDate);
            this.panel1.Controls.Add(this.dteAlcHbalcPeakFromDate);
            this.panel1.Controls.Add(this.dteAlcHbalcCurrentToDate);
            this.panel1.Controls.Add(this.dteAlcHbalcPeakToDate);
            this.panel1.Controls.Add(this.dteAlcHbalcInitialToDate);
            this.panel1.Controls.Add(this.dteAlcHbalcInitialFromDate);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.txtAlcHbalcCurrent);
            this.panel1.Controls.Add(this.lblAlcHbalcCurrent);
            this.panel1.Controls.Add(this.txtAlcHbalcPeak);
            this.panel1.Controls.Add(this.lblAlcHbalcPeak);
            this.panel1.Controls.Add(this.txtAlcHbalcInitial);
            this.panel1.Controls.Add(this.lblAlcHbalcInitial);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(3, 3);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(785, 94);
            this.panel1.TabIndex = 0;
            // 
            // dteAlcHbalcCurrentFromDate
            // 
            this.dteAlcHbalcCurrentFromDate.Location = new System.Drawing.Point(416, 65);
            this.dteAlcHbalcCurrentFromDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteAlcHbalcCurrentFromDate.Name = "dteAlcHbalcCurrentFromDate";
            this.dteAlcHbalcCurrentFromDate.Size = new System.Drawing.Size(144, 21);
            this.dteAlcHbalcCurrentFromDate.TabIndex = 9;
            // 
            // dteAlcHbalcPeakFromDate
            // 
            this.dteAlcHbalcPeakFromDate.Location = new System.Drawing.Point(416, 40);
            this.dteAlcHbalcPeakFromDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteAlcHbalcPeakFromDate.Name = "dteAlcHbalcPeakFromDate";
            this.dteAlcHbalcPeakFromDate.Size = new System.Drawing.Size(144, 21);
            this.dteAlcHbalcPeakFromDate.TabIndex = 6;
            // 
            // dteAlcHbalcCurrentToDate
            // 
            this.dteAlcHbalcCurrentToDate.Location = new System.Drawing.Point(261, 66);
            this.dteAlcHbalcCurrentToDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteAlcHbalcCurrentToDate.Name = "dteAlcHbalcCurrentToDate";
            this.dteAlcHbalcCurrentToDate.Size = new System.Drawing.Size(144, 21);
            this.dteAlcHbalcCurrentToDate.TabIndex = 8;
            // 
            // dteAlcHbalcPeakToDate
            // 
            this.dteAlcHbalcPeakToDate.Location = new System.Drawing.Point(261, 40);
            this.dteAlcHbalcPeakToDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteAlcHbalcPeakToDate.Name = "dteAlcHbalcPeakToDate";
            this.dteAlcHbalcPeakToDate.Size = new System.Drawing.Size(144, 21);
            this.dteAlcHbalcPeakToDate.TabIndex = 5;
            // 
            // dteAlcHbalcInitialToDate
            // 
            this.dteAlcHbalcInitialToDate.Location = new System.Drawing.Point(416, 14);
            this.dteAlcHbalcInitialToDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteAlcHbalcInitialToDate.Name = "dteAlcHbalcInitialToDate";
            this.dteAlcHbalcInitialToDate.Size = new System.Drawing.Size(144, 21);
            this.dteAlcHbalcInitialToDate.TabIndex = 3;
            // 
            // dteAlcHbalcInitialFromDate
            // 
            this.dteAlcHbalcInitialFromDate.Location = new System.Drawing.Point(261, 14);
            this.dteAlcHbalcInitialFromDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteAlcHbalcInitialFromDate.Name = "dteAlcHbalcInitialFromDate";
            this.dteAlcHbalcInitialFromDate.Size = new System.Drawing.Size(144, 21);
            this.dteAlcHbalcInitialFromDate.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label2.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label2.Location = new System.Drawing.Point(413, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(23, 13);
            this.label2.TabIndex = 9;
            this.label2.Text = "To:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label1.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label1.Location = new System.Drawing.Point(258, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 8;
            this.label1.Text = "From:";
            // 
            // txtAlcHbalcCurrent
            // 
            this.txtAlcHbalcCurrent.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtAlcHbalcCurrent.Location = new System.Drawing.Point(146, 68);
            this.txtAlcHbalcCurrent.Name = "txtAlcHbalcCurrent";
            this.txtAlcHbalcCurrent.Required = false;
            this.txtAlcHbalcCurrent.Size = new System.Drawing.Size(100, 20);
            this.txtAlcHbalcCurrent.SpellCheckEnabled = false;
            this.txtAlcHbalcCurrent.TabIndex = 7;
            // 
            // lblAlcHbalcCurrent
            // 
            this.lblAlcHbalcCurrent.AutoSize = true;
            this.lblAlcHbalcCurrent.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblAlcHbalcCurrent.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblAlcHbalcCurrent.Location = new System.Drawing.Point(15, 68);
            this.lblAlcHbalcCurrent.Name = "lblAlcHbalcCurrent";
            this.lblAlcHbalcCurrent.Size = new System.Drawing.Size(132, 13);
            this.lblAlcHbalcCurrent.TabIndex = 4;
            this.lblAlcHbalcCurrent.Text = "Alc/HbAlc (<6%) Current:";
            // 
            // txtAlcHbalcPeak
            // 
            this.txtAlcHbalcPeak.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtAlcHbalcPeak.Location = new System.Drawing.Point(146, 42);
            this.txtAlcHbalcPeak.Name = "txtAlcHbalcPeak";
            this.txtAlcHbalcPeak.Required = false;
            this.txtAlcHbalcPeak.Size = new System.Drawing.Size(100, 20);
            this.txtAlcHbalcPeak.SpellCheckEnabled = false;
            this.txtAlcHbalcPeak.TabIndex = 4;
            // 
            // lblAlcHbalcPeak
            // 
            this.lblAlcHbalcPeak.AutoSize = true;
            this.lblAlcHbalcPeak.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblAlcHbalcPeak.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblAlcHbalcPeak.Location = new System.Drawing.Point(15, 42);
            this.lblAlcHbalcPeak.Name = "lblAlcHbalcPeak";
            this.lblAlcHbalcPeak.Size = new System.Drawing.Size(118, 13);
            this.lblAlcHbalcPeak.TabIndex = 2;
            this.lblAlcHbalcPeak.Text = "Alc/HbAlc (<6%) Peak:";
            // 
            // txtAlcHbalcInitial
            // 
            this.txtAlcHbalcInitial.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtAlcHbalcInitial.Location = new System.Drawing.Point(146, 16);
            this.txtAlcHbalcInitial.Name = "txtAlcHbalcInitial";
            this.txtAlcHbalcInitial.Required = false;
            this.txtAlcHbalcInitial.Size = new System.Drawing.Size(100, 20);
            this.txtAlcHbalcInitial.SpellCheckEnabled = false;
            this.txtAlcHbalcInitial.TabIndex = 1;
            // 
            // lblAlcHbalcInitial
            // 
            this.lblAlcHbalcInitial.AutoSize = true;
            this.lblAlcHbalcInitial.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblAlcHbalcInitial.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblAlcHbalcInitial.Location = new System.Drawing.Point(15, 16);
            this.lblAlcHbalcInitial.Name = "lblAlcHbalcInitial";
            this.lblAlcHbalcInitial.Size = new System.Drawing.Size(121, 13);
            this.lblAlcHbalcInitial.TabIndex = 0;
            this.lblAlcHbalcInitial.Text = "Alc/HbAlc (<6%) Initial:";
            // 
            // LabProfileSummaryControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "LabProfileSummaryControl";
            this.Size = new System.Drawing.Size(791, 510);
            ((System.ComponentModel.ISupportInitialize)(this.ugLabProfileSummary)).EndInit();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcCurrentFromDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcPeakFromDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcCurrentToDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcPeakToDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcInitialToDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteAlcHbalcInitialFromDate)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraGrid ugLabProfileSummary;
		private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
		private System.Windows.Forms.Panel panel1;
		private Statline.Stattrac.Windows.Forms.TextBox txtAlcHbalcCurrent;
		private Statline.Stattrac.Windows.Forms.Label lblAlcHbalcCurrent;
		private Statline.Stattrac.Windows.Forms.TextBox txtAlcHbalcPeak;
		private Statline.Stattrac.Windows.Forms.Label lblAlcHbalcPeak;
		private Statline.Stattrac.Windows.Forms.TextBox txtAlcHbalcInitial;
        private Statline.Stattrac.Windows.Forms.Label lblAlcHbalcInitial;
        private Statline.Stattrac.Windows.Forms.Label label2;
        private Statline.Stattrac.Windows.Forms.Label label1;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteAlcHbalcCurrentFromDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteAlcHbalcPeakFromDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteAlcHbalcCurrentToDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteAlcHbalcPeakToDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteAlcHbalcInitialToDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteAlcHbalcInitialFromDate;
	}
}
