namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class AbgVentSettingsControl
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("TcssDonorAbg", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn18 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorAbgId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn19 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateStatEmployeeId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn20 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateDate");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn21 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn22 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SampleDateTime");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn23 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Ph");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn24 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Pco2");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn25 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Po2");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn26 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Hco3");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn27 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("O2sat");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn28 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssListVentSettingModeId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn29 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ModeOther");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn30 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Fio2");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn31 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Rate");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn32 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Vt");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn33 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Peep");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn34 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Pip");
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            this.ugAbgVentSettings = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.tcssDS1 = new Statline.Stattrac.Data.Types.NewCall.TcssDS();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.panel1 = new System.Windows.Forms.Panel();
            this.txtHowManyDaysVented = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblHowManyDaysVented = new Statline.Stattrac.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.ugAbgVentSettings)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tcssDS1)).BeginInit();
            this.tableLayoutPanel1.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // ugAbgVentSettings
            // 
            this.ugAbgVentSettings.DataMember = "TcssDonorAbg";
            this.ugAbgVentSettings.DataSource = this.tcssDS1;
            appearance1.BackColor = System.Drawing.Color.Transparent;
            this.ugAbgVentSettings.DisplayLayout.Appearance = appearance1;
            this.ugAbgVentSettings.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn18.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn18.Header.VisiblePosition = 0;
            ultraGridColumn18.Hidden = true;
            ultraGridColumn19.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn19.Header.VisiblePosition = 14;
            ultraGridColumn19.Hidden = true;
            ultraGridColumn20.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn20.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn20.Header.VisiblePosition = 15;
            ultraGridColumn20.Hidden = true;
            ultraGridColumn21.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn21.Header.VisiblePosition = 1;
            ultraGridColumn21.Hidden = true;
            ultraGridColumn22.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn22.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn22.Header.VisiblePosition = 2;
            ultraGridColumn22.Width = 70;
            ultraGridColumn23.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn23.Header.VisiblePosition = 3;
            ultraGridColumn23.Width = 68;
            ultraGridColumn24.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn24.Header.VisiblePosition = 4;
            ultraGridColumn24.Width = 55;
            ultraGridColumn25.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn25.Header.VisiblePosition = 5;
            ultraGridColumn25.Width = 50;
            ultraGridColumn26.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn26.Header.VisiblePosition = 6;
            ultraGridColumn26.Width = 36;
            ultraGridColumn27.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn27.Header.VisiblePosition = 7;
            ultraGridColumn27.Width = 50;
            ultraGridColumn28.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn28.Header.VisiblePosition = 8;
            ultraGridColumn28.Width = 61;
            ultraGridColumn29.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn29.Header.VisiblePosition = 9;
            ultraGridColumn29.Width = 60;
            ultraGridColumn30.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn30.Header.VisiblePosition = 10;
            ultraGridColumn30.Width = 55;
            ultraGridColumn31.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn31.Header.VisiblePosition = 11;
            ultraGridColumn31.Width = 55;
            ultraGridColumn32.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn32.Header.VisiblePosition = 12;
            ultraGridColumn32.Width = 55;
            ultraGridColumn33.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn33.Header.VisiblePosition = 13;
            ultraGridColumn33.Width = 55;
            ultraGridColumn34.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn34.Header.VisiblePosition = 16;
            ultraGridColumn34.Width = 55;
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
            this.ugAbgVentSettings.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugAbgVentSettings.DisplayLayout.MaxRowScrollRegions = 1;
            this.ugAbgVentSettings.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugAbgVentSettings.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugAbgVentSettings.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ugAbgVentSettings.DisplayLayout.Override.CardAreaAppearance = appearance2;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.FontData.BoldAsString = "True";
            appearance3.FontData.Name = "Tahoma";
            appearance3.FontData.SizeInPoints = 8F;
            appearance3.ForeColor = System.Drawing.Color.White;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugAbgVentSettings.DisplayLayout.Override.HeaderAppearance = appearance3;
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugAbgVentSettings.DisplayLayout.Override.RowSelectorAppearance = appearance4;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance5.ForeColor = System.Drawing.Color.Black;
            this.ugAbgVentSettings.DisplayLayout.Override.SelectedRowAppearance = appearance5;
            this.ugAbgVentSettings.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugAbgVentSettings.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugAbgVentSettings.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugAbgVentSettings.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugAbgVentSettings.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugAbgVentSettings.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugAbgVentSettings.Font = new System.Drawing.Font("Tahoma", 7F);
            this.ugAbgVentSettings.Location = new System.Drawing.Point(3, 33);
            this.ugAbgVentSettings.Name = "ugAbgVentSettings";
            this.ugAbgVentSettings.Size = new System.Drawing.Size(746, 438);
            this.ugAbgVentSettings.TabIndex = 0;
            this.ugAbgVentSettings.Text = "ABG’s / Ventilator Settings Details";
            this.ugAbgVentSettings.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugAbgVentSettings.AfterCellUpdate += new Infragistics.Win.UltraWinGrid.CellEventHandler(this.ugAbgVentSettings_AfterCellUpdate);
            this.ugAbgVentSettings.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ugAbgVentSettings_InitializeRow);
            this.ugAbgVentSettings.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugAbgVentSettings_InitializeLayout);
            // 
            // tcssDS1
            // 
            this.tcssDS1.DataSetName = "TcssDS";
            this.tcssDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.ugAbgVentSettings, 0, 1);
            this.tableLayoutPanel1.Controls.Add(this.panel1, 0, 0);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(752, 474);
            this.tableLayoutPanel1.TabIndex = 1;
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.txtHowManyDaysVented);
            this.panel1.Controls.Add(this.lblHowManyDaysVented);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel1.Location = new System.Drawing.Point(3, 3);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(746, 24);
            this.panel1.TabIndex = 1;
            // 
            // txtHowManyDaysVented
            // 
            this.txtHowManyDaysVented.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtHowManyDaysVented.Location = new System.Drawing.Point(134, 1);
            this.txtHowManyDaysVented.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.PositiveInteger;
            this.txtHowManyDaysVented.Name = "txtHowManyDaysVented";
            this.txtHowManyDaysVented.Required = false;
            this.txtHowManyDaysVented.Size = new System.Drawing.Size(100, 20);
            this.txtHowManyDaysVented.SpellCheckEnabled = false;
            this.txtHowManyDaysVented.TabIndex = 1;
            // 
            // lblHowManyDaysVented
            // 
            this.lblHowManyDaysVented.AutoSize = true;
            this.lblHowManyDaysVented.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblHowManyDaysVented.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblHowManyDaysVented.Location = new System.Drawing.Point(3, 4);
            this.lblHowManyDaysVented.Name = "lblHowManyDaysVented";
            this.lblHowManyDaysVented.Size = new System.Drawing.Size(125, 13);
            this.lblHowManyDaysVented.TabIndex = 0;
            this.lblHowManyDaysVented.Text = "How Many Days Vented:";
            // 
            // AbgVentSettingsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "AbgVentSettingsControl";
            this.Size = new System.Drawing.Size(752, 474);
            ((System.ComponentModel.ISupportInitialize)(this.ugAbgVentSettings)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tcssDS1)).EndInit();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraGrid ugAbgVentSettings;
		private Statline.Stattrac.Data.Types.NewCall.TcssDS tcssDS1;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Panel panel1;
        private Statline.Stattrac.Windows.Forms.TextBox txtHowManyDaysVented;
        private Statline.Stattrac.Windows.Forms.Label lblHowManyDaysVented;
	}
}
