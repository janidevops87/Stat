namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class DuplicateReferalsForm
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("TcssDuplicateReferals", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssRecipientId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateDate");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ImportOfferNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn6 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn7 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SourceCodeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn8 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Client");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn9 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MostRecentStatus");
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            this.ugTcssDuplicateReferals = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.tcssDuplicateReferalsDS = new Statline.Stattrac.Data.Types.NewCall.TcssDuplicateReferalsDS();
            ((System.ComponentModel.ISupportInitialize)(this.ugTcssDuplicateReferals)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tcssDuplicateReferalsDS)).BeginInit();
            this.SuspendLayout();
            // 
            // ugTcssDuplicateReferals
            // 
            this.ugTcssDuplicateReferals.DataMember = "TcssDuplicateReferals";
            this.ugTcssDuplicateReferals.DataSource = this.tcssDuplicateReferalsDS;
            appearance1.BackColor = System.Drawing.Color.Transparent;
            this.ugTcssDuplicateReferals.DisplayLayout.Appearance = appearance1;
            ultraGridColumn1.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn1.Width = 80;
            ultraGridColumn2.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn2.Header.VisiblePosition = 2;
            ultraGridColumn2.Hidden = true;
            ultraGridColumn3.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn3.Header.VisiblePosition = 1;
            ultraGridColumn3.Hidden = true;
            ultraGridColumn4.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn4.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridColumn5.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn5.Header.VisiblePosition = 4;
            ultraGridColumn6.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn6.Header.VisiblePosition = 5;
            ultraGridColumn6.Width = 110;
            ultraGridColumn7.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn7.Header.VisiblePosition = 6;
            ultraGridColumn8.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn8.Header.VisiblePosition = 7;
            ultraGridColumn9.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn9.Header.VisiblePosition = 8;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5,
            ultraGridColumn6,
            ultraGridColumn7,
            ultraGridColumn8,
            ultraGridColumn9});
            this.ugTcssDuplicateReferals.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ugTcssDuplicateReferals.DisplayLayout.Override.CardAreaAppearance = appearance2;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.FontData.BoldAsString = "True";
            appearance3.FontData.Name = "Arial";
            appearance3.FontData.SizeInPoints = 10F;
            appearance3.ForeColor = System.Drawing.Color.White;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugTcssDuplicateReferals.DisplayLayout.Override.HeaderAppearance = appearance3;
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugTcssDuplicateReferals.DisplayLayout.Override.RowSelectorAppearance = appearance4;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugTcssDuplicateReferals.DisplayLayout.Override.SelectedRowAppearance = appearance5;
            this.ugTcssDuplicateReferals.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugTcssDuplicateReferals.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugTcssDuplicateReferals.Location = new System.Drawing.Point(0, 0);
            this.ugTcssDuplicateReferals.Name = "ugTcssDuplicateReferals";
            this.ugTcssDuplicateReferals.Size = new System.Drawing.Size(609, 263);
            this.ugTcssDuplicateReferals.TabIndex = 0;
            this.ugTcssDuplicateReferals.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            this.ugTcssDuplicateReferals.DoubleClickRow += new Infragistics.Win.UltraWinGrid.DoubleClickRowEventHandler(this.ugTcssDuplicateReferals_DoubleClickRow);
            // 
            // tcssDuplicateReferalsDS
            // 
            this.tcssDuplicateReferalsDS.DataSetName = "TcssDuplicateReferalsDS";
            this.tcssDuplicateReferalsDS.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // DuplicateReferalsForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(609, 263);
            this.Controls.Add(this.ugTcssDuplicateReferals);
            this.Name = "DuplicateReferalsForm";
            this.Text = "Duplicate Referals";
            ((System.ComponentModel.ISupportInitialize)(this.ugTcssDuplicateReferals)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tcssDuplicateReferalsDS)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraGrid ugTcssDuplicateReferals;
		private Statline.Stattrac.Data.Types.NewCall.TcssDuplicateReferalsDS tcssDuplicateReferalsDS;
	}
}