namespace Statline.Stattrac.Windows.UI.Controls.NewCall.FamilyServices
{
	partial class CaseStatusControl
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
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("FsbCaseStatus", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn10 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("FsbCaseStatusId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn11 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn12 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastStatEmployeeId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn13 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastStatEmployeeName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn14 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastModified");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn15 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("FamilyServicesCoordinatorId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn16 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("FamilyServicesCoordinatorName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn17 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("ListFsbStatusId");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn18 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Comment");
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            this.txtClient = new Statline.Stattrac.Windows.Forms.TextBox();
            this.txtPatientFirstName = new Statline.Stattrac.Windows.Forms.TextBox();
            this.txtPatientLastName = new Statline.Stattrac.Windows.Forms.TextBox();
            this.txtReferralNum = new Statline.Stattrac.Windows.Forms.TextBox();
            this.txtDateCreated = new Statline.Stattrac.Windows.Forms.TextBox();
            this.txtCreatedBy = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblCreatedBy = new Statline.Stattrac.Windows.Forms.Label();
            this.lblDateCreated = new Statline.Stattrac.Windows.Forms.Label();
            this.lblPatientFirstName = new Statline.Stattrac.Windows.Forms.Label();
            this.lblPatientLastName = new Statline.Stattrac.Windows.Forms.Label();
            this.lblClient = new Statline.Stattrac.Windows.Forms.Label();
            this.lblReferralNum = new Statline.Stattrac.Windows.Forms.Label();
            this.ugFsbCaseStatus = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.familyServicesDS1 = new Statline.Stattrac.Data.Types.NewCall.FamilyServicesDS();
            this.splitContainer1 = new System.Windows.Forms.SplitContainer();
            ((System.ComponentModel.ISupportInitialize)(this.ugFsbCaseStatus)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.familyServicesDS1)).BeginInit();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtClient
            // 
            this.txtClient.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtClient.Location = new System.Drawing.Point(113, 89);
            this.txtClient.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.ReadOnly;
            this.txtClient.Name = "txtClient";
            this.txtClient.ReadOnly = true;
            this.txtClient.Required = false;
            this.txtClient.Size = new System.Drawing.Size(100, 20);
            this.txtClient.SpellCheckEnabled = false;
            this.txtClient.TabIndex = 91;
            this.txtClient.TabStop = false;
            // 
            // txtPatientFirstName
            // 
            this.txtPatientFirstName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtPatientFirstName.Location = new System.Drawing.Point(113, 139);
            this.txtPatientFirstName.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.ReadOnly;
            this.txtPatientFirstName.Name = "txtPatientFirstName";
            this.txtPatientFirstName.ReadOnly = true;
            this.txtPatientFirstName.Required = false;
            this.txtPatientFirstName.Size = new System.Drawing.Size(100, 20);
            this.txtPatientFirstName.SpellCheckEnabled = false;
            this.txtPatientFirstName.TabIndex = 90;
            this.txtPatientFirstName.TabStop = false;
            // 
            // txtPatientLastName
            // 
            this.txtPatientLastName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtPatientLastName.Location = new System.Drawing.Point(113, 114);
            this.txtPatientLastName.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.ReadOnly;
            this.txtPatientLastName.Name = "txtPatientLastName";
            this.txtPatientLastName.ReadOnly = true;
            this.txtPatientLastName.Required = false;
            this.txtPatientLastName.Size = new System.Drawing.Size(100, 20);
            this.txtPatientLastName.SpellCheckEnabled = false;
            this.txtPatientLastName.TabIndex = 89;
            this.txtPatientLastName.TabStop = false;
            // 
            // txtReferralNum
            // 
            this.txtReferralNum.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtReferralNum.Location = new System.Drawing.Point(113, 64);
            this.txtReferralNum.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.PositiveInteger;
            this.txtReferralNum.Name = "txtReferralNum";
            this.txtReferralNum.Required = false;
            this.txtReferralNum.Size = new System.Drawing.Size(100, 20);
            this.txtReferralNum.SpellCheckEnabled = false;
            this.txtReferralNum.TabIndex = 88;
            this.txtReferralNum.Leave += new System.EventHandler(this.txtReferralNum_Leave);
            // 
            // txtDateCreated
            // 
            this.txtDateCreated.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtDateCreated.Location = new System.Drawing.Point(113, 39);
            this.txtDateCreated.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.ReadOnly;
            this.txtDateCreated.Name = "txtDateCreated";
            this.txtDateCreated.ReadOnly = true;
            this.txtDateCreated.Required = false;
            this.txtDateCreated.Size = new System.Drawing.Size(100, 20);
            this.txtDateCreated.SpellCheckEnabled = false;
            this.txtDateCreated.TabIndex = 87;
            this.txtDateCreated.TabStop = false;
            // 
            // txtCreatedBy
            // 
            this.txtCreatedBy.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtCreatedBy.Location = new System.Drawing.Point(113, 14);
            this.txtCreatedBy.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.ReadOnly;
            this.txtCreatedBy.Name = "txtCreatedBy";
            this.txtCreatedBy.ReadOnly = true;
            this.txtCreatedBy.Required = false;
            this.txtCreatedBy.Size = new System.Drawing.Size(100, 20);
            this.txtCreatedBy.SpellCheckEnabled = false;
            this.txtCreatedBy.TabIndex = 86;
            this.txtCreatedBy.TabStop = false;
            // 
            // lblCreatedBy
            // 
            this.lblCreatedBy.AutoSize = true;
            this.lblCreatedBy.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblCreatedBy.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCreatedBy.Location = new System.Drawing.Point(45, 14);
            this.lblCreatedBy.Name = "lblCreatedBy";
            this.lblCreatedBy.Size = new System.Drawing.Size(65, 13);
            this.lblCreatedBy.TabIndex = 80;
            this.lblCreatedBy.Text = "Created By:";
            // 
            // lblDateCreated
            // 
            this.lblDateCreated.AutoSize = true;
            this.lblDateCreated.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblDateCreated.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblDateCreated.Location = new System.Drawing.Point(34, 39);
            this.lblDateCreated.Name = "lblDateCreated";
            this.lblDateCreated.Size = new System.Drawing.Size(76, 13);
            this.lblDateCreated.TabIndex = 81;
            this.lblDateCreated.Text = "Date Created:";
            // 
            // lblPatientFirstName
            // 
            this.lblPatientFirstName.AutoSize = true;
            this.lblPatientFirstName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblPatientFirstName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblPatientFirstName.Location = new System.Drawing.Point(11, 139);
            this.lblPatientFirstName.Name = "lblPatientFirstName";
            this.lblPatientFirstName.Size = new System.Drawing.Size(99, 13);
            this.lblPatientFirstName.TabIndex = 85;
            this.lblPatientFirstName.Text = "Patient First Name:";
            // 
            // lblPatientLastName
            // 
            this.lblPatientLastName.AutoSize = true;
            this.lblPatientLastName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblPatientLastName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblPatientLastName.Location = new System.Drawing.Point(10, 114);
            this.lblPatientLastName.Name = "lblPatientLastName";
            this.lblPatientLastName.Size = new System.Drawing.Size(98, 13);
            this.lblPatientLastName.TabIndex = 84;
            this.lblPatientLastName.Text = "Patient Last Name:";
            // 
            // lblClient
            // 
            this.lblClient.AutoSize = true;
            this.lblClient.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblClient.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblClient.Location = new System.Drawing.Point(71, 89);
            this.lblClient.Name = "lblClient";
            this.lblClient.Size = new System.Drawing.Size(38, 13);
            this.lblClient.TabIndex = 83;
            this.lblClient.Text = "Client:";
            // 
            // lblReferralNum
            // 
            this.lblReferralNum.AutoSize = true;
            this.lblReferralNum.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblReferralNum.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblReferralNum.Location = new System.Drawing.Point(50, 64);
            this.lblReferralNum.Name = "lblReferralNum";
            this.lblReferralNum.Size = new System.Drawing.Size(61, 13);
            this.lblReferralNum.TabIndex = 82;
            this.lblReferralNum.Text = "Referral #:";
            // 
            // ugFsbCaseStatus
            // 
            this.ugFsbCaseStatus.DataMember = "FsbCaseStatus";
            this.ugFsbCaseStatus.DataSource = this.familyServicesDS1;
            appearance1.BackColor = System.Drawing.Color.Transparent;
            this.ugFsbCaseStatus.DisplayLayout.Appearance = appearance1;
            this.ugFsbCaseStatus.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn10.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn10.Header.VisiblePosition = 0;
            ultraGridColumn10.Hidden = true;
            ultraGridColumn10.Width = 139;
            ultraGridColumn11.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn11.Header.VisiblePosition = 1;
            ultraGridColumn11.Hidden = true;
            ultraGridColumn11.Width = 107;
            ultraGridColumn12.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn12.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn12.Format = "";
            ultraGridColumn12.Header.VisiblePosition = 3;
            ultraGridColumn12.Width = 184;
            ultraGridColumn13.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn13.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn13.Header.VisiblePosition = 4;
            ultraGridColumn13.Hidden = true;
            ultraGridColumn13.Width = 104;
            ultraGridColumn14.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn14.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn14.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn14.Header.VisiblePosition = 2;
            ultraGridColumn14.Width = 151;
            ultraGridColumn15.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn15.Header.VisiblePosition = 5;
            ultraGridColumn15.Width = 222;
            ultraGridColumn16.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn16.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn16.Header.VisiblePosition = 6;
            ultraGridColumn16.Hidden = true;
            ultraGridColumn16.Width = 167;
            ultraGridColumn17.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn17.Header.VisiblePosition = 7;
            ultraGridColumn17.Width = 113;
            ultraGridColumn18.AutoCompleteMode = Infragistics.Win.AutoCompleteMode.Append;
            ultraGridColumn18.Header.VisiblePosition = 8;
            ultraGridColumn18.Width = 182;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn10,
            ultraGridColumn11,
            ultraGridColumn12,
            ultraGridColumn13,
            ultraGridColumn14,
            ultraGridColumn15,
            ultraGridColumn16,
            ultraGridColumn17,
            ultraGridColumn18});
            this.ugFsbCaseStatus.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugFsbCaseStatus.DisplayLayout.MaxRowScrollRegions = 1;
            appearance2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance2.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance2.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance2.BackHatchStyle = Infragistics.Win.BackHatchStyle.Horizontal;
            this.ugFsbCaseStatus.DisplayLayout.Override.ActiveCellAppearance = appearance2;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugFsbCaseStatus.DisplayLayout.Override.ActiveRowAppearance = appearance3;
            this.ugFsbCaseStatus.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugFsbCaseStatus.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugFsbCaseStatus.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance4.BackColor = System.Drawing.Color.Transparent;
            this.ugFsbCaseStatus.DisplayLayout.Override.CardAreaAppearance = appearance4;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance5.FontData.BoldAsString = "True";
            appearance5.FontData.Name = "Tahoma";
            appearance5.FontData.SizeInPoints = 8F;
            appearance5.ForeColor = System.Drawing.Color.White;
            appearance5.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugFsbCaseStatus.DisplayLayout.Override.HeaderAppearance = appearance5;
            appearance6.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance6.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance6.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugFsbCaseStatus.DisplayLayout.Override.RowSelectorAppearance = appearance6;
            appearance7.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance7.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance7.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance7.ForeColor = System.Drawing.Color.Black;
            this.ugFsbCaseStatus.DisplayLayout.Override.SelectedRowAppearance = appearance7;
            this.ugFsbCaseStatus.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugFsbCaseStatus.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            appearance8.BackColor = System.Drawing.Color.LightSkyBlue;
            appearance8.BackColor2 = System.Drawing.Color.CornflowerBlue;
            appearance8.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugFsbCaseStatus.DisplayLayout.Override.TemplateAddRowAppearance = appearance8;
            this.ugFsbCaseStatus.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugFsbCaseStatus.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugFsbCaseStatus.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugFsbCaseStatus.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugFsbCaseStatus.Font = new System.Drawing.Font("Tahoma", 7F);
            this.ugFsbCaseStatus.Location = new System.Drawing.Point(0, 0);
            this.ugFsbCaseStatus.Name = "ugFsbCaseStatus";
            this.ugFsbCaseStatus.Size = new System.Drawing.Size(873, 385);
            this.ugFsbCaseStatus.TabIndex = 92;
            this.ugFsbCaseStatus.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugFsbCaseStatus.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugFsbCaseStatus_InitializeLayout);
            this.ugFsbCaseStatus.AfterRowActivate += new System.EventHandler(this.ugFsbCaseStatus_AfterRowActivate);
            // 
            // familyServicesDS1
            // 
            this.familyServicesDS1.DataSetName = "FamilyServicesDS";
            this.familyServicesDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.lblCreatedBy);
            this.splitContainer1.Panel1.Controls.Add(this.lblReferralNum);
            this.splitContainer1.Panel1.Controls.Add(this.txtCreatedBy);
            this.splitContainer1.Panel1.Controls.Add(this.txtClient);
            this.splitContainer1.Panel1.Controls.Add(this.txtDateCreated);
            this.splitContainer1.Panel1.Controls.Add(this.lblClient);
            this.splitContainer1.Panel1.Controls.Add(this.lblDateCreated);
            this.splitContainer1.Panel1.Controls.Add(this.txtPatientFirstName);
            this.splitContainer1.Panel1.Controls.Add(this.txtReferralNum);
            this.splitContainer1.Panel1.Controls.Add(this.lblPatientLastName);
            this.splitContainer1.Panel1.Controls.Add(this.lblPatientFirstName);
            this.splitContainer1.Panel1.Controls.Add(this.txtPatientLastName);
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.ugFsbCaseStatus);
            this.splitContainer1.Size = new System.Drawing.Size(873, 564);
            this.splitContainer1.SplitterDistance = 175;
            this.splitContainer1.TabIndex = 94;
            // 
            // CaseStatusControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.splitContainer1);
            this.Name = "CaseStatusControl";
            this.Size = new System.Drawing.Size(873, 564);
            ((System.ComponentModel.ISupportInitialize)(this.ugFsbCaseStatus)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.familyServicesDS1)).EndInit();
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel1.PerformLayout();
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.ResumeLayout(false);
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.TextBox txtClient;
		private Statline.Stattrac.Windows.Forms.TextBox txtPatientFirstName;
		private Statline.Stattrac.Windows.Forms.TextBox txtPatientLastName;
		private Statline.Stattrac.Windows.Forms.TextBox txtReferralNum;
		private Statline.Stattrac.Windows.Forms.TextBox txtDateCreated;
		private Statline.Stattrac.Windows.Forms.TextBox txtCreatedBy;
		private Statline.Stattrac.Windows.Forms.Label lblCreatedBy;
		private Statline.Stattrac.Windows.Forms.Label lblDateCreated;
		private Statline.Stattrac.Windows.Forms.Label lblPatientFirstName;
		private Statline.Stattrac.Windows.Forms.Label lblPatientLastName;
		private Statline.Stattrac.Windows.Forms.Label lblClient;
		private Statline.Stattrac.Windows.Forms.Label lblReferralNum;
		private Statline.Stattrac.Windows.Forms.UltraGrid ugFsbCaseStatus;
		private Statline.Stattrac.Data.Types.NewCall.FamilyServicesDS familyServicesDS1;
		private System.Windows.Forms.SplitContainer splitContainer1;


	}
}
