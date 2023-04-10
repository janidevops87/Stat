namespace Statline.Stattrac.Windows.Controls.Organization
{
    partial class ContactCallInstructionsControl
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
            this.lblContactFirstName = new Statline.Stattrac.Windows.Forms.Label();
            this.chkPersonBusy = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.groupBox1 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.txtPersonNote = new Statline.Stattrac.Windows.Forms.TextBox();
            this.groupBox2 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.ultraDtPersonTempNoteExpires = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.txtPesonTempNote = new Statline.Stattrac.Windows.Forms.TextBox();
            this.chkPersonTempNoteActive = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.lblContactLastName = new Statline.Stattrac.Windows.Forms.Label();
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            this.ultraDtPersonBusyUntil = new Statline.Stattrac.Windows.Forms.UltraDateTimeEditor();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ultraDtPersonTempNoteExpires)).BeginInit();
            this.flowLayoutPanel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ultraDtPersonBusyUntil)).BeginInit();
            this.SuspendLayout();
            // 
            // lblContactFirstName
            // 
            this.lblContactFirstName.AutoSize = true;
            this.lblContactFirstName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblContactFirstName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblContactFirstName.Location = new System.Drawing.Point(3, 0);
            this.lblContactFirstName.Margin = new System.Windows.Forms.Padding(3, 0, 0, 0);
            this.lblContactFirstName.Name = "lblContactFirstName";
            this.lblContactFirstName.Size = new System.Drawing.Size(20, 13);
            this.lblContactFirstName.TabIndex = 0;
            this.lblContactFirstName.Text = "FN";
            // 
            // chkPersonBusy
            // 
            this.chkPersonBusy.AutoSize = true;
            this.chkPersonBusy.Checked = false;
            this.chkPersonBusy.Font = new System.Drawing.Font("Tahoma", 8F);
            this.chkPersonBusy.Location = new System.Drawing.Point(12, 32);
            this.chkPersonBusy.Name = "chkPersonBusy";
            this.chkPersonBusy.Size = new System.Drawing.Size(85, 17);
            this.chkPersonBusy.TabIndex = 0;
            this.chkPersonBusy.Text = "Is Busy Until";
            this.chkPersonBusy.UseVisualStyleBackColor = true;
            this.chkPersonBusy.CheckStateChanged += new System.EventHandler(this.chkPersonBusy_CheckedChanged);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.txtPersonNote);
            this.groupBox1.Location = new System.Drawing.Point(6, 55);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(564, 215);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Permanent Call Instructions";
            // 
            // txtPersonNote
            // 
            this.txtPersonNote.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtPersonNote.Location = new System.Drawing.Point(6, 19);
            this.txtPersonNote.Multiline = true;
            this.txtPersonNote.Name = "txtPersonNote";
            this.txtPersonNote.Required = false;
            this.txtPersonNote.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtPersonNote.Size = new System.Drawing.Size(552, 190);
            this.txtPersonNote.SpellCheckEnabled = false;
            this.txtPersonNote.TabIndex = 0;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.ultraDtPersonTempNoteExpires);
            this.groupBox2.Controls.Add(this.txtPesonTempNote);
            this.groupBox2.Controls.Add(this.chkPersonTempNoteActive);
            this.groupBox2.Location = new System.Drawing.Point(6, 274);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(564, 215);
            this.groupBox2.TabIndex = 4;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Temporary Call Instructions";
            // 
            // ultraDtPersonTempNoteExpires
            // 
            this.ultraDtPersonTempNoteExpires.AutoSize = false;
            this.ultraDtPersonTempNoteExpires.InvalidTextBehavior = Infragistics.Win.UltraWinEditors.InvalidTextBehavior.RevertToOriginalValue;
            this.ultraDtPersonTempNoteExpires.Location = new System.Drawing.Point(184, 18);
            this.ultraDtPersonTempNoteExpires.MaskInput = "mm/dd/yyyy hh:mm";
            this.ultraDtPersonTempNoteExpires.Name = "ultraDtPersonTempNoteExpires";
            this.ultraDtPersonTempNoteExpires.Size = new System.Drawing.Size(144, 19);
            this.ultraDtPersonTempNoteExpires.TabIndex = 3;
            this.ultraDtPersonTempNoteExpires.Validating += new System.ComponentModel.CancelEventHandler(this.ultraDtPersonTempNoteExpires_Validating);
            // 
            // txtPesonTempNote
            // 
            this.txtPesonTempNote.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Left | System.Windows.Forms.AnchorStyles.Right)));
            this.txtPesonTempNote.Font = new System.Drawing.Font("Tahoma", 8F);
            this.txtPesonTempNote.Location = new System.Drawing.Point(6, 43);
            this.txtPesonTempNote.Multiline = true;
            this.txtPesonTempNote.Name = "txtPesonTempNote";
            this.txtPesonTempNote.Required = false;
            this.txtPesonTempNote.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.txtPesonTempNote.Size = new System.Drawing.Size(551, 166);
            this.txtPesonTempNote.SpellCheckEnabled = false;
            this.txtPesonTempNote.TabIndex = 2;
            // 
            // chkPersonTempNoteActive
            // 
            this.chkPersonTempNoteActive.AutoSize = true;
            this.chkPersonTempNoteActive.Checked = false;
            this.chkPersonTempNoteActive.Font = new System.Drawing.Font("Tahoma", 8F);
            this.chkPersonTempNoteActive.Location = new System.Drawing.Point(7, 20);
            this.chkPersonTempNoteActive.Name = "chkPersonTempNoteActive";
            this.chkPersonTempNoteActive.Size = new System.Drawing.Size(171, 17);
            this.chkPersonTempNoteActive.TabIndex = 0;
            this.chkPersonTempNoteActive.Text = "Temporary Instructions Expire";
            this.chkPersonTempNoteActive.UseVisualStyleBackColor = true;
            this.chkPersonTempNoteActive.CheckedChanged += new System.EventHandler(this.chkPersonTempNoteActive_CheckedChanged);
            // 
            // lblContactLastName
            // 
            this.lblContactLastName.AutoSize = true;
            this.lblContactLastName.Font = new System.Drawing.Font("Tahoma", 8F);
            this.lblContactLastName.LabelStyle = Statline.Stattrac.Windows.Forms.LabelStyle.None;
            this.lblContactLastName.Location = new System.Drawing.Point(23, 0);
            this.lblContactLastName.Margin = new System.Windows.Forms.Padding(0, 0, 3, 0);
            this.lblContactLastName.Name = "lblContactLastName";
            this.lblContactLastName.Size = new System.Drawing.Size(19, 13);
            this.lblContactLastName.TabIndex = 0;
            this.lblContactLastName.Text = "LN";
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.flowLayoutPanel1.Controls.Add(this.lblContactFirstName);
            this.flowLayoutPanel1.Controls.Add(this.lblContactLastName);
            this.flowLayoutPanel1.Location = new System.Drawing.Point(6, 11);
            this.flowLayoutPanel1.Margin = new System.Windows.Forms.Padding(0, 3, 3, 3);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(230, 13);
            this.flowLayoutPanel1.TabIndex = 8;
            // 
            // ultraDtPersonBusyUntil
            // 
            this.ultraDtPersonBusyUntil.AutoSize = false;
            this.ultraDtPersonBusyUntil.InvalidTextBehavior = Infragistics.Win.UltraWinEditors.InvalidTextBehavior.PreserveWhileInEditMode;
            this.ultraDtPersonBusyUntil.Location = new System.Drawing.Point(190, 32);
            this.ultraDtPersonBusyUntil.MaskInput = "mm/dd/yyyy hh:mm";
            this.ultraDtPersonBusyUntil.Name = "ultraDtPersonBusyUntil";
            this.ultraDtPersonBusyUntil.Size = new System.Drawing.Size(144, 19);
            this.ultraDtPersonBusyUntil.TabIndex = 9;
            this.ultraDtPersonBusyUntil.Validating += new System.ComponentModel.CancelEventHandler(this.ultraDtPersonBusyUntil_Validating);
            // 
            // ContactCallInstructionsControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoSize = true;
            this.Controls.Add(this.ultraDtPersonBusyUntil);
            this.Controls.Add(this.flowLayoutPanel1);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.chkPersonBusy);
            this.Name = "ContactCallInstructionsControl";
            this.Size = new System.Drawing.Size(574, 526);
            this.Validating += new System.ComponentModel.CancelEventHandler(this.ContactCallInstructionsControl_Validating);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ultraDtPersonTempNoteExpires)).EndInit();
            this.flowLayoutPanel1.ResumeLayout(false);
            this.flowLayoutPanel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.ultraDtPersonBusyUntil)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Label lblContactFirstName;
        private Statline.Stattrac.Windows.Forms.CheckBox chkPersonBusy;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox1;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox2;
        private Statline.Stattrac.Windows.Forms.CheckBox chkPersonTempNoteActive;
        private Statline.Stattrac.Windows.Forms.Label lblContactLastName;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
        private Statline.Stattrac.Windows.Forms.TextBox txtPersonNote;
        private Statline.Stattrac.Windows.Forms.TextBox txtPesonTempNote;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor ultraDtPersonBusyUntil;
        private Statline.Stattrac.Windows.Forms.UltraDateTimeEditor ultraDtPersonTempNoteExpires;
    }
}
