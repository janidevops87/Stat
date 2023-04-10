namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class MessageandImportControl
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
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("MessagesandImports", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn17 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn18 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn19 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallDateTime", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Descending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn20 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PersonFirst");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn21 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("PersonLast");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn22 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn23 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MessageTypeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn24 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MessageImportUNOSID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn25 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MessageCallerName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn26 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MessageCallerOrganization");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn27 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SourceCodeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn28 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeFirstName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn29 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeLastName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn30 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn31 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastModified");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn32 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ToDate", 0);
            Infragistics.Win.Appearance appearance18 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance17 = new Infragistics.Win.Appearance();
            this.messageandImportDS1 = new Statline.Stattrac.Data.Types.Dashboard.MessageandImportDS();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.messageandImportDS1)).BeginInit();
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
            this.ultraGrid.DataMember = "MessagesandImports";
            this.ultraGrid.DataSource = this.messageandImportDS1;
            appearance10.BackColor = System.Drawing.Color.Transparent;
            this.ultraGrid.DisplayLayout.Appearance = appearance10;
            this.ultraGrid.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn17.Header.VisiblePosition = 0;
            ultraGridColumn17.Hidden = true;
            ultraGridColumn17.Width = 8;
            ultraGridColumn18.Header.Caption = "Call #";
            ultraGridColumn18.Header.VisiblePosition = 1;
            ultraGridColumn18.Width = 38;
            ultraGridColumn19.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn19.Header.Caption = "Date/Time";
            ultraGridColumn19.Header.VisiblePosition = 2;
            ultraGridColumn19.Width = 124;
            ultraGridColumn20.Header.Caption = "For Person First";
            ultraGridColumn20.Header.VisiblePosition = 4;
            ultraGridColumn20.Width = 47;
            ultraGridColumn21.Header.Caption = "For Person Last";
            ultraGridColumn21.Header.VisiblePosition = 5;
            ultraGridColumn21.Width = 57;
            ultraGridColumn22.Header.Caption = "Message for Organization";
            ultraGridColumn22.Header.VisiblePosition = 6;
            ultraGridColumn22.Width = 107;
            ultraGridColumn23.Header.Caption = "Type";
            ultraGridColumn23.Header.VisiblePosition = 7;
            ultraGridColumn23.Width = 26;
            ultraGridColumn24.Header.Caption = "OPTN #";
            ultraGridColumn24.Header.VisiblePosition = 8;
            ultraGridColumn24.Width = 40;
            ultraGridColumn25.Header.Caption = "Caller Name";
            ultraGridColumn25.Header.VisiblePosition = 9;
            ultraGridColumn25.Width = 55;
            ultraGridColumn26.Header.Caption = "Caller Org";
            ultraGridColumn26.Header.VisiblePosition = 10;
            ultraGridColumn26.Width = 53;
            ultraGridColumn27.Header.Caption = "Source Code";
            ultraGridColumn27.Header.VisiblePosition = 11;
            ultraGridColumn27.Width = 27;
            ultraGridColumn28.Header.Caption = "Coord. First";
            ultraGridColumn28.Header.VisiblePosition = 12;
            ultraGridColumn28.Width = 43;
            ultraGridColumn29.Header.Caption = "Coord. Last";
            ultraGridColumn29.Header.VisiblePosition = 13;
            ultraGridColumn29.Width = 75;
            ultraGridColumn30.Header.VisiblePosition = 15;
            ultraGridColumn30.Hidden = true;
            ultraGridColumn30.Width = 45;
            ultraGridColumn31.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn31.Header.VisiblePosition = 14;
            ultraGridColumn31.Hidden = true;
            ultraGridColumn31.Width = 29;
            ultraGridColumn32.DataType = typeof(System.DateTime);
            ultraGridColumn32.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn32.Header.Caption = "";
            ultraGridColumn32.Header.VisiblePosition = 3;
            ultraGridColumn32.Width = 58;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn17,
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
            ultraGridColumn32});
            appearance18.FontData.SizeInPoints = 7F;
            ultraGridBand1.Header.Appearance = appearance18;
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
            // messageandImportDS1
            // 
            this.messageandImportDS1.DataSetName = "MessageandImportDS";
            this.messageandImportDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // MessageandImportControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.MinimumSize = new System.Drawing.Size(702, 200);
            this.Name = "MessageandImportControl";
            this.Size = new System.Drawing.Size(771, 443);
            this.Controls.SetChildIndex(this.splitContainer, 0);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.messageandImportDS1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Data.Types.Dashboard.MessageandImportDS messageandImportDS1;
    }
}
