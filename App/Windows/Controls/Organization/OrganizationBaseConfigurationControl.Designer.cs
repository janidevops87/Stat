namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class OrganizationBaseConfigurationControl
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
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance3 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance4 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance5 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance6 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance15 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance17 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance18 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance19 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance20 = new Infragistics.Win.Appearance();
            this.lblOrganizationName = new Statline.Stattrac.Windows.Forms.Label();
            this.txtAspPhone = new Statline.Stattrac.Windows.Forms.MaskedTextBox();
            this.groupBox1 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.groupBox7 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.chkLinkToStatlinePhoneSystem = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.chkAutoDisplaySourceCode = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.cbAutoDisplaySourceCode = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.ugSourceCodeMappingFamilyServicesASP = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.label3 = new Statline.Stattrac.Windows.Forms.Label();
            this.cbASPSettingType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.label2 = new Statline.Stattrac.Windows.Forms.Label();
            this.groupBox2 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.groupBox5 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.ugCallEventExpiration = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.label4 = new Statline.Stattrac.Windows.Forms.Label();
            this.groupBox4 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.availableSelectedControl = new Statline.Stattrac.Windows.Forms.AvailableSelectedControl();
            this.groupBox3 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.label6 = new Statline.Stattrac.Windows.Forms.Label();
            this.ugCaseReviewPercentage = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.panel1 = new Statline.Stattrac.Windows.Forms.Panel();
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            this.groupBox6 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.label5 = new Statline.Stattrac.Windows.Forms.Label();
            this.ugDuplicateSearchSettings = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.groupBox1.SuspendLayout();
            this.groupBox7.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugSourceCodeMappingFamilyServicesASP)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.groupBox5.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugCallEventExpiration)).BeginInit();
            this.groupBox4.SuspendLayout();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugCaseReviewPercentage)).BeginInit();
            this.panel1.SuspendLayout();
            this.groupBox6.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugDuplicateSearchSettings)).BeginInit();
            this.SuspendLayout();
            // 
            // lblOrganizationName
            // 
            this.lblOrganizationName.AutoSize = true;
            this.lblOrganizationName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblOrganizationName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOrganizationName.Location = new System.Drawing.Point(3, 17);
            this.lblOrganizationName.Name = "lblOrganizationName";
            this.lblOrganizationName.Size = new System.Drawing.Size(95, 13);
            this.lblOrganizationName.TabIndex = 0;
            this.lblOrganizationName.Text = "OrganizationName";
            // 
            // txtAspPhone
            // 
            this.txtAspPhone.Location = new System.Drawing.Point(188, 7);
            this.txtAspPhone.Mask = "(999) 000-0000";
            this.txtAspPhone.Name = "txtAspPhone";
            this.txtAspPhone.Size = new System.Drawing.Size(100, 20);
            this.txtAspPhone.TabIndex = 0;
            this.txtAspPhone.Validated += new System.EventHandler(this.txtAspPhone_Validated);
            this.txtAspPhone.Leave += new System.EventHandler(this.txtAspPhone_Leave);
            this.txtAspPhone.TextChanged += new System.EventHandler(this.txtAspPhone_TextChanged);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.groupBox7);
            this.groupBox1.Controls.Add(this.ugSourceCodeMappingFamilyServicesASP);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.cbASPSettingType);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Location = new System.Drawing.Point(6, 33);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(948, 291);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Lease Organizations (ASP) Settings";
            // 
            // groupBox7
            // 
            this.groupBox7.Controls.Add(this.chkLinkToStatlinePhoneSystem);
            this.groupBox7.Controls.Add(this.chkAutoDisplaySourceCode);
            this.groupBox7.Controls.Add(this.cbAutoDisplaySourceCode);
            this.groupBox7.Location = new System.Drawing.Point(7, 227);
            this.groupBox7.Name = "groupBox7";
            this.groupBox7.Size = new System.Drawing.Size(935, 55);
            this.groupBox7.TabIndex = 2;
            this.groupBox7.TabStop = false;
            // 
            // chkLinkToStatlinePhoneSystem
            // 
            this.chkLinkToStatlinePhoneSystem.AutoSize = true;
            this.chkLinkToStatlinePhoneSystem.Checked = false;
            this.chkLinkToStatlinePhoneSystem.Font = new System.Drawing.Font("Tahoma", 8F);
            this.chkLinkToStatlinePhoneSystem.Location = new System.Drawing.Point(4, 14);
            this.chkLinkToStatlinePhoneSystem.Name = "chkLinkToStatlinePhoneSystem";
            this.chkLinkToStatlinePhoneSystem.Size = new System.Drawing.Size(167, 17);
            this.chkLinkToStatlinePhoneSystem.TabIndex = 2;
            this.chkLinkToStatlinePhoneSystem.Text = "Link to Statline Phone System";
            this.chkLinkToStatlinePhoneSystem.UseVisualStyleBackColor = true;
            // 
            // chkAutoDisplaySourceCode
            // 
            this.chkAutoDisplaySourceCode.AutoSize = true;
            this.chkAutoDisplaySourceCode.Checked = false;
            this.chkAutoDisplaySourceCode.Font = new System.Drawing.Font("Tahoma", 8F);
            this.chkAutoDisplaySourceCode.Location = new System.Drawing.Point(4, 33);
            this.chkAutoDisplaySourceCode.Name = "chkAutoDisplaySourceCode";
            this.chkAutoDisplaySourceCode.Size = new System.Drawing.Size(150, 17);
            this.chkAutoDisplaySourceCode.TabIndex = 3;
            this.chkAutoDisplaySourceCode.Text = "Auto Display Source Code";
            this.chkAutoDisplaySourceCode.UseVisualStyleBackColor = true;
            this.chkAutoDisplaySourceCode.CheckedChanged += new System.EventHandler(this.chkAutoDisplaySourceCode_CheckedChanged);
            // 
            // cbAutoDisplaySourceCode
            // 
            this.cbAutoDisplaySourceCode.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbAutoDisplaySourceCode.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbAutoDisplaySourceCode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbAutoDisplaySourceCode.Font = new System.Drawing.Font("Tahoma", 7F);
            this.cbAutoDisplaySourceCode.FormattingEnabled = true;
            this.cbAutoDisplaySourceCode.Location = new System.Drawing.Point(175, 29);
            this.cbAutoDisplaySourceCode.Name = "cbAutoDisplaySourceCode";
            this.cbAutoDisplaySourceCode.Required = false;
            this.cbAutoDisplaySourceCode.Size = new System.Drawing.Size(121, 19);
            this.cbAutoDisplaySourceCode.TabIndex = 4;
            this.cbAutoDisplaySourceCode.Validating += new System.ComponentModel.CancelEventHandler(this.cbAutoDisplaySourceCode_Validating);
            // 
            // ugSourceCodeMappingFamilyServicesASP
            // 
            appearance1.BackColor = System.Drawing.Color.White;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Appearance = appearance1;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.MaxRowScrollRegions = 1;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance2.BackColor = System.Drawing.Color.Transparent;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.CardAreaAppearance = appearance2;
            appearance3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance3.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance3.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance3.FontData.BoldAsString = "True";
            appearance3.FontData.Name = "Arial";
            appearance3.FontData.SizeInPoints = 10F;
            appearance3.ForeColor = System.Drawing.Color.White;
            appearance3.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.HeaderAppearance = appearance3;
            appearance4.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance4.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance4.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.RowSelectorAppearance = appearance4;
            appearance5.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance5.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance5.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.SelectedRowAppearance = appearance5;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugSourceCodeMappingFamilyServicesASP.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugSourceCodeMappingFamilyServicesASP.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.ugSourceCodeMappingFamilyServicesASP.Location = new System.Drawing.Point(152, 56);
            this.ugSourceCodeMappingFamilyServicesASP.Name = "ugSourceCodeMappingFamilyServicesASP";
            this.ugSourceCodeMappingFamilyServicesASP.Size = new System.Drawing.Size(498, 155);
            this.ugSourceCodeMappingFamilyServicesASP.TabIndex = 1;
            this.ugSourceCodeMappingFamilyServicesASP.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugSourceCodeMappingFamilyServicesASP.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugSourceCodeMappingFamilyServicesASP_InitializeLayout);
            this.ugSourceCodeMappingFamilyServicesASP.Validating += new System.ComponentModel.CancelEventHandler(this.ugSourceCodeMappingFamilyServicesASP_Validating);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label3.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label3.Location = new System.Drawing.Point(152, 40);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(290, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Source Code Mapping for Family Services ASP Only Clients:";
            // 
            // cbASPSettingType
            // 
            this.cbASPSettingType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbASPSettingType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbASPSettingType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbASPSettingType.Font = new System.Drawing.Font("Tahoma", 7F);
            this.cbASPSettingType.FormattingEnabled = true;
            this.cbASPSettingType.Location = new System.Drawing.Point(152, 16);
            this.cbASPSettingType.Name = "cbASPSettingType";
            this.cbASPSettingType.Required = false;
            this.cbASPSettingType.Size = new System.Drawing.Size(314, 19);
            this.cbASPSettingType.TabIndex = 0;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label2.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label2.Location = new System.Drawing.Point(12, 20);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(140, 13);
            this.label2.TabIndex = 0;
            this.label2.Text = "Lease Organization Setting:";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.groupBox5);
            this.groupBox2.Controls.Add(this.groupBox4);
            this.groupBox2.Controls.Add(this.groupBox3);
            this.groupBox2.Location = new System.Drawing.Point(6, 328);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(948, 738);
            this.groupBox2.TabIndex = 4;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Dashboard Settings";
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.ugCallEventExpiration);
            this.groupBox5.Controls.Add(this.label4);
            this.groupBox5.Location = new System.Drawing.Point(6, 412);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(936, 320);
            this.groupBox5.TabIndex = 0;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Timers for Calls and Events in Dashboard";
            // 
            // ugCallEventExpiration
            // 
            appearance6.BackColor = System.Drawing.Color.White;
            this.ugCallEventExpiration.DisplayLayout.Appearance = appearance6;
            this.ugCallEventExpiration.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            this.ugCallEventExpiration.DisplayLayout.MaxRowScrollRegions = 1;
            this.ugCallEventExpiration.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugCallEventExpiration.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugCallEventExpiration.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance7.BackColor = System.Drawing.Color.Transparent;
            this.ugCallEventExpiration.DisplayLayout.Override.CardAreaAppearance = appearance7;
            appearance8.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance8.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance8.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance8.FontData.BoldAsString = "True";
            appearance8.FontData.Name = "Arial";
            appearance8.FontData.SizeInPoints = 10F;
            appearance8.ForeColor = System.Drawing.Color.White;
            appearance8.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugCallEventExpiration.DisplayLayout.Override.HeaderAppearance = appearance8;
            appearance9.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance9.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugCallEventExpiration.DisplayLayout.Override.RowSelectorAppearance = appearance9;
            appearance10.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance10.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugCallEventExpiration.DisplayLayout.Override.SelectedRowAppearance = appearance10;
            this.ugCallEventExpiration.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugCallEventExpiration.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugCallEventExpiration.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugCallEventExpiration.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugCallEventExpiration.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugCallEventExpiration.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.ugCallEventExpiration.Location = new System.Drawing.Point(5, 33);
            this.ugCallEventExpiration.Name = "ugCallEventExpiration";
            this.ugCallEventExpiration.Size = new System.Drawing.Size(931, 280);
            this.ugCallEventExpiration.TabIndex = 0;
            this.ugCallEventExpiration.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugCallEventExpiration.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugCallEventExpiration_InitializeLayout);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label4.ForeColor = System.Drawing.Color.Red;
            this.label4.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label4.Location = new System.Drawing.Point(4, 20);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(657, 13);
            this.label4.TabIndex = 0;
            this.label4.Text = "*** Pending dashboard window with a timer type of Expired will only be used if th" +
                "e Page/Email Response interval is not set in Schedules";
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.availableSelectedControl);
            this.groupBox4.Location = new System.Drawing.Point(6, 14);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(936, 150);
            this.groupBox4.TabIndex = 0;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Display Settings";
            // 
            // availableSelectedControl
            // 
            this.availableSelectedControl.ColumnList = null;
            this.availableSelectedControl.DataMember = null;
            this.availableSelectedControl.DataSource = null;
            this.availableSelectedControl.IdColumn = "";
            this.availableSelectedControl.Location = new System.Drawing.Point(5, 20);
            this.availableSelectedControl.Name = "availableSelectedControl";
            this.availableSelectedControl.Size = new System.Drawing.Size(925, 121);
            this.availableSelectedControl.TabIndex = 0;
            this.availableSelectedControl.TextAvailable = "Available:";
            this.availableSelectedControl.TextSelected = "Selected:";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.label6);
            this.groupBox3.Controls.Add(this.ugCaseReviewPercentage);
            this.groupBox3.Location = new System.Drawing.Point(6, 174);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(936, 239);
            this.groupBox3.TabIndex = 0;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Case Review Percentages";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label6.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label6.Location = new System.Drawing.Point(7, 20);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(334, 13);
            this.label6.TabIndex = 1;
            this.label6.Text = "100% of all cases will be reviewed unless otherwise specified below:";
            // 
            // ugCaseReviewPercentage
            // 
            appearance11.BackColor = System.Drawing.Color.White;
            this.ugCaseReviewPercentage.DisplayLayout.Appearance = appearance11;
            this.ugCaseReviewPercentage.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            this.ugCaseReviewPercentage.DisplayLayout.MaxRowScrollRegions = 1;
            this.ugCaseReviewPercentage.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugCaseReviewPercentage.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugCaseReviewPercentage.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance12.BackColor = System.Drawing.Color.Transparent;
            this.ugCaseReviewPercentage.DisplayLayout.Override.CardAreaAppearance = appearance12;
            appearance13.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance13.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance13.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance13.FontData.BoldAsString = "True";
            appearance13.FontData.Name = "Arial";
            appearance13.FontData.SizeInPoints = 10F;
            appearance13.ForeColor = System.Drawing.Color.White;
            appearance13.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugCaseReviewPercentage.DisplayLayout.Override.HeaderAppearance = appearance13;
            appearance14.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance14.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugCaseReviewPercentage.DisplayLayout.Override.RowSelectorAppearance = appearance14;
            appearance15.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance15.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance15.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugCaseReviewPercentage.DisplayLayout.Override.SelectedRowAppearance = appearance15;
            this.ugCaseReviewPercentage.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugCaseReviewPercentage.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugCaseReviewPercentage.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugCaseReviewPercentage.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugCaseReviewPercentage.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugCaseReviewPercentage.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.ugCaseReviewPercentage.Location = new System.Drawing.Point(7, 35);
            this.ugCaseReviewPercentage.Name = "ugCaseReviewPercentage";
            this.ugCaseReviewPercentage.Size = new System.Drawing.Size(929, 198);
            this.ugCaseReviewPercentage.TabIndex = 0;
            this.ugCaseReviewPercentage.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugCaseReviewPercentage.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugCaseReviewPercentage_InitializeLayout);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.groupBox6);
            this.panel1.Controls.Add(this.groupBox2);
            this.panel1.Controls.Add(this.groupBox1);
            this.panel1.Controls.Add(this.txtAspPhone);
            this.panel1.Location = new System.Drawing.Point(15, 46);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(957, 1406);
            this.panel1.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label1.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label1.Location = new System.Drawing.Point(6, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(182, 13);
            this.label1.TabIndex = 10;
            this.label1.Text = "Paging by Comm Center Call Back #:";
            // 
            // groupBox6
            // 
            this.groupBox6.Controls.Add(this.label5);
            this.groupBox6.Controls.Add(this.ugDuplicateSearchSettings);
            this.groupBox6.Location = new System.Drawing.Point(9, 1072);
            this.groupBox6.Name = "groupBox6";
            this.groupBox6.Size = new System.Drawing.Size(945, 320);
            this.groupBox6.TabIndex = 9;
            this.groupBox6.TabStop = false;
            this.groupBox6.Text = "Duplicate Search Settings";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label5.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label5.Location = new System.Drawing.Point(10, 20);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(471, 13);
            this.label5.TabIndex = 1;
            this.label5.Text = "Calls that are not older than the days listed below and match the rule will be fo" +
                "und as duplicates.";
            // 
            // ugDuplicateSearchSettings
            // 
            appearance16.BackColor = System.Drawing.Color.White;
            this.ugDuplicateSearchSettings.DisplayLayout.Appearance = appearance16;
            this.ugDuplicateSearchSettings.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            this.ugDuplicateSearchSettings.DisplayLayout.MaxRowScrollRegions = 1;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance17.BackColor = System.Drawing.Color.Transparent;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.CardAreaAppearance = appearance17;
            appearance18.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance18.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance18.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance18.FontData.BoldAsString = "True";
            appearance18.FontData.Name = "Arial";
            appearance18.FontData.SizeInPoints = 10F;
            appearance18.ForeColor = System.Drawing.Color.White;
            appearance18.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.HeaderAppearance = appearance18;
            appearance19.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance19.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance19.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.RowSelectorAppearance = appearance19;
            appearance20.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance20.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance20.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.SelectedRowAppearance = appearance20;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugDuplicateSearchSettings.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugDuplicateSearchSettings.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugDuplicateSearchSettings.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugDuplicateSearchSettings.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugDuplicateSearchSettings.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F);
            this.ugDuplicateSearchSettings.Location = new System.Drawing.Point(10, 33);
            this.ugDuplicateSearchSettings.Name = "ugDuplicateSearchSettings";
            this.ugDuplicateSearchSettings.Size = new System.Drawing.Size(929, 280);
            this.ugDuplicateSearchSettings.TabIndex = 0;
            this.ugDuplicateSearchSettings.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.AddEdit;
            this.ugDuplicateSearchSettings.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugDuplicateSearchSettings_InitializeLayout);
            // 
            // OrganizationBaseConfigurationControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.lblOrganizationName);
            this.Name = "OrganizationBaseConfigurationControl";
            this.Size = new System.Drawing.Size(975, 1486);
            this.Validating += new System.ComponentModel.CancelEventHandler(this.OrganizationBaseConfigurationControl_Validating);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox7.ResumeLayout(false);
            this.groupBox7.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugSourceCodeMappingFamilyServicesASP)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugCallEventExpiration)).EndInit();
            this.groupBox4.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugCaseReviewPercentage)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.groupBox6.ResumeLayout(false);
            this.groupBox6.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugDuplicateSearchSettings)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Label lblOrganizationName;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox1;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox2;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox3;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox5;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox4;
        private Statline.Stattrac.Windows.Forms.Panel panel1;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugSourceCodeMappingFamilyServicesASP;
        private Statline.Stattrac.Windows.Forms.Label label3;
        private Statline.Stattrac.Windows.Forms.ComboBox cbASPSettingType;
        private Statline.Stattrac.Windows.Forms.Label label2;
        private Statline.Stattrac.Windows.Forms.ComboBox cbAutoDisplaySourceCode;
        private Statline.Stattrac.Windows.Forms.CheckBox chkAutoDisplaySourceCode;
        private Statline.Stattrac.Windows.Forms.CheckBox chkLinkToStatlinePhoneSystem;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugCaseReviewPercentage;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugCallEventExpiration;
        private Statline.Stattrac.Windows.Forms.Label label4;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox6;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugDuplicateSearchSettings;
        private Statline.Stattrac.Windows.Forms.Label label5;
        private Statline.Stattrac.Windows.Forms.Label label6;
        private Statline.Stattrac.Windows.Forms.Label label1;
        private Statline.Stattrac.Windows.Forms.MaskedTextBox txtAspPhone;
        private Statline.Stattrac.Windows.Forms.AvailableSelectedControl availableSelectedControl;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox7;
                
    }
}
