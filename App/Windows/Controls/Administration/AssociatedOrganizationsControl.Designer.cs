namespace Statline.Stattrac.Windows.Controls.Administration
{
    partial class AssociatedOrganizationsControl
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
            this.btnSearch = new Statline.Stattrac.Windows.Forms.Button();
            this.btnUnassigned = new Statline.Stattrac.Windows.Forms.Button();
            this.organizationSearchParameter = new Statline.Stattrac.Windows.Controls.Common.OrganizationSearchParameter();
            this.availableSelectedControl = new Statline.Stattrac.Windows.Forms.AvailableSelectedControl();
            this.lblSelectedOrganizations = new Statline.Stattrac.Windows.Forms.Label();
            this.lblAvailableOrganizations = new Statline.Stattrac.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnSearch
            // 
            this.btnSearch.Location = new System.Drawing.Point(145, 179);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(75, 23);
            this.btnSearch.TabIndex = 1;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = true;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // btnUnassigned
            // 
            this.btnUnassigned.Location = new System.Drawing.Point(226, 179);
            this.btnUnassigned.Name = "btnUnassigned";
            this.btnUnassigned.Size = new System.Drawing.Size(75, 23);
            this.btnUnassigned.TabIndex = 2;
            this.btnUnassigned.Text = "Unassigned";
            this.btnUnassigned.UseVisualStyleBackColor = true;
            // 
            // organizationSearchParameter
            // 
            this.organizationSearchParameter.BRSearchParameter = null;
            this.organizationSearchParameter.Location = new System.Drawing.Point(30, 3);
            this.organizationSearchParameter.Name = "organizationSearchParameter";
            this.organizationSearchParameter.Size = new System.Drawing.Size(628, 176);
            this.organizationSearchParameter.TabIndex = 0;
            // 
            // availableSelectedControl
            // 
            this.availableSelectedControl.ColumnList = null;
            this.availableSelectedControl.DataMember = null;
            this.availableSelectedControl.DataSource = null;
            this.availableSelectedControl.IdColumn = "";
            this.availableSelectedControl.Location = new System.Drawing.Point(30, 218);
            this.availableSelectedControl.Name = "availableSelectedControl";
            this.availableSelectedControl.Size = new System.Drawing.Size(729, 258);
            this.availableSelectedControl.TabIndex = 3;
            this.availableSelectedControl.TextAvailable = "";
            this.availableSelectedControl.TextSelected = "";
            // 
            // lblSelectedOrganizations
            // 
            this.lblSelectedOrganizations.AutoSize = true;
            this.lblSelectedOrganizations.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblSelectedOrganizations.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblSelectedOrganizations.Location = new System.Drawing.Point(419, 202);
            this.lblSelectedOrganizations.Name = "lblSelectedOrganizations";
            this.lblSelectedOrganizations.Size = new System.Drawing.Size(121, 13);
            this.lblSelectedOrganizations.TabIndex = 4;
            this.lblSelectedOrganizations.Text = "Selected Organizations:";
            // 
            // lblAvailableOrganizations
            // 
            this.lblAvailableOrganizations.AutoSize = true;
            this.lblAvailableOrganizations.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblAvailableOrganizations.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblAvailableOrganizations.Location = new System.Drawing.Point(27, 202);
            this.lblAvailableOrganizations.Name = "lblAvailableOrganizations";
            this.lblAvailableOrganizations.Size = new System.Drawing.Size(123, 13);
            this.lblAvailableOrganizations.TabIndex = 5;
            this.lblAvailableOrganizations.Text = "Available Organizations:";
            // 
            // AssociatedOrganizationsControl
            // 
            this.AutoScroll = true;
            this.Controls.Add(this.lblAvailableOrganizations);
            this.Controls.Add(this.lblSelectedOrganizations);
            this.Controls.Add(this.availableSelectedControl);
            this.Controls.Add(this.organizationSearchParameter);
            this.Controls.Add(this.btnUnassigned);
            this.Controls.Add(this.btnSearch);
            this.Name = "AssociatedOrganizationsControl";
            this.Size = new System.Drawing.Size(775, 488);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Button btnSearch;
        private Statline.Stattrac.Windows.Forms.Button btnUnassigned;
        private Statline.Stattrac.Windows.Controls.Common.OrganizationSearchParameter organizationSearchParameter;
        private Statline.Stattrac.Windows.Forms.AvailableSelectedControl availableSelectedControl;
        private Statline.Stattrac.Windows.Forms.Label lblSelectedOrganizations;
        private Statline.Stattrac.Windows.Forms.Label lblAvailableOrganizations;
    }
}
