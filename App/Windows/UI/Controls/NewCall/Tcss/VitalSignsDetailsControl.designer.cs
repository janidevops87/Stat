namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class VitalSignsDetailsControl
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
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            this.ugVitalSign = new Statline.Stattrac.Windows.Forms.UltraGrid();
            ((System.ComponentModel.ISupportInitialize)(this.ugVitalSign)).BeginInit();
            this.SuspendLayout();
            // 
            // ugVitalSign
            // 
            this.ugVitalSign.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            this.ugVitalSign.DisplayLayout.MaxRowScrollRegions = 1;
            this.ugVitalSign.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugVitalSign.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugVitalSign.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
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
            this.ugVitalSign.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugVitalSign.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugVitalSign.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugVitalSign.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugVitalSign.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugVitalSign.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugVitalSign.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.ugVitalSign.Location = new System.Drawing.Point(0, 0);
            this.ugVitalSign.Name = "ugVitalSign";
            this.ugVitalSign.Size = new System.Drawing.Size(800, 500);
            this.ugVitalSign.TabIndex = 1;
            this.ugVitalSign.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.VerticalAddEdit;
            // 
            // VitalSignsDetailsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.ugVitalSign);
            this.Name = "VitalSignsDetailsControl";
            this.Size = new System.Drawing.Size(800, 500);
            ((System.ComponentModel.ISupportInitialize)(this.ugVitalSign)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraGrid ugVitalSign;
	}
}
