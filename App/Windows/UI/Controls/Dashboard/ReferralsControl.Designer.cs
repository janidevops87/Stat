namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class ReferralsControl
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("ReferralList", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn49 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn50 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn51 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallDateTime", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Descending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn52 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralDonorFirstName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn53 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralDonorLastName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn54 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn55 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StateAbbrv");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn56 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PrevReferralTypeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn57 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralTypeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn58 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SourceCodeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn59 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeFirstName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn60 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeLastName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn61 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn62 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("FromTime", 0);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn63 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ToDate", 1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn64 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ToTime", 2);
            Infragistics.Win.Appearance appearance20 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance17 = new Infragistics.Win.Appearance();
            this.referralDS1 = new Statline.Stattrac.Data.Types.Dashboard.ReferralDS();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.referralDS1)).BeginInit();
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
            this.ultraGrid.DataMember = "ReferralList";
            this.ultraGrid.DataSource = this.referralDS1;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Appearance = appearance2;
            this.ultraGrid.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn49.Header.Caption = "Referral #";
            ultraGridColumn49.Header.VisiblePosition = 0;
            ultraGridColumn49.Hidden = true;
            ultraGridColumn49.Width = 51;
            ultraGridColumn50.Header.Caption = "Referral #";
            ultraGridColumn50.Header.VisiblePosition = 1;
            ultraGridColumn50.Width = 34;
            ultraGridColumn51.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn51.Header.Caption = "Date/Time";
            ultraGridColumn51.Header.VisiblePosition = 2;
            ultraGridColumn51.MaskInput = "";
            ultraGridColumn51.Width = 125;
            ultraGridColumn52.Header.Caption = "First Name";
            ultraGridColumn52.Header.VisiblePosition = 6;
            ultraGridColumn52.Width = 51;
            ultraGridColumn53.Header.Caption = "Last Name";
            ultraGridColumn53.Header.VisiblePosition = 7;
            ultraGridColumn53.Width = 52;
            ultraGridColumn54.Header.Caption = "Referral Facility";
            ultraGridColumn54.Header.VisiblePosition = 8;
            ultraGridColumn54.Width = 76;
            ultraGridColumn55.Header.Caption = "St.";
            ultraGridColumn55.Header.VisiblePosition = 9;
            ultraGridColumn55.Width = 34;
            ultraGridColumn56.Header.Caption = "Pre. Ref Type";
            ultraGridColumn56.Header.VisiblePosition = 10;
            ultraGridColumn56.Width = 64;
            ultraGridColumn57.Header.Caption = "Ref. Type";
            ultraGridColumn57.Header.VisiblePosition = 11;
            ultraGridColumn57.Width = 39;
            ultraGridColumn58.Header.Caption = "Source Code";
            ultraGridColumn58.Header.VisiblePosition = 12;
            ultraGridColumn58.Width = 50;
            ultraGridColumn59.Header.Caption = "Coord. First Name";
            ultraGridColumn59.Header.VisiblePosition = 13;
            ultraGridColumn59.Width = 65;
            ultraGridColumn60.Header.Caption = "Coord. Last Name";
            ultraGridColumn60.Header.VisiblePosition = 14;
            ultraGridColumn60.Width = 94;
            ultraGridColumn61.Header.VisiblePosition = 15;
            ultraGridColumn61.Hidden = true;
            ultraGridColumn61.Width = 87;
            ultraGridColumn62.Format = "hh:mm";
            ultraGridColumn62.Header.Caption = "";
            ultraGridColumn62.Header.VisiblePosition = 3;
            ultraGridColumn62.Hidden = true;
            ultraGridColumn62.Width = 36;
            ultraGridColumn63.DataType = typeof(System.DateTime);
            ultraGridColumn63.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn63.Header.Caption = "";
            ultraGridColumn63.Header.VisiblePosition = 4;
            ultraGridColumn63.Width = 66;
            ultraGridColumn64.Header.Caption = "";
            ultraGridColumn64.Header.VisiblePosition = 5;
            ultraGridColumn64.Hidden = true;
            ultraGridColumn64.Width = 42;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn49,
            ultraGridColumn50,
            ultraGridColumn51,
            ultraGridColumn52,
            ultraGridColumn53,
            ultraGridColumn54,
            ultraGridColumn55,
            ultraGridColumn56,
            ultraGridColumn57,
            ultraGridColumn58,
            ultraGridColumn59,
            ultraGridColumn60,
            ultraGridColumn61,
            ultraGridColumn62,
            ultraGridColumn63,
            ultraGridColumn64});
            appearance20.FontData.SizeInPoints = 7F;
            ultraGridBand1.Header.Appearance = appearance20;
            this.ultraGrid.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            appearance15.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance15.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance15.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance15.BackHatchStyle = Infragistics.Win.BackHatchStyle.Horizontal;
            this.ultraGrid.DisplayLayout.Override.ActiveCellAppearance = appearance15;
            appearance13.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance13.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance13.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.ActiveRowAppearance = appearance13;
            this.ultraGrid.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.ultraGrid.DisplayLayout.Override.AllowColMoving = Infragistics.Win.UltraWinGrid.AllowColMoving.NotAllowed;
            this.ultraGrid.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.False;
            this.ultraGrid.DisplayLayout.Override.AllowRowFiltering = Infragistics.Win.DefaultableBoolean.True;
            this.ultraGrid.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance14.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Override.CardAreaAppearance = appearance14;
            this.ultraGrid.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.RowSelect;
            this.ultraGrid.DisplayLayout.Override.FilterClearButtonLocation = Infragistics.Win.UltraWinGrid.FilterClearButtonLocation.Hidden;
            this.ultraGrid.DisplayLayout.Override.FilterEvaluationTrigger = Infragistics.Win.UltraWinGrid.FilterEvaluationTrigger.OnCellValueChange;
            this.ultraGrid.DisplayLayout.Override.FilterOperandStyle = Infragistics.Win.UltraWinGrid.FilterOperandStyle.UseColumnEditor;
            this.ultraGrid.DisplayLayout.Override.FilterOperatorDefaultValue = Infragistics.Win.UltraWinGrid.FilterOperatorDefaultValue.StartsWith;
            this.ultraGrid.DisplayLayout.Override.FilterOperatorLocation = Infragistics.Win.UltraWinGrid.FilterOperatorLocation.Hidden;
            appearance16.BackColor = System.Drawing.Color.WhiteSmoke;
            appearance16.BackColor2 = System.Drawing.Color.LightGray;
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.FilterRowAppearance = appearance16;
            this.ultraGrid.DisplayLayout.Override.FilterUIType = Infragistics.Win.UltraWinGrid.FilterUIType.FilterRow;
            appearance12.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance12.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance12.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance12.FontData.BoldAsString = "True";
            appearance12.FontData.Name = "Tahoma";
            appearance12.FontData.SizeInPoints = 8F;
            appearance12.ForeColor = System.Drawing.Color.White;
            appearance12.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ultraGrid.DisplayLayout.Override.HeaderAppearance = appearance12;
            this.ultraGrid.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            appearance11.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance11.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ultraGrid.DisplayLayout.Override.RowSelectorAppearance = appearance11;
            this.ultraGrid.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.True;
            this.ultraGrid.DisplayLayout.Override.RowSizing = Infragistics.Win.UltraWinGrid.RowSizing.AutoFixed;
            appearance17.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance17.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance17.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance17.ForeColor = System.Drawing.Color.Black;
            this.ultraGrid.DisplayLayout.Override.SelectedRowAppearance = appearance17;
            this.ultraGrid.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.None;
            this.ultraGrid.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ultraGrid.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.OutlookGroupBy;
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
            // referralDS1
            // 
            this.referralDS1.DataSetName = "ReferralDS";
            this.referralDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // ReferralsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.MinimumSize = new System.Drawing.Size(702, 200);
            this.Name = "ReferralsControl";
            this.Size = new System.Drawing.Size(771, 443);
            this.Controls.SetChildIndex(this.splitContainer, 0);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.referralDS1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Data.Types.Dashboard.ReferralDS referralDS1;


    }
}
