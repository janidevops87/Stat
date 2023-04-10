namespace Statline.Stattrac.Windows.UI
{
	partial class BaseGridSearch
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
            this.components = new System.ComponentModel.Container();
            this.btnSearch = new Statline.Stattrac.Windows.Forms.Button();
            this.btnDelete = new Statline.Stattrac.Windows.Forms.Button();
            this.txtCount = new Statline.Stattrac.Windows.Forms.Label();
            this.lblCount = new Statline.Stattrac.Windows.Forms.Label();
            this.btnAdd = new Statline.Stattrac.Windows.Forms.Button();
            this.timer = new System.Windows.Forms.Timer(this.components);
            this.splitContainer = new System.Windows.Forms.SplitContainer();
            this.panel2SplitContainer = new System.Windows.Forms.SplitContainer();
            this.panelSearch = new System.Windows.Forms.Panel();
            this.btnClearFilter = new Statline.Stattrac.Windows.Forms.Button();
            this.lblCallType = new Statline.Stattrac.Windows.Forms.Label();
            this.cbCallType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.btnSearchClosed = new Statline.Stattrac.Windows.Forms.Button();
            this.ultraGrid = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.contextMenuStrip1 = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.openInReadOnlyToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.recycleToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.splitContainer.Panel2.SuspendLayout();
            this.splitContainer.SuspendLayout();
            this.panel2SplitContainer.Panel1.SuspendLayout();
            this.panel2SplitContainer.Panel2.SuspendLayout();
            this.panel2SplitContainer.SuspendLayout();
            this.panelSearch.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.contextMenuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnSearch
            // 
            this.btnSearch.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSearch.Location = new System.Drawing.Point(187, 1);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnSearch.Size = new System.Drawing.Size(85, 24);
            this.btnSearch.TabIndex = 0;
            this.btnSearch.Text = "&Refresh";
            this.btnSearch.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnSearch.Visible = false;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // btnDelete
            // 
            this.btnDelete.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnDelete.Location = new System.Drawing.Point(365, 1);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnDelete.Size = new System.Drawing.Size(85, 24);
            this.btnDelete.TabIndex = 2;
            this.btnDelete.Text = "&Delete Call";
            this.btnDelete.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnDelete.Visible = false;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // txtCount
            // 
            this.txtCount.AutoSize = true;
            this.txtCount.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtCount.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.txtCount.Location = new System.Drawing.Point(676, 4);
            this.txtCount.Name = "txtCount";
            this.txtCount.Size = new System.Drawing.Size(13, 13);
            this.txtCount.TabIndex = 5;
            this.txtCount.Text = "0";
            // 
            // lblCount
            // 
            this.lblCount.AutoSize = true;
            this.lblCount.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblCount.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCount.Location = new System.Drawing.Point(638, 4);
            this.lblCount.Name = "lblCount";
            this.lblCount.Size = new System.Drawing.Size(40, 13);
            this.lblCount.TabIndex = 3;
            this.lblCount.Text = "Count:";
            // 
            // btnAdd
            // 
            this.btnAdd.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnAdd.Location = new System.Drawing.Point(276, 1);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnAdd.Size = new System.Drawing.Size(85, 24);
            this.btnAdd.TabIndex = 1;
            this.btnAdd.Text = "&New Call";
            this.btnAdd.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // timer
            // 
            this.timer.Interval = 90000;
            this.timer.Tick += new System.EventHandler(this.timer_Tick);
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
            this.splitContainer.Panel1.AccessibleRole = System.Windows.Forms.AccessibleRole.None;
            this.splitContainer.Panel1Collapsed = true;
            this.splitContainer.Panel1MinSize = 10;
            // 
            // splitContainer.Panel2
            // 
            //this.splitContainer.Panel2.AutoScrollMinSize = new System.Drawing.Size(0, 300);
            this.splitContainer.Panel2.Controls.Add(this.panel2SplitContainer);
            this.splitContainer.Panel2MinSize = 100;
            this.splitContainer.Size = new System.Drawing.Size(702, 463);
            this.splitContainer.SplitterDistance = 20;
            this.splitContainer.TabIndex = 3;
            // 
            // panel2SplitContainer
            // 
            this.panel2SplitContainer.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panel2SplitContainer.IsSplitterFixed = true;
            this.panel2SplitContainer.Location = new System.Drawing.Point(0, 0);
            this.panel2SplitContainer.Name = "panel2SplitContainer";
            this.panel2SplitContainer.Orientation = System.Windows.Forms.Orientation.Horizontal;
            // 
            // panel2SplitContainer.Panel1
            // 
            this.panel2SplitContainer.Panel1.Controls.Add(this.panelSearch);
            this.panel2SplitContainer.Panel1MinSize = 28;
            // 
            // panel2SplitContainer.Panel2
            // 
            this.panel2SplitContainer.Panel2.Controls.Add(this.ultraGrid);
            this.panel2SplitContainer.Size = new System.Drawing.Size(702, 463);
            this.panel2SplitContainer.SplitterDistance = 28;
            this.panel2SplitContainer.TabIndex = 3;
            // 
            // panelSearch
            // 
            this.panelSearch.AutoSize = true;
            this.panelSearch.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.panelSearch.Controls.Add(this.btnClearFilter);
            this.panelSearch.Controls.Add(this.lblCallType);
            this.panelSearch.Controls.Add(this.cbCallType);
            this.panelSearch.Controls.Add(this.btnSearchClosed);
            this.panelSearch.Controls.Add(this.btnSearch);
            this.panelSearch.Controls.Add(this.btnDelete);
            this.panelSearch.Controls.Add(this.lblCount);
            this.panelSearch.Controls.Add(this.btnAdd);
            this.panelSearch.Controls.Add(this.txtCount);
            this.panelSearch.Dock = System.Windows.Forms.DockStyle.Fill;
            this.panelSearch.Location = new System.Drawing.Point(0, 0);
            this.panelSearch.MaximumSize = new System.Drawing.Size(0, 30);
            this.panelSearch.MinimumSize = new System.Drawing.Size(0, 28);
            this.panelSearch.Name = "panelSearch";
            this.panelSearch.Size = new System.Drawing.Size(702, 28);
            this.panelSearch.TabIndex = 0;
            // 
            // btnClearFilter
            // 
            this.btnClearFilter.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClearFilter.Location = new System.Drawing.Point(454, 1);
            this.btnClearFilter.Name = "btnClearFilter";
            this.btnClearFilter.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnClearFilter.Size = new System.Drawing.Size(79, 24);
            this.btnClearFilter.TabIndex = 9;
            this.btnClearFilter.Text = "Clear &Filter";
            this.btnClearFilter.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            // 
            // lblCallType
            // 
            this.lblCallType.AutoSize = true;
            this.lblCallType.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblCallType.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCallType.Location = new System.Drawing.Point(5, 6);
            this.lblCallType.Name = "lblCallType";
            this.lblCallType.Size = new System.Drawing.Size(55, 13);
            this.lblCallType.TabIndex = 8;
            this.lblCallType.Text = "Call Type:";
            this.lblCallType.Visible = false;
            // 
            // cbCallType
            // 
            this.cbCallType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cbCallType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbCallType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbCallType.Font = new System.Drawing.Font("Tahoma", 8F);
            this.cbCallType.FormattingEnabled = true;
            this.cbCallType.Location = new System.Drawing.Point(64, 2);
            this.cbCallType.Name = "cbCallType";
            this.cbCallType.Required = false;
            this.cbCallType.Size = new System.Drawing.Size(121, 21);
            this.cbCallType.TabIndex = 7;
            this.cbCallType.Visible = false;
            // 
            // btnSearchClosed
            // 
            this.btnSearchClosed.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSearchClosed.Location = new System.Drawing.Point(620, 1);
            this.btnSearchClosed.Name = "btnSearchClosed";
            this.btnSearchClosed.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnSearchClosed.Size = new System.Drawing.Size(16, 24);
            this.btnSearchClosed.TabIndex = 3;
            this.btnSearchClosed.Text = "Search Closed";
            this.btnSearchClosed.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnSearchClosed.Visible = false;
            // 
            // ultraGrid
            // 
            this.ultraGrid.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            this.ultraGrid.DisplayLayout.GroupByBox.Hidden = true;
            this.ultraGrid.DisplayLayout.Override.AllowColSwapping = Infragistics.Win.UltraWinGrid.AllowColSwapping.NotAllowed;
            this.ultraGrid.DisplayLayout.Override.AllowGroupBy = Infragistics.Win.DefaultableBoolean.False;
            this.ultraGrid.DisplayLayout.ViewStyleBand = Infragistics.Win.UltraWinGrid.ViewStyleBand.Horizontal;
            this.ultraGrid.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ultraGrid.Location = new System.Drawing.Point(0, 0);
            this.ultraGrid.MinimumSize = new System.Drawing.Size(500, 400);
            this.ultraGrid.Name = "ultraGrid";
            this.ultraGrid.RowUpdateCancelAction = Infragistics.Win.UltraWinGrid.RowUpdateCancelAction.RetainDataAndActivation;
            this.ultraGrid.Size = new System.Drawing.Size(702, 431);
            this.ultraGrid.TabIndex = 0;
            this.ultraGrid.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.Search;
            // 
            // contextMenuStrip1
            // 
            this.contextMenuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.openInReadOnlyToolStripMenuItem,
            this.recycleToolStripMenuItem});
            this.contextMenuStrip1.Name = "contextMenuStrip1";
            this.contextMenuStrip1.Size = new System.Drawing.Size(165, 48);
            // 
            // openInReadOnlyToolStripMenuItem
            // 
            this.openInReadOnlyToolStripMenuItem.Name = "openInReadOnlyToolStripMenuItem";
            this.openInReadOnlyToolStripMenuItem.Size = new System.Drawing.Size(164, 22);
            this.openInReadOnlyToolStripMenuItem.Text = "Open in Read Only";
            // 
            // recycleToolStripMenuItem
            // 
            this.recycleToolStripMenuItem.Name = "recycleToolStripMenuItem";
            this.recycleToolStripMenuItem.Size = new System.Drawing.Size(164, 22);
            this.recycleToolStripMenuItem.Text = "Delete";
            // 
            // BaseGridSearch
            // 
            this.Controls.Add(this.splitContainer);
            this.MinimumSize = new System.Drawing.Size(702, 443);
            this.Name = "BaseGridSearch";
            this.Size = new System.Drawing.Size(702, 463);
            this.splitContainer.Panel2.ResumeLayout(false);
            this.splitContainer.ResumeLayout(false);
            this.panel2SplitContainer.Panel1.ResumeLayout(false);
            this.panel2SplitContainer.Panel1.PerformLayout();
            this.panel2SplitContainer.Panel2.ResumeLayout(false);
            this.panel2SplitContainer.ResumeLayout(false);
            this.panelSearch.ResumeLayout(false);
            this.panelSearch.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.contextMenuStrip1.ResumeLayout(false);
            this.ResumeLayout(false);

		}

		#endregion

        private Statline.Stattrac.Windows.Forms.Label lblCount;
		private Statline.Stattrac.Windows.Forms.Label txtCount;
        private System.Windows.Forms.Timer timer;
        public Statline.Stattrac.Windows.Forms.Button btnAdd;
        public Statline.Stattrac.Windows.Forms.Button btnDelete;
        public Statline.Stattrac.Windows.Forms.Button btnSearch;
        private System.Windows.Forms.Panel panelSearch;
        protected Statline.Stattrac.Windows.Forms.UltraGrid ultraGrid;
        protected System.Windows.Forms.SplitContainer splitContainer;
		  public Statline.Stattrac.Windows.Forms.Button btnSearchClosed;
          private System.Windows.Forms.SplitContainer panel2SplitContainer;
          public Statline.Stattrac.Windows.Forms.Label lblCallType;
          public Statline.Stattrac.Windows.Forms.ComboBox cbCallType;
          public Statline.Stattrac.Windows.Forms.Button btnClearFilter;
          public System.Windows.Forms.ContextMenuStrip contextMenuStrip1;
          public System.Windows.Forms.ToolStripMenuItem openInReadOnlyToolStripMenuItem;
          public System.Windows.Forms.ToolStripMenuItem recycleToolStripMenuItem;
	}
}
