namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class ContactPermissionControl
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
            this.availableSelectedRole = new Statline.Stattrac.Windows.Forms.AvailableSelectedControl();
            this.SuspendLayout();
            // 
            // availableSelectedRole
            // 
            this.availableSelectedRole.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.availableSelectedRole.ColumnList = null;
            this.availableSelectedRole.DataMember = null;
            this.availableSelectedRole.DataSource = null;
            this.availableSelectedRole.Dock = System.Windows.Forms.DockStyle.Fill;
            this.availableSelectedRole.IdColumn = "";
            this.availableSelectedRole.Location = new System.Drawing.Point(0, 0);
            this.availableSelectedRole.Name = "availableSelectedRole";
            this.availableSelectedRole.Size = new System.Drawing.Size(600, 673);
            this.availableSelectedRole.TabIndex = 0;
            this.availableSelectedRole.TextAvailable = "Available";
            this.availableSelectedRole.TextSelected = "Selected";
            // 
            // ContactPermissionControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.availableSelectedRole);
            this.Name = "ContactPermissionControl";
            this.Size = new System.Drawing.Size(600, 673);
            this.ResumeLayout(false);

        }

        #endregion

        public Statline.Stattrac.Windows.Forms.AvailableSelectedControl availableSelectedRole;
    }
}
