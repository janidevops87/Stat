namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class UpdateControl
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("UpdatedReferralEvents", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallDateTime", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Descending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralDonorFirstName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralDonorLastName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn6 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn7 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PrevReferralTypeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn8 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralTypeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn9 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SourceCodeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn10 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeFirstName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn11 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeLastName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn12 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn13 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StateAbbrv");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn14 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("FromTime", 0);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn15 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ToDate", 1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn16 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ToTime", 2);
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            this.updateDS1 = new Statline.Stattrac.Data.Types.Dashboard.UpdateDS();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.updateDS1)).BeginInit();
            this.SuspendLayout();
            // 
            // btnAdd
            // 
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // ultraGrid
            // 
            this.ultraGrid.DataMember = null;
            this.ultraGrid.DataSource = this.updateDS1;
            appearance1.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Appearance = appearance1;
            this.ultraGrid.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn1.Header.VisiblePosition = 14;
            ultraGridColumn1.Hidden = true;
            ultraGridColumn1.Width = 12;
            ultraGridColumn2.Header.Caption = "Call #";
            ultraGridColumn2.Header.VisiblePosition = 0;
            ultraGridColumn2.Width = 59;
            ultraGridColumn3.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn3.Header.Caption = "Call Date Time (Updated)";
            ultraGridColumn3.Header.VisiblePosition = 1;
            ultraGridColumn3.Width = 155;
            ultraGridColumn4.Header.Caption = "First Name";
            ultraGridColumn4.Header.VisiblePosition = 5;
            ultraGridColumn4.Width = 47;
            ultraGridColumn5.Header.Caption = "Last Name";
            ultraGridColumn5.Header.VisiblePosition = 6;
            ultraGridColumn5.Width = 86;
            ultraGridColumn6.Header.Caption = "Referral Facility";
            ultraGridColumn6.Header.VisiblePosition = 7;
            ultraGridColumn6.Width = 52;
            ultraGridColumn7.Header.Caption = "Pre. Ref. Type";
            ultraGridColumn7.Header.VisiblePosition = 9;
            ultraGridColumn7.Width = 23;
            ultraGridColumn8.Header.Caption = "Ref. Type";
            ultraGridColumn8.Header.VisiblePosition = 10;
            ultraGridColumn8.Width = 19;
            ultraGridColumn9.Header.Caption = "Source Code";
            ultraGridColumn9.Header.VisiblePosition = 11;
            ultraGridColumn9.Width = 49;
            ultraGridColumn10.Header.Caption = "Coord. First Name";
            ultraGridColumn10.Header.VisiblePosition = 12;
            ultraGridColumn10.Width = 77;
            ultraGridColumn11.Header.Caption = "Coord. Last Name";
            ultraGridColumn11.Header.VisiblePosition = 13;
            ultraGridColumn11.Width = 75;
            ultraGridColumn12.Header.VisiblePosition = 15;
            ultraGridColumn12.Hidden = true;
            ultraGridColumn12.Width = 101;
            ultraGridColumn13.Header.Caption = "St";
            ultraGridColumn13.Header.VisiblePosition = 8;
            ultraGridColumn13.Width = 27;
            ultraGridColumn14.Header.Caption = "";
            ultraGridColumn14.Header.VisiblePosition = 2;
            ultraGridColumn14.Hidden = true;
            ultraGridColumn14.Width = 41;
            ultraGridColumn15.DataType = typeof(System.DateTime);
            ultraGridColumn15.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn15.Header.Caption = "";
            ultraGridColumn15.Header.VisiblePosition = 3;
            ultraGridColumn15.Width = 81;
            ultraGridColumn16.Header.Caption = "";
            ultraGridColumn16.Header.VisiblePosition = 4;
            ultraGridColumn16.Hidden = true;
            ultraGridColumn16.Width = 47;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5,
            ultraGridColumn6,
            ultraGridColumn7,
            ultraGridColumn8,
            ultraGridColumn9,
            ultraGridColumn10,
            ultraGridColumn11,
            ultraGridColumn12,
            ultraGridColumn13,
            ultraGridColumn14,
            ultraGridColumn15,
            ultraGridColumn16});
            this.ultraGrid.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BackHatchStyle = Infragistics.Win.BackHatchStyle.Horizontal;
            this.ultraGrid.DisplayLayout.Override.ActiveCellAppearance = appearance2;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.ActiveRowAppearance = appearance3;
            this.ultraGrid.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.ultraGrid.DisplayLayout.Override.AllowColMoving = Infragistics.Win.UltraWinGrid.AllowColMoving.NotAllowed;
            this.ultraGrid.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.False;
            this.ultraGrid.DisplayLayout.Override.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.True;
            this.ultraGrid.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance4.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Override.CardAreaAppearance = appearance4;
            this.ultraGrid.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.RowSelect;
            this.ultraGrid.DisplayLayout.Override.FilterClearButtonLocation = Infragistics.Win.UltraWinGrid.FilterClearButtonLocation.Hidden;
            this.ultraGrid.DisplayLayout.Override.FilterEvaluationTrigger = Infragistics.Win.UltraWinGrid.FilterEvaluationTrigger.OnCellValueChange;
            this.ultraGrid.DisplayLayout.Override.FilterOperandStyle = Infragistics.Win.UltraWinGrid.FilterOperandStyle.UseColumnEditor;
            this.ultraGrid.DisplayLayout.Override.FilterOperatorDefaultValue = Infragistics.Win.UltraWinGrid.FilterOperatorDefaultValue.StartsWith;
            this.ultraGrid.DisplayLayout.Override.FilterOperatorLocation = Infragistics.Win.UltraWinGrid.FilterOperatorLocation.Hidden;
            appearance5.BackColor = System.Drawing.Color.WhiteSmoke;
            appearance5.BackColor2 = System.Drawing.Color.LightGray;
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.FilterRowAppearance = appearance5;
            this.ultraGrid.DisplayLayout.Override.FilterUIType = Infragistics.Win.UltraWinGrid.FilterUIType.FilterRow;
            appearance6.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance6.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance6.FontData.BoldAsString = "True";
            appearance6.FontData.Name = "Tahoma";
            appearance6.FontData.SizeInPoints = 8F;
            appearance6.ForeColor = System.Drawing.Color.White;
            appearance6.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ultraGrid.DisplayLayout.Override.HeaderAppearance = appearance6;
            this.ultraGrid.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            appearance7.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance7.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance7.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.RowSelectorAppearance = appearance7;
            this.ultraGrid.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.True;
            this.ultraGrid.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFixed;
            appearance8.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance8.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance8.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance8.ForeColor = System.Drawing.Color.Black;
            this.ultraGrid.DisplayLayout.Override.SelectedRowAppearance = appearance8;
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
            // updateDS1
            // 
            this.updateDS1.DataSetName = "UpdateDS";
            this.updateDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // UpdateControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.MinimumSize = new System.Drawing.Size(702, 200);
            this.Name = "UpdateControl";
            this.Size = new System.Drawing.Size(771, 443);
            this.Controls.SetChildIndex(this.splitContainer, 0);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.updateDS1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Data.Types.Dashboard.UpdateDS updateDS1;
    }
}
