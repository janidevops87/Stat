namespace Statline.Stattrac.Windows.UI
{
    partial class AddItemControl
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
            this.btnCancel = new Statline.Stattrac.Windows.Forms.Button();
            this.btnSave = new Statline.Stattrac.Windows.Forms.Button();
            this.textBox1 = new Statline.Stattrac.Windows.Forms.TextBox();
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(312, 32);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 7;
            this.btnCancel.Text = "&Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(312, 3);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 23);
            this.btnSave.TabIndex = 6;
            this.btnSave.TabStop = false;
            this.btnSave.Text = "&Add";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(77, 6);
            this.textBox1.Name = "textBox1";
            this.textBox1.Required = false;
            this.textBox1.Size = new System.Drawing.Size(220, 20);
            this.textBox1.SpellCheckEnabled = false;
            this.textBox1.TabIndex = 5;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(7, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 13);
            this.label1.TabIndex = 4;
            this.label1.Text = "Item to Add:";
            // 
            // AddItemControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ActiveBorder;
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.label1);
            this.ForeColor = System.Drawing.SystemColors.WindowText;
            this.Name = "AddItemControl";
            this.Size = new System.Drawing.Size(393, 59);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Button btnCancel;
        private Statline.Stattrac.Windows.Forms.Button btnSave;
        private Statline.Stattrac.Windows.Forms.TextBox textBox1;
        private Statline.Stattrac.Windows.Forms.Label label1;


    }
}
