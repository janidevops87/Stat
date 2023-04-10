namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class OrganizationDeleteControl
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
            this.panel1 = new Statline.Stattrac.Windows.Forms.Panel();
            this.pnlDefaultNote = new Statline.Stattrac.Windows.Forms.Panel();
            this.lblDefaultMessage = new Statline.Stattrac.Windows.Forms.Label();
            this.panel2 = new Statline.Stattrac.Windows.Forms.Panel();
            this.lblHeader = new Statline.Stattrac.Windows.Forms.Label();
            this.organizationAssociatedCall = new Statline.Stattrac.Windows.Controls.Organization.OrganizationAssociatedCall();
            this.panel1.SuspendLayout();
            this.pnlDefaultNote.SuspendLayout();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.organizationAssociatedCall);
            this.panel1.Controls.Add(this.pnlDefaultNote);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 60);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(575, 349);
            this.panel1.TabIndex = 1;
            // 
            // pnlDefaultNote
            // 
            this.pnlDefaultNote.Controls.Add(this.lblDefaultMessage);
            this.pnlDefaultNote.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlDefaultNote.Location = new System.Drawing.Point(0, 0);
            this.pnlDefaultNote.Name = "pnlDefaultNote";
            this.pnlDefaultNote.Size = new System.Drawing.Size(575, 349);
            this.pnlDefaultNote.TabIndex = 2;
            this.pnlDefaultNote.Visible = false;
            // 
            // lblDefaultMessage
            // 
            this.lblDefaultMessage.AutoSize = true;
            this.lblDefaultMessage.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblDefaultMessage.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblDefaultMessage.Location = new System.Drawing.Point(3, 28);
            this.lblDefaultMessage.Name = "lblDefaultMessage";
            this.lblDefaultMessage.Size = new System.Drawing.Size(295, 13);
            this.lblDefaultMessage.TabIndex = 1;
            this.lblDefaultMessage.Text = "Searching for Calls associated to Organization <OrgName>.";
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.lblHeader);
            this.panel2.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel2.Location = new System.Drawing.Point(0, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(575, 60);
            this.panel2.TabIndex = 2;
            // 
            // lblHeader
            // 
            this.lblHeader.Dock = System.Windows.Forms.DockStyle.Fill;
            this.lblHeader.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblHeader.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblHeader.Location = new System.Drawing.Point(0, 0);
            this.lblHeader.Name = "lblHeader";
            this.lblHeader.Size = new System.Drawing.Size(575, 60);
            this.lblHeader.TabIndex = 0;
            this.lblHeader.Text = "Text for current Organization";
            this.lblHeader.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            // 
            // organizationAssociatedCall
            // 
            this.organizationAssociatedCall.Dock = System.Windows.Forms.DockStyle.Fill;
            this.organizationAssociatedCall.Enabled = false;
            this.organizationAssociatedCall.Location = new System.Drawing.Point(0, 0);
            this.organizationAssociatedCall.Name = "organizationAssociatedCall";
            this.organizationAssociatedCall.Size = new System.Drawing.Size(575, 349);
            this.organizationAssociatedCall.TabIndex = 0;
            // 
            // OrganizationDeleteControl
            // 
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.panel2);
            this.Name = "OrganizationDeleteControl";
            this.Size = new System.Drawing.Size(575, 384);
            this.panel1.ResumeLayout(false);
            this.pnlDefaultNote.ResumeLayout(false);
            this.pnlDefaultNote.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private OrganizationAssociatedCall organizationAssociatedCall;
        private Statline.Stattrac.Windows.Forms.Panel panel1;
        private Statline.Stattrac.Windows.Forms.Panel panel2;
        private Statline.Stattrac.Windows.Forms.Label lblHeader;
        private Statline.Stattrac.Windows.Forms.Label lblDefaultMessage;
        private Statline.Stattrac.Windows.Forms.Panel pnlDefaultNote;

    }
}