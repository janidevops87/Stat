namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class RestoreMessagesPopUp
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("RecycleRestoreMessagesList", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MessageCallerName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MessageCallerOrganization");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SourceCodeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("MessageImportUNOSID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn6 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventDateTime");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn7 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CreatedBy");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn8 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventTypeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn9 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventOrg");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn10 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventDesc");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn11 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventNumber");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn12 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventName");
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            this.ugRestoreMessage = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.recycledRestoreDS1 = new Statline.Stattrac.Data.Types.Dashboard.RecycledRestoreDS();
            this.lblTransCenterData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMsgForOrgData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCallerOrgData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCallerNameData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMsgImpNoData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblTransCenter = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMsgForOrg = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCallerOrg = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCallerName = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMsgImpNo = new Statline.Stattrac.Windows.Forms.Label();
            this.btnCancel = new Statline.Stattrac.Windows.Forms.Button();
            this.btnRestoreCase = new Statline.Stattrac.Windows.Forms.Button();
            this.lblUnosIDData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblUnosID = new Statline.Stattrac.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.ugRestoreMessage)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.recycledRestoreDS1)).BeginInit();
            this.SuspendLayout();
            // 
            // ugRestoreMessage
            // 
            this.ugRestoreMessage.DataMember = "RecycleRestoreMessagesList";
            this.ugRestoreMessage.DataSource = this.recycledRestoreDS1;
            appearance1.BackColor = System.Drawing.Color.Transparent;
            this.ugRestoreMessage.DisplayLayout.Appearance = appearance1;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn1.Hidden = true;
            ultraGridColumn2.Header.VisiblePosition = 1;
            ultraGridColumn2.Hidden = true;
            ultraGridColumn3.Header.VisiblePosition = 2;
            ultraGridColumn3.Hidden = true;
            ultraGridColumn4.Header.VisiblePosition = 3;
            ultraGridColumn4.Hidden = true;
            ultraGridColumn5.Header.VisiblePosition = 8;
            ultraGridColumn5.Hidden = true;
            ultraGridColumn6.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn6.Header.Caption = "Date/Time";
            ultraGridColumn6.Header.VisiblePosition = 4;
            ultraGridColumn6.Width = 100;
            ultraGridColumn7.Header.Caption = "By";
            ultraGridColumn7.Header.VisiblePosition = 9;
            ultraGridColumn7.Width = 67;
            ultraGridColumn8.Header.Caption = "Event Type";
            ultraGridColumn8.Header.VisiblePosition = 5;
            ultraGridColumn9.Header.Caption = "Organization";
            ultraGridColumn9.Header.VisiblePosition = 7;
            ultraGridColumn9.Width = 192;
            ultraGridColumn10.Header.Caption = "Description";
            ultraGridColumn10.Header.VisiblePosition = 10;
            ultraGridColumn10.Width = 283;
            ultraGridColumn11.Header.Caption = "#";
            ultraGridColumn11.Header.VisiblePosition = 11;
            ultraGridColumn11.Width = 26;
            ultraGridColumn12.Header.Caption = "From/To";
            ultraGridColumn12.Header.VisiblePosition = 6;
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
            ultraGridColumn12});
            this.ugRestoreMessage.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugRestoreMessage.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ugRestoreMessage.DisplayLayout.Override.CardAreaAppearance = appearance2;
            this.ugRestoreMessage.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.RowSelect;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.FontData.BoldAsString = "True";
            appearance3.FontData.Name = "Arial";
            appearance3.FontData.SizeInPoints = 10F;
            appearance3.ForeColor = System.Drawing.Color.White;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugRestoreMessage.DisplayLayout.Override.HeaderAppearance = appearance3;
            this.ugRestoreMessage.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugRestoreMessage.DisplayLayout.Override.RowSelectorAppearance = appearance4;
            this.ugRestoreMessage.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance5.ForeColor = System.Drawing.Color.Black;
            this.ugRestoreMessage.DisplayLayout.Override.SelectedRowAppearance = appearance5;
            this.ugRestoreMessage.Font = new System.Drawing.Font("Tahoma", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);
            this.ugRestoreMessage.Location = new System.Drawing.Point(12, 107);
            this.ugRestoreMessage.Name = "ugRestoreMessage";
            this.ugRestoreMessage.Size = new System.Drawing.Size(857, 241);
            this.ugRestoreMessage.TabIndex = 0;
            this.ugRestoreMessage.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            // 
            // recycledRestoreDS1
            // 
            this.recycledRestoreDS1.DataSetName = "RecycledRestoreDS";
            this.recycledRestoreDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // lblTransCenterData
            // 
            this.lblTransCenterData.AutoSize = true;
            this.lblTransCenterData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblTransCenterData.Location = new System.Drawing.Point(146, 77);
            this.lblTransCenterData.Name = "lblTransCenterData";
            this.lblTransCenterData.Size = new System.Drawing.Size(35, 13);
            this.lblTransCenterData.TabIndex = 22;
            this.lblTransCenterData.Text = "label6";
            // 
            // lblMsgForOrgData
            // 
            this.lblMsgForOrgData.AutoSize = true;
            this.lblMsgForOrgData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMsgForOrgData.Location = new System.Drawing.Point(146, 60);
            this.lblMsgForOrgData.Name = "lblMsgForOrgData";
            this.lblMsgForOrgData.Size = new System.Drawing.Size(35, 13);
            this.lblMsgForOrgData.TabIndex = 21;
            this.lblMsgForOrgData.Text = "label7";
            // 
            // lblCallerOrgData
            // 
            this.lblCallerOrgData.AutoSize = true;
            this.lblCallerOrgData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCallerOrgData.Location = new System.Drawing.Point(146, 43);
            this.lblCallerOrgData.Name = "lblCallerOrgData";
            this.lblCallerOrgData.Size = new System.Drawing.Size(35, 13);
            this.lblCallerOrgData.TabIndex = 20;
            this.lblCallerOrgData.Text = "label8";
            // 
            // lblCallerNameData
            // 
            this.lblCallerNameData.AutoSize = true;
            this.lblCallerNameData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCallerNameData.Location = new System.Drawing.Point(146, 26);
            this.lblCallerNameData.Name = "lblCallerNameData";
            this.lblCallerNameData.Size = new System.Drawing.Size(25, 13);
            this.lblCallerNameData.TabIndex = 19;
            this.lblCallerNameData.Text = "999";
            // 
            // lblMsgImpNoData
            // 
            this.lblMsgImpNoData.AutoSize = true;
            this.lblMsgImpNoData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMsgImpNoData.Location = new System.Drawing.Point(146, 9);
            this.lblMsgImpNoData.Name = "lblMsgImpNoData";
            this.lblMsgImpNoData.Size = new System.Drawing.Size(41, 13);
            this.lblMsgImpNoData.TabIndex = 18;
            this.lblMsgImpNoData.Text = "label10";
            // 
            // lblTransCenter
            // 
            this.lblTransCenter.AutoSize = true;
            this.lblTransCenter.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblTransCenter.Location = new System.Drawing.Point(12, 77);
            this.lblTransCenter.Name = "lblTransCenter";
            this.lblTransCenter.Size = new System.Drawing.Size(94, 13);
            this.lblTransCenter.TabIndex = 17;
            this.lblTransCenter.Text = "Transplant Center:";
            // 
            // lblMsgForOrg
            // 
            this.lblMsgForOrg.AutoSize = true;
            this.lblMsgForOrg.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMsgForOrg.Location = new System.Drawing.Point(12, 60);
            this.lblMsgForOrg.Name = "lblMsgForOrg";
            this.lblMsgForOrg.Size = new System.Drawing.Size(133, 13);
            this.lblMsgForOrg.TabIndex = 16;
            this.lblMsgForOrg.Text = "Message For Organization:";
            // 
            // lblCallerOrg
            // 
            this.lblCallerOrg.AutoSize = true;
            this.lblCallerOrg.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCallerOrg.Location = new System.Drawing.Point(12, 43);
            this.lblCallerOrg.Name = "lblCallerOrg";
            this.lblCallerOrg.Size = new System.Drawing.Size(98, 13);
            this.lblCallerOrg.TabIndex = 15;
            this.lblCallerOrg.Text = "Caller Organization:";
            // 
            // lblCallerName
            // 
            this.lblCallerName.AutoSize = true;
            this.lblCallerName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCallerName.Location = new System.Drawing.Point(12, 26);
            this.lblCallerName.Name = "lblCallerName";
            this.lblCallerName.Size = new System.Drawing.Size(67, 13);
            this.lblCallerName.TabIndex = 14;
            this.lblCallerName.Text = "Caller Name:";
            // 
            // lblMsgImpNo
            // 
            this.lblMsgImpNo.AutoSize = true;
            this.lblMsgImpNo.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMsgImpNo.Location = new System.Drawing.Point(12, 9);
            this.lblMsgImpNo.Name = "lblMsgImpNo";
            this.lblMsgImpNo.Size = new System.Drawing.Size(123, 13);
            this.lblMsgImpNo.TabIndex = 13;
            this.lblMsgImpNo.Text = "Message/Import Offer #:";
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(794, 354);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 24;
            this.btnCancel.Text = "&Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnRestoreCase
            // 
            this.btnRestoreCase.Location = new System.Drawing.Point(694, 354);
            this.btnRestoreCase.Name = "btnRestoreCase";
            this.btnRestoreCase.Size = new System.Drawing.Size(75, 23);
            this.btnRestoreCase.TabIndex = 23;
            this.btnRestoreCase.Text = "&Restore Case";
            this.btnRestoreCase.UseVisualStyleBackColor = true;
            this.btnRestoreCase.Click += new System.EventHandler(this.btnRestoreCase_Click);
            // 
            // lblUnosIDData
            // 
            this.lblUnosIDData.AutoSize = true;
            this.lblUnosIDData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblUnosIDData.Location = new System.Drawing.Point(146, 92);
            this.lblUnosIDData.Name = "lblUnosIDData";
            this.lblUnosIDData.Size = new System.Drawing.Size(35, 13);
            this.lblUnosIDData.TabIndex = 26;
            this.lblUnosIDData.Text = "label6";
            // 
            // lblUnosID
            // 
            this.lblUnosID.AutoSize = true;
            this.lblUnosID.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblUnosID.Location = new System.Drawing.Point(12, 92);
            this.lblUnosID.Name = "lblUnosID";
            this.lblUnosID.Size = new System.Drawing.Size(55, 13);
            this.lblUnosID.TabIndex = 25;
            this.lblUnosID.Text = "UNOS ID:";
            // 
            // RestoreMessagesPopUp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(881, 382);
            this.Controls.Add(this.lblUnosIDData);
            this.Controls.Add(this.lblUnosID);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnRestoreCase);
            this.Controls.Add(this.lblTransCenterData);
            this.Controls.Add(this.lblMsgForOrgData);
            this.Controls.Add(this.lblCallerOrgData);
            this.Controls.Add(this.lblCallerNameData);
            this.Controls.Add(this.lblMsgImpNoData);
            this.Controls.Add(this.lblTransCenter);
            this.Controls.Add(this.lblMsgForOrg);
            this.Controls.Add(this.lblCallerOrg);
            this.Controls.Add(this.lblCallerName);
            this.Controls.Add(this.lblMsgImpNo);
            this.Controls.Add(this.ugRestoreMessage);
            this.Name = "RestoreMessagesPopUp";
            this.ShowInTaskbar = false;
            this.Text = "RestoreMessagesPopUp";
            ((System.ComponentModel.ISupportInitialize)(this.ugRestoreMessage)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.recycledRestoreDS1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.UltraGrid ugRestoreMessage;
        private Statline.Stattrac.Windows.Forms.Label lblTransCenterData;
        private Statline.Stattrac.Windows.Forms.Label lblMsgForOrgData;
        private Statline.Stattrac.Windows.Forms.Label lblCallerOrgData;
        private Statline.Stattrac.Windows.Forms.Label lblCallerNameData;
        private Statline.Stattrac.Windows.Forms.Label lblMsgImpNoData;
        private Statline.Stattrac.Windows.Forms.Label lblTransCenter;
        private Statline.Stattrac.Windows.Forms.Label lblMsgForOrg;
        private Statline.Stattrac.Windows.Forms.Label lblCallerOrg;
        private Statline.Stattrac.Windows.Forms.Label lblCallerName;
        private Statline.Stattrac.Windows.Forms.Label lblMsgImpNo;
        private Statline.Stattrac.Windows.Forms.Button btnCancel;
        private Statline.Stattrac.Windows.Forms.Button btnRestoreCase;
        private Statline.Stattrac.Data.Types.Dashboard.RecycledRestoreDS recycledRestoreDS1;
        private Statline.Stattrac.Windows.Forms.Label lblUnosIDData;
        private Statline.Stattrac.Windows.Forms.Label lblUnosID;
    }
}