namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class OrganizationSearchControl
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
            this.chkDisplayAllOrganizations = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.organizationSearchParameter = new Statline.Stattrac.Windows.Controls.Common.OrganizationSearchParameter();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.Panel1.SuspendLayout();
            this.splitContainer.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnAdd
            // 
            this.btnAdd.Text = "New";
            // 
            // btnDelete
            // 
            this.btnDelete.TabStop = false;
            this.btnDelete.Text = "Delete";
            // 
            // btnSearch
            // 
            this.btnSearch.Text = "&Search";
            // 
            // ultraGrid
            // 
            this.ultraGrid.DisplayLayout.ForceSerialization = true;
            this.ultraGrid.MinimumSize = new System.Drawing.Size(500, 150);
            this.ultraGrid.Size = new System.Drawing.Size(800, 312);
            this.ultraGrid.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            // 
            // splitContainer
            // 
            // 
            // splitContainer.Panel1
            // 
            this.splitContainer.Panel1.Controls.Add(this.organizationSearchParameter);
            this.splitContainer.Panel1.Controls.Add(this.chkDisplayAllOrganizations);
            this.splitContainer.Panel1Collapsed = false;
            this.splitContainer.Panel1MinSize = 26;
            // 
            // splitContainer.Panel2
            // 
            this.splitContainer.Panel2.AutoScroll = false;
            this.splitContainer.Size = new System.Drawing.Size(800, 533);
            this.splitContainer.SplitterDistance = 195;
            this.splitContainer.SplitterWidth = 2;
            this.splitContainer.TabIndex = 0;
            // 
            // chkDisplayAllOrganizations
            // 
            this.chkDisplayAllOrganizations.AutoSize = true;
            this.chkDisplayAllOrganizations.Checked = false;
            this.chkDisplayAllOrganizations.Font = new System.Drawing.Font("Tahoma", 8F);
            this.chkDisplayAllOrganizations.Location = new System.Drawing.Point(133, 171);
            this.chkDisplayAllOrganizations.Name = "chkDisplayAllOrganizations";
            this.chkDisplayAllOrganizations.Size = new System.Drawing.Size(143, 17);
            this.chkDisplayAllOrganizations.TabIndex = 1;
            this.chkDisplayAllOrganizations.Text = "Display All Organizations";
            this.chkDisplayAllOrganizations.UseVisualStyleBackColor = true;
            // 
            // organizationSearchParameter
            // 
            this.organizationSearchParameter.BRSearchParameter = null;
            this.organizationSearchParameter.Location = new System.Drawing.Point(15, 3);
            this.organizationSearchParameter.Name = "organizationSearchParameter";
            this.organizationSearchParameter.Size = new System.Drawing.Size(623, 162);
            this.organizationSearchParameter.TabIndex = 0;
            // 
            // OrganizationSearchControl
            // 
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.MinimumSize = new System.Drawing.Size(702, 150);
            this.Name = "OrganizationSearchControl";
            this.RefreshOnVisible = false;
            this.Size = new System.Drawing.Size(800, 533);
            this.Controls.SetChildIndex(this.splitContainer, 0);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.Panel1.ResumeLayout(false);
            this.splitContainer.Panel1.PerformLayout();
            this.splitContainer.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.CheckBox chkDisplayAllOrganizations;
        private Statline.Stattrac.Windows.Controls.Common.OrganizationSearchParameter organizationSearchParameter;
    }
}
