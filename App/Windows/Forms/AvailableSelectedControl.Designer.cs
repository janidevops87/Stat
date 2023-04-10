namespace Statline.Stattrac.Windows.Forms
{
    partial class AvailableSelectedControl
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
            Infragistics.Win.Appearance appearance26 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance27 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance28 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance29 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance30 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance16 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance17 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance18 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance19 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance20 = new Infragistics.Win.Appearance();
            this.splitContainer1 = new Statline.Stattrac.Windows.Forms.SplitContainer();
            this.ugAvailable = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.splitContainer2 = new Statline.Stattrac.Windows.Forms.SplitContainer();
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.btnAvailable = new Statline.Stattrac.Windows.Forms.Button();
            this.btnAvailableAll = new Statline.Stattrac.Windows.Forms.Button();
            this.btnSelectedAll = new Statline.Stattrac.Windows.Forms.Button();
            this.btnSelected = new Statline.Stattrac.Windows.Forms.Button();
            this.ugSelected = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.splitContainer1.Panel1.SuspendLayout();
            this.splitContainer1.Panel2.SuspendLayout();
            this.splitContainer1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugAvailable)).BeginInit();
            this.splitContainer2.Panel1.SuspendLayout();
            this.splitContainer2.Panel2.SuspendLayout();
            this.splitContainer2.SuspendLayout();
            this.flowLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ugSelected)).BeginInit();
            this.SuspendLayout();
            // 
            // splitContainer1
            // 
            this.splitContainer1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer1.Location = new System.Drawing.Point(0, 0);
            this.splitContainer1.Name = "splitContainer1";
            // 
            // splitContainer1.Panel1
            // 
            this.splitContainer1.Panel1.Controls.Add(this.ugAvailable);
            this.splitContainer1.Panel1.Margin = new System.Windows.Forms.Padding(50);
            this.splitContainer1.Panel1MinSize = 75;
            // 
            // splitContainer1.Panel2
            // 
            this.splitContainer1.Panel2.Controls.Add(this.splitContainer2);
            this.splitContainer1.Size = new System.Drawing.Size(680, 156);
            this.splitContainer1.SplitterDistance = 314;
            this.splitContainer1.TabIndex = 0;
            // 
            // ugAvailable
            // 
            appearance26.BackColor = System.Drawing.Color.White;
            this.ugAvailable.DisplayLayout.Appearance = appearance26;
            this.ugAvailable.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.True;
            this.ugAvailable.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.ugAvailable.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.False;
            this.ugAvailable.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance27.BackColor = System.Drawing.Color.Transparent;
            this.ugAvailable.DisplayLayout.Override.CardAreaAppearance = appearance27;
            appearance28.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance28.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance28.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance28.FontData.BoldAsString = "True";
            appearance28.FontData.Name = "Arial";
            appearance28.FontData.SizeInPoints = 10F;
            appearance28.ForeColor = System.Drawing.Color.White;
            appearance28.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugAvailable.DisplayLayout.Override.HeaderAppearance = appearance28;
            appearance29.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance29.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance29.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugAvailable.DisplayLayout.Override.RowSelectorAppearance = appearance29;
            this.ugAvailable.DisplayLayout.Override.RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle.SeparateElement;
            appearance30.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance30.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance30.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugAvailable.DisplayLayout.Override.SelectedRowAppearance = appearance30;
            this.ugAvailable.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.ExtendedAutoDrag;
            this.ugAvailable.DisplayLayout.Override.SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType.None;
            this.ugAvailable.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.ExtendedAutoDrag;
            this.ugAvailable.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugAvailable.Location = new System.Drawing.Point(0, 0);
            this.ugAvailable.Name = "ugAvailable";
            this.ugAvailable.Size = new System.Drawing.Size(314, 156);
            this.ugAvailable.TabIndex = 5;
            this.ugAvailable.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            this.ugAvailable.ClickCell += new Infragistics.Win.UltraWinGrid.ClickCellEventHandler(this.ugAvailable_ClickCell);
            this.ugAvailable.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ugAvailable_InitializeRow);
            this.ugAvailable.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugAvailable_InitializeLayout);
            this.ugAvailable.DoubleClickCell += new Infragistics.Win.UltraWinGrid.DoubleClickCellEventHandler(this.ugAvailable_DoubleClickCell);
            // 
            // splitContainer2
            // 
            this.splitContainer2.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainer2.Location = new System.Drawing.Point(0, 0);
            this.splitContainer2.Name = "splitContainer2";
            // 
            // splitContainer2.Panel1
            // 
            this.splitContainer2.Panel1.Controls.Add(this.flowLayoutPanel1);
            this.splitContainer2.Panel1.Margin = new System.Windows.Forms.Padding(2);
            this.splitContainer2.Panel1MinSize = 5;
            // 
            // splitContainer2.Panel2
            // 
            this.splitContainer2.Panel2.Controls.Add(this.ugSelected);
            this.splitContainer2.Size = new System.Drawing.Size(362, 156);
            this.splitContainer2.SplitterDistance = 42;
            this.splitContainer2.TabIndex = 0;
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.flowLayoutPanel1.Controls.Add(this.btnAvailable);
            this.flowLayoutPanel1.Controls.Add(this.btnAvailableAll);
            this.flowLayoutPanel1.Controls.Add(this.btnSelectedAll);
            this.flowLayoutPanel1.Controls.Add(this.btnSelected);
            this.flowLayoutPanel1.FlowDirection = System.Windows.Forms.FlowDirection.TopDown;
            this.flowLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(40, 121);
            this.flowLayoutPanel1.TabIndex = 0;
            // 
            // btnAvailable
            // 
            this.btnAvailable.Location = new System.Drawing.Point(3, 3);
            this.btnAvailable.Name = "btnAvailable";
            this.btnAvailable.Size = new System.Drawing.Size(32, 23);
            this.btnAvailable.TabIndex = 0;
            this.btnAvailable.Text = ">";
            this.btnAvailable.UseVisualStyleBackColor = true;
            this.btnAvailable.Click += new System.EventHandler(this.btnAvailable_Click);
            // 
            // btnAvailableAll
            // 
            this.btnAvailableAll.Location = new System.Drawing.Point(3, 32);
            this.btnAvailableAll.Name = "btnAvailableAll";
            this.btnAvailableAll.Size = new System.Drawing.Size(32, 23);
            this.btnAvailableAll.TabIndex = 1;
            this.btnAvailableAll.Text = ">>";
            this.btnAvailableAll.UseVisualStyleBackColor = true;
            this.btnAvailableAll.Click += new System.EventHandler(this.btnAvailableAll_Click);
            // 
            // btnSelectedAll
            // 
            this.btnSelectedAll.Location = new System.Drawing.Point(3, 61);
            this.btnSelectedAll.Name = "btnSelectedAll";
            this.btnSelectedAll.Size = new System.Drawing.Size(32, 23);
            this.btnSelectedAll.TabIndex = 2;
            this.btnSelectedAll.Text = "<<";
            this.btnSelectedAll.UseVisualStyleBackColor = true;
            this.btnSelectedAll.Click += new System.EventHandler(this.btnSelectedAll_Click);
            // 
            // btnSelected
            // 
            this.btnSelected.Location = new System.Drawing.Point(3, 90);
            this.btnSelected.Name = "btnSelected";
            this.btnSelected.Size = new System.Drawing.Size(32, 23);
            this.btnSelected.TabIndex = 3;
            this.btnSelected.Text = "<";
            this.btnSelected.UseVisualStyleBackColor = true;
            this.btnSelected.Click += new System.EventHandler(this.btnSelected_Click);
            // 
            // ugSelected
            // 
            appearance16.BackColor = System.Drawing.Color.White;
            this.ugSelected.DisplayLayout.Appearance = appearance16;
            this.ugSelected.DisplayLayout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.No;
            this.ugSelected.DisplayLayout.Override.AllowDelete = Infragistics.Win.DefaultableBoolean.False;
            this.ugSelected.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance17.BackColor = System.Drawing.Color.Transparent;
            this.ugSelected.DisplayLayout.Override.CardAreaAppearance = appearance17;
            appearance18.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance18.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance18.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance18.FontData.BoldAsString = "True";
            appearance18.FontData.Name = "Arial";
            appearance18.FontData.SizeInPoints = 10F;
            appearance18.ForeColor = System.Drawing.Color.White;
            appearance18.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugSelected.DisplayLayout.Override.HeaderAppearance = appearance18;
            appearance19.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance19.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance19.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugSelected.DisplayLayout.Override.RowSelectorAppearance = appearance19;
            this.ugSelected.DisplayLayout.Override.RowSelectorHeaderStyle = Infragistics.Win.UltraWinGrid.RowSelectorHeaderStyle.SeparateElement;
            appearance20.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance20.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance20.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugSelected.DisplayLayout.Override.SelectedRowAppearance = appearance20;
            this.ugSelected.DisplayLayout.Override.SelectTypeCell = Infragistics.Win.UltraWinGrid.SelectType.ExtendedAutoDrag;
            this.ugSelected.DisplayLayout.Override.SelectTypeCol = Infragistics.Win.UltraWinGrid.SelectType.None;
            this.ugSelected.DisplayLayout.Override.SelectTypeRow = Infragistics.Win.UltraWinGrid.SelectType.ExtendedAutoDrag;
            this.ugSelected.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ugSelected.Location = new System.Drawing.Point(0, 0);
            this.ugSelected.Name = "ugSelected";
            this.ugSelected.Size = new System.Drawing.Size(316, 156);
            this.ugSelected.TabIndex = 6;
            this.ugSelected.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            this.ugSelected.ClickCell += new Infragistics.Win.UltraWinGrid.ClickCellEventHandler(this.ugSelected_ClickCell);
            this.ugSelected.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ugSelected_InitializeRow);
            this.ugSelected.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ugSelected_InitializeLayout);
            this.ugSelected.DoubleClickCell += new Infragistics.Win.UltraWinGrid.DoubleClickCellEventHandler(this.ugSelected_DoubleClickCell);
            // 
            // AvailableSelectedControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.splitContainer1);
            this.Name = "AvailableSelectedControl";
            this.Size = new System.Drawing.Size(680, 156);
            this.splitContainer1.Panel1.ResumeLayout(false);
            this.splitContainer1.Panel2.ResumeLayout(false);
            this.splitContainer1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ugAvailable)).EndInit();
            this.splitContainer2.Panel1.ResumeLayout(false);
            this.splitContainer2.Panel2.ResumeLayout(false);
            this.splitContainer2.ResumeLayout(false);
            this.flowLayoutPanel1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.ugSelected)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private SplitContainer splitContainer1;
        private SplitContainer splitContainer2;
        private UltraGrid ugAvailable;
        private Button btnSelected;
        private Button btnSelectedAll;
        private Button btnAvailableAll;
        private Button btnAvailable;
        private UltraGrid ugSelected;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;

    }
}
