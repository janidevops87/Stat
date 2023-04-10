namespace Statline.Stattrac.Windows.UI
{
	partial class BaseManagerControl
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
            this.pnlFooter = new Statline.Stattrac.Windows.Forms.Panel();
            this.btnSave = new Statline.Stattrac.Windows.Forms.Button();
            this.btnCancel = new Statline.Stattrac.Windows.Forms.Button();
            this.pnlBody = new Statline.Stattrac.Windows.Forms.Panel();
            this.pnlFooter.SuspendLayout();
            this.SuspendLayout();
            // 
            // pnlFooter
            // 
            this.pnlFooter.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.pnlFooter.Controls.Add(this.btnSave);
            this.pnlFooter.Controls.Add(this.btnCancel);
            this.pnlFooter.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.pnlFooter.Location = new System.Drawing.Point(0, 475);
            this.pnlFooter.Name = "pnlFooter";
            this.pnlFooter.Padding = new System.Windows.Forms.Padding(1);
            this.pnlFooter.Size = new System.Drawing.Size(843, 26);
            this.pnlFooter.TabIndex = 900;
            this.pnlFooter.TabStop = true;
            // 
            // btnSave
            // 
            this.btnSave.Dock = System.Windows.Forms.DockStyle.Right;
            this.btnSave.Location = new System.Drawing.Point(763, 1);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 20);
            this.btnSave.TabIndex = 1;
            this.btnSave.Text = "Close";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Dock = System.Windows.Forms.DockStyle.Left;
            this.btnCancel.Location = new System.Drawing.Point(1, 1);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 20);
            this.btnCancel.TabIndex = 0;
            this.btnCancel.Text = "&Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // pnlBody
            // 
            this.pnlBody.Dock = System.Windows.Forms.DockStyle.Fill;
            this.pnlBody.Location = new System.Drawing.Point(0, 0);
            this.pnlBody.Name = "pnlBody";
            this.pnlBody.Padding = new System.Windows.Forms.Padding(0, 0, 0, 26);
            this.pnlBody.Size = new System.Drawing.Size(843, 501);
            this.pnlBody.TabIndex = 2;
            this.pnlBody.TabStop = true;
            // 
            // BaseManagerControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.pnlFooter);
            this.Controls.Add(this.pnlBody);
            this.Name = "BaseManagerControl";
            this.Size = new System.Drawing.Size(843, 501);
            this.Load += new System.EventHandler(this.BaseManagerControl_Load);
            this.pnlFooter.ResumeLayout(false);
            this.ResumeLayout(false);

		}

		#endregion

        public Statline.Stattrac.Windows.Forms.Button btnSave;
		private Statline.Stattrac.Windows.Forms.Panel pnlFooter;
        private Statline.Stattrac.Windows.Forms.Button btnCancel;
        public Statline.Stattrac.Windows.Forms.Panel pnlBody;


	}
}
