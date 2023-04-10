namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class DeleteCasesPopUp
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
            this.btnCancel = new Statline.Stattrac.Windows.Forms.Button();
            this.btnDeleteCase = new Statline.Stattrac.Windows.Forms.Button();
            this.textBox1 = new Statline.Stattrac.Windows.Forms.TextBox();
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(241, 141);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 4;
            this.btnCancel.Text = "&Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnDeleteCase
            // 
            this.btnDeleteCase.Location = new System.Drawing.Point(145, 141);
            this.btnDeleteCase.Name = "btnDeleteCase";
            this.btnDeleteCase.Size = new System.Drawing.Size(75, 23);
            this.btnDeleteCase.TabIndex = 3;
            this.btnDeleteCase.Text = "&Delete";
            this.btnDeleteCase.UseVisualStyleBackColor = true;
            this.btnDeleteCase.Click += new System.EventHandler(this.btnDeleteCase_Click);
            // 
            // textBox1
            // 
            this.textBox1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.textBox1.Location = new System.Drawing.Point(8, 43);
            this.textBox1.MaxLength = 255;
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Required = false;
            this.textBox1.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.textBox1.Size = new System.Drawing.Size(308, 92);
            this.textBox1.SpellCheckEnabled = false;
            this.textBox1.TabIndex = 5;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Tahoma", 8F);
            this.label1.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.label1.Location = new System.Drawing.Point(5, 27);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(107, 13);
            this.label1.TabIndex = 6;
            this.label1.Text = "Please enter reason:";
            // 
            // DeleteCasesPopUp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(323, 168);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnDeleteCase);
            this.Name = "DeleteCasesPopUp";
            this.Text = "Recycle Case Reason";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Button btnCancel;
        private Statline.Stattrac.Windows.Forms.Button btnDeleteCase;
        private Statline.Stattrac.Windows.Forms.TextBox textBox1;
        private Statline.Stattrac.Windows.Forms.Label label1;
    }
}