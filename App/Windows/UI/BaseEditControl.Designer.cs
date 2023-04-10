namespace Statline.Stattrac.Windows.UI
{
	partial class BaseEditControl
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
            this.components = new System.ComponentModel.Container();
            this.ultraSpellChecker = new Statline.Stattrac.Windows.Forms.UltraSpellChecker(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.ultraSpellChecker)).BeginInit();
            this.SuspendLayout();
            // 
            // ultraSpellChecker
            // 
            this.ultraSpellChecker.ContainingControl = this;
            // 
            // BaseEditControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoScroll = true;
            this.AutoScrollMargin = new System.Drawing.Size(0, 30);
            this.AutoValidate = System.Windows.Forms.AutoValidate.EnableAllowFocusChange;
            this.Name = "BaseEditControl";
            this.Size = new System.Drawing.Size(876, 585);
            this.Load += new System.EventHandler(this.BaseEditControl_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ultraSpellChecker)).EndInit();
            this.ResumeLayout(false);

		}

		#endregion

        private Statline.Stattrac.Windows.Forms.UltraSpellChecker ultraSpellChecker;





    }
}
