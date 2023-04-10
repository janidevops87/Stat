namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    partial class FamilyServicesNavigation
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
            this.tabControl = new Statline.Stattrac.Windows.Forms.UltraTabControl();
            this.ultraTabSharedControlsPage1 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
            this.cbDisplayFS = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.label1 = new Statline.Stattrac.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).BeginInit();
            this.tabControl.SuspendLayout();
            this.SuspendLayout();
            // 
            // tabControl
            // 
            this.tabControl.Controls.Add(this.ultraTabSharedControlsPage1);
            this.tabControl.Location = new System.Drawing.Point(4, 33);
            this.tabControl.Name = "tabControl";
            this.tabControl.SharedControlsPage = this.ultraTabSharedControlsPage1;
            this.tabControl.Size = new System.Drawing.Size(879, 584);
            this.tabControl.TabIndex = 0;
            // 
            // ultraTabSharedControlsPage1
            // 
            this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(2, 21);
            this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
            this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(875, 561);
            // 
            // cbDisplayFS
            // 
            this.cbDisplayFS.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbDisplayFS.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbDisplayFS.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbDisplayFS.FormattingEnabled = true;
            this.cbDisplayFS.Location = new System.Drawing.Point(162, 12);
            this.cbDisplayFS.Name = "cbDisplayFS";
            this.cbDisplayFS.Size = new System.Drawing.Size(121, 21);
            this.cbDisplayFS.TabIndex = 6;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(14, 20);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(142, 13);
            this.label1.TabIndex = 5;
            this.label1.Text = "Display Family Services Tab:";
            //this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // FamilyServicesNavigation
            // 
            this.AutoScroll = true;
            this.Controls.Add(this.cbDisplayFS);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tabControl);
            this.Name = "FamilyServicesNavigation";
            this.Size = new System.Drawing.Size(979, 672);
            ((System.ComponentModel.ISupportInitialize)(this.tabControl)).EndInit();
            this.tabControl.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.UltraTabControl tabControl;
        private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;
        private Statline.Stattrac.Windows.Forms.ComboBox cbDisplayFS;
        private Statline.Stattrac.Windows.Forms.Label label1;
    }
}
