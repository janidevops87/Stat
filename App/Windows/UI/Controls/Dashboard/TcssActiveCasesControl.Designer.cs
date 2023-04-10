namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
	partial class TcssActiveCasesControl
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("TcssActiveCases", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn20 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn21 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssRecipientId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn22 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn23 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastModified");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn24 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Client");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn25 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ImportOfferNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn26 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn27 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganType");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn28 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OptnNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn29 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MatchId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn30 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TransplantSurgeonContact");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn31 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ClinicalCoordinator");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn32 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CoordinatorFirstName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn33 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CoordinatorLastName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn34 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MostRecentStatus");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn35 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("expirationminutes");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn36 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("pendingexpirationminutes");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn37 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MostRecentComment");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn38 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ToDate", 0);
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            this.tcssActiveCasesDS1 = new Statline.Stattrac.Data.Types.Dashboard.TcssActiveCasesDS();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tcssActiveCasesDS1)).BeginInit();
            this.SuspendLayout();
            // 
            // btnDelete
            // 
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnSearch
            // 
            this.btnSearch.Click += new System.EventHandler(this.btnSearchClosed_Click);
            // 
            // ultraGrid
            // 
            this.ultraGrid.DataMember = "TcssActiveCases";
            this.ultraGrid.DataSource = this.tcssActiveCasesDS1;
            appearance9.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Appearance = appearance9;
            this.ultraGrid.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn20.Header.VisiblePosition = 0;
            ultraGridColumn20.Width = 11;
            ultraGridColumn21.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn21.Header.VisiblePosition = 1;
            ultraGridColumn21.Hidden = true;
            ultraGridColumn21.Width = 50;
            ultraGridColumn22.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn22.Header.VisiblePosition = 2;
            ultraGridColumn22.Hidden = true;
            ultraGridColumn22.Width = 50;
            ultraGridColumn23.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn23.Header.VisiblePosition = 3;
            ultraGridColumn23.Width = 134;
            ultraGridColumn24.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn24.Header.VisiblePosition = 5;
            ultraGridColumn24.Width = 55;
            ultraGridColumn25.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn25.Header.VisiblePosition = 6;
            ultraGridColumn25.Width = 45;
            ultraGridColumn26.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn26.Header.VisiblePosition = 7;
            ultraGridColumn26.Width = 54;
            ultraGridColumn27.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn27.Header.VisiblePosition = 8;
            ultraGridColumn27.Width = 39;
            ultraGridColumn28.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn28.Header.VisiblePosition = 9;
            ultraGridColumn28.Width = 39;
            ultraGridColumn29.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn29.Header.VisiblePosition = 10;
            ultraGridColumn29.Width = 39;
            ultraGridColumn30.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn30.Header.VisiblePosition = 11;
            ultraGridColumn30.Width = 39;
            ultraGridColumn31.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn31.Header.VisiblePosition = 12;
            ultraGridColumn31.Width = 39;
            ultraGridColumn32.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn32.Header.VisiblePosition = 13;
            ultraGridColumn32.Width = 39;
            ultraGridColumn33.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn33.Header.VisiblePosition = 14;
            ultraGridColumn33.Width = 39;
            ultraGridColumn34.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn34.Header.VisiblePosition = 15;
            ultraGridColumn34.Width = 39;
            ultraGridColumn35.Header.VisiblePosition = 16;
            ultraGridColumn35.Hidden = true;
            ultraGridColumn35.Width = 87;
            ultraGridColumn36.Header.VisiblePosition = 17;
            ultraGridColumn36.Hidden = true;
            ultraGridColumn36.Width = 119;
            ultraGridColumn37.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn37.Header.VisiblePosition = 18;
            ultraGridColumn37.Width = 39;
            ultraGridColumn38.DataType = typeof(System.DateTime);
            ultraGridColumn38.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn38.Header.Caption = "";
            ultraGridColumn38.Header.VisiblePosition = 4;
            ultraGridColumn38.Width = 83;
            ultraGridBand1.Columns.AddRange(new object[] {
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
            ultraGridColumn34,
            ultraGridColumn35,
            ultraGridColumn36,
            ultraGridColumn37,
            ultraGridColumn38});
            this.ultraGrid.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            appearance14.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance14.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance14.BackHatchStyle = Infragistics.Win.BackHatchStyle.Horizontal;
            this.ultraGrid.DisplayLayout.Override.ActiveCellAppearance = appearance14;
            appearance12.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance12.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance12.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.ActiveRowAppearance = appearance12;
            this.ultraGrid.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.ultraGrid.DisplayLayout.Override.AllowColMoving = Infragistics.Win.UltraWinGrid.AllowColMoving.NotAllowed;
            this.ultraGrid.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.False;
            this.ultraGrid.DisplayLayout.Override.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.True;
            this.ultraGrid.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance13.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Override.CardAreaAppearance = appearance13;
            this.ultraGrid.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.RowSelect;
            this.ultraGrid.DisplayLayout.Override.FilterClearButtonLocation = Infragistics.Win.UltraWinGrid.FilterClearButtonLocation.Hidden;
            this.ultraGrid.DisplayLayout.Override.FilterEvaluationTrigger = Infragistics.Win.UltraWinGrid.FilterEvaluationTrigger.OnCellValueChange;
            this.ultraGrid.DisplayLayout.Override.FilterOperandStyle = Infragistics.Win.UltraWinGrid.FilterOperandStyle.UseColumnEditor;
            this.ultraGrid.DisplayLayout.Override.FilterOperatorDefaultValue = Infragistics.Win.UltraWinGrid.FilterOperatorDefaultValue.StartsWith;
            this.ultraGrid.DisplayLayout.Override.FilterOperatorLocation = Infragistics.Win.UltraWinGrid.FilterOperatorLocation.Hidden;
            appearance15.BackColor = System.Drawing.Color.WhiteSmoke;
            appearance15.BackColor2 = System.Drawing.Color.LightGray;
            appearance15.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.FilterRowAppearance = appearance15;
            this.ultraGrid.DisplayLayout.Override.FilterUIType = Infragistics.Win.UltraWinGrid.FilterUIType.FilterRow;
            appearance11.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance11.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance11.FontData.BoldAsString = "True";
            appearance11.FontData.Name = "Tahoma";
            appearance11.FontData.SizeInPoints = 8F;
            appearance11.ForeColor = System.Drawing.Color.White;
            appearance11.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ultraGrid.DisplayLayout.Override.HeaderAppearance = appearance11;
            this.ultraGrid.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            appearance10.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance10.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.RowSelectorAppearance = appearance10;
            this.ultraGrid.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.True;
            this.ultraGrid.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFixed;
            appearance16.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance16.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance16.ForeColor = System.Drawing.Color.Black;
            this.ultraGrid.DisplayLayout.Override.SelectedRowAppearance = appearance16;
            this.ultraGrid.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.None;
            this.ultraGrid.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ultraGrid.Font = new System.Drawing.Font("Tahoma", 7F);
            this.ultraGrid.MinimumSize = new System.Drawing.Size(500, 200);
            this.ultraGrid.Size = new System.Drawing.Size(754, 268);
            this.ultraGrid.MouseDown += new System.Windows.Forms.MouseEventHandler(this.ultraGrid_MouseDown);
            this.ultraGrid.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ultraGrid_InitializeRow);
            this.ultraGrid.CellDataError += new Infragistics.Win.UltraWinGrid.CellDataErrorEventHandler(this.ultraGrid_CellDataError);
            this.ultraGrid.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ultraGrid_InitializeLayout);
            // 
            // splitContainer
            // 
            // 
            // splitContainer.Panel1
            // 
            this.splitContainer.Panel1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.splitContainer.Size = new System.Drawing.Size(771, 200);
            // 
            // btnSearchClosed
            // 
            this.btnSearchClosed.Click += new System.EventHandler(this.btnSearchClosed_Click);
            // 
            // btnClearFilter
            // 
            this.btnClearFilter.Click += new System.EventHandler(this.btnClearFilter_Click);
            // 
            // tcssActiveCasesDS1
            // 
            this.tcssActiveCasesDS1.DataSetName = "TcssActiveCasesDS";
            this.tcssActiveCasesDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // TcssActiveCasesControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.MinimumSize = new System.Drawing.Size(0, 0);
            this.Name = "TcssActiveCasesControl";
            this.Size = new System.Drawing.Size(771, 200);
            this.Controls.SetChildIndex(this.splitContainer, 0);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.tcssActiveCasesDS1)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Data.Types.Dashboard.TcssActiveCasesDS tcssActiveCasesDS1;


	}
}
