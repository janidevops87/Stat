namespace Statline.Stattrac.Windows.Controls.Administration.SourceCode
{
    partial class SourceCodeEditManager
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
            this.lblCallType = new Statline.Stattrac.Windows.Forms.Label();
            this.lblSourceCode = new Statline.Stattrac.Windows.Forms.Label();
            this.cbCallType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.btnAdd = new Statline.Stattrac.Windows.Forms.Button();
            this.chkDisplayAllSourceCodes = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.panel1 = new Statline.Stattrac.Windows.Forms.Panel();
            this.cbSourceCode = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.tabControl = new Statline.Stattrac.Windows.Forms.UltraTabControl();
            this.ultraTabSharedControlsPage2 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
            this.pnlBody.SuspendLayout();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).BeginInit();
            this.tabControl.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlBody
            // 
            this.pnlBody.AutoScrollMargin = new System.Drawing.Size(1, 0);
            this.pnlBody.Controls.Add(this.tabControl);
            this.pnlBody.Location = new System.Drawing.Point(0, 99);
            this.pnlBody.Padding = new System.Windows.Forms.Padding(0);
            this.pnlBody.Size = new System.Drawing.Size(701, 497);
            this.pnlBody.TabIndex = 4;
            // 
            // lblCallType
            // 
            this.lblCallType.AutoSize = true;
            this.lblCallType.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblCallType.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblCallType.Location = new System.Drawing.Point(33, 17);
            this.lblCallType.Name = "lblCallType";
            this.lblCallType.Size = new System.Drawing.Size(55, 13);
            this.lblCallType.TabIndex = 0;
            this.lblCallType.Text = "Call Type:";
            this.lblCallType.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // lblSourceCode
            // 
            this.lblSourceCode.AutoSize = true;
            this.lblSourceCode.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblSourceCode.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblSourceCode.Location = new System.Drawing.Point(15, 43);
            this.lblSourceCode.Name = "lblSourceCode";
            this.lblSourceCode.Size = new System.Drawing.Size(72, 13);
            this.lblSourceCode.TabIndex = 2;
            this.lblSourceCode.Text = "Source Code:";
            this.lblSourceCode.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // cbCallType
            // 
            this.cbCallType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbCallType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbCallType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbCallType.Font = new System.Drawing.Font("Tahoma", 8F);
            this.cbCallType.FormattingEnabled = true;
            this.cbCallType.Location = new System.Drawing.Point(93, 14);
            this.cbCallType.Name = "cbCallType";
            this.cbCallType.Required = false;
            this.cbCallType.Size = new System.Drawing.Size(159, 21);
            this.cbCallType.TabIndex = 1;
            this.cbCallType.SelectedIndexChanged += new System.EventHandler(this.cbCallType_SelectedIndexChanged);
            // 
            // btnAdd
            // 
            this.btnAdd.Location = new System.Drawing.Point(259, 40);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(53, 23);
            this.btnAdd.TabIndex = 4;
            this.btnAdd.Text = "Add";
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // chkDisplayAllSourceCodes
            // 
            this.chkDisplayAllSourceCodes.AutoSize = true;
            this.chkDisplayAllSourceCodes.Checked = false;
            this.chkDisplayAllSourceCodes.Font = new System.Drawing.Font("Tahoma", 8F);
            this.chkDisplayAllSourceCodes.Location = new System.Drawing.Point(93, 74);
            this.chkDisplayAllSourceCodes.Name = "chkDisplayAllSourceCodes";
            this.chkDisplayAllSourceCodes.Size = new System.Drawing.Size(143, 17);
            this.chkDisplayAllSourceCodes.TabIndex = 5;
            this.chkDisplayAllSourceCodes.Text = "Display All Source Codes";
            this.chkDisplayAllSourceCodes.UseVisualStyleBackColor = true;
            this.chkDisplayAllSourceCodes.CheckedChanged += new System.EventHandler(this.chkDisplayAllSourceCodes_CheckedChanged);
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.cbSourceCode);
            this.panel1.Controls.Add(this.cbCallType);
            this.panel1.Controls.Add(this.chkDisplayAllSourceCodes);
            this.panel1.Controls.Add(this.lblCallType);
            this.panel1.Controls.Add(this.btnAdd);
            this.panel1.Controls.Add(this.lblSourceCode);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(701, 99);
            this.panel1.TabIndex = 2;
            this.panel1.TabStop = true;
            // 
            // cbSourceCode
            // 
            this.cbSourceCode.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbSourceCode.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbSourceCode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbSourceCode.Font = new System.Drawing.Font("Tahoma", 8F);
            this.cbSourceCode.FormattingEnabled = true;
            this.cbSourceCode.Location = new System.Drawing.Point(93, 42);
            this.cbSourceCode.Name = "cbSourceCode";
            this.cbSourceCode.Required = false;
            this.cbSourceCode.Size = new System.Drawing.Size(159, 21);
            this.cbSourceCode.TabIndex = 3;
            this.cbSourceCode.SelectedIndexChanged += new System.EventHandler(this.cbSourceCode_SelectedIndexChanged);
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.ultraTabSharedControlsPage2);
            this.tabControl.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tabControl.Location = new System.Drawing.Point(0, 0);
            this.tabControl.Name = "tabControl";
            this.tabControl.ScrollButtons = Infragistics.Win.UltraWinTabs.TabScrollButtons.None;
            this.tabControl.SharedControlsPage = this.ultraTabSharedControlsPage2;
            this.tabControl.Size = new System.Drawing.Size(701, 497);
            this.tabControl.TabIndex = 0;
            this.tabControl.SelectedTabChanged += new Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventHandler(this.tabControl_SelectedTabChanged);
            // 
            // ultraTabSharedControlsPage2
            // 
            this.ultraTabSharedControlsPage2.Location = new System.Drawing.Point(1, 20);
            this.ultraTabSharedControlsPage2.Name = "ultraTabSharedControlsPage2";
            this.ultraTabSharedControlsPage2.Size = new System.Drawing.Size(697, 474);
            // 
            // SourceCodeEditManager
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.panel1);
            this.Name = "SourceCodeEditManager";
            this.Size = new System.Drawing.Size(701, 622);
            this.Controls.SetChildIndex(this.panel1, 0);
            this.Controls.SetChildIndex(this.pnlBody, 0);
            this.pnlBody.ResumeLayout(false);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).EndInit();
            this.tabControl.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Label lblCallType;
        private Statline.Stattrac.Windows.Forms.Label lblSourceCode;
        private Statline.Stattrac.Windows.Forms.ComboBox cbCallType;
        private Statline.Stattrac.Windows.Forms.Button btnAdd;
        private Statline.Stattrac.Windows.Forms.CheckBox chkDisplayAllSourceCodes;
        private Statline.Stattrac.Windows.Forms.Panel panel1;
        private Statline.Stattrac.Windows.Forms.ComboBox cbSourceCode;
        private Statline.Stattrac.Windows.Forms.UltraTabControl tabControl;
        private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage2;
    }
}
