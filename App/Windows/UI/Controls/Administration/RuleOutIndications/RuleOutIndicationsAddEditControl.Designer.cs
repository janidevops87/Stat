namespace Statline.Stattrac.Windows.UI.Controls.Administration.RuleOutIndications
{
    partial class RuleOutIndicationsAddEditControl
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
            this.chkDisplayAllRuleOutIndications = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.lblRuleOutIndications = new Statline.Stattrac.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.Panel1.SuspendLayout();
            this.splitContainer.Panel2.SuspendLayout();
            this.splitContainer.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnAdd
            // 
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnDelete
            // 
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(208, 0);
            // 
            // ultraGrid
            // 
            this.ultraGrid.DisplayLayout.Override.AllowColSwapping = Infragistics.Win.UltraWinGrid.AllowColSwapping.NotAllowed;
            this.ultraGrid.Location = new System.Drawing.Point(102, 88);
            this.ultraGrid.Size = new System.Drawing.Size(537, 284);
            this.ultraGrid.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.Search;
            this.ultraGrid.DoubleClickRow += new Infragistics.Win.UltraWinGrid.DoubleClickRowEventHandler(this.ultraGrid_DoubleClickRow);
            this.ultraGrid.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ultraGrid_InitializeLayout);
            // 
            // splitContainer
            // 
            // 
            // splitContainer.Panel1
            // 
            this.splitContainer.Panel1.Controls.Add(this.lblRuleOutIndications);
            this.splitContainer.Panel1.Controls.Add(this.chkDisplayAllRuleOutIndications);
            this.splitContainer.Panel1Collapsed = false;
            this.splitContainer.SplitterDistance = 100;
            // 
            // chkDisplayAllRuleOutIndications
            // 
            this.chkDisplayAllRuleOutIndications.AutoSize = true;
            this.chkDisplayAllRuleOutIndications.Checked = false;
            this.chkDisplayAllRuleOutIndications.Location = new System.Drawing.Point(115, 65);
            this.chkDisplayAllRuleOutIndications.Name = "chkDisplayAllRuleOutIndications";
            this.chkDisplayAllRuleOutIndications.Size = new System.Drawing.Size(173, 17);
            this.chkDisplayAllRuleOutIndications.TabIndex = 0;
            this.chkDisplayAllRuleOutIndications.Text = "Display All Rule Out Indications";
            this.chkDisplayAllRuleOutIndications.UseVisualStyleBackColor = true;
            this.chkDisplayAllRuleOutIndications.CheckedChanged += new System.EventHandler(this.chkDisplayAllRuleOutIndications_CheckedChanged);
            // 
            // lblRuleOutIndications
            // 
            this.lblRuleOutIndications.AutoSize = true;
            this.lblRuleOutIndications.Location = new System.Drawing.Point(3, 65);
            this.lblRuleOutIndications.Name = "lblRuleOutIndications";
            this.lblRuleOutIndications.Size = new System.Drawing.Size(106, 13);
            this.lblRuleOutIndications.TabIndex = 1;
            this.lblRuleOutIndications.Text = "Rule Out Indications:";
            // 
            // RuleOutIndicationsAddEditSearch
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Inherit;
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.Name = "RuleOutIndicationsAddEditSearch";
            this.Size = new System.Drawing.Size(968, 517);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.Panel1.ResumeLayout(false);
            this.splitContainer.Panel1.PerformLayout();
            this.splitContainer.Panel2.ResumeLayout(false);
            this.splitContainer.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.CheckBox chkDisplayAllRuleOutIndications;
        private Statline.Stattrac.Windows.Forms.Label lblRuleOutIndications;
    }
}
