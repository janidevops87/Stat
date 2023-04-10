namespace Statline.Stattrac.Windows.UI.Controls
{
    partial class AddItemForm
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
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            this.textBox1 = new Statline.Stattrac.Windows.Forms.TextBox();
            this.btnSave = new Statline.Stattrac.Windows.Forms.Button();
            this.btnCancel = new Statline.Stattrac.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(1, 13);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Item to Add:";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(71, 10);
            this.textBox1.Name = "textBox1";
            this.textBox1.Required = false;
            this.textBox1.Size = new System.Drawing.Size(220, 20);
            this.textBox1.SpellCheckEnabled = false;
            this.textBox1.TabIndex = 1;
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(306, 7);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 23);
            this.btnSave.TabIndex = 2;
            this.btnSave.TabStop = false;
            this.btnSave.Text = "&Save";
            this.btnSave.UseVisualStyleBackColor = true;
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(306, 36);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 3;
            this.btnCancel.Text = "&Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            // 
            // AddItemForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(387, 64);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.textBox1);
            this.Controls.Add(this.label1);
            this.Name = "AddItemForm";
            this.Text = "Item to Add";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Label label1;
        private Statline.Stattrac.Windows.Forms.TextBox textBox1;
        private Statline.Stattrac.Windows.Forms.Button btnSave;
        private Statline.Stattrac.Windows.Forms.Button btnCancel;

    }
}