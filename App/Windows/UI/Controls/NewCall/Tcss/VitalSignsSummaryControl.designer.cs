namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class VitalSignsSummaryControl
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
            this.ugVitalSign = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.panel1 = new System.Windows.Forms.Panel();
            this.dteSao2CurrentToDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteSao2PeakToDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteSao2InitialToDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteSao2CurrentFromDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteSao2PeakFromDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.dteSao2InitialFromDate = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.label2 = new Statline.Stattrac.Windows.Forms.Label();
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            this.txtSao2Current = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblSao2Current = new Statline.Stattrac.Windows.Forms.Label();
            this.txtSao2Peak = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblSao2Peak = new Statline.Stattrac.Windows.Forms.Label();
            this.txtSao2Initial = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblSao2Initial = new Statline.Stattrac.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.ugVitalSign)).BeginInit();
            this.tableLayoutPanel1.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2CurrentToDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2PeakToDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2InitialToDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2CurrentFromDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2PeakFromDate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2InitialFromDate)).BeginInit();
            this.SuspendLayout();
            // 
            // ugVitalSign
            // 
            appearance1.BackColor = System.Drawing.Color.White;
            this.ugVitalSign.DisplayLayout.Appearance = appearance1;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ugVitalSign.DisplayLayout.Override.CardAreaAppearance = appearance2;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.FontData.BoldAsString = "True";
            appearance3.FontData.Name = "Arial";
            appearance3.FontData.SizeInPoints = 10F;
            appearance3.ForeColor = System.Drawing.Color.White;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugVitalSign.DisplayLayout.Override.HeaderAppearance = appearance3;
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugVitalSign.DisplayLayout.Override.RowSelectorAppearance = appearance4;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugVitalSign.DisplayLayout.Override.SelectedRowAppearance = appearance5;
            this.ugVitalSign.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugVitalSign.Location = new System.Drawing.Point(3, 103);
            this.ugVitalSign.Name = "ugVitalSign";
            this.ugVitalSign.Size = new System.Drawing.Size(704, 338);
            this.ugVitalSign.TabIndex = 0;
            this.ugVitalSign.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.VerticalReadOnly;
            this.ugVitalSign.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugVitalSign_InitializeLayout);
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.panel1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.ugVitalSign, 0, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 100F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle());
            this.tableLayoutPanel1.Size = new System.Drawing.Size(710, 444);
            this.tableLayoutPanel1.TabIndex = 1;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.dteSao2CurrentToDate);
            this.panel1.Controls.Add(this.dteSao2PeakToDate);
            this.panel1.Controls.Add(this.dteSao2InitialToDate);
            this.panel1.Controls.Add(this.dteSao2CurrentFromDate);
            this.panel1.Controls.Add(this.dteSao2PeakFromDate);
            this.panel1.Controls.Add(this.dteSao2InitialFromDate);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.txtSao2Current);
            this.panel1.Controls.Add(this.lblSao2Current);
            this.panel1.Controls.Add(this.txtSao2Peak);
            this.panel1.Controls.Add(this.lblSao2Peak);
            this.panel1.Controls.Add(this.txtSao2Initial);
            this.panel1.Controls.Add(this.lblSao2Initial);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(3, 3);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(704, 94);
            this.panel1.TabIndex = 0;
            // 
            // dteSao2CurrentToDate
            // 
            this.dteSao2CurrentToDate.Location = new System.Drawing.Point(379, 63);
            this.dteSao2CurrentToDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteSao2CurrentToDate.Name = "dteSao2CurrentToDate";
            this.dteSao2CurrentToDate.Size = new System.Drawing.Size(144, 21);
            this.dteSao2CurrentToDate.TabIndex = 9;
            // 
            // dteSao2PeakToDate
            // 
            this.dteSao2PeakToDate.Location = new System.Drawing.Point(379, 37);
            this.dteSao2PeakToDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteSao2PeakToDate.Name = "dteSao2PeakToDate";
            this.dteSao2PeakToDate.Size = new System.Drawing.Size(144, 21);
            this.dteSao2PeakToDate.TabIndex = 6;
            // 
            // dteSao2InitialToDate
            // 
            this.dteSao2InitialToDate.Location = new System.Drawing.Point(379, 11);
            this.dteSao2InitialToDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteSao2InitialToDate.Name = "dteSao2InitialToDate";
            this.dteSao2InitialToDate.Size = new System.Drawing.Size(144, 21);
            this.dteSao2InitialToDate.TabIndex = 3;
            // 
            // dteSao2CurrentFromDate
            // 
            this.dteSao2CurrentFromDate.Location = new System.Drawing.Point(208, 63);
            this.dteSao2CurrentFromDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteSao2CurrentFromDate.Name = "dteSao2CurrentFromDate";
            this.dteSao2CurrentFromDate.Size = new System.Drawing.Size(144, 21);
            this.dteSao2CurrentFromDate.TabIndex = 8;
            // 
            // dteSao2PeakFromDate
            // 
            this.dteSao2PeakFromDate.Location = new System.Drawing.Point(208, 37);
            this.dteSao2PeakFromDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteSao2PeakFromDate.Name = "dteSao2PeakFromDate";
            this.dteSao2PeakFromDate.Size = new System.Drawing.Size(144, 21);
            this.dteSao2PeakFromDate.TabIndex = 5;
            // 
            // dteSao2InitialFromDate
            // 
            this.dteSao2InitialFromDate.Location = new System.Drawing.Point(208, 11);
            this.dteSao2InitialFromDate.MaskInput = "mm/dd/yyyy hh:mm";
            this.dteSao2InitialFromDate.Name = "dteSao2InitialFromDate";
            this.dteSao2InitialFromDate.Size = new System.Drawing.Size(144, 21);
            this.dteSao2InitialFromDate.TabIndex = 2;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label2.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label2.Location = new System.Drawing.Point(376, -3);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(23, 13);
            this.label2.TabIndex = 17;
            this.label2.Text = "To:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label1.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label1.Location = new System.Drawing.Point(205, -3);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 16;
            this.label1.Text = "From:";
            // 
            // txtSao2Current
            // 
            this.txtSao2Current.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtSao2Current.Location = new System.Drawing.Point(98, 65);
            this.txtSao2Current.Name = "txtSao2Current";
            this.txtSao2Current.Required = false;
            this.txtSao2Current.Size = new System.Drawing.Size(100, 20);
            this.txtSao2Current.SpellCheckEnabled = false;
            this.txtSao2Current.TabIndex = 7;
            // 
            // lblSao2Current
            // 
            this.lblSao2Current.AutoSize = true;
            this.lblSao2Current.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblSao2Current.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblSao2Current.Location = new System.Drawing.Point(15, 65);
            this.lblSao2Current.Name = "lblSao2Current";
            this.lblSao2Current.Size = new System.Drawing.Size(86, 13);
            this.lblSao2Current.TabIndex = 4;
            this.lblSao2Current.Text = "Sa02% Current:";
            // 
            // txtSao2Peak
            // 
            this.txtSao2Peak.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtSao2Peak.Location = new System.Drawing.Point(98, 39);
            this.txtSao2Peak.Name = "txtSao2Peak";
            this.txtSao2Peak.Required = false;
            this.txtSao2Peak.Size = new System.Drawing.Size(100, 20);
            this.txtSao2Peak.SpellCheckEnabled = false;
            this.txtSao2Peak.TabIndex = 4;
            // 
            // lblSao2Peak
            // 
            this.lblSao2Peak.AutoSize = true;
            this.lblSao2Peak.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblSao2Peak.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblSao2Peak.Location = new System.Drawing.Point(15, 39);
            this.lblSao2Peak.Name = "lblSao2Peak";
            this.lblSao2Peak.Size = new System.Drawing.Size(72, 13);
            this.lblSao2Peak.TabIndex = 2;
            this.lblSao2Peak.Text = "Sa02% Peak:";
            // 
            // txtSao2Initial
            // 
            this.txtSao2Initial.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtSao2Initial.Location = new System.Drawing.Point(98, 13);
            this.txtSao2Initial.Name = "txtSao2Initial";
            this.txtSao2Initial.Required = false;
            this.txtSao2Initial.Size = new System.Drawing.Size(100, 20);
            this.txtSao2Initial.SpellCheckEnabled = false;
            this.txtSao2Initial.TabIndex = 1;
            // 
            // lblSao2Initial
            // 
            this.lblSao2Initial.AutoSize = true;
            this.lblSao2Initial.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblSao2Initial.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblSao2Initial.Location = new System.Drawing.Point(15, 13);
            this.lblSao2Initial.Name = "lblSao2Initial";
            this.lblSao2Initial.Size = new System.Drawing.Size(75, 13);
            this.lblSao2Initial.TabIndex = 0;
            this.lblSao2Initial.Text = "Sa02% Initial:";
            // 
            // VitalSignsSummaryControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "VitalSignsSummaryControl";
            this.Size = new System.Drawing.Size(710, 444);
            ((System.ComponentModel.ISupportInitialize)(this.ugVitalSign)).EndInit();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2CurrentToDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2PeakToDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2InitialToDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2CurrentFromDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2PeakFromDate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dteSao2InitialFromDate)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraGrid ugVitalSign;
		private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
		private System.Windows.Forms.Panel panel1;
		private Statline.Stattrac.Windows.Forms.TextBox txtSao2Current;
		private Statline.Stattrac.Windows.Forms.Label lblSao2Current;
		private Statline.Stattrac.Windows.Forms.TextBox txtSao2Peak;
		private Statline.Stattrac.Windows.Forms.Label lblSao2Peak;
		private Statline.Stattrac.Windows.Forms.TextBox txtSao2Initial;
        private Statline.Stattrac.Windows.Forms.Label lblSao2Initial;
        private Statline.Stattrac.Windows.Forms.Label label2;
        private Statline.Stattrac.Windows.Forms.Label label1;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteSao2CurrentToDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteSao2PeakToDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteSao2InitialToDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteSao2CurrentFromDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteSao2PeakFromDate;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor dteSao2InitialFromDate;
	}
}
