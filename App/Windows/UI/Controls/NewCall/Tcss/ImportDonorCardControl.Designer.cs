namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	partial class ImportDonorCardControl
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
			if (wbMain != null)
			{
				wbMain.Dispose();
			}
			if (wbPopup != null)
			{
				wbPopup.Dispose();
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
			Infragistics.Win.UltraWinTabControl.UltraTab ultraTab1 = new Infragistics.Win.UltraWinTabControl.UltraTab();
			Infragistics.Win.UltraWinTabControl.UltraTab ultraTab2 = new Infragistics.Win.UltraWinTabControl.UltraTab();
			Infragistics.Win.UltraWinTabControl.UltraTab ultraTab3 = new Infragistics.Win.UltraWinTabControl.UltraTab();
			this.ultraTabPageControl1 = new Infragistics.Win.UltraWinTabControl.UltraTabPageControl();
			this.txtImportStatus = new Statline.Stattrac.Windows.Forms.TextBox();
			this.ultraTabPageControl2 = new Infragistics.Win.UltraWinTabControl.UltraTabPageControl();
			this.wbMain = new Statline.Stattrac.Windows.Forms.WebBrowser();
			this.ultraTabPageControl3 = new Infragistics.Win.UltraWinTabControl.UltraTabPageControl();
			this.wbPopup = new Statline.Stattrac.Windows.Forms.WebBrowser();
			this.gbImportDonorCardData = new Statline.Stattrac.Windows.Forms.GroupBox();
			this.btnImport = new Statline.Stattrac.Windows.Forms.Button();
			this.txtPassword = new Statline.Stattrac.Windows.Forms.TextBox();
			this.txtUserId = new Statline.Stattrac.Windows.Forms.TextBox();
			this.txtOptn = new Statline.Stattrac.Windows.Forms.TextBox();
			this.txtMatchId = new Statline.Stattrac.Windows.Forms.TextBox();
			this.lblPassword = new Statline.Stattrac.Windows.Forms.Label();
			this.lblUserId = new Statline.Stattrac.Windows.Forms.Label();
			this.lblOptn = new Statline.Stattrac.Windows.Forms.Label();
			this.lblMatchId = new Statline.Stattrac.Windows.Forms.Label();
			this.gbImportStatus = new Statline.Stattrac.Windows.Forms.GroupBox();
			this.ultraTabControl1 = new Statline.Stattrac.Windows.Forms.UltraTabControl();
			this.ultraTabSharedControlsPage1 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
			this.splitContainer1 = new System.Windows.Forms.SplitContainer();
			this.ultraTabPageControl1.SuspendLayout();
			this.ultraTabPageControl2.SuspendLayout();
			this.ultraTabPageControl3.SuspendLayout();
			this.gbImportDonorCardData.SuspendLayout();
			this.gbImportStatus.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.ultraTabControl1)).BeginInit();
			this.ultraTabControl1.SuspendLayout();
			this.splitContainer1.Panel1.SuspendLayout();
			this.splitContainer1.Panel2.SuspendLayout();
			this.splitContainer1.SuspendLayout();
			this.SuspendLayout();
			// 
			// ultraTabPageControl1
			// 
			this.ultraTabPageControl1.Controls.Add(this.txtImportStatus);
			this.ultraTabPageControl1.Location = new System.Drawing.Point(1, 23);
			this.ultraTabPageControl1.Name = "ultraTabPageControl1";
			this.ultraTabPageControl1.Size = new System.Drawing.Size(715, 493);
			// 
			// txtImportStatus
			// 
			this.txtImportStatus.Dock = System.Windows.Forms.DockStyle.Fill;
			this.txtImportStatus.Location = new System.Drawing.Point(0, 0);
			this.txtImportStatus.Multiline = true;
			this.txtImportStatus.Name = "txtImportStatus";
			this.txtImportStatus.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
			this.txtImportStatus.Size = new System.Drawing.Size(715, 493);
			this.txtImportStatus.TabIndex = 0;
			// 
			// ultraTabPageControl2
			// 
			this.ultraTabPageControl2.Controls.Add(this.wbMain);
			this.ultraTabPageControl2.Location = new System.Drawing.Point(-10000, -10000);
			this.ultraTabPageControl2.Name = "ultraTabPageControl2";
			this.ultraTabPageControl2.Size = new System.Drawing.Size(715, 493);
			// 
			// wbMain
			// 
			this.wbMain.Dock = System.Windows.Forms.DockStyle.Fill;
			this.wbMain.Location = new System.Drawing.Point(0, 0);
			this.wbMain.MinimumSize = new System.Drawing.Size(20, 20);
			this.wbMain.Name = "wbMain";
			this.wbMain.Size = new System.Drawing.Size(715, 493);
			this.wbMain.TabIndex = 0;
			this.wbMain.NewWindow2 += new Statline.Stattrac.Windows.Forms.WebBrowser.WebBrowserNewWindow2EventHandler(this.wbMain_NewWindow2);
			// 
			// ultraTabPageControl3
			// 
			this.ultraTabPageControl3.Controls.Add(this.wbPopup);
			this.ultraTabPageControl3.Location = new System.Drawing.Point(-10000, -10000);
			this.ultraTabPageControl3.Name = "ultraTabPageControl3";
			this.ultraTabPageControl3.Size = new System.Drawing.Size(715, 493);
			// 
			// wbPopup
			// 
			this.wbPopup.Dock = System.Windows.Forms.DockStyle.Fill;
			this.wbPopup.Location = new System.Drawing.Point(0, 0);
			this.wbPopup.MinimumSize = new System.Drawing.Size(20, 20);
			this.wbPopup.Name = "wbPopup";
			this.wbPopup.Size = new System.Drawing.Size(715, 493);
			this.wbPopup.TabIndex = 0;
			// 
			// gbImportDonorCardData
			// 
			this.gbImportDonorCardData.Controls.Add(this.btnImport);
			this.gbImportDonorCardData.Controls.Add(this.txtPassword);
			this.gbImportDonorCardData.Controls.Add(this.txtUserId);
			this.gbImportDonorCardData.Controls.Add(this.txtOptn);
			this.gbImportDonorCardData.Controls.Add(this.txtMatchId);
			this.gbImportDonorCardData.Controls.Add(this.lblPassword);
			this.gbImportDonorCardData.Controls.Add(this.lblUserId);
			this.gbImportDonorCardData.Controls.Add(this.lblOptn);
			this.gbImportDonorCardData.Controls.Add(this.lblMatchId);
			this.gbImportDonorCardData.Location = new System.Drawing.Point(4, 3);
			this.gbImportDonorCardData.Name = "gbImportDonorCardData";
			this.gbImportDonorCardData.Size = new System.Drawing.Size(354, 156);
			this.gbImportDonorCardData.TabIndex = 0;
			this.gbImportDonorCardData.TabStop = false;
			this.gbImportDonorCardData.Text = "Import Donor Card Data";
			// 
			// btnImport
			// 
			this.btnImport.Location = new System.Drawing.Point(93, 129);
			this.btnImport.Name = "btnImport";
			this.btnImport.Size = new System.Drawing.Size(75, 23);
			this.btnImport.TabIndex = 4;
			this.btnImport.Text = "Import";
			this.btnImport.UseVisualStyleBackColor = true;
			this.btnImport.Click += new System.EventHandler(this.btnImport_Click);
			// 
			// txtPassword
			// 
			this.txtPassword.Font = new System.Drawing.Font("Bookshelf Symbol 7", 8.25F);
			this.txtPassword.ForeColor = System.Drawing.Color.Red;
			this.txtPassword.Location = new System.Drawing.Point(93, 105);
			this.txtPassword.Mask = Statline.Stattrac.Windows.Forms.TextBoxMask.Password;
			this.txtPassword.Name = "txtPassword";
			this.txtPassword.PasswordChar = 'w';
			this.txtPassword.Size = new System.Drawing.Size(200, 18);
			this.txtPassword.TabIndex = 3;
			// 
			// txtUserId
			// 
			this.txtUserId.Location = new System.Drawing.Point(93, 76);
			this.txtUserId.Name = "txtUserId";
			this.txtUserId.Size = new System.Drawing.Size(200, 20);
			this.txtUserId.TabIndex = 2;
			// 
			// txtOptn
			// 
			this.txtOptn.Location = new System.Drawing.Point(93, 16);
			this.txtOptn.Name = "txtOptn";
			this.txtOptn.Size = new System.Drawing.Size(200, 20);
			this.txtOptn.TabIndex = 0;
			this.txtOptn.Leave += new System.EventHandler(this.EndCurrentEdit);
			// 
			// txtMatchId
			// 
			this.txtMatchId.Location = new System.Drawing.Point(93, 46);
			this.txtMatchId.Name = "txtMatchId";
			this.txtMatchId.Size = new System.Drawing.Size(200, 20);
			this.txtMatchId.TabIndex = 1;
			this.txtMatchId.Leave += new System.EventHandler(this.EndCurrentEdit);
			// 
			// lblPassword
			// 
			this.lblPassword.AutoSize = true;
			this.lblPassword.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
			this.lblPassword.Location = new System.Drawing.Point(18, 105);
			this.lblPassword.Name = "lblPassword";
			this.lblPassword.Size = new System.Drawing.Size(56, 13);
			this.lblPassword.TabIndex = 3;
			this.lblPassword.Text = "Password:";
			// 
			// lblUserId
			// 
			this.lblUserId.AutoSize = true;
			this.lblUserId.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
			this.lblUserId.Location = new System.Drawing.Point(18, 76);
			this.lblUserId.Name = "lblUserId";
			this.lblUserId.Size = new System.Drawing.Size(46, 13);
			this.lblUserId.TabIndex = 2;
			this.lblUserId.Text = "User ID:";
			// 
			// lblOptn
			// 
			this.lblOptn.AutoSize = true;
			this.lblOptn.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
			this.lblOptn.Location = new System.Drawing.Point(18, 16);
			this.lblOptn.Name = "lblOptn";
			this.lblOptn.Size = new System.Drawing.Size(50, 13);
			this.lblOptn.TabIndex = 1;
			this.lblOptn.Text = "OPTN #:";
			// 
			// lblMatchId
			// 
			this.lblMatchId.AutoSize = true;
			this.lblMatchId.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
			this.lblMatchId.Location = new System.Drawing.Point(18, 47);
			this.lblMatchId.Name = "lblMatchId";
			this.lblMatchId.Size = new System.Drawing.Size(54, 13);
			this.lblMatchId.TabIndex = 0;
			this.lblMatchId.Text = "Match ID:";
			// 
			// gbImportStatus
			// 
			this.gbImportStatus.Controls.Add(this.ultraTabControl1);
			this.gbImportStatus.Dock = System.Windows.Forms.DockStyle.Fill;
			this.gbImportStatus.Location = new System.Drawing.Point(0, 0);
			this.gbImportStatus.Name = "gbImportStatus";
			this.gbImportStatus.Size = new System.Drawing.Size(725, 538);
			this.gbImportStatus.TabIndex = 1;
			this.gbImportStatus.TabStop = false;
			this.gbImportStatus.Text = "Import Status";
			// 
			// ultraTabControl1
			// 
			this.ultraTabControl1.Controls.Add(this.ultraTabSharedControlsPage1);
			this.ultraTabControl1.Controls.Add(this.ultraTabPageControl1);
			this.ultraTabControl1.Controls.Add(this.ultraTabPageControl2);
			this.ultraTabControl1.Controls.Add(this.ultraTabPageControl3);
			this.ultraTabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.ultraTabControl1.Location = new System.Drawing.Point(3, 16);
			this.ultraTabControl1.Name = "ultraTabControl1";
			this.ultraTabControl1.SharedControlsPage = this.ultraTabSharedControlsPage1;
			this.ultraTabControl1.Size = new System.Drawing.Size(719, 519);
			this.ultraTabControl1.TabIndex = 1;
			ultraTab1.TabPage = this.ultraTabPageControl1;
			ultraTab1.Text = "Status";
			ultraTab2.TabPage = this.ultraTabPageControl2;
			ultraTab2.Text = "UNOS Login";
			ultraTab3.TabPage = this.ultraTabPageControl3;
			ultraTab3.Text = "Donor Summary/Match Results";
			this.ultraTabControl1.Tabs.AddRange(new Infragistics.Win.UltraWinTabControl.UltraTab[] {
            ultraTab1,
            ultraTab2,
            ultraTab3});
			// 
			// ultraTabSharedControlsPage1
			// 
			this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(-10000, -10000);
			this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
			this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(715, 493);
			// 
			// splitContainer1
			// 
			this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.splitContainer1.FixedPanel = System.Windows.Forms.FixedPanel.Panel1;
			this.splitContainer1.Location = new System.Drawing.Point(0, 0);
			this.splitContainer1.Name = "splitContainer1";
			this.splitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal;
			// 
			// splitContainer1.Panel1
			// 
			this.splitContainer1.Panel1.Controls.Add(this.gbImportDonorCardData);
			// 
			// splitContainer1.Panel2
			// 
			this.splitContainer1.Panel2.Controls.Add(this.gbImportStatus);
			this.splitContainer1.Size = new System.Drawing.Size(725, 711);
			this.splitContainer1.SplitterDistance = 169;
			this.splitContainer1.TabIndex = 2;
			// 
			// ImportDonorCardControl
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.Controls.Add(this.splitContainer1);
			this.Name = "ImportDonorCardControl";
			this.Size = new System.Drawing.Size(725, 711);
			this.ultraTabPageControl1.ResumeLayout(false);
			this.ultraTabPageControl1.PerformLayout();
			this.ultraTabPageControl2.ResumeLayout(false);
			this.ultraTabPageControl3.ResumeLayout(false);
			this.gbImportDonorCardData.ResumeLayout(false);
			this.gbImportDonorCardData.PerformLayout();
			this.gbImportStatus.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.ultraTabControl1)).EndInit();
			this.ultraTabControl1.ResumeLayout(false);
			this.splitContainer1.Panel1.ResumeLayout(false);
			this.splitContainer1.Panel2.ResumeLayout(false);
			this.splitContainer1.ResumeLayout(false);
			this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.GroupBox gbImportDonorCardData;
		private Statline.Stattrac.Windows.Forms.TextBox txtPassword;
		private Statline.Stattrac.Windows.Forms.TextBox txtUserId;
		private Statline.Stattrac.Windows.Forms.TextBox txtOptn;
		private Statline.Stattrac.Windows.Forms.TextBox txtMatchId;
		private Statline.Stattrac.Windows.Forms.Label lblPassword;
		private Statline.Stattrac.Windows.Forms.Label lblUserId;
		private Statline.Stattrac.Windows.Forms.Label lblOptn;
		private Statline.Stattrac.Windows.Forms.Label lblMatchId;
		private Statline.Stattrac.Windows.Forms.Button btnImport;
		private Statline.Stattrac.Windows.Forms.GroupBox gbImportStatus;
		private Statline.Stattrac.Windows.Forms.TextBox txtImportStatus;
		private Statline.Stattrac.Windows.Forms.UltraTabControl ultraTabControl1;
		private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;
		private Infragistics.Win.UltraWinTabControl.UltraTabPageControl ultraTabPageControl1;
		private Infragistics.Win.UltraWinTabControl.UltraTabPageControl ultraTabPageControl2;
		private Statline.Stattrac.Windows.Forms.WebBrowser wbMain;
		private Infragistics.Win.UltraWinTabControl.UltraTabPageControl ultraTabPageControl3;
		private Statline.Stattrac.Windows.Forms.WebBrowser wbPopup;
		private System.Windows.Forms.SplitContainer splitContainer1;

	}
}
