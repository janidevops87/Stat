namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class TestDiagnosesControl
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("TcssDonorTest", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn8 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorTestId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn9 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateStatEmployeeId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn10 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateDate");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn11 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn12 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssListTestTypeId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn13 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TestDateTime");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn14 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Interpretation");
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            this.ugTestDiagnoses = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.tcssDS1 = new Statline.Stattrac.Data.Types.NewCall.TcssDS();
            ((System.ComponentModel.ISupportInitialize)(this.ugTestDiagnoses)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tcssDS1)).BeginInit();
            this.SuspendLayout();
            // 
            // ugTestDiagnoses
            // 
            this.ugTestDiagnoses.DataMember = "TcssDonorTest";
            this.ugTestDiagnoses.DataSource = this.tcssDS1;
            appearance1.BackColor = System.Drawing.Color.Transparent;
            this.ugTestDiagnoses.DisplayLayout.Appearance = appearance1;
            this.ugTestDiagnoses.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn8.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn8.Header.VisiblePosition = 0;
            ultraGridColumn8.Hidden = true;
            ultraGridColumn8.Width = 100;
            ultraGridColumn9.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn9.Header.VisiblePosition = 2;
            ultraGridColumn9.Hidden = true;
            ultraGridColumn9.Width = 100;
            ultraGridColumn10.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn10.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn10.Header.VisiblePosition = 3;
            ultraGridColumn10.Hidden = true;
            ultraGridColumn10.Width = 100;
            ultraGridColumn11.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn11.Header.VisiblePosition = 1;
            ultraGridColumn11.Hidden = true;
            ultraGridColumn11.Width = 100;
            ultraGridColumn12.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn12.Header.VisiblePosition = 4;
            ultraGridColumn12.Width = 152;
            ultraGridColumn13.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn13.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn13.Header.VisiblePosition = 5;
            ultraGridColumn13.Width = 151;
            ultraGridColumn14.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn14.Header.VisiblePosition = 6;
            ultraGridColumn14.Width = 453;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn8,
            ultraGridColumn9,
            ultraGridColumn10,
            ultraGridColumn11,
            ultraGridColumn12,
            ultraGridColumn13,
            ultraGridColumn14});
            this.ugTestDiagnoses.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugTestDiagnoses.DisplayLayout.MaxRowScrollRegions = 1;
            this.ugTestDiagnoses.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugTestDiagnoses.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugTestDiagnoses.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ugTestDiagnoses.DisplayLayout.Override.CardAreaAppearance = appearance2;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.FontData.BoldAsString = "True";
            appearance3.FontData.Name = "Tahoma";
            appearance3.FontData.SizeInPoints = 8F;
            appearance3.ForeColor = System.Drawing.Color.White;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugTestDiagnoses.DisplayLayout.Override.HeaderAppearance = appearance3;
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugTestDiagnoses.DisplayLayout.Override.RowSelectorAppearance = appearance4;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance5.ForeColor = System.Drawing.Color.Black;
            this.ugTestDiagnoses.DisplayLayout.Override.SelectedRowAppearance = appearance5;
            this.ugTestDiagnoses.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugTestDiagnoses.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugTestDiagnoses.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugTestDiagnoses.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugTestDiagnoses.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugTestDiagnoses.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugTestDiagnoses.Font = new System.Drawing.Font("Tahoma", 7F);
            this.ugTestDiagnoses.Location = new System.Drawing.Point(0, 0);
            this.ugTestDiagnoses.Name = "ugTestDiagnoses";
            this.ugTestDiagnoses.Size = new System.Drawing.Size(777, 445);
            this.ugTestDiagnoses.TabIndex = 0;
            this.ugTestDiagnoses.Text = "Tests & Diagnoses Details";
            this.ugTestDiagnoses.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugTestDiagnoses.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugTestDiagnoses_InitializeLayout);
            // 
            // tcssDS1
            // 
            this.tcssDS1.DataSetName = "TcssDS";
            this.tcssDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // TestDiagnosesControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.ugTestDiagnoses);
            this.Name = "TestDiagnosesControl";
            this.Size = new System.Drawing.Size(777, 445);
            ((System.ComponentModel.ISupportInitialize)(this.ugTestDiagnoses)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tcssDS1)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraGrid ugTestDiagnoses;
		private Statline.Stattrac.Data.Types.NewCall.TcssDS tcssDS1;
	}
}
