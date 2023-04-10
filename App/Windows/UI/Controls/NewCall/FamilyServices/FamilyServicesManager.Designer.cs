namespace Statline.Stattrac.Windows.UI.Controls.NewCall.FamilyServices
{
	partial class FamilyServicesManager
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
			Infragistics.Win.UltraWinTabControl.UltraTab ultraTab1 = new Infragistics.Win.UltraWinTabControl.UltraTab();
			this.ultraTabControl1 = new Statline.Stattrac.Windows.Forms.UltraTabControl();
			this.ultraTabSharedControlsPage1 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
			this.ultraTabPageControl1 = new Infragistics.Win.UltraWinTabControl.UltraTabPageControl();
			this.caseStatusControl = new Statline.Stattrac.Windows.UI.Controls.NewCall.FamilyServices.CaseStatusControl();
			this.MainBody.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.ultraTabControl1)).BeginInit();
			this.ultraTabControl1.SuspendLayout();
			this.ultraTabPageControl1.SuspendLayout();
			this.SuspendLayout();
			// 
			// pnlBody
			// 
			this.MainBody.Controls.Add(this.ultraTabControl1);
			this.MainBody.Size = new System.Drawing.Size(900, 572);
			// 
			// ultraTabControl1
			// 
			this.ultraTabControl1.Controls.Add(this.ultraTabSharedControlsPage1);
			this.ultraTabControl1.Controls.Add(this.ultraTabPageControl1);
			this.ultraTabControl1.Dock = System.Windows.Forms.DockStyle.Fill;
			this.ultraTabControl1.Location = new System.Drawing.Point(0, 0);
			this.ultraTabControl1.Name = "ultraTabControl1";
			this.ultraTabControl1.SharedControlsPage = this.ultraTabSharedControlsPage1;
			this.ultraTabControl1.Size = new System.Drawing.Size(900, 572);
			this.ultraTabControl1.TabIndex = 0;
			ultraTab1.TabPage = this.ultraTabPageControl1;
			ultraTab1.Text = "Case Status";
			this.ultraTabControl1.Tabs.AddRange(new Infragistics.Win.UltraWinTabControl.UltraTab[] {
            ultraTab1});
			// 
			// ultraTabSharedControlsPage1
			// 
			this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(-10000, -10000);
			this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
			this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(896, 546);
			// 
			// ultraTabPageControl1
			// 
			this.ultraTabPageControl1.Controls.Add(this.caseStatusControl);
			this.ultraTabPageControl1.Location = new System.Drawing.Point(1, 23);
			this.ultraTabPageControl1.Name = "ultraTabPageControl1";
			this.ultraTabPageControl1.Size = new System.Drawing.Size(896, 546);
			// 
			// caseStatusControl
			// 
			this.caseStatusControl.Dock = System.Windows.Forms.DockStyle.Fill;
			this.caseStatusControl.Location = new System.Drawing.Point(0, 0);
			this.caseStatusControl.Name = "caseStatusControl";
			this.caseStatusControl.Size = new System.Drawing.Size(896, 546);
			this.caseStatusControl.TabIndex = 0;
			// 
			// FamilyServicesManager
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.Name = "FamilyServicesManager";
			this.Size = new System.Drawing.Size(900, 572);
			this.MainBody.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.ultraTabControl1)).EndInit();
			this.ultraTabControl1.ResumeLayout(false);
			this.ultraTabPageControl1.ResumeLayout(false);
			this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraTabControl ultraTabControl1;
		private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;
		private Infragistics.Win.UltraWinTabControl.UltraTabPageControl ultraTabPageControl1;
		private CaseStatusControl caseStatusControl;

	}
}
