namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class NoCallsControl
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("NoCalls", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn11 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn12 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn13 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallDateTime", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Descending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn14 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("NoCallTypeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn15 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("NoCallDescription");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn16 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SourceCodeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn17 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeFirstName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn18 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeLastName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn19 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn20 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ToDate", 0);
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            this.noCallsDS1 = new Statline.Stattrac.Data.Types.Dashboard.NoCallsDS();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.noCallsDS1)).BeginInit();
            this.SuspendLayout();
            // 
            // btnAdd
            // 
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnDelete
            // 
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // ultraGrid
            // 
            this.ultraGrid.DataMember = "NoCalls";
            this.ultraGrid.DataSource = this.noCallsDS1;
            appearance9.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Appearance = appearance9;
            this.ultraGrid.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn11.Header.VisiblePosition = 0;
            ultraGridColumn11.Hidden = true;
            ultraGridColumn11.Width = 12;
            ultraGridColumn12.Header.Caption = "Call #";
            ultraGridColumn12.Header.VisiblePosition = 1;
            ultraGridColumn12.Width = 42;
            ultraGridColumn13.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn13.Header.Caption = "Date/Time";
            ultraGridColumn13.Header.VisiblePosition = 2;
            ultraGridColumn13.Width = 127;
            ultraGridColumn14.Header.Caption = "No Call Type";
            ultraGridColumn14.Header.VisiblePosition = 4;
            ultraGridColumn14.Width = 76;
            ultraGridColumn15.Header.Caption = "Description";
            ultraGridColumn15.Header.VisiblePosition = 5;
            ultraGridColumn15.Width = 139;
            ultraGridColumn16.Header.Caption = "Source Code";
            ultraGridColumn16.Header.VisiblePosition = 6;
            ultraGridColumn16.Width = 76;
            ultraGridColumn17.Header.Caption = "Coord. First";
            ultraGridColumn17.Header.VisiblePosition = 7;
            ultraGridColumn17.Width = 96;
            ultraGridColumn18.Header.Caption = "Coord. Last";
            ultraGridColumn18.Header.VisiblePosition = 8;
            ultraGridColumn18.Width = 120;
            ultraGridColumn19.Header.VisiblePosition = 9;
            ultraGridColumn19.Hidden = true;
            ultraGridColumn19.Width = 99;
            ultraGridColumn20.DataType = typeof(System.DateTime);
            ultraGridColumn20.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn20.Header.Caption = "";
            ultraGridColumn20.Header.VisiblePosition = 3;
            ultraGridColumn20.Width = 74;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn11,
            ultraGridColumn12,
            ultraGridColumn13,
            ultraGridColumn14,
            ultraGridColumn15,
            ultraGridColumn16,
            ultraGridColumn17,
            ultraGridColumn18,
            ultraGridColumn19,
            ultraGridColumn20});
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
            this.ultraGrid.Size = new System.Drawing.Size(771, 411);
            this.ultraGrid.MouseDown += new System.Windows.Forms.MouseEventHandler(this.ultraGrid_MouseDown);
            this.ultraGrid.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ultraGrid_InitializeRow);
            this.ultraGrid.DoubleClickRow += new Infragistics.Win.UltraWinGrid.DoubleClickRowEventHandler(this.ultraGrid_DoubleClickRow);
            this.ultraGrid.CellDataError += new Infragistics.Win.UltraWinGrid.CellDataErrorEventHandler(this.ultraGrid_CellDataError);
            this.ultraGrid.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ultraGrid_InitializeLayout);
            // 
            // splitContainer
            // 
            this.splitContainer.Size = new System.Drawing.Size(771, 443);
            // 
            // btnClearFilter
            // 
            this.btnClearFilter.Click += new System.EventHandler(this.btnClearFilter_Click);
            // 
            // noCallsDS1
            // 
            this.noCallsDS1.DataSetName = "NoCallsDS";
            this.noCallsDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // NoCallsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.MinimumSize = new System.Drawing.Size(702, 200);
            this.Name = "NoCallsControl";
            this.Size = new System.Drawing.Size(771, 443);
            this.Controls.SetChildIndex(this.splitContainer, 0);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.noCallsDS1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Data.Types.Dashboard.NoCallsDS noCallsDS1;

    }
}
