namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    partial class QuestionAddEditControl
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
            this.ckDisplayAllQuestions = new Statline.Stattrac.Windows.Forms.CheckBox();
            this.lblQuestion = new Statline.Stattrac.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).BeginInit();
            this.splitContainer.Panel1.SuspendLayout();
            this.splitContainer.Panel2.SuspendLayout();
            this.splitContainer.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnAdd
            // 
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnDelete
            // 
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // ultraGrid
            // 
            this.ultraGrid.DisplayLayout.GroupByBox.Hidden = true;
            this.ultraGrid.DisplayLayout.Override.AllowColSwapping = Infragistics.Win.UltraWinGrid.AllowColSwapping.NotAllowed;
            this.ultraGrid.Location = new System.Drawing.Point(10, 33);
            this.ultraGrid.Size = new System.Drawing.Size(892, 280);
            this.ultraGrid.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.Search;
            this.ultraGrid.DoubleClick += new System.EventHandler(this.ultraGrid_DoubleClick);
            this.ultraGrid.InitializeLayout += new Infragistics.Win.UltraWinGrid.InitializeLayoutEventHandler(this.ultraGrid_InitializeLayout);
            // 
            // splitContainer
            // 
            // 
            // splitContainer.Panel1
            // 
            this.splitContainer.Panel1.Controls.Add(this.lblQuestion);
            this.splitContainer.Panel1.Controls.Add(this.ckDisplayAllQuestions);
            // 
            // ckDisplayAllQuestions
            // 
            this.ckDisplayAllQuestions.AutoSize = true;
            this.ckDisplayAllQuestions.Checked = false;
            this.ckDisplayAllQuestions.Location = new System.Drawing.Point(63, 171);
            this.ckDisplayAllQuestions.Name = "ckDisplayAllQuestions";
            this.ckDisplayAllQuestions.Size = new System.Drawing.Size(127, 17);
            this.ckDisplayAllQuestions.TabIndex = 0;
            this.ckDisplayAllQuestions.Text = "Display All Questions:";
            this.ckDisplayAllQuestions.UseVisualStyleBackColor = true;
            this.ckDisplayAllQuestions.CheckedChanged += new System.EventHandler(this.ckDisplayAllQuestions_CheckedChanged);
            // 
            // lblQuestion
            // 
            this.lblQuestion.AutoSize = true;
            this.lblQuestion.Location = new System.Drawing.Point(5, 171);
            this.lblQuestion.Name = "lblQuestion";
            this.lblQuestion.Size = new System.Drawing.Size(52, 13);
            this.lblQuestion.TabIndex = 1;
            this.lblQuestion.Text = "Question:";
            // 
            // QuestionAddEditControl
            // 
            this.ButtonDeleteVisible = true;
            this.ButtonSearchVisible = true;
            this.Name = "QuestionAddEditControl";
            this.Size = new System.Drawing.Size(913, 325);
            ((System.ComponentModel.ISupportInitialize)(this.ultraGrid)).EndInit();
            this.splitContainer.Panel1.ResumeLayout(false);
            this.splitContainer.Panel1.PerformLayout();
            this.splitContainer.Panel2.ResumeLayout(false);
            this.splitContainer.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.CheckBox ckDisplayAllQuestions;
        private Statline.Stattrac.Windows.Forms.Label lblQuestion;
       
    }
}
