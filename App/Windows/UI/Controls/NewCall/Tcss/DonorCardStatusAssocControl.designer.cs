namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class DonorCardStatusAssocControl
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("TcssDonorToRecipient", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn1 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorToRecipientId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn2 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateStatEmployeeId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn3 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastUpdateDate");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn4 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssDonorId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn5 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssRecipientId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn6 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn7 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ClientName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn8 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("TcssListOrganType");
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(DonorCardStatusAssocControl));
            this.gbDonorCardStatus = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.txtDateTime = new Statline.Stattrac.Windows.Forms.Label();
            this.txtStatusSetBy = new Statline.Stattrac.Windows.Forms.Label();
            this.cbStatusOfImportData = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblDateTime = new Statline.Stattrac.Windows.Forms.Label();
            this.lblStatusSetBy = new Statline.Stattrac.Windows.Forms.Label();
            this.lblStatusOfImportData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCardMessage = new Statline.Stattrac.Windows.Forms.Label();
            this.gbAssociatedDonorCards = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.ugAssociatedDonorCards = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.tcssDS1 = new Statline.Stattrac.Data.Types.NewCall.TcssDS();
            this.lblAssociatedDonorCards = new Statline.Stattrac.Windows.Forms.Label();
            this.txtStatusSetByStatEmployeeId = new Statline.Stattrac.Windows.Forms.TextBox();
            this.dtStatusSetDateTime = new Statline.Stattrac.Windows.Forms.DateTimePicker();
            this.gbDonorCardStatus.SuspendLayout();
            this.gbAssociatedDonorCards.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedDonorCards)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tcssDS1)).BeginInit();
            this.SuspendLayout();
            // 
            // gbDonorCardStatus
            // 
            this.gbDonorCardStatus.Controls.Add(this.txtDateTime);
            this.gbDonorCardStatus.Controls.Add(this.txtStatusSetBy);
            this.gbDonorCardStatus.Controls.Add(this.cbStatusOfImportData);
            this.gbDonorCardStatus.Controls.Add(this.lblDateTime);
            this.gbDonorCardStatus.Controls.Add(this.lblStatusSetBy);
            this.gbDonorCardStatus.Controls.Add(this.lblStatusOfImportData);
            this.gbDonorCardStatus.Controls.Add(this.lblCardMessage);
            this.gbDonorCardStatus.Location = new System.Drawing.Point(13, 13);
            this.gbDonorCardStatus.Name = "gbDonorCardStatus";
            this.gbDonorCardStatus.Size = new System.Drawing.Size(393, 143);
            this.gbDonorCardStatus.TabIndex = 0;
            this.gbDonorCardStatus.TabStop = false;
            this.gbDonorCardStatus.Text = "Donor Card Status";
            // 
            // txtDateTime
            // 
            this.txtDateTime.AutoSize = true;
            this.txtDateTime.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtDateTime.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtDateTime.Location = new System.Drawing.Point(214, 110);
            this.txtDateTime.Name = "txtDateTime";
            this.txtDateTime.Size = new System.Drawing.Size(37, 13);
            this.txtDateTime.TabIndex = 6;
            this.txtDateTime.Text = "_____";
            // 
            // txtStatusSetBy
            // 
            this.txtStatusSetBy.AutoSize = true;
            this.txtStatusSetBy.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtStatusSetBy.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtStatusSetBy.Location = new System.Drawing.Point(214, 85);
            this.txtStatusSetBy.Name = "txtStatusSetBy";
            this.txtStatusSetBy.Size = new System.Drawing.Size(37, 13);
            this.txtStatusSetBy.TabIndex = 5;
            this.txtStatusSetBy.Text = "_____";
            // 
            // cbStatusOfImportData
            // 
            this.cbStatusOfImportData.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cbStatusOfImportData.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbStatusOfImportData.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbStatusOfImportData.Enabled = false;
            this.cbStatusOfImportData.Font = new System.Drawing.Font("Tahoma", 8F);
            this.cbStatusOfImportData.FormattingEnabled = true;
            this.cbStatusOfImportData.Location = new System.Drawing.Point(137, 52);
            this.cbStatusOfImportData.Name = "cbStatusOfImportData";
            this.cbStatusOfImportData.Required = false;
            this.cbStatusOfImportData.Size = new System.Drawing.Size(242, 21);
            this.cbStatusOfImportData.TabIndex = 4;
            this.cbStatusOfImportData.SelectedIndexChanged += new System.EventHandler(this.cbStatusOfImportData_SelectedIndexChanged);
            this.cbStatusOfImportData.Leave += new System.EventHandler(this.cbStatusOfImportData_Leave);
            // 
            // lblDateTime
            // 
            this.lblDateTime.AutoSize = true;
            this.lblDateTime.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblDateTime.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblDateTime.Location = new System.Drawing.Point(134, 110);
            this.lblDateTime.Name = "lblDateTime";
            this.lblDateTime.Size = new System.Drawing.Size(60, 13);
            this.lblDateTime.TabIndex = 3;
            this.lblDateTime.Text = "Date/Time:";
            // 
            // lblStatusSetBy
            // 
            this.lblStatusSetBy.AutoSize = true;
            this.lblStatusSetBy.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblStatusSetBy.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblStatusSetBy.Location = new System.Drawing.Point(134, 85);
            this.lblStatusSetBy.Name = "lblStatusSetBy";
            this.lblStatusSetBy.Size = new System.Drawing.Size(76, 13);
            this.lblStatusSetBy.TabIndex = 2;
            this.lblStatusSetBy.Text = "Status Set By:";
            // 
            // lblStatusOfImportData
            // 
            this.lblStatusOfImportData.AutoSize = true;
            this.lblStatusOfImportData.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblStatusOfImportData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblStatusOfImportData.Location = new System.Drawing.Point(15, 52);
            this.lblStatusOfImportData.Name = "lblStatusOfImportData";
            this.lblStatusOfImportData.Size = new System.Drawing.Size(116, 13);
            this.lblStatusOfImportData.TabIndex = 1;
            this.lblStatusOfImportData.Text = "Status of Import Data:";
            // 
            // lblCardMessage
            // 
            this.lblCardMessage.AutoSize = true;
            this.lblCardMessage.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblCardMessage.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCardMessage.Location = new System.Drawing.Point(15, 25);
            this.lblCardMessage.Name = "lblCardMessage";
            this.lblCardMessage.Size = new System.Drawing.Size(295, 13);
            this.lblCardMessage.TabIndex = 0;
            this.lblCardMessage.Text = "Donor Cards cannot be modified until a status has been set.";
            // 
            // gbAssociatedDonorCards
            // 
            this.gbAssociatedDonorCards.Controls.Add(this.ugAssociatedDonorCards);
            this.gbAssociatedDonorCards.Controls.Add(this.lblAssociatedDonorCards);
            this.gbAssociatedDonorCards.Location = new System.Drawing.Point(13, 185);
            this.gbAssociatedDonorCards.Name = "gbAssociatedDonorCards";
            this.gbAssociatedDonorCards.Size = new System.Drawing.Size(583, 203);
            this.gbAssociatedDonorCards.TabIndex = 1;
            this.gbAssociatedDonorCards.TabStop = false;
            this.gbAssociatedDonorCards.Text = "Associated Donor Cards";
            // 
            // ugAssociatedDonorCards
            // 
            this.ugAssociatedDonorCards.DataMember = "TcssDonorToRecipient";
            this.ugAssociatedDonorCards.DataSource = this.tcssDS1;
            appearance9.BackColor = System.Drawing.Color.Transparent;
            this.ugAssociatedDonorCards.DisplayLayout.Appearance = appearance9;
            this.ugAssociatedDonorCards.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn1.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn1.Header.VisiblePosition = 0;
            ultraGridColumn1.Hidden = true;
            ultraGridColumn1.Width = 161;
            ultraGridColumn2.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn2.Header.VisiblePosition = 2;
            ultraGridColumn2.Hidden = true;
            ultraGridColumn3.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn3.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn3.Header.VisiblePosition = 3;
            ultraGridColumn3.Hidden = true;
            ultraGridColumn4.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn4.Header.VisiblePosition = 4;
            ultraGridColumn4.Hidden = true;
            ultraGridColumn4.Width = 140;
            ultraGridColumn5.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn5.Header.VisiblePosition = 1;
            ultraGridColumn5.Hidden = true;
            ultraGridColumn5.Width = 130;
            ultraGridColumn6.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn6.Header.VisiblePosition = 5;
            ultraGridColumn6.Width = 130;
            ultraGridColumn7.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn7.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn7.Header.VisiblePosition = 6;
            ultraGridColumn7.Width = 195;
            ultraGridColumn8.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn8.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn8.Header.VisiblePosition = 7;
            ultraGridColumn8.Width = 186;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn1,
            ultraGridColumn2,
            ultraGridColumn3,
            ultraGridColumn4,
            ultraGridColumn5,
            ultraGridColumn6,
            ultraGridColumn7,
            ultraGridColumn8});
            this.ugAssociatedDonorCards.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugAssociatedDonorCards.DisplayLayout.MaxRowScrollRegions = 1;
            appearance10.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance10.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance10.BackHatchStyle = Infragistics.Win.BackHatchStyle.Horizontal;
            this.ugAssociatedDonorCards.DisplayLayout.Override.ActiveCellAppearance = appearance10;
            appearance11.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance11.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugAssociatedDonorCards.DisplayLayout.Override.ActiveRowAppearance = appearance11;
            this.ugAssociatedDonorCards.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugAssociatedDonorCards.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugAssociatedDonorCards.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance12.BackColor = System.Drawing.Color.Transparent;
            this.ugAssociatedDonorCards.DisplayLayout.Override.CardAreaAppearance = appearance12;
            appearance13.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance13.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance13.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance13.FontData.BoldAsString = "True";
            appearance13.FontData.Name = "Tahoma";
            appearance13.FontData.SizeInPoints = 8F;
            appearance13.ForeColor = System.Drawing.Color.White;
            appearance13.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugAssociatedDonorCards.DisplayLayout.Override.HeaderAppearance = appearance13;
            this.ugAssociatedDonorCards.DisplayLayout.Override.InvalidValueBehavior = Infragistics.Win.UltraWinGrid.InvalidValueBehavior.RevertValueAndRetainFocus;
            appearance14.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance14.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugAssociatedDonorCards.DisplayLayout.Override.RowSelectorAppearance = appearance14;
            appearance15.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance15.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance15.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance15.ForeColor = System.Drawing.Color.Black;
            this.ugAssociatedDonorCards.DisplayLayout.Override.SelectedRowAppearance = appearance15;
            this.ugAssociatedDonorCards.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugAssociatedDonorCards.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            appearance16.BackColor = System.Drawing.Color.LightSkyBlue;
            appearance16.BackColor2 = System.Drawing.Color.CornflowerBlue;
            appearance16.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugAssociatedDonorCards.DisplayLayout.Override.TemplateAddRowAppearance = appearance16;
            this.ugAssociatedDonorCards.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugAssociatedDonorCards.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugAssociatedDonorCards.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugAssociatedDonorCards.Font = new System.Drawing.Font("Tahoma", 7F);
            this.ugAssociatedDonorCards.Location = new System.Drawing.Point(18, 70);
            this.ugAssociatedDonorCards.Name = "ugAssociatedDonorCards";
            this.ugAssociatedDonorCards.Size = new System.Drawing.Size(532, 127);
            this.ugAssociatedDonorCards.TabIndex = 1;
            this.ugAssociatedDonorCards.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugAssociatedDonorCards.UpdateMode = Infragistics.Win.UltraWinGrid.UpdateMode.OnCellChangeOrLostFocus;
            this.ugAssociatedDonorCards.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ugAssociatedDonorCards_InitializeRow);
            // 
            // tcssDS1
            // 
            this.tcssDS1.DataSetName = "TcssDS";
            this.tcssDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // lblAssociatedDonorCards
            // 
            this.lblAssociatedDonorCards.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblAssociatedDonorCards.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblAssociatedDonorCards.Location = new System.Drawing.Point(18, 24);
            this.lblAssociatedDonorCards.Name = "lblAssociatedDonorCards";
            this.lblAssociatedDonorCards.Size = new System.Drawing.Size(565, 43);
            this.lblAssociatedDonorCards.TabIndex = 0;
            this.lblAssociatedDonorCards.Text = resources.GetString("lblAssociatedDonorCards.Text");
            // 
            // txtStatusSetByStatEmployeeId
            // 
            this.txtStatusSetByStatEmployeeId.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtStatusSetByStatEmployeeId.Location = new System.Drawing.Point(412, 90);
            this.txtStatusSetByStatEmployeeId.Name = "txtStatusSetByStatEmployeeId";
            this.txtStatusSetByStatEmployeeId.Required = false;
            this.txtStatusSetByStatEmployeeId.Size = new System.Drawing.Size(0, 20);
            this.txtStatusSetByStatEmployeeId.SpellCheckEnabled = false;
            this.txtStatusSetByStatEmployeeId.TabIndex = 7;
            this.txtStatusSetByStatEmployeeId.Visible = false;
            // 
            // dtStatusSetDateTime
            // 
            this.dtStatusSetDateTime.CustomFormat = "MM/dd/yyyy HH:mm";
            this.dtStatusSetDateTime.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtStatusSetDateTime.Location = new System.Drawing.Point(412, 116);
            this.dtStatusSetDateTime.Name = "dtStatusSetDateTime";
            this.dtStatusSetDateTime.Size = new System.Drawing.Size(0, 20);
            this.dtStatusSetDateTime.TabIndex = 8;
            this.dtStatusSetDateTime.Value = new System.DateTime(2010, 7, 15, 14, 38, 34, 0);
            this.dtStatusSetDateTime.Visible = false;
            // 
            // DonorCardStatusAssocControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.gbAssociatedDonorCards);
            this.Controls.Add(this.gbDonorCardStatus);
            this.Controls.Add(this.txtStatusSetByStatEmployeeId);
            this.Controls.Add(this.dtStatusSetDateTime);
            this.Name = "DonorCardStatusAssocControl";
            this.Size = new System.Drawing.Size(630, 451);
            this.Leave += new System.EventHandler(this.DonorCardStatusAssocControl_Leave);
            this.gbDonorCardStatus.ResumeLayout(false);
            this.gbDonorCardStatus.PerformLayout();
            this.gbAssociatedDonorCards.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ugAssociatedDonorCards)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tcssDS1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.GroupBox gbDonorCardStatus;
		private Statline.Stattrac.Windows.Forms.ComboBox cbStatusOfImportData;
		private Statline.Stattrac.Windows.Forms.Label lblDateTime;
		private Statline.Stattrac.Windows.Forms.Label lblStatusSetBy;
		private Statline.Stattrac.Windows.Forms.Label lblStatusOfImportData;
		private Statline.Stattrac.Windows.Forms.Label lblCardMessage;
		private Statline.Stattrac.Windows.Forms.Label txtDateTime;
		private Statline.Stattrac.Windows.Forms.Label txtStatusSetBy;
		private Statline.Stattrac.Windows.Forms.GroupBox gbAssociatedDonorCards;
		private Statline.Stattrac.Windows.Forms.Label lblAssociatedDonorCards;
		private Statline.Stattrac.Windows.Forms.UltraGrid ugAssociatedDonorCards;
        private Statline.Stattrac.Data.Types.NewCall.TcssDS tcssDS1;
        private Statline.Stattrac.Windows.Forms.TextBox txtStatusSetByStatEmployeeId;
        private Statline.Stattrac.Windows.Forms.DateTimePicker dtStatusSetDateTime;
	}
}
