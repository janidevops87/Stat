namespace Statline.Stattrac.Windows.UI
{
	partial class SecureForm
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
            Infragistics.Win.UltraWinDock.DockAreaPane dockAreaPane1 = new Infragistics.Win.UltraWinDock.DockAreaPane(Infragistics.Win.UltraWinDock.DockedLocation.DockedLeft, new System.Guid("f8c747da-b531-45a3-b52c-d74cefd74e3e"));
            Infragistics.Win.UltraWinDock.DockableControlPane dockableControlPane1 = new Infragistics.Win.UltraWinDock.DockableControlPane(new System.Guid("37e643af-73ab-4b50-90fe-e49abf6bc0d2"), new System.Guid("00000000-0000-0000-0000-000000000000"), -1, new System.Guid("f8c747da-b531-45a3-b52c-d74cefd74e3e"), -1);
            Infragistics.Win.UltraWinDock.DockAreaPane dockAreaPane2 = new Infragistics.Win.UltraWinDock.DockAreaPane(Infragistics.Win.UltraWinDock.DockedLocation.DockedTop, new System.Guid("cc44d156-aba3-4f91-b940-9854547127f0"));
            Infragistics.Win.UltraWinDock.DockableControlPane dockableControlPane2 = new Infragistics.Win.UltraWinDock.DockableControlPane(new System.Guid("6a6dd1b5-de2a-4182-ad6c-cdcd9056eef3"), new System.Guid("00000000-0000-0000-0000-000000000000"), -1, new System.Guid("cc44d156-aba3-4f91-b940-9854547127f0"), -1);
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SecureForm));
            this.uebMainNavigation = new Statline.Stattrac.Windows.Forms.UltraExplorerBar();
            this.pnlMainHeader = new Statline.Stattrac.Windows.Forms.Panel();
            this.ultraDockManager = new Statline.Stattrac.Windows.Forms.UltraDockManager();
            this._SecureFormUnpinnedTabAreaLeft = new Infragistics.Win.UltraWinDock.UnpinnedTabArea();
            this._SecureFormUnpinnedTabAreaRight = new Infragistics.Win.UltraWinDock.UnpinnedTabArea();
            this._SecureFormUnpinnedTabAreaTop = new Infragistics.Win.UltraWinDock.UnpinnedTabArea();
            this._SecureFormUnpinnedTabAreaBottom = new Infragistics.Win.UltraWinDock.UnpinnedTabArea();
            this._SecureFormAutoHideControl = new Infragistics.Win.UltraWinDock.AutoHideControl();
            this.dockableWindow1 = new Infragistics.Win.UltraWinDock.DockableWindow();
            this.dockableWindow2 = new Infragistics.Win.UltraWinDock.DockableWindow();
            this.windowDockingArea1 = new Infragistics.Win.UltraWinDock.WindowDockingArea();
            this.pnlBody = new Statline.Stattrac.Windows.Forms.Panel();
            this.windowDockingArea2 = new Infragistics.Win.UltraWinDock.WindowDockingArea();
            ((System.ComponentModel.ISupportInitialize)(this.uebMainNavigation)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ultraDockManager)).BeginInit();
            this.dockableWindow1.SuspendLayout();
            this.dockableWindow2.SuspendLayout();
            this.windowDockingArea1.SuspendLayout();
            this.windowDockingArea2.SuspendLayout();
            this.SuspendLayout();
            // 
            // uebMainNavigation
            // 
            this.uebMainNavigation.AnimationEnabled = false;
            this.uebMainNavigation.AnimationSpeed = Infragistics.Win.UltraWinExplorerBar.AnimationSpeed.Fast;
            this.uebMainNavigation.GroupSettings.Style = Infragistics.Win.UltraWinExplorerBar.GroupStyle.SmallImagesWithText;
            this.uebMainNavigation.ImageSizeSmall = new System.Drawing.Size(0, 0);
            this.uebMainNavigation.Location = new System.Drawing.Point(0, 26);
            this.uebMainNavigation.Name = "uebMainNavigation";
            this.uebMainNavigation.Size = new System.Drawing.Size(158, 715);
            this.uebMainNavigation.Style = Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarStyle.Listbar;
            this.uebMainNavigation.TabIndex = 5;
            this.uebMainNavigation.ViewStyle = Infragistics.Win.UltraWinExplorerBar.UltraExplorerBarViewStyle.Office2003;
            this.uebMainNavigation.GroupClick += new Infragistics.Win.UltraWinExplorerBar.GroupClickEventHandler(this.uebMainNavigation_GroupClick);
            this.uebMainNavigation.ItemClick += new Infragistics.Win.UltraWinExplorerBar.ItemClickEventHandler(this.uebMainNavigation_ItemClick);
            // 
            // pnlMainHeader
            // 
            this.pnlMainHeader.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlMainHeader.Location = new System.Drawing.Point(0, 0);
            this.pnlMainHeader.Name = "pnlMainHeader";
            this.pnlMainHeader.Size = new System.Drawing.Size(853, 165);
            this.pnlMainHeader.TabIndex = 7;
            // 
            // ultraDockManager
            // 
            this.ultraDockManager.AnimationEnabled = false;
            this.ultraDockManager.AnimationSpeed = Infragistics.Win.UltraWinDock.AnimationSpeed.StandardSpeedPlus5;
            this.ultraDockManager.AutoHideDelay = 1;
            this.ultraDockManager.CaptionStyle = Infragistics.Win.UltraWinDock.CaptionStyle.Office2003;
            dockAreaPane1.DockedBefore = new System.Guid("cc44d156-aba3-4f91-b940-9854547127f0");
            dockableControlPane1.Control = this.uebMainNavigation;
            dockableControlPane1.FlyoutSize = new System.Drawing.Size(196, -1);
            dockableControlPane1.OriginalControlBounds = new System.Drawing.Rectangle(46, 119, 175, 230);
            dockableControlPane1.Size = new System.Drawing.Size(100, 100);
            dockableControlPane1.Text = "Navigation";
            dockAreaPane1.Panes.AddRange(new Infragistics.Win.UltraWinDock.DockablePaneBase[] {
            dockableControlPane1});
            dockAreaPane1.Size = new System.Drawing.Size(158, 741);
            dockAreaPane2.DefaultPaneSettings.ShowCaption = Infragistics.Win.DefaultableBoolean.False;
            dockableControlPane2.Control = this.pnlMainHeader;
            dockableControlPane2.FlyoutSize = new System.Drawing.Size(-1, 149);
            dockableControlPane2.OriginalControlBounds = new System.Drawing.Rectangle(176, 166, 200, 100);
            dockableControlPane2.Size = new System.Drawing.Size(100, 100);
            dockAreaPane2.Panes.AddRange(new Infragistics.Win.UltraWinDock.DockablePaneBase[] {
            dockableControlPane2});
            dockAreaPane2.Size = new System.Drawing.Size(853, 165);
            this.ultraDockManager.DockAreas.AddRange(new Infragistics.Win.UltraWinDock.DockAreaPane[] {
            dockAreaPane1,
            dockAreaPane2});
            this.ultraDockManager.HostControl = this;
            this.ultraDockManager.ShowCloseButton = false;
            this.ultraDockManager.UnpinnedTabStyle = Infragistics.Win.UltraWinTabs.TabStyle.PropertyPage2003;
            this.ultraDockManager.WindowStyle = Infragistics.Win.UltraWinDock.WindowStyle.Office2003;
            // 
            // _SecureFormUnpinnedTabAreaLeft
            // 
            this._SecureFormUnpinnedTabAreaLeft.Dock = System.Windows.Forms.DockStyle.Left;
            this._SecureFormUnpinnedTabAreaLeft.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this._SecureFormUnpinnedTabAreaLeft.Location = new System.Drawing.Point(0, 0);
            this._SecureFormUnpinnedTabAreaLeft.Name = "_SecureFormUnpinnedTabAreaLeft";
            this._SecureFormUnpinnedTabAreaLeft.Owner = this.ultraDockManager;
            this._SecureFormUnpinnedTabAreaLeft.Size = new System.Drawing.Size(0, 741);
            this._SecureFormUnpinnedTabAreaLeft.TabIndex = 0;
            // 
            // _SecureFormUnpinnedTabAreaRight
            // 
            this._SecureFormUnpinnedTabAreaRight.Dock = System.Windows.Forms.DockStyle.Right;
            this._SecureFormUnpinnedTabAreaRight.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this._SecureFormUnpinnedTabAreaRight.Location = new System.Drawing.Point(1016, 0);
            this._SecureFormUnpinnedTabAreaRight.Name = "_SecureFormUnpinnedTabAreaRight";
            this._SecureFormUnpinnedTabAreaRight.Owner = this.ultraDockManager;
            this._SecureFormUnpinnedTabAreaRight.Size = new System.Drawing.Size(0, 741);
            this._SecureFormUnpinnedTabAreaRight.TabIndex = 1;
            // 
            // _SecureFormUnpinnedTabAreaTop
            // 
            this._SecureFormUnpinnedTabAreaTop.Dock = System.Windows.Forms.DockStyle.Top;
            this._SecureFormUnpinnedTabAreaTop.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this._SecureFormUnpinnedTabAreaTop.Location = new System.Drawing.Point(0, 0);
            this._SecureFormUnpinnedTabAreaTop.Name = "_SecureFormUnpinnedTabAreaTop";
            this._SecureFormUnpinnedTabAreaTop.Owner = this.ultraDockManager;
            this._SecureFormUnpinnedTabAreaTop.Size = new System.Drawing.Size(1016, 0);
            this._SecureFormUnpinnedTabAreaTop.TabIndex = 2;
            // 
            // _SecureFormUnpinnedTabAreaBottom
            // 
            this._SecureFormUnpinnedTabAreaBottom.Dock = System.Windows.Forms.DockStyle.Bottom;
            this._SecureFormUnpinnedTabAreaBottom.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this._SecureFormUnpinnedTabAreaBottom.Location = new System.Drawing.Point(0, 741);
            this._SecureFormUnpinnedTabAreaBottom.Name = "_SecureFormUnpinnedTabAreaBottom";
            this._SecureFormUnpinnedTabAreaBottom.Owner = this.ultraDockManager;
            this._SecureFormUnpinnedTabAreaBottom.Size = new System.Drawing.Size(1016, 0);
            this._SecureFormUnpinnedTabAreaBottom.TabIndex = 3;
            // 
            // _SecureFormAutoHideControl
            // 
            this._SecureFormAutoHideControl.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this._SecureFormAutoHideControl.Location = new System.Drawing.Point(22, 0);
            this._SecureFormAutoHideControl.Name = "_SecureFormAutoHideControl";
            this._SecureFormAutoHideControl.Owner = this.ultraDockManager;
            this._SecureFormAutoHideControl.Size = new System.Drawing.Size(201, 741);
            this._SecureFormAutoHideControl.TabIndex = 4;
            // 
            // dockableWindow1
            // 
            this.dockableWindow1.Controls.Add(this.uebMainNavigation);
            this.dockableWindow1.Location = new System.Drawing.Point(0, 0);
            this.dockableWindow1.Name = "dockableWindow1";
            this.dockableWindow1.Owner = this.ultraDockManager;
            this.dockableWindow1.Size = new System.Drawing.Size(158, 741);
            this.dockableWindow1.TabIndex = 10;
            // 
            // dockableWindow2
            // 
            this.dockableWindow2.Controls.Add(this.pnlMainHeader);
            this.dockableWindow2.Location = new System.Drawing.Point(0, 0);
            this.dockableWindow2.Name = "dockableWindow2";
            this.dockableWindow2.Owner = this.ultraDockManager;
            this.dockableWindow2.Size = new System.Drawing.Size(853, 165);
            this.dockableWindow2.TabIndex = 11;
            // 
            // windowDockingArea1
            // 
            this.windowDockingArea1.Controls.Add(this.dockableWindow1);
            this.windowDockingArea1.Dock = System.Windows.Forms.DockStyle.Left;
            this.windowDockingArea1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.windowDockingArea1.Location = new System.Drawing.Point(0, 0);
            this.windowDockingArea1.Name = "windowDockingArea1";
            this.windowDockingArea1.Owner = this.ultraDockManager;
            this.windowDockingArea1.Size = new System.Drawing.Size(163, 741);
            this.windowDockingArea1.TabIndex = 6;
            // 
            // pnlBody
            // 
            this.pnlBody.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlBody.Location = new System.Drawing.Point(163, 170);
            this.pnlBody.Name = "pnlBody";
            this.pnlBody.Size = new System.Drawing.Size(853, 571);
            this.pnlBody.TabIndex = 8;
            // 
            // windowDockingArea2
            // 
            this.windowDockingArea2.Controls.Add(this.dockableWindow2);
            this.windowDockingArea2.Dock = System.Windows.Forms.DockStyle.Top;
            this.windowDockingArea2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.windowDockingArea2.Location = new System.Drawing.Point(163, 0);
            this.windowDockingArea2.Name = "windowDockingArea2";
            this.windowDockingArea2.Owner = this.ultraDockManager;
            this.windowDockingArea2.Size = new System.Drawing.Size(853, 170);
            this.windowDockingArea2.TabIndex = 9;
            // 
            // SecureForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1016, 741);
            this.Controls.Add(this._SecureFormAutoHideControl);
            this.Controls.Add(this.pnlBody);
            this.Controls.Add(this.windowDockingArea2);
            this.Controls.Add(this.windowDockingArea1);
            this.Controls.Add(this._SecureFormUnpinnedTabAreaTop);
            this.Controls.Add(this._SecureFormUnpinnedTabAreaBottom);
            this.Controls.Add(this._SecureFormUnpinnedTabAreaRight);
            this.Controls.Add(this._SecureFormUnpinnedTabAreaLeft);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.KeyPreview = true;
            this.MinimumSize = new System.Drawing.Size(1024, 768);
            this.Name = "SecureForm";
            this.Text = "";
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.SecureForm_KeyDown);
            ((System.ComponentModel.ISupportInitialize)(this.uebMainNavigation)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ultraDockManager)).EndInit();
            this.dockableWindow1.ResumeLayout(false);
            this.dockableWindow2.ResumeLayout(false);
            this.windowDockingArea1.ResumeLayout(false);
            this.windowDockingArea2.ResumeLayout(false);
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraDockManager ultraDockManager;
		private Statline.Stattrac.Windows.Forms.UltraExplorerBar uebMainNavigation;
		private Infragistics.Win.UltraWinDock.AutoHideControl _SecureFormAutoHideControl;
		private Infragistics.Win.UltraWinDock.WindowDockingArea windowDockingArea1;
		private Infragistics.Win.UltraWinDock.DockableWindow dockableWindow1;
		private Infragistics.Win.UltraWinDock.UnpinnedTabArea _SecureFormUnpinnedTabAreaTop;
		private Infragistics.Win.UltraWinDock.UnpinnedTabArea _SecureFormUnpinnedTabAreaBottom;
		private Infragistics.Win.UltraWinDock.UnpinnedTabArea _SecureFormUnpinnedTabAreaLeft;
		private Infragistics.Win.UltraWinDock.UnpinnedTabArea _SecureFormUnpinnedTabAreaRight;
		private Statline.Stattrac.Windows.Forms.Panel pnlMainHeader;
		private Statline.Stattrac.Windows.Forms.Panel pnlBody;
		private Infragistics.Win.UltraWinDock.WindowDockingArea windowDockingArea2;
        private Infragistics.Win.UltraWinDock.DockableWindow dockableWindow2;
	}
}