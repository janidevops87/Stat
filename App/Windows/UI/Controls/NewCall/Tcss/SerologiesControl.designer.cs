namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class SerologiesControl
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
			Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("TcssDonorSerologies", -1);
			Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorSerologiesId");
			Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateStatEmployeeId");
			Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateDate");
			Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorId");
			Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssListSerologyQuestionId");
			Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn6 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssListSerologyAnswerId");
			Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
			Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
			Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
			Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
			this.ugSerologies = new Statline.Stattrac.Windows.Forms.UltraGrid();
			((System.ComponentModel.ISupportInitialize)(this.ugSerologies)).BeginInit();
			this.SuspendLayout();
			// 
			// ugSerologies
			// 
			this.ugSerologies.DataMember = "TcssDonorSerologies";
			appearance1.BackColor = System.Drawing.Color.White;
			this.ugSerologies.DisplayLayout.Appearance = appearance1;
			this.ugSerologies.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
			ultraGridColumn1.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
			ultraGridColumn1.Header.VisiblePosition = 0;
			ultraGridColumn1.Hidden = true;
			ultraGridColumn1.Width = 130;
			ultraGridColumn2.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
			ultraGridColumn2.Header.VisiblePosition = 1;
			ultraGridColumn2.Hidden = true;
			ultraGridColumn2.Width = 142;
			ultraGridColumn3.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
			ultraGridColumn3.Format = "MM/dd/yyyy HH:mm";
			ultraGridColumn3.Header.VisiblePosition = 2;
			ultraGridColumn3.Hidden = true;
			ultraGridColumn3.Width = 111;
			ultraGridColumn4.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
			ultraGridColumn4.Header.VisiblePosition = 3;
			ultraGridColumn4.Hidden = true;
			ultraGridColumn4.Width = 110;
			ultraGridColumn5.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
			ultraGridColumn5.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
			ultraGridColumn5.Header.VisiblePosition = 4;
			ultraGridColumn5.Width = 171;
			ultraGridColumn6.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
			ultraGridColumn6.Header.VisiblePosition = 5;
			ultraGridColumn6.Width = 171;
			ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5,
            ultraGridColumn6});
			this.ugSerologies.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
			this.ugSerologies.DisplayLayout.MaxRowScrollRegions = 1;
			this.ugSerologies.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
			this.ugSerologies.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
			this.ugSerologies.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
			appearance2.BackColor = System.Drawing.Color.Transparent;
			this.ugSerologies.DisplayLayout.Override.CardAreaAppearance = appearance2;
			appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
			appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
			appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
			appearance3.FontData.BoldAsString = "True";
			appearance3.FontData.Name = "Arial";
			appearance3.FontData.SizeInPoints = 10F;
			appearance3.ForeColor = System.Drawing.Color.White;
			appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
			this.ugSerologies.DisplayLayout.Override.HeaderAppearance = appearance3;
			appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
			appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
			appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
			this.ugSerologies.DisplayLayout.Override.RowSelectorAppearance = appearance4;
			appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
			appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
			appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
			this.ugSerologies.DisplayLayout.Override.SelectedRowAppearance = appearance5;
			this.ugSerologies.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
			this.ugSerologies.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
			this.ugSerologies.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
			this.ugSerologies.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
			this.ugSerologies.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
			this.ugSerologies.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
			this.ugSerologies.Location = new System.Drawing.Point(0, 0);
			this.ugSerologies.Name = "ugSerologies";
			this.ugSerologies.Size = new System.Drawing.Size(363, 336);
			this.ugSerologies.TabIndex = 1;
			this.ugSerologies.Text = "Serologies Details";
			this.ugSerologies.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.EditOnly;
			this.ugSerologies.AfterCellUpdate += new Infragistics.Win.UltraWinGrid.CellEventHandler(this.ugSerologies_AfterCellUpdate);
			this.ugSerologies.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ugSerologies_InitializeRow);
			// 
			// SerologiesControl
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.Controls.Add(this.ugSerologies);
			this.Name = "SerologiesControl";
			this.Size = new System.Drawing.Size(594, 471);
			((System.ComponentModel.ISupportInitialize)(this.ugSerologies)).EndInit();
			this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraGrid ugSerologies;


	}
}
