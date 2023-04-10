namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    partial class ReferralEventLogControl
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
            this.groupBox2 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            this.lblInclude = new Statline.Stattrac.Windows.Forms.Label();
            this.cbInclude = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.availableSelectedControl2 = new Statline.Stattrac.Windows.Forms.AvailableSelectedControl();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Controls.Add(this.lblInclude);
            this.groupBox2.Controls.Add(this.cbInclude);
            this.groupBox2.Controls.Add(this.availableSelectedControl2);
            this.groupBox2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.Location = new System.Drawing.Point(3, 19);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(836, 528);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Referral Event Log Configuration";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(61, 57);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(144, 13);
            this.label1.TabIndex = 3;
            this.label1.Text = "Shortened Configuration";
            // 
            // lblInclude
            // 
            this.lblInclude.AutoSize = true;
            this.lblInclude.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblInclude.Location = new System.Drawing.Point(64, 26);
            this.lblInclude.Name = "lblInclude";
            this.lblInclude.Size = new System.Drawing.Size(99, 13);
            this.lblInclude.TabIndex = 2;
            this.lblInclude.Text = "Configuration Type:";
            // 
            // cbInclude
            // 
            this.cbInclude.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbInclude.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbInclude.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbInclude.FormattingEnabled = true;
            this.cbInclude.Location = new System.Drawing.Point(178, 19);
            this.cbInclude.Name = "cbInclude";
            this.cbInclude.Size = new System.Drawing.Size(171, 21);
            this.cbInclude.TabIndex = 1;
            this.cbInclude.SelectedIndexChanged += new System.EventHandler(this.cbInclude_SelectedIndexChanged);
            // 
            // availableSelectedControl2
            // 
            this.availableSelectedControl2.ColumnList = null;
            this.availableSelectedControl2.DataMember = "";
            this.availableSelectedControl2.DataSource = null;
            this.availableSelectedControl2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.availableSelectedControl2.IdColumn = "";
            this.availableSelectedControl2.Location = new System.Drawing.Point(64, 84);
            this.availableSelectedControl2.Name = "availableSelectedControl2";
            this.availableSelectedControl2.Size = new System.Drawing.Size(680, 438);
            this.availableSelectedControl2.TabIndex = 0;
            this.availableSelectedControl2.TextAvailable = "";
            this.availableSelectedControl2.TextSelected = "";
            // 
            // ReferralEventLogControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.Controls.Add(this.groupBox2);
            this.Name = "ReferralEventLogControl";
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.GroupBox groupBox2;
        private Statline.Stattrac.Windows.Forms.AvailableSelectedControl availableSelectedControl2;
        private Statline.Stattrac.Windows.Forms.Label lblInclude;
        private Statline.Stattrac.Windows.Forms.ComboBox cbInclude;
        private Statline.Stattrac.Windows.Forms.Label label1;
    }
}
