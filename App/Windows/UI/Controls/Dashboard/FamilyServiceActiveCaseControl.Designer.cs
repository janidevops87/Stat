namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
	partial class FamilyServiceActiveCaseControl
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
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("FsbActiveCases", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn18 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn19 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastModified", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Ascending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn20 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SourceCodeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn21 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PatientFirst");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn22 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PatientLast");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn23 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CoordinatorFirst");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn24 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CoordinatorLast");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn25 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MostRecentStatus");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn26 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MostRecentComment");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn27 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PreviousCoordinatorFirst");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn28 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PreviousCoordinatorLast");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn29 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Color");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn30 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn31 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastModifiedBegin");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn32 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("expirationminutes");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn33 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastModifiedEnd");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn34 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ToDate", 0);
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            this.fsbActiveCasesDS = new Statline.Stattrac.Data.Types.Dashboard.FsbActiveCasesDS();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.fsbActiveCasesDS)).BeginInit();
            this.SuspendLayout();
            // 
            // btnDelete
            // 
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnSearch
            // 
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // ultraGrid
            // 
            this.ultraGrid.DataMember = "FsbActiveCases";
            this.ultraGrid.DataSource = this.fsbActiveCasesDS;
            appearance9.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Appearance = appearance9;
            this.ultraGrid.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn18.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn18.Header.VisiblePosition = 0;
            ultraGridColumn18.Width = 8;
            ultraGridColumn19.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn19.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn19.Header.VisiblePosition = 1;
            ultraGridColumn19.Width = 146;
            ultraGridColumn20.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn20.Header.VisiblePosition = 3;
            ultraGridColumn20.Width = 45;
            ultraGridColumn21.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn21.Header.VisiblePosition = 4;
            ultraGridColumn21.Width = 57;
            ultraGridColumn22.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn22.Header.VisiblePosition = 5;
            ultraGridColumn22.Width = 53;
            ultraGridColumn23.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn23.Header.VisiblePosition = 6;
            ultraGridColumn23.Width = 63;
            ultraGridColumn24.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn24.Header.VisiblePosition = 7;
            ultraGridColumn24.Width = 63;
            ultraGridColumn25.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn25.Header.VisiblePosition = 8;
            ultraGridColumn25.Width = 67;
            ultraGridColumn26.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn26.Header.VisiblePosition = 9;
            ultraGridColumn26.Width = 76;
            ultraGridColumn27.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn27.Header.VisiblePosition = 10;
            ultraGridColumn27.Width = 40;
            ultraGridColumn28.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn28.Header.VisiblePosition = 11;
            ultraGridColumn28.Width = 38;
            ultraGridColumn29.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn29.Header.VisiblePosition = 12;
            ultraGridColumn29.Hidden = true;
            ultraGridColumn30.Header.VisiblePosition = 13;
            ultraGridColumn30.Hidden = true;
            ultraGridColumn30.Width = 89;
            ultraGridColumn31.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn31.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn31.Header.VisiblePosition = 14;
            ultraGridColumn31.Hidden = true;
            ultraGridColumn32.Header.VisiblePosition = 15;
            ultraGridColumn32.Hidden = true;
            ultraGridColumn32.Width = 102;
            ultraGridColumn33.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn33.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn33.Header.VisiblePosition = 16;
            ultraGridColumn33.Hidden = true;
            ultraGridColumn34.DataType = typeof(System.DateTime);
            ultraGridColumn34.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn34.Header.Caption = "";
            ultraGridColumn34.Header.VisiblePosition = 2;
            ultraGridColumn34.Width = 129;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn18,
            ultraGridColumn19,
            ultraGridColumn20,
            ultraGridColumn21,
            ultraGridColumn22,
            ultraGridColumn23,
            ultraGridColumn24,
            ultraGridColumn25,
            ultraGridColumn26,
            ultraGridColumn27,
            ultraGridColumn28,
            ultraGridColumn29,
            ultraGridColumn30,
            ultraGridColumn31,
            ultraGridColumn32,
            ultraGridColumn33,
            ultraGridColumn34});
            this.ultraGrid.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            appearance10.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance10.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance10.BackHatchStyle = Infragistics.Win.BackHatchStyle.Horizontal;
            this.ultraGrid.DisplayLayout.Override.ActiveCellAppearance = appearance10;
            appearance11.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance11.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.ActiveRowAppearance = appearance11;
            this.ultraGrid.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.ultraGrid.DisplayLayout.Override.AllowColMoving = Infragistics.Win.UltraWinGrid.AllowColMoving.NotAllowed;
            this.ultraGrid.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.False;
            this.ultraGrid.DisplayLayout.Override.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.True;
            this.ultraGrid.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Override.CardAreaAppearance = appearance12;
            this.ultraGrid.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.RowSelect;
            this.ultraGrid.DisplayLayout.Override.FilterClearButtonLocation = Infragistics.Win.UltraWinGrid.FilterClearButtonLocation.Hidden;
            this.ultraGrid.DisplayLayout.Override.FilterEvaluationTrigger = Infragistics.Win.UltraWinGrid.FilterEvaluationTrigger.OnCellValueChange;
            this.ultraGrid.DisplayLayout.Override.FilterOperandStyle = Infragistics.Win.UltraWinGrid.FilterOperandStyle.UseColumnEditor;
            this.ultraGrid.DisplayLayout.Override.FilterOperatorDefaultValue = Infragistics.Win.UltraWinGrid.FilterOperatorDefaultValue.StartsWith;
            this.ultraGrid.DisplayLayout.Override.FilterOperatorLocation = Infragistics.Win.UltraWinGrid.FilterOperatorLocation.Hidden;
            appearance13.BackColor = System.Drawing.Color.WhiteSmoke;
            appearance13.BackColor2 = System.Drawing.Color.LightGray;
            appearance13.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.FilterRowAppearance = appearance13;
            this.ultraGrid.DisplayLayout.Override.FilterUIType = Infragistics.Win.UltraWinGrid.FilterUIType.FilterRow;
            appearance14.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance14.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance14.FontData.BoldAsString = "True";
            appearance14.FontData.Name = "Tahoma";
            appearance14.FontData.SizeInPoints = 8F;
            appearance14.ForeColor = System.Drawing.Color.White;
            appearance14.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ultraGrid.DisplayLayout.Override.HeaderAppearance = appearance14;
            this.ultraGrid.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            appearance15.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance15.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance15.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.RowSelectorAppearance = appearance15;
            this.ultraGrid.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.True;
            this.ultraGrid.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFixed;
            appearance16.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance16.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance16.ForeColor = System.Drawing.Color.Black;
            this.ultraGrid.DisplayLayout.Override.SelectedRowAppearance = appearance16;
            this.ultraGrid.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.None;
            this.ultraGrid.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ultraGrid.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
            this.ultraGrid.Font = new System.Drawing.Font("Tahoma", 7F);
            this.ultraGrid.MinimumSize = new System.Drawing.Size(500, 200);
            this.ultraGrid.Size = new System.Drawing.Size(806, 468);
            this.ultraGrid.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ultraGrid_InitializeRow);
            this.ultraGrid.CellDataError += new Infragistics.Win.UltraWinGrid.CellDataErrorEventHandler(this.ultraGrid_CellDataError);
            this.ultraGrid.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ultraGrid_InitializeLayout);
            // 
            // splitContainer
            // 
            this.splitContainer.Size = new System.Drawing.Size(806, 502);
            // 
            // btnClearFilter
            // 
            this.btnClearFilter.Click += new System.EventHandler(this.btnClearFilter_Click);
            // 
            // fsbActiveCasesDS
            // 
            this.fsbActiveCasesDS.DataSetName = "FsbActiveCasesDS";
            this.fsbActiveCasesDS.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // FamilyServiceActiveCaseControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.MinimumSize = new System.Drawing.Size(702, 200);
            this.Name = "FamilyServiceActiveCaseControl";
            this.Size = new System.Drawing.Size(806, 502);
            this.Controls.SetChildIndex(this.splitContainer, 0);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.fsbActiveCasesDS)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Data.Types.Dashboard.FsbActiveCasesDS fsbActiveCasesDS;
	}
}
