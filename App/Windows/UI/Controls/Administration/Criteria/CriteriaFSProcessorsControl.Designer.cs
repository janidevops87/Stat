namespace Statline.Stattrac.Windows.UI.Controls.Administration.Criteria
{
    partial class CriteriaFSProcessorsControl
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
            this.lblStateProvince = new Statline.Stattrac.Windows.Forms.Label();
            this.cbStateProvince = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblOrganizationType = new Statline.Stattrac.Windows.Forms.Label();
            this.cbOrganizationType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.btnSearch = new Statline.Stattrac.Windows.Forms.Button();
            this.availableSelectedControl1 = new Statline.Stattrac.Windows.Forms.AvailableSelectedControl();
            this.lblAvailableProcessors = new Statline.Stattrac.Windows.Forms.Label();
            this.lblSelectedProcessors = new Statline.Stattrac.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // lblStateProvince
            // 
            this.lblStateProvince.AutoSize = true;
            this.lblStateProvince.Location = new System.Drawing.Point(17, 14);
            this.lblStateProvince.Name = "lblStateProvince";
            this.lblStateProvince.Size = new System.Drawing.Size(82, 13);
            this.lblStateProvince.TabIndex = 0;
            this.lblStateProvince.Text = "State/Province:";
            // 
            // cbStateProvince
            // 
            this.cbStateProvince.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbStateProvince.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbStateProvince.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbStateProvince.FormattingEnabled = true;
            this.cbStateProvince.Location = new System.Drawing.Point(105, 11);
            this.cbStateProvince.Name = "cbStateProvince";
            this.cbStateProvince.Size = new System.Drawing.Size(125, 21);
            this.cbStateProvince.TabIndex = 1;
            this.cbStateProvince.SelectedIndexChanged += new System.EventHandler(this.cbStatProvince_SelectedIndexChanged);
            // 
            // lblOrganizationType
            // 
            this.lblOrganizationType.AutoSize = true;
            this.lblOrganizationType.Location = new System.Drawing.Point(9, 42);
            this.lblOrganizationType.Name = "lblOrganizationType";
            this.lblOrganizationType.Size = new System.Drawing.Size(96, 13);
            this.lblOrganizationType.TabIndex = 2;
            this.lblOrganizationType.Text = "Organization Type:";
            // 
            // cbOrganizationType
            // 
            this.cbOrganizationType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbOrganizationType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbOrganizationType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbOrganizationType.FormattingEnabled = true;
            this.cbOrganizationType.Location = new System.Drawing.Point(105, 39);
            this.cbOrganizationType.Name = "cbOrganizationType";
            this.cbOrganizationType.Size = new System.Drawing.Size(225, 21);
            this.cbOrganizationType.TabIndex = 3;
            this.cbOrganizationType.SelectedIndexChanged += new System.EventHandler(this.cbOrganizationType_SelectedIndexChanged);
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(254, 67);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(75, 23);
            this.btnSearch.TabIndex = 4;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // availableSelectedControl1
            // 
            this.availableSelectedControl1.ColumnList = null;
            this.availableSelectedControl1.DataMember = "";
            this.availableSelectedControl1.DataSource = null;
            this.availableSelectedControl1.IdColumn = "";
            this.availableSelectedControl1.Location = new System.Drawing.Point(12, 145);
            this.availableSelectedControl1.Name = "availableSelectedControl1";
            this.availableSelectedControl1.Size = new System.Drawing.Size(680, 252);
            this.availableSelectedControl1.TabIndex = 5;
            this.availableSelectedControl1.TextAvailable = "";
            this.availableSelectedControl1.TextSelected = "";
            // 
            // lblAvailableProcessors
            // 
            this.lblAvailableProcessors.AutoSize = true;
            this.lblAvailableProcessors.Location = new System.Drawing.Point(12, 126);
            this.lblAvailableProcessors.Name = "lblAvailableProcessors";
            this.lblAvailableProcessors.Size = new System.Drawing.Size(105, 13);
            this.lblAvailableProcessors.TabIndex = 6;
            this.lblAvailableProcessors.Text = "Available Processors";
            // 
            // lblSelectedProcessors
            // 
            this.lblSelectedProcessors.AutoSize = true;
            this.lblSelectedProcessors.Location = new System.Drawing.Point(375, 126);
            this.lblSelectedProcessors.Name = "lblSelectedProcessors";
            this.lblSelectedProcessors.Size = new System.Drawing.Size(104, 13);
            this.lblSelectedProcessors.TabIndex = 7;
            this.lblSelectedProcessors.Text = "Selected Processors";
            // 
            // CriteriaFSProcessorsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.lblSelectedProcessors);
            this.Controls.Add(this.lblAvailableProcessors);
            this.Controls.Add(this.availableSelectedControl1);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.cbOrganizationType);
            this.Controls.Add(this.lblOrganizationType);
            this.Controls.Add(this.cbStateProvince);
            this.Controls.Add(this.lblStateProvince);
            this.Name = "CriteriaFSProcessorsControl";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Label lblStateProvince;
        private Statline.Stattrac.Windows.Forms.ComboBox cbStateProvince;
        private Statline.Stattrac.Windows.Forms.Label lblOrganizationType;
        private Statline.Stattrac.Windows.Forms.ComboBox cbOrganizationType;
        private Statline.Stattrac.Windows.Forms.Button btnSearch;
        private Statline.Stattrac.Windows.Forms.AvailableSelectedControl availableSelectedControl1;
        private Statline.Stattrac.Windows.Forms.Label lblAvailableProcessors;
        private Statline.Stattrac.Windows.Forms.Label lblSelectedProcessors;
    }
}
