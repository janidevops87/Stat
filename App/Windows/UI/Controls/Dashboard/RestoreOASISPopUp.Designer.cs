namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class RestoreOASISPopUp
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
            this.btnRestoreCase = new Statline.Stattrac.Windows.Forms.Button();
            this.lblOrganData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMatchIDData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblOPTNData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblOasisNoData = new Statline.Stattrac.Windows.Forms.Label();
            this.lblOrgan = new Statline.Stattrac.Windows.Forms.Label();
            this.lblMatchID = new Statline.Stattrac.Windows.Forms.Label();
            this.lblOPTN = new Statline.Stattrac.Windows.Forms.Label();
            this.lblOasisNo = new Statline.Stattrac.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(118, 122);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 26;
            this.btnCancel.Text = "&Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnRestoreCase
            // 
            this.btnRestoreCase.Location = new System.Drawing.Point(18, 122);
            this.btnRestoreCase.Name = "btnRestoreCase";
            this.btnRestoreCase.Size = new System.Drawing.Size(75, 23);
            this.btnRestoreCase.TabIndex = 25;
            this.btnRestoreCase.Text = "&Restore Case";
            this.btnRestoreCase.UseVisualStyleBackColor = true;
            this.btnRestoreCase.Click += new System.EventHandler(this.btnRestoreCase_Click);
            // 
            // lblOrganData
            // 
            this.lblOrganData.AutoSize = true;
            this.lblOrganData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOrganData.Location = new System.Drawing.Point(98, 75);
            this.lblOrganData.Name = "lblOrganData";
            this.lblOrganData.Size = new System.Drawing.Size(35, 13);
            this.lblOrganData.TabIndex = 34;
            this.lblOrganData.Text = "label7";
            // 
            // lblMatchIDData
            // 
            this.lblMatchIDData.AutoSize = true;
            this.lblMatchIDData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMatchIDData.Location = new System.Drawing.Point(98, 58);
            this.lblMatchIDData.Name = "lblMatchIDData";
            this.lblMatchIDData.Size = new System.Drawing.Size(35, 13);
            this.lblMatchIDData.TabIndex = 33;
            this.lblMatchIDData.Text = "label8";
            // 
            // lblOPTNData
            // 
            this.lblOPTNData.AutoSize = true;
            this.lblOPTNData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOPTNData.Location = new System.Drawing.Point(98, 41);
            this.lblOPTNData.Name = "lblOPTNData";
            this.lblOPTNData.Size = new System.Drawing.Size(25, 13);
            this.lblOPTNData.TabIndex = 32;
            this.lblOPTNData.Text = "999";
            // 
            // lblOasisNoData
            // 
            this.lblOasisNoData.AutoSize = true;
            this.lblOasisNoData.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOasisNoData.Location = new System.Drawing.Point(98, 24);
            this.lblOasisNoData.Name = "lblOasisNoData";
            this.lblOasisNoData.Size = new System.Drawing.Size(41, 13);
            this.lblOasisNoData.TabIndex = 31;
            this.lblOasisNoData.Text = "label10";
            // 
            // lblOrgan
            // 
            this.lblOrgan.AutoSize = true;
            this.lblOrgan.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOrgan.Location = new System.Drawing.Point(25, 75);
            this.lblOrgan.Name = "lblOrgan";
            this.lblOrgan.Size = new System.Drawing.Size(39, 13);
            this.lblOrgan.TabIndex = 30;
            this.lblOrgan.Text = "Organ:";
            // 
            // lblMatchID
            // 
            this.lblMatchID.AutoSize = true;
            this.lblMatchID.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblMatchID.Location = new System.Drawing.Point(25, 58);
            this.lblMatchID.Name = "lblMatchID";
            this.lblMatchID.Size = new System.Drawing.Size(54, 13);
            this.lblMatchID.TabIndex = 29;
            this.lblMatchID.Text = "Match ID:";
            // 
            // lblOPTN
            // 
            this.lblOPTN.AutoSize = true;
            this.lblOPTN.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOPTN.Location = new System.Drawing.Point(25, 41);
            this.lblOPTN.Name = "lblOPTN";
            this.lblOPTN.Size = new System.Drawing.Size(50, 13);
            this.lblOPTN.TabIndex = 28;
            this.lblOPTN.Text = "OPTN #:";
            // 
            // lblOasisNo
            // 
            this.lblOasisNo.AutoSize = true;
            this.lblOasisNo.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblOasisNo.Location = new System.Drawing.Point(25, 24);
            this.lblOasisNo.Name = "lblOasisNo";
            this.lblOasisNo.Size = new System.Drawing.Size(52, 13);
            this.lblOasisNo.TabIndex = 27;
            this.lblOasisNo.Text = "OASIS #:";
            // 
            // RestoreOASIS
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(213, 177);
            this.Controls.Add(this.lblOrganData);
            this.Controls.Add(this.lblMatchIDData);
            this.Controls.Add(this.lblOPTNData);
            this.Controls.Add(this.lblOasisNoData);
            this.Controls.Add(this.lblOrgan);
            this.Controls.Add(this.lblMatchID);
            this.Controls.Add(this.lblOPTN);
            this.Controls.Add(this.lblOasisNo);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnRestoreCase);
            this.Name = "RestoreOASIS";
            this.Text = "View Recycled Case";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Button btnCancel;
        private Statline.Stattrac.Windows.Forms.Button btnRestoreCase;
        private Statline.Stattrac.Windows.Forms.Label lblOrganData;
        private Statline.Stattrac.Windows.Forms.Label lblMatchIDData;
        private Statline.Stattrac.Windows.Forms.Label lblOPTNData;
        private Statline.Stattrac.Windows.Forms.Label lblOasisNoData;
        private Statline.Stattrac.Windows.Forms.Label lblOrgan;
        private Statline.Stattrac.Windows.Forms.Label lblMatchID;
        private Statline.Stattrac.Windows.Forms.Label lblOPTN;
        private Statline.Stattrac.Windows.Forms.Label lblOasisNo;
    }
}