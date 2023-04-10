namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class ContactRoleControl
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
            this.availableSelectedRoleControl = new Statline.Stattrac.Windows.Forms.AvailableSelectedControl();
            this.SuspendLayout();
            // 
            // availableSelectedRoleControl
            // 
            this.availableSelectedRoleControl.ColumnList = null;
            this.availableSelectedRoleControl.DataMember = null;
            this.availableSelectedRoleControl.DataSource = null;
            this.availableSelectedRoleControl.Dock = System.Windows.Forms.DockStyle.Fill;
            this.availableSelectedRoleControl.IdColumn = "";
            this.availableSelectedRoleControl.Location = new System.Drawing.Point(0, 0);
            this.availableSelectedRoleControl.Name = "availableSelectedRoleControl";
            this.availableSelectedRoleControl.Size = new System.Drawing.Size(600, 673);
            this.availableSelectedRoleControl.TabIndex = 0;
            this.availableSelectedRoleControl.TextAvailable = "Available";
            this.availableSelectedRoleControl.TextSelected = "Selected";
            // 
            // ContactRoleControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSize = true;
            this.Controls.Add(this.availableSelectedRoleControl);
            this.Name = "ContactRoleControl";
            this.Size = new System.Drawing.Size(600, 673);
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.AvailableSelectedControl availableSelectedRoleControl;
    }
}
