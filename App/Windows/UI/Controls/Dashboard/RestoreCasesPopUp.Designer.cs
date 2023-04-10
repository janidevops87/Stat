namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class RestoreCasesPopUp
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("RecycleRestoreList", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn23 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralDonorFirstName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn24 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralDonorLastName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn25 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralDonorRecNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn26 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ReferralDonorNameMI");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn27 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventDateTime");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn28 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CreatedBy");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn29 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventTypeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn30 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventOrg");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn31 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventDesc");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn32 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn33 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventName");
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            this.ugRestoreCase = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.recycledRestoreDS1 = new Statline.Stattrac.Data.Types.Dashboard.RecycledRestoreDS();
            this.btnRestoreCase = new Statline.Stattrac.Windows.Forms.Button();
            this.btnCancel = new Statline.Stattrac.Windows.Forms.Button();
            this.lblReferralNo = new Statline.Stattrac.Windows.Forms.Label();
            this.lblFirstName = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMiddleInt = new Statline.Stattrac.Windows.Forms.Label();
            this.lblLastName = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMedRecord = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMedRecordData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblLastNameData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMiddleIntData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblFirstNameData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblReferralNoData = new Statline.Stattrac.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.ugRestoreCase)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.recycledRestoreDS1)).BeginInit();
            this.SuspendLayout();
            // 
            // ugRestoreCase
            // 
            this.ugRestoreCase.DataMember = "RecycleRestoreList";
            this.ugRestoreCase.DataSource = this.recycledRestoreDS1;
            appearance1.BackColor = System.Drawing.Color.Transparent;
            this.ugRestoreCase.DisplayLayout.Appearance = appearance1;
            ultraGridColumn23.Header.VisiblePosition = 0;
            ultraGridColumn23.Hidden = true;
            ultraGridColumn24.Header.VisiblePosition = 1;
            ultraGridColumn24.Hidden = true;
            ultraGridColumn25.Header.VisiblePosition = 2;
            ultraGridColumn25.Hidden = true;
            ultraGridColumn26.Header.VisiblePosition = 3;
            ultraGridColumn26.Hidden = true;
            ultraGridColumn27.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn27.Header.Caption = "Date/Time";
            ultraGridColumn27.Header.VisiblePosition = 4;
            ultraGridColumn27.Width = 114;
            ultraGridColumn28.Header.Caption = "By";
            ultraGridColumn28.Header.VisiblePosition = 8;
            ultraGridColumn28.Width = 79;
            ultraGridColumn29.Header.Caption = "Event Type";
            ultraGridColumn29.Header.VisiblePosition = 5;
            ultraGridColumn30.Header.Caption = "Organization";
            ultraGridColumn30.Header.VisiblePosition = 7;
            ultraGridColumn30.Width = 199;
            ultraGridColumn31.Header.Caption = "Description";
            ultraGridColumn31.Header.VisiblePosition = 9;
            ultraGridColumn31.Width = 217;
            ultraGridColumn32.Header.Caption = "#";
            ultraGridColumn32.Header.VisiblePosition = 10;
            ultraGridColumn32.Width = 29;
            ultraGridColumn33.Header.Caption = "From/To";
            ultraGridColumn33.Header.VisiblePosition = 6;
            ultraGridColumn33.Width = 123;
            ultraGridBand1.Columns.AddRange(new object[] {
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
            ultraGridColumn33});
            this.ugRestoreCase.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugRestoreCase.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ugRestoreCase.DisplayLayout.Override.CardAreaAppearance = appearance2;
            this.ugRestoreCase.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.RowSelect;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.FontData.BoldAsString = "True";
            appearance3.FontData.Name = "Arial";
            appearance3.FontData.SizeInPoints = 10F;
            appearance3.ForeColor = System.Drawing.Color.White;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugRestoreCase.DisplayLayout.Override.HeaderAppearance = appearance3;
            this.ugRestoreCase.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugRestoreCase.DisplayLayout.Override.RowSelectorAppearance = appearance4;
            this.ugRestoreCase.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance5.ForeColor = System.Drawing.Color.Black;
            this.ugRestoreCase.DisplayLayout.Override.SelectedRowAppearance = appearance5;
            this.ugRestoreCase.Font = new System.Drawing.Font("Tahoma", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
            this.ugRestoreCase.Location = new System.Drawing.Point(15, 93);
            this.ugRestoreCase.Name = "ugRestoreCase";
            this.ugRestoreCase.Size = new System.Drawing.Size(857, 241);
            this.ugRestoreCase.TabIndex = 0;
            this.ugRestoreCase.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            this.ugRestoreCase.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugRestoreCase_InitializeLayout);
            // 
            // recycledRestoreDS1
            // 
            this.recycledRestoreDS1.DataSetName = "RecycledRestoreDS";
            this.recycledRestoreDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // btnRestoreCase
            // 
            this.btnRestoreCase.Location = new System.Drawing.Point(697, 340);
            this.btnRestoreCase.Name = "btnRestoreCase";
            this.btnRestoreCase.Size = new System.Drawing.Size(75, 23);
            this.btnRestoreCase.TabIndex = 1;
            this.btnRestoreCase.Text = "&Restore Case";
            this.btnRestoreCase.UseVisualStyleBackColor = true;
            this.btnRestoreCase.Click += new System.EventHandler(this.btnRestoreCase_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(797, 340);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 2;
            this.btnCancel.Text = "&Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // lblReferralNo
            // 
            this.lblReferralNo.AutoSize = true;
            this.lblReferralNo.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblReferralNo.Location = new System.Drawing.Point(12, 9);
            this.lblReferralNo.Name = "lblReferralNo";
            this.lblReferralNo.Size = new System.Drawing.Size(57, 13);
            this.lblReferralNo.TabIndex = 3;
            this.lblReferralNo.Text = "Referral #:";
            // 
            // lblFirstName
            // 
            this.lblFirstName.AutoSize = true;
            this.lblFirstName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblFirstName.Location = new System.Drawing.Point(12, 26);
            this.lblFirstName.Name = "lblFirstName";
            this.lblFirstName.Size = new System.Drawing.Size(60, 13);
            this.lblFirstName.TabIndex = 4;
            this.lblFirstName.Text = "First Name:";
            // 
            // lblMiddleInt
            // 
            this.lblMiddleInt.AutoSize = true;
            this.lblMiddleInt.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMiddleInt.Location = new System.Drawing.Point(12, 43);
            this.lblMiddleInt.Name = "lblMiddleInt";
            this.lblMiddleInt.Size = new System.Drawing.Size(68, 13);
            this.lblMiddleInt.TabIndex = 5;
            this.lblMiddleInt.Text = "Middle Initial:";
            // 
            // lblLastName
            // 
            this.lblLastName.AutoSize = true;
            this.lblLastName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblLastName.Location = new System.Drawing.Point(12, 60);
            this.lblLastName.Name = "lblLastName";
            this.lblLastName.Size = new System.Drawing.Size(61, 13);
            this.lblLastName.TabIndex = 6;
            this.lblLastName.Text = "Last Name:";
            // 
            // lblMedRecord
            // 
            this.lblMedRecord.AutoSize = true;
            this.lblMedRecord.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMedRecord.Location = new System.Drawing.Point(12, 77);
            this.lblMedRecord.Name = "lblMedRecord";
            this.lblMedRecord.Size = new System.Drawing.Size(95, 13);
            this.lblMedRecord.TabIndex = 7;
            this.lblMedRecord.Text = "Medical Record #:";
            // 
            // lblMedRecordData
            // 
            this.lblMedRecordData.AutoSize = true;
            this.lblMedRecordData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMedRecordData.Location = new System.Drawing.Point(110, 77);
            this.lblMedRecordData.Name = "lblMedRecordData";
            this.lblMedRecordData.Size = new System.Drawing.Size(35, 13);
            this.lblMedRecordData.TabIndex = 12;
            this.lblMedRecordData.Text = "label6";
            // 
            // lblLastNameData
            // 
            this.lblLastNameData.AutoSize = true;
            this.lblLastNameData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblLastNameData.Location = new System.Drawing.Point(110, 60);
            this.lblLastNameData.Name = "lblLastNameData";
            this.lblLastNameData.Size = new System.Drawing.Size(35, 13);
            this.lblLastNameData.TabIndex = 11;
            this.lblLastNameData.Text = "label7";
            // 
            // lblMiddleIntData
            // 
            this.lblMiddleIntData.AutoSize = true;
            this.lblMiddleIntData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMiddleIntData.Location = new System.Drawing.Point(110, 43);
            this.lblMiddleIntData.Name = "lblMiddleIntData";
            this.lblMiddleIntData.Size = new System.Drawing.Size(35, 13);
            this.lblMiddleIntData.TabIndex = 10;
            this.lblMiddleIntData.Text = "label8";
            // 
            // lblFirstNameData
            // 
            this.lblFirstNameData.AutoSize = true;
            this.lblFirstNameData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblFirstNameData.Location = new System.Drawing.Point(110, 26);
            this.lblFirstNameData.Name = "lblFirstNameData";
            this.lblFirstNameData.Size = new System.Drawing.Size(25, 13);
            this.lblFirstNameData.TabIndex = 9;
            this.lblFirstNameData.Text = "999";
            // 
            // lblReferralNoData
            // 
            this.lblReferralNoData.AutoSize = true;
            this.lblReferralNoData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblReferralNoData.Location = new System.Drawing.Point(110, 9);
            this.lblReferralNoData.Name = "lblReferralNoData";
            this.lblReferralNoData.Size = new System.Drawing.Size(41, 13);
            this.lblReferralNoData.TabIndex = 8;
            this.lblReferralNoData.Text = "label10";
            // 
            // RestoreCasesPopUp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(881, 370);
            this.Controls.Add(this.lblMedRecordData);
            this.Controls.Add(this.lblLastNameData);
            this.Controls.Add(this.lblMiddleIntData);
            this.Controls.Add(this.lblFirstNameData);
            this.Controls.Add(this.lblReferralNoData);
            this.Controls.Add(this.lblMedRecord);
            this.Controls.Add(this.lblLastName);
            this.Controls.Add(this.lblMiddleInt);
            this.Controls.Add(this.lblFirstName);
            this.Controls.Add(this.lblReferralNo);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnRestoreCase);
            this.Controls.Add(this.ugRestoreCase);
            this.Name = "RestoreCasesPopUp";
            this.ShowInTaskbar = false;
            this.Text = "View Recycled Case";
            ((System.ComponentModel.ISupportInitialize)(this.ugRestoreCase)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.recycledRestoreDS1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.UltraGrid ugRestoreCase;
        private Statline.Stattrac.Windows.Forms.Button btnRestoreCase;
        private Statline.Stattrac.Windows.Forms.Button btnCancel;
        private Statline.Stattrac.Windows.Forms.Label lblReferralNo;
        private Statline.Stattrac.Windows.Forms.Label lblFirstName;
        private Statline.Stattrac.Windows.Forms.Label lblMiddleInt;
        private Statline.Stattrac.Windows.Forms.Label lblLastName;
        private Statline.Stattrac.Windows.Forms.Label lblMedRecord;
        private Statline.Stattrac.Windows.Forms.Label lblMedRecordData;
        private Statline.Stattrac.Windows.Forms.Label lblLastNameData;
        private Statline.Stattrac.Windows.Forms.Label lblMiddleIntData;
        private Statline.Stattrac.Windows.Forms.Label lblFirstNameData;
        private Statline.Stattrac.Windows.Forms.Label lblReferralNoData;
        private Statline.Stattrac.Data.Types.Dashboard.RecycledRestoreDS recycledRestoreDS1;

    }
}