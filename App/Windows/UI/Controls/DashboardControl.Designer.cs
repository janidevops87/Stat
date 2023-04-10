namespace Statline.Stattrac.Windows.UI.Controls
{
	partial class DashboardControl
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
            Infragistics.Win.Appearance appearance2 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance1 = new Infragistics.Win.Appearance();
            this.tcDashboard = new Statline.Stattrac.Windows.Forms.UltraTabControl();
            this.ultraTabSharedControlsPage1 = new Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage();
            ((System.ComponentModel.ISupportInitialize)(this.tcDashboard)).BeginInit();
            this.tcDashboard.SuspendLayout();
            this.SuspendLayout();
            // 
            // tcDashboard
            // 
            appearance2.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(192)))));
            this.tcDashboard.ActiveTabAppearance = appearance2;
            this.tcDashboard.Controls.Add(this.ultraTabSharedControlsPage1);
            this.tcDashboard.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tcDashboard.Location = new System.Drawing.Point(0, 0);
            this.tcDashboard.Name = "tcDashboard";
            this.tcDashboard.SharedControlsPage = this.ultraTabSharedControlsPage1;
            this.tcDashboard.Size = new System.Drawing.Size(814, 533);
            this.tcDashboard.TabButtonStyle = Infragistics.Win.UIElementButtonStyle.Button3D;
            appearance1.BorderColor = System.Drawing.Color.White;
            appearance1.BorderColor3DBase = System.Drawing.Color.Black;
            this.tcDashboard.TabHeaderAreaAppearance = appearance1;
            this.tcDashboard.TabIndex = 0;
            this.tcDashboard.SelectedTabChanged += new Infragistics.Win.UltraWinTabControl.SelectedTabChangedEventHandler(this.tcDashboard_SelectedTabChanged);
            // 
            // ultraTabSharedControlsPage1
            // 
            this.ultraTabSharedControlsPage1.Location = new System.Drawing.Point(2, 21);
            this.ultraTabSharedControlsPage1.Name = "ultraTabSharedControlsPage1";
            this.ultraTabSharedControlsPage1.Size = new System.Drawing.Size(810, 510);
            // 
            // DashboardControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.Controls.Add(this.tcDashboard);
            this.Name = "DashboardControl";
            this.Size = new System.Drawing.Size(814, 533);
            ((System.ComponentModel.ISupportInitialize)(this.tcDashboard)).EndInit();
            this.tcDashboard.ResumeLayout(false);
            this.ResumeLayout(false);

		}

		#endregion

		private Statline.Stattrac.Windows.Forms.UltraTabControl tcDashboard;
		private Infragistics.Win.UltraWinTabControl.UltraTabSharedControlsPage ultraTabSharedControlsPage1;

	}
}
