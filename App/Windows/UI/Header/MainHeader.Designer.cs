namespace Statline.Stattrac.Windows.UI.Header
{
	partial class MainHeader
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
			// we need to dispose the timerClock in order to dispose MainHeader
			if (timerClock != null)
			{
				timerClock.Stop();
				timerClock.Dispose();
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainHeader));
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("BulletinBoard", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn11 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("BulletinBoardID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn12 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("DateTimeStatus");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn13 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Organization");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn14 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Alert");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn15 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CreateDate");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn16 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn17 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("SavedBy");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn18 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastModified");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn19 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LastStatEmployeeID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn20 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("AuditLogTypeID");
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance13 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance14 = new Infragistics.Win.Appearance();
            this.splitContainer = new System.Windows.Forms.SplitContainer();
            this.lblDataBase = new System.Windows.Forms.Label();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.newToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.SearchToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.organizationToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.phoneToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.helptoolStripButton = new System.Windows.Forms.ToolStripButton();
            this.IssueToolStripButton = new System.Windows.Forms.ToolStripButton();
            this.txtHaw = new Statline.Stattrac.Windows.Forms.Label();
            this.txtAls = new Statline.Stattrac.Windows.Forms.Label();
            this.txtPac = new Statline.Stattrac.Windows.Forms.Label();
            this.txtMnt = new Statline.Stattrac.Windows.Forms.Label();
            this.txtCnt = new Statline.Stattrac.Windows.Forms.Label();
            this.txtEst = new Statline.Stattrac.Windows.Forms.Label();
            this.lblHaw = new Statline.Stattrac.Windows.Forms.Label();
            this.txtAtl = new Statline.Stattrac.Windows.Forms.Label();
            this.lblAls = new Statline.Stattrac.Windows.Forms.Label();
            this.lblPac = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMnt = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCnt = new Statline.Stattrac.Windows.Forms.Label();
            this.lblEst = new Statline.Stattrac.Windows.Forms.Label();
            this.lblAtl = new Statline.Stattrac.Windows.Forms.Label();
            this.ugBulletinboard = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.bulletinBoardDS = new Statline.Stattrac.Data.Types.Dashboard.BulletinBoardDS();
            this.timerClock = new Statline.Stattrac.Windows.Forms.Timer();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.addLineToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.deleteLineToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.refreshToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.splitContainer.Panel1.SuspendLayout();
            this.splitContainer.Panel2.SuspendLayout();
            this.splitContainer.SuspendLayout();
            this.toolStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugBulletinboard)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.bulletinBoardDS)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.timerClock)).BeginInit();
            this.contextMenuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // splitContainer
            // 
            this.splitContainer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer.Location = new System.Drawing.Point(0, 0);
            this.splitContainer.Name = "splitContainer";
            this.splitContainer.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // splitContainer.Panel1
            // 
            this.splitContainer.Panel1.Controls.Add(this.lblDataBase);
            this.splitContainer.Panel1.Controls.Add(this.toolStrip1);
            this.splitContainer.Panel1.Controls.Add(this.txtHaw);
            this.splitContainer.Panel1.Controls.Add(this.txtAls);
            this.splitContainer.Panel1.Controls.Add(this.txtPac);
            this.splitContainer.Panel1.Controls.Add(this.txtMnt);
            this.splitContainer.Panel1.Controls.Add(this.txtCnt);
            this.splitContainer.Panel1.Controls.Add(this.txtEst);
            this.splitContainer.Panel1.Controls.Add(this.lblHaw);
            this.splitContainer.Panel1.Controls.Add(this.txtAtl);
            this.splitContainer.Panel1.Controls.Add(this.lblAls);
            this.splitContainer.Panel1.Controls.Add(this.lblPac);
            this.splitContainer.Panel1.Controls.Add(this.lblMnt);
            this.splitContainer.Panel1.Controls.Add(this.lblCnt);
            this.splitContainer.Panel1.Controls.Add(this.lblEst);
            this.splitContainer.Panel1.Controls.Add(this.lblAtl);
            this.splitContainer.Panel1MinSize = 33;
            // 
            // splitContainer.Panel2
            // 
            this.splitContainer.Panel2.AutoScroll = true;
            this.splitContainer.Panel2.Controls.Add(this.ugBulletinboard);
            this.splitContainer.Size = new System.Drawing.Size(863, 203);
            this.splitContainer.SplitterDistance = 33;
            this.splitContainer.SplitterWidth = 2;
            this.splitContainer.TabIndex = 15;
            // 
            // lblDataBase
            // 
            this.lblDataBase.AutoSize = true;
            this.lblDataBase.BackColor = System.Drawing.SystemColors.Window;
            this.lblDataBase.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.lblDataBase.Font = new System.Drawing.Font("Tahoma", 8F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDataBase.Location = new System.Drawing.Point(154, 3);
            this.lblDataBase.MaximumSize = new System.Drawing.Size(115, 0);
            this.lblDataBase.MinimumSize = new System.Drawing.Size(165, 25);
            this.lblDataBase.Name = "lblDataBase";
            this.lblDataBase.Size = new System.Drawing.Size(165, 25);
            this.lblDataBase.TabIndex = 17;
            this.lblDataBase.Text = "db";
            // 
            // toolStrip1
            // 
            this.toolStrip1.Dock = System.Windows.Forms.DockStyle.None;
            this.toolStrip1.GripStyle = System.Windows.Forms.ToolStripGripStyle.Hidden;
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.newToolStripButton,
            this.SearchToolStripButton,
            this.organizationToolStripButton,
            this.phoneToolStripButton,
            this.helptoolStripButton,
            this.IssueToolStripButton});
            this.toolStrip1.Location = new System.Drawing.Point(0, 3);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.RenderMode = System.Windows.Forms.ToolStripRenderMode.Professional;
            this.toolStrip1.Size = new System.Drawing.Size(141, 25);
            this.toolStrip1.TabIndex = 15;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // newToolStripButton
            // 
            this.newToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.newToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("newToolStripButton.Image")));
            this.newToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.newToolStripButton.Name = "newToolStripButton";
            this.newToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.newToolStripButton.Text = "&New Call";
            this.newToolStripButton.ToolTipText = "New Call";
            this.newToolStripButton.Click += new System.EventHandler(this.newToolStripButton_Click);
            // 
            // SearchToolStripButton
            // 
            this.SearchToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.SearchToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("SearchToolStripButton.Image")));
            this.SearchToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.SearchToolStripButton.Name = "SearchToolStripButton";
            this.SearchToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.SearchToolStripButton.Text = "&Quick Lookup";
            this.SearchToolStripButton.Click += new System.EventHandler(this.SearchToolStripButton_Click);
            // 
            // organizationToolStripButton
            // 
            this.organizationToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.organizationToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("organizationToolStripButton.Image")));
            this.organizationToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.organizationToolStripButton.Name = "organizationToolStripButton";
            this.organizationToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.organizationToolStripButton.Text = "&Organizations";
            this.organizationToolStripButton.ToolTipText = "Organizations";
            this.organizationToolStripButton.Click += new System.EventHandler(this.organizationToolStripButton_Click);
            // 
            // phoneToolStripButton
            // 
            this.phoneToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.phoneToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("phoneToolStripButton.Image")));
            this.phoneToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.phoneToolStripButton.Name = "phoneToolStripButton";
            this.phoneToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.phoneToolStripButton.Text = "&On Call";
            this.phoneToolStripButton.ToolTipText = "On Call";
            this.phoneToolStripButton.Click += new System.EventHandler(this.phoneToolStripButton_Click);
            // 
            // helptoolStripButton
            // 
            this.helptoolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.helptoolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("helptoolStripButton.Image")));
            this.helptoolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.helptoolStripButton.Name = "helptoolStripButton";
            this.helptoolStripButton.Size = new System.Drawing.Size(23, 22);
            this.helptoolStripButton.Text = "&Help";
            this.helptoolStripButton.Click += new System.EventHandler(this.helptoolStripButton_Click);
            // 
            // IssueToolStripButton
            // 
            this.IssueToolStripButton.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.IssueToolStripButton.Image = ((System.Drawing.Image)(resources.GetObject("IssueToolStripButton.Image")));
            this.IssueToolStripButton.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.IssueToolStripButton.Name = "IssueToolStripButton";
            this.IssueToolStripButton.Size = new System.Drawing.Size(23, 22);
            this.IssueToolStripButton.Text = "toolStripButton1";
            this.IssueToolStripButton.ToolTipText = "Report Issues/Feedback";
            this.IssueToolStripButton.Click += new System.EventHandler(this.IssueToolStripButton_Click);
            // 
            // txtHaw
            // 
            this.txtHaw.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtHaw.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtHaw.Location = new System.Drawing.Point(373, 18);
            this.txtHaw.Name = "txtHaw";
            this.txtHaw.Size = new System.Drawing.Size(60, 14);
            this.txtHaw.TabIndex = 8;
            this.txtHaw.Click += new System.EventHandler(this.timeChange_Click);
            // 
            // txtAls
            // 
            this.txtAls.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtAls.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtAls.Location = new System.Drawing.Point(463, 18);
            this.txtAls.Name = "txtAls";
            this.txtAls.Size = new System.Drawing.Size(60, 14);
            this.txtAls.TabIndex = 9;
            this.txtAls.Click += new System.EventHandler(this.timeChange_Click);
            // 
            // txtPac
            // 
            this.txtPac.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtPac.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtPac.Location = new System.Drawing.Point(520, 18);
            this.txtPac.Name = "txtPac";
            this.txtPac.Size = new System.Drawing.Size(60, 14);
            this.txtPac.TabIndex = 10;
            this.txtPac.Click += new System.EventHandler(this.timeChange_Click);
            // 
            // txtMnt
            // 
            this.txtMnt.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtMnt.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtMnt.Location = new System.Drawing.Point(593, 18);
            this.txtMnt.Name = "txtMnt";
            this.txtMnt.Size = new System.Drawing.Size(60, 14);
            this.txtMnt.TabIndex = 11;
            this.txtMnt.Click += new System.EventHandler(this.timeChange_Click);
            // 
            // txtCnt
            // 
            this.txtCnt.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtCnt.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtCnt.Location = new System.Drawing.Point(671, 18);
            this.txtCnt.Name = "txtCnt";
            this.txtCnt.Size = new System.Drawing.Size(60, 14);
            this.txtCnt.TabIndex = 12;
            this.txtCnt.Click += new System.EventHandler(this.timeChange_Click);
            // 
            // txtEst
            // 
            this.txtEst.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtEst.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtEst.Location = new System.Drawing.Point(731, 18);
            this.txtEst.Name = "txtEst";
            this.txtEst.Size = new System.Drawing.Size(60, 14);
            this.txtEst.TabIndex = 13;
            this.txtEst.Click += new System.EventHandler(this.timeChange_Click);
            // 
            // lblHaw
            // 
            this.lblHaw.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblHaw.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblHaw.Location = new System.Drawing.Point(373, 3);
            this.lblHaw.Name = "lblHaw";
            this.lblHaw.Size = new System.Drawing.Size(90, 20);
            this.lblHaw.TabIndex = 0;
            this.lblHaw.Text = "Hawaii-Aleutian";
            // 
            // txtAtl
            // 
            this.txtAtl.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtAtl.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtAtl.Location = new System.Drawing.Point(791, 18);
            this.txtAtl.Name = "txtAtl";
            this.txtAtl.Size = new System.Drawing.Size(60, 14);
            this.txtAtl.TabIndex = 14;
            this.txtAtl.Click += new System.EventHandler(this.timeChange_Click);
            // 
            // lblAls
            // 
            this.lblAls.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblAls.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblAls.Location = new System.Drawing.Point(463, 3);
            this.lblAls.Name = "lblAls";
            this.lblAls.Size = new System.Drawing.Size(60, 20);
            this.lblAls.TabIndex = 1;
            this.lblAls.Text = "Alaska";
            // 
            // lblPac
            // 
            this.lblPac.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblPac.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblPac.Location = new System.Drawing.Point(520, 3);
            this.lblPac.Name = "lblPac";
            this.lblPac.Size = new System.Drawing.Size(60, 20);
            this.lblPac.TabIndex = 2;
            this.lblPac.Text = "Pacific/AZ";
            // 
            // lblMnt
            // 
            this.lblMnt.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblMnt.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMnt.Location = new System.Drawing.Point(593, 3);
            this.lblMnt.Name = "lblMnt";
            this.lblMnt.Size = new System.Drawing.Size(80, 20);
            this.lblMnt.TabIndex = 3;
            this.lblMnt.Text = "Mountain";
            // 
            // lblCnt
            // 
            this.lblCnt.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblCnt.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCnt.Location = new System.Drawing.Point(671, 3);
            this.lblCnt.Name = "lblCnt";
            this.lblCnt.Size = new System.Drawing.Size(60, 20);
            this.lblCnt.TabIndex = 4;
            this.lblCnt.Text = "Central";
            // 
            // lblEst
            // 
            this.lblEst.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblEst.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblEst.Location = new System.Drawing.Point(731, 3);
            this.lblEst.Name = "lblEst";
            this.lblEst.Size = new System.Drawing.Size(60, 20);
            this.lblEst.TabIndex = 5;
            this.lblEst.Text = "Eastern";
            // 
            // lblAtl
            // 
            this.lblAtl.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblAtl.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblAtl.Location = new System.Drawing.Point(791, 3);
            this.lblAtl.Name = "lblAtl";
            this.lblAtl.Size = new System.Drawing.Size(60, 20);
            this.lblAtl.TabIndex = 7;
            this.lblAtl.Text = "Atlantic";
            // 
            // ugBulletinboard
            // 
            this.ugBulletinboard.DataMember = "BulletinBoard";
            this.ugBulletinboard.DataSource = this.bulletinBoardDS;
            appearance8.BackColor = System.Drawing.Color.Transparent;
            this.ugBulletinboard.DisplayLayout.Appearance = appearance8;
            this.ugBulletinboard.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn11.Header.VisiblePosition = 0;
            ultraGridColumn11.Hidden = true;
            ultraGridColumn11.Width = 75;
            ultraGridColumn12.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn12.Header.VisiblePosition = 1;
            ultraGridColumn12.Width = 43;
            ultraGridColumn13.Header.VisiblePosition = 3;
            ultraGridColumn13.Width = 134;
            ultraGridColumn14.Header.VisiblePosition = 5;
            ultraGridColumn14.Width = 299;
            ultraGridColumn15.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn15.Header.VisiblePosition = 4;
            ultraGridColumn15.Hidden = true;
            ultraGridColumn15.MaskInput = "MM/dd/yyyy HH:mm";
            ultraGridColumn15.Width = 74;
            ultraGridColumn16.Header.VisiblePosition = 6;
            ultraGridColumn16.Hidden = true;
            ultraGridColumn16.Width = 85;
            ultraGridColumn17.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn17.Header.VisiblePosition = 7;
            ultraGridColumn17.Width = 250;
            ultraGridColumn18.CellActivation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
            ultraGridColumn18.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn18.Header.VisiblePosition = 2;
            ultraGridColumn18.MaskInput = "MM/dd/yyyy HH:mm";
            ultraGridColumn18.Width = 116;
            ultraGridColumn19.Header.VisiblePosition = 8;
            ultraGridColumn19.Hidden = true;
            ultraGridColumn19.Width = 109;
            ultraGridColumn20.Header.VisiblePosition = 9;
            ultraGridColumn20.Hidden = true;
            ultraGridColumn20.Width = 89;
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
            ultraGridBand1.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            this.ugBulletinboard.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugBulletinboard.DisplayLayout.MaxRowScrollRegions = 1;
            appearance9.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance9.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance9.BackHatchStyle = Infragistics.Win.BackHatchStyle.Horizontal;
            this.ugBulletinboard.DisplayLayout.Override.ActiveCellAppearance = appearance9;
            appearance10.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance10.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugBulletinboard.DisplayLayout.Override.ActiveRowAppearance = appearance10;
            this.ugBulletinboard.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.ugBulletinboard.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;
            this.ugBulletinboard.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.True;
            appearance11.BackColor = System.Drawing.Color.Transparent;
            this.ugBulletinboard.DisplayLayout.Override.CardAreaAppearance = appearance11;
            appearance12.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance12.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance12.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance12.FontData.BoldAsString = "True";
            appearance12.FontData.Name = "Tahoma";
            appearance12.FontData.SizeInPoints = 8F;
            appearance12.ForeColor = System.Drawing.Color.White;
            appearance12.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugBulletinboard.DisplayLayout.Override.HeaderAppearance = appearance12;
            this.ugBulletinboard.DisplayLayout.Override.InvalidValueBehavior = Infragistics.Win.UltraWinGrid.InvalidValueBehavior.RevertValueAndRetainFocus;
            appearance13.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance13.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance13.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugBulletinboard.DisplayLayout.Override.RowSelectorAppearance = appearance13;
            appearance14.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance14.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance14.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance14.ForeColor = System.Drawing.Color.Black;
            this.ugBulletinboard.DisplayLayout.Override.SelectedRowAppearance = appearance14;
            this.ugBulletinboard.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugBulletinboard.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.Single;
            this.ugBulletinboard.DisplayLayout.ScrollBounds = Infragistics.Win.UltraWinGrid.ScrollBounds.ScrollToFill;
            this.ugBulletinboard.DisplayLayout.ScrollStyle = Infragistics.Win.UltraWinGrid.ScrollStyle.Immediate;
            this.ugBulletinboard.DisplayLayout.ViewStyle = Infragistics.Win.UltraWinGrid.ViewStyle.SingleBand;
            this.ugBulletinboard.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugBulletinboard.Font = new System.Drawing.Font("Tahoma", 8F);
            this.ugBulletinboard.Location = new System.Drawing.Point(0, 0);
            this.ugBulletinboard.Name = "ugBulletinboard";
            this.ugBulletinboard.Size = new System.Drawing.Size(863, 168);
            this.ugBulletinboard.TabIndex = 0;
            this.ugBulletinboard.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.EditOnly;
            this.ugBulletinboard.UpdateMode = Infragistics.Win.UltraWinGrid.UpdateMode.OnCellChangeOrLostFocus;
            this.ugBulletinboard.MouseDown += new System.Windows.Forms.MouseEventHandler(this.ugBulletinboard_MouseDown);
            this.ugBulletinboard.KeyDown += new System.Windows.Forms.KeyEventHandler(this.ugBulletinboard_KeyDown);
            this.ugBulletinboard.Leave += new System.EventHandler(this.ugBulletinboard_Leave);
            this.ugBulletinboard.AfterRowUpdate += new Infragistics.Win.UltraWinGrid.RowEventHandler(this.ugBulletinboard_AfterRowUpdate);
            // 
            // bulletinBoardDS
            // 
            this.bulletinBoardDS.DataSetName = "BulletinBoardDS";
            this.bulletinBoardDS.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // timerClock
            // 
            this.timerClock.Enabled = true;
            this.timerClock.SynchronizingObject = this;
            this.timerClock.Elapsed += new System.Timers.ElapsedEventHandler(this.timerClock_Elapsed);
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.addLineToolStripMenuItem,
            this.deleteLineToolStripMenuItem,
            this.refreshToolStripMenuItem});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(114, 70);
            // 
            // addLineToolStripMenuItem
            // 
            this.addLineToolStripMenuItem.Name = "addLineToolStripMenuItem";
            this.addLineToolStripMenuItem.Size = new System.Drawing.Size(113, 22);
            this.addLineToolStripMenuItem.Text = "Add";
            this.addLineToolStripMenuItem.Click += new System.EventHandler(this.addLineToolStripMenuItem_Click);
            // 
            // deleteLineToolStripMenuItem
            // 
            this.deleteLineToolStripMenuItem.Name = "deleteLineToolStripMenuItem";
            this.deleteLineToolStripMenuItem.Size = new System.Drawing.Size(113, 22);
            this.deleteLineToolStripMenuItem.Text = "Delete";
            this.deleteLineToolStripMenuItem.Click += new System.EventHandler(this.deleteLineToolStripMenuItem_Click);
            // 
            // refreshToolStripMenuItem
            // 
            this.refreshToolStripMenuItem.Name = "refreshToolStripMenuItem";
            this.refreshToolStripMenuItem.Size = new System.Drawing.Size(113, 22);
            this.refreshToolStripMenuItem.Text = "Refresh";
            this.refreshToolStripMenuItem.Click += new System.EventHandler(this.refreshToolStripMenuItem_Click);
            // 
            // MainHeader
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.Controls.Add(this.splitContainer);
            this.Name = "MainHeader";
            this.Size = new System.Drawing.Size(863, 203);
            this.splitContainer.Panel1.ResumeLayout(false);
            this.splitContainer.Panel1.PerformLayout();
            this.splitContainer.Panel2.ResumeLayout(false);
            this.splitContainer.ResumeLayout(false);
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugBulletinboard)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.bulletinBoardDS)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.timerClock)).EndInit();
            this.contextMenuStrip1.ResumeLayout(false);
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.Label lblHaw;
		private Statline.Stattrac.Windows.Forms.Label lblAls;
		private Statline.Stattrac.Windows.Forms.Label lblPac;
		private Statline.Stattrac.Windows.Forms.Label lblMnt;
		private Statline.Stattrac.Windows.Forms.Label lblCnt;
		private Statline.Stattrac.Windows.Forms.Label lblEst;
		private Statline.Stattrac.Windows.Forms.Label lblAtl;
		private Statline.Stattrac.Windows.Forms.Label txtHaw;
		private Statline.Stattrac.Windows.Forms.Label txtAls;
		private Statline.Stattrac.Windows.Forms.Label txtPac;
		private Statline.Stattrac.Windows.Forms.Label txtMnt;
		private Statline.Stattrac.Windows.Forms.Label txtCnt;
		private Statline.Stattrac.Windows.Forms.Label txtEst;
		private Statline.Stattrac.Windows.Forms.Label txtAtl;
        private System.Windows.Forms.SplitContainer splitContainer;
		private System.Windows.Forms.ToolStrip toolStrip1;
		private System.Windows.Forms.ToolStripButton newToolStripButton;
		private System.Windows.Forms.ToolStripButton SearchToolStripButton;
		private System.Windows.Forms.ToolStripButton organizationToolStripButton;
		private System.Windows.Forms.ToolStripButton phoneToolStripButton;
		private Statline.Stattrac.Windows.Forms.Timer timerClock;
        private System.Windows.Forms.ToolStripButton helptoolStripButton;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
        private System.Windows.Forms.ToolStripMenuItem addLineToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem deleteLineToolStripMenuItem;
        public System.Windows.Forms.Label lblDataBase;
        private System.Windows.Forms.ToolStripButton IssueToolStripButton;
        private System.Windows.Forms.ToolStripMenuItem refreshToolStripMenuItem;
        private Statline.Stattrac.Data.Types.Dashboard.BulletinBoardDS bulletinBoardDS;
        private Statline.Stattrac.Windows.Forms.UltraGrid ugBulletinboard;
	}
}
