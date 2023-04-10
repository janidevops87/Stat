namespace Statline.Stattrac.Windows.UI.Controls.Administration.Question
{
    partial class QuestionConfigurationControl
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
            this.lblScreenQuestions = new Statline.Stattrac.Windows.Forms.Label();
            this.cbScreen = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.groupBox1 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.cbTime = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblTime = new Statline.Stattrac.Windows.Forms.Label();
            this.cbResponse = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbRequire = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblResponse = new Statline.Stattrac.Windows.Forms.Label();
            this.lblRequire = new Statline.Stattrac.Windows.Forms.Label();
            this.groupBox3 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.txtTimeTo = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblTo = new Statline.Stattrac.Windows.Forms.Label();
            this.txtTimeFrom = new Statline.Stattrac.Windows.Forms.TextBox();
            this.lblTimeRange = new Statline.Stattrac.Windows.Forms.Label();
            this.cbDateTimeType = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblDateType = new Statline.Stattrac.Windows.Forms.Label();
            this.lblTimeSettings4 = new Statline.Stattrac.Windows.Forms.Label();
            this.lblTimeSettings3 = new Statline.Stattrac.Windows.Forms.Label();
            this.lblTimeSettings2 = new Statline.Stattrac.Windows.Forms.Label();
            this.lblTimeSettings1 = new Statline.Stattrac.Windows.Forms.Label();
            this.groupBox2 = new Statline.Stattrac.Windows.Forms.GroupBox();
            this.availableSelectedControl1 = new Statline.Stattrac.Windows.Forms.AvailableSelectedControl();
            this.lblFields = new Statline.Stattrac.Windows.Forms.Label();
            this.cbOnce = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblOnce = new Statline.Stattrac.Windows.Forms.Label();
            this.cbAskonUpdate = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.cbAskonInit = new Statline.Stattrac.Windows.Forms.ComboBox();
            this.lblAskonUpdate = new Statline.Stattrac.Windows.Forms.Label();
            this.lblAskonInt = new Statline.Stattrac.Windows.Forms.Label();
            this.baseUserControl1 = new Statline.Stattrac.Windows.UI.BaseUserControl();
            this.baseUserControl2 = new Statline.Stattrac.Windows.UI.BaseUserControl();
            this.baseUserControl3 = new Statline.Stattrac.Windows.UI.BaseUserControl();
            this.groupBox1.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblScreenQuestions
            // 
            this.lblScreenQuestions.AutoSize = true;
            this.lblScreenQuestions.Location = new System.Drawing.Point(4, 4);
            this.lblScreenQuestions.Name = "lblScreenQuestions";
            this.lblScreenQuestions.Size = new System.Drawing.Size(184, 13);
            this.lblScreenQuestions.TabIndex = 0;
            this.lblScreenQuestions.Text = "Screen Where Question(s) Displayed:";
            // 
            // cbScreen
            // 
            this.cbScreen.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbScreen.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbScreen.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbScreen.FormattingEnabled = true;
            this.cbScreen.Location = new System.Drawing.Point(188, 0);
            this.cbScreen.Name = "cbScreen";
            this.cbScreen.Size = new System.Drawing.Size(339, 21);
            this.cbScreen.TabIndex = 1;
            this.cbScreen.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.cbTime);
            this.groupBox1.Controls.Add(this.lblTime);
            this.groupBox1.Controls.Add(this.cbResponse);
            this.groupBox1.Controls.Add(this.cbRequire);
            this.groupBox1.Controls.Add(this.lblResponse);
            this.groupBox1.Controls.Add(this.lblRequire);
            this.groupBox1.Controls.Add(this.groupBox3);
            this.groupBox1.Controls.Add(this.groupBox2);
            this.groupBox1.Controls.Add(this.cbAskonUpdate);
            this.groupBox1.Controls.Add(this.cbAskonInit);
            this.groupBox1.Controls.Add(this.lblAskonUpdate);
            this.groupBox1.Controls.Add(this.lblAskonInt);
            this.groupBox1.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(7, 21);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(820, 542);
            this.groupBox1.TabIndex = 2;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Question Timing";
            // 
            // cbTime
            // 
            this.cbTime.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbTime.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbTime.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbTime.FormattingEnabled = true;
            this.cbTime.Location = new System.Drawing.Point(149, 341);
            this.cbTime.Name = "cbTime";
            this.cbTime.Size = new System.Drawing.Size(121, 21);
            this.cbTime.TabIndex = 11;
            // 
            // lblTime
            // 
            this.lblTime.AutoSize = true;
            this.lblTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTime.Location = new System.Drawing.Point(49, 344);
            this.lblTime.Name = "lblTime";
            this.lblTime.Size = new System.Drawing.Size(102, 13);
            this.lblTime.TabIndex = 10;
            this.lblTime.Text = "Ask Based on Time:";
            // 
            // cbResponse
            // 
            this.cbResponse.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbResponse.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbResponse.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbResponse.FormattingEnabled = true;
            this.cbResponse.Location = new System.Drawing.Point(149, 306);
            this.cbResponse.Name = "cbResponse";
            this.cbResponse.Size = new System.Drawing.Size(121, 21);
            this.cbResponse.TabIndex = 9;
            // 
            // cbRequire
            // 
            this.cbRequire.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbRequire.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbRequire.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbRequire.FormattingEnabled = true;
            this.cbRequire.Location = new System.Drawing.Point(149, 268);
            this.cbRequire.Name = "cbRequire";
            this.cbRequire.Size = new System.Drawing.Size(121, 21);
            this.cbRequire.TabIndex = 8;
            // 
            // lblResponse
            // 
            this.lblResponse.AutoSize = true;
            this.lblResponse.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblResponse.Location = new System.Drawing.Point(27, 306);
            this.lblResponse.Name = "lblResponse";
            this.lblResponse.Size = new System.Drawing.Size(124, 13);
            this.lblResponse.TabIndex = 7;
            this.lblResponse.Text = "Ask Until Yes Response:";
            // 
            // lblRequire
            // 
            this.lblRequire.AutoSize = true;
            this.lblRequire.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblRequire.Location = new System.Drawing.Point(3, 271);
            this.lblRequire.Name = "lblRequire";
            this.lblRequire.Size = new System.Drawing.Size(148, 13);
            this.lblRequire.TabIndex = 6;
            this.lblRequire.Text = "Require Answer if Incomplete:";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.txtTimeTo);
            this.groupBox3.Controls.Add(this.lblTo);
            this.groupBox3.Controls.Add(this.txtTimeFrom);
            this.groupBox3.Controls.Add(this.lblTimeRange);
            this.groupBox3.Controls.Add(this.cbDateTimeType);
            this.groupBox3.Controls.Add(this.lblDateType);
            this.groupBox3.Controls.Add(this.lblTimeSettings4);
            this.groupBox3.Controls.Add(this.lblTimeSettings3);
            this.groupBox3.Controls.Add(this.lblTimeSettings2);
            this.groupBox3.Controls.Add(this.lblTimeSettings1);
            this.groupBox3.Location = new System.Drawing.Point(149, 384);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(665, 137);
            this.groupBox3.TabIndex = 5;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Time Settings";
            // 
            // txtTimeTo
            // 
            this.txtTimeTo.Location = new System.Drawing.Point(261, 104);
            this.txtTimeTo.Name = "txtTimeTo";
            this.txtTimeTo.Required = false;
            this.txtTimeTo.Size = new System.Drawing.Size(100, 20);
            this.txtTimeTo.SpellCheckEnabled = false;
            this.txtTimeTo.TabIndex = 9;
            // 
            // lblTo
            // 
            this.lblTo.AutoSize = true;
            this.lblTo.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTo.Location = new System.Drawing.Point(239, 107);
            this.lblTo.Name = "lblTo";
            this.lblTo.Size = new System.Drawing.Size(16, 13);
            this.lblTo.TabIndex = 8;
            this.lblTo.Text = "to";
            // 
            // txtTimeFrom
            // 
            this.txtTimeFrom.Location = new System.Drawing.Point(133, 104);
            this.txtTimeFrom.Name = "txtTimeFrom";
            this.txtTimeFrom.Required = false;
            this.txtTimeFrom.Size = new System.Drawing.Size(100, 20);
            this.txtTimeFrom.SpellCheckEnabled = false;
            this.txtTimeFrom.TabIndex = 7;
            // 
            // lblTimeRange
            // 
            this.lblTimeRange.AutoSize = true;
            this.lblTimeRange.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTimeRange.Location = new System.Drawing.Point(12, 107);
            this.lblTimeRange.Name = "lblTimeRange";
            this.lblTimeRange.Size = new System.Drawing.Size(115, 13);
            this.lblTimeRange.TabIndex = 6;
            this.lblTimeRange.Text = "Specified Time Range:";
            // 
            // cbDateTimeType
            // 
            this.cbDateTimeType.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbDateTimeType.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbDateTimeType.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbDateTimeType.FormattingEnabled = true;
            this.cbDateTimeType.Location = new System.Drawing.Point(133, 77);
            this.cbDateTimeType.Name = "cbDateTimeType";
            this.cbDateTimeType.Size = new System.Drawing.Size(344, 21);
            this.cbDateTimeType.TabIndex = 5;
            // 
            // lblDateType
            // 
            this.lblDateType.AutoSize = true;
            this.lblDateType.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDateType.Location = new System.Drawing.Point(39, 85);
            this.lblDateType.Name = "lblDateType";
            this.lblDateType.Size = new System.Drawing.Size(88, 13);
            this.lblDateType.TabIndex = 4;
            this.lblDateType.Text = "Date/Time Type:";
            // 
            // lblTimeSettings4
            // 
            this.lblTimeSettings4.AutoSize = true;
            this.lblTimeSettings4.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTimeSettings4.Location = new System.Drawing.Point(12, 53);
            this.lblTimeSettings4.Name = "lblTimeSettings4";
            this.lblTimeSettings4.Size = new System.Drawing.Size(598, 13);
            this.lblTimeSettings4.TabIndex = 3;
            this.lblTimeSettings4.Text = "The specified time range is the range of hours that have elasped sinece cardiac d" +
                "eath and LKA time, not the hours in the day.";
            // 
            // lblTimeSettings3
            // 
            this.lblTimeSettings3.AutoSize = true;
            this.lblTimeSettings3.Location = new System.Drawing.Point(12, 40);
            this.lblTimeSettings3.Name = "lblTimeSettings3";
            this.lblTimeSettings3.Size = new System.Drawing.Size(285, 13);
            this.lblTimeSettings3.TabIndex = 2;
            this.lblTimeSettings3.Text = "Time Elasped Since Cardiac Death or LKA Time -";
            // 
            // lblTimeSettings2
            // 
            this.lblTimeSettings2.AutoSize = true;
            this.lblTimeSettings2.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblTimeSettings2.Location = new System.Drawing.Point(98, 20);
            this.lblTimeSettings2.Name = "lblTimeSettings2";
            this.lblTimeSettings2.Size = new System.Drawing.Size(450, 13);
            this.lblTimeSettings2.TabIndex = 1;
            this.lblTimeSettings2.Text = "The specified time range entered is the range of hours in a day that the question" +
                " will be asked.";
            // 
            // lblTimeSettings1
            // 
            this.lblTimeSettings1.AutoSize = true;
            this.lblTimeSettings1.Location = new System.Drawing.Point(12, 20);
            this.lblTimeSettings1.Name = "lblTimeSettings1";
            this.lblTimeSettings1.Size = new System.Drawing.Size(87, 13);
            this.lblTimeSettings1.TabIndex = 0;
            this.lblTimeSettings1.Text = "Current Time -";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.availableSelectedControl1);
            this.groupBox2.Controls.Add(this.lblFields);
            this.groupBox2.Controls.Add(this.cbOnce);
            this.groupBox2.Controls.Add(this.lblOnce);
            this.groupBox2.Location = new System.Drawing.Point(32, 75);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(782, 178);
            this.groupBox2.TabIndex = 4;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Update Call";
            // 
            // availableSelectedControl1
            // 
            this.availableSelectedControl1.ColumnList = null;
            this.availableSelectedControl1.DataMember = "";
            this.availableSelectedControl1.DataSource = null;
            this.availableSelectedControl1.IdColumn = "";
            this.availableSelectedControl1.Location = new System.Drawing.Point(132, 45);
            this.availableSelectedControl1.Name = "availableSelectedControl1";
            this.availableSelectedControl1.Size = new System.Drawing.Size(644, 127);
            this.availableSelectedControl1.TabIndex = 7;
            this.availableSelectedControl1.TextAvailable = "";
            this.availableSelectedControl1.TextSelected = "";
            // 
            // lblFields
            // 
            this.lblFields.AutoSize = true;
            this.lblFields.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFields.Location = new System.Drawing.Point(-5, 45);
            this.lblFields.Name = "lblFields";
            this.lblFields.Size = new System.Drawing.Size(141, 13);
            this.lblFields.TabIndex = 6;
            this.lblFields.Text = "Ask Only If Field(s) Updated:";
            // 
            // cbOnce
            // 
            this.cbOnce.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbOnce.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbOnce.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbOnce.FormattingEnabled = true;
            this.cbOnce.Location = new System.Drawing.Point(153, 13);
            this.cbOnce.Name = "cbOnce";
            this.cbOnce.Size = new System.Drawing.Size(121, 21);
            this.cbOnce.TabIndex = 4;
            // 
            // lblOnce
            // 
            this.lblOnce.AutoSize = true;
            this.lblOnce.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblOnce.Location = new System.Drawing.Point(21, 16);
            this.lblOnce.Name = "lblOnce";
            this.lblOnce.Size = new System.Drawing.Size(126, 13);
            this.lblOnce.TabIndex = 3;
            this.lblOnce.Text = "Only Ask Question Once:";
            // 
            // cbAskonUpdate
            // 
            this.cbAskonUpdate.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbAskonUpdate.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbAskonUpdate.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbAskonUpdate.FormattingEnabled = true;
            this.cbAskonUpdate.Location = new System.Drawing.Point(123, 48);
            this.cbAskonUpdate.Name = "cbAskonUpdate";
            this.cbAskonUpdate.Size = new System.Drawing.Size(121, 21);
            this.cbAskonUpdate.TabIndex = 3;
            // 
            // cbAskonInit
            // 
            this.cbAskonInit.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.Suggest;
            this.cbAskonInit.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cbAskonInit.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbAskonInit.FormattingEnabled = true;
            this.cbAskonInit.Location = new System.Drawing.Point(123, 17);
            this.cbAskonInit.Name = "cbAskonInit";
            this.cbAskonInit.Size = new System.Drawing.Size(121, 21);
            this.cbAskonInit.TabIndex = 2;
            // 
            // lblAskonUpdate
            // 
            this.lblAskonUpdate.AutoSize = true;
            this.lblAskonUpdate.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblAskonUpdate.Location = new System.Drawing.Point(18, 51);
            this.lblAskonUpdate.Name = "lblAskonUpdate";
            this.lblAskonUpdate.Size = new System.Drawing.Size(101, 13);
            this.lblAskonUpdate.TabIndex = 1;
            this.lblAskonUpdate.Text = "Ask on Update Call:";
            // 
            // lblAskonInt
            // 
            this.lblAskonInt.AutoSize = true;
            this.lblAskonInt.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblAskonInt.Location = new System.Drawing.Point(29, 20);
            this.lblAskonInt.Name = "lblAskonInt";
            this.lblAskonInt.Size = new System.Drawing.Size(90, 13);
            this.lblAskonInt.TabIndex = 0;
            this.lblAskonInt.Text = "Ask on Initial Call:";
            // 
            // baseUserControl1
            // 
            this.baseUserControl1.AutoSize = true;
            this.baseUserControl1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.baseUserControl1.Location = new System.Drawing.Point(7, 569);
            this.baseUserControl1.Name = "baseUserControl1";
            this.baseUserControl1.Size = new System.Drawing.Size(810, 475);
            this.baseUserControl1.TabIndex = 3;
            // 
            // baseUserControl2
            // 
            this.baseUserControl2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.baseUserControl2.Location = new System.Drawing.Point(7, 1050);
            this.baseUserControl2.Name = "baseUserControl2";
            this.baseUserControl2.Size = new System.Drawing.Size(810, 500);
            this.baseUserControl2.TabIndex = 4;
            // 
            // baseUserControl3
            // 
            this.baseUserControl3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.baseUserControl3.Location = new System.Drawing.Point(7, 1556);
            this.baseUserControl3.Name = "baseUserControl3";
            this.baseUserControl3.Size = new System.Drawing.Size(810, 150);
            this.baseUserControl3.TabIndex = 5;
            // 
            // QuestionConfigurationControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoSize = true;
            this.Controls.Add(this.baseUserControl3);
            this.Controls.Add(this.baseUserControl1);
            this.Controls.Add(this.baseUserControl2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.cbScreen);
            this.Controls.Add(this.lblScreenQuestions);
            this.Name = "QuestionConfigurationControl";
            this.Size = new System.Drawing.Size(847, 1737);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.Label lblScreenQuestions;
        private Statline.Stattrac.Windows.Forms.ComboBox cbScreen;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox1;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox3;
        private Statline.Stattrac.Windows.Forms.GroupBox groupBox2;
        private Statline.Stattrac.Windows.Forms.ComboBox cbAskonUpdate;
        private Statline.Stattrac.Windows.Forms.ComboBox cbAskonInit;
        private Statline.Stattrac.Windows.Forms.Label lblAskonUpdate;
        private Statline.Stattrac.Windows.Forms.Label lblAskonInt;
        private Statline.Stattrac.Windows.Forms.ComboBox cbTime;
        private Statline.Stattrac.Windows.Forms.Label lblTime;
        private Statline.Stattrac.Windows.Forms.ComboBox cbResponse;
        private Statline.Stattrac.Windows.Forms.ComboBox cbRequire;
        private Statline.Stattrac.Windows.Forms.Label lblResponse;
        private Statline.Stattrac.Windows.Forms.Label lblRequire;
        private Statline.Stattrac.Windows.Forms.Label lblFields;
        private Statline.Stattrac.Windows.Forms.ComboBox cbOnce;
        private Statline.Stattrac.Windows.Forms.Label lblOnce;
        private Statline.Stattrac.Windows.Forms.Label lblTimeSettings4;
        private Statline.Stattrac.Windows.Forms.Label lblTimeSettings3;
        private Statline.Stattrac.Windows.Forms.Label lblTimeSettings2;
        private Statline.Stattrac.Windows.Forms.Label lblTimeSettings1;
        private Statline.Stattrac.Windows.Forms.TextBox txtTimeTo;
        private Statline.Stattrac.Windows.Forms.Label lblTo;
        private Statline.Stattrac.Windows.Forms.TextBox txtTimeFrom;
        private Statline.Stattrac.Windows.Forms.Label lblTimeRange;
        private Statline.Stattrac.Windows.Forms.ComboBox cbDateTimeType;
        private Statline.Stattrac.Windows.Forms.Label lblDateType;
        private BaseUserControl baseUserControl1;
        private BaseUserControl baseUserControl2;
        private Statline.Stattrac.Windows.Forms.AvailableSelectedControl availableSelectedControl1;
        private BaseUserControl baseUserControl3;
    }
}
