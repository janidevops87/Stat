namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    partial class FormPendingEventsPop
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
            Infragistics.Win.Appearance appearance7 = new Infragistics.Win.Appearance();
            Infragistics.Win.UltraWinGrid.UltraGridBand ultraGridBand1 = new Infragistics.Win.UltraWinGrid.UltraGridBand("PendingList", -1);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn23 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn24 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventTime");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn25 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventName");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn26 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventOrg", -1, null, 0, Infragistics.Win.UltraWinGrid.SortIndicator.Ascending, false);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn27 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CreatedBy");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn28 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("Spacer");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn29 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventCalloutDateTime");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn30 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventDateTime");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn31 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallType");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn32 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventTypeID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn33 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("OrganizationID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn34 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("expirationminutes");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn35 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("overexpirationminutes");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn36 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("interval");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn37 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CallLocked");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn38 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("InQueue");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn39 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("StatEmployeeID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn40 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("acknowledgeevalexpireminutes");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn41 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("CanOpenPopUp");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn42 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("LogEventID");
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn43 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("icon", 0);
            Infragistics.Win.UltraWinGrid.UltraGridColumn ultraGridColumn44 = new Infragistics.Win.UltraWinGrid.UltraGridColumn("donornetsort", 1);
            Infragistics.Win.Appearance appearance8 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance9 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance10 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance11 = new Infragistics.Win.Appearance();
            Infragistics.Win.Appearance appearance12 = new Infragistics.Win.Appearance();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormPendingEventsPop));
            this.ugPending = new Statline.Stattrac.Windows.Forms.UltraGrid();
            this.pendingEventsDS1 = new Statline.Stattrac.Data.Types.Dashboard.PendingEventsDS();
            this.btnRefresh = new Statline.Stattrac.Windows.Forms.Button();
            this.btnCancel = new Statline.Stattrac.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.ugPending)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pendingEventsDS1)).BeginInit();
            this.SuspendLayout();
            // 
            // ugPending
            // 
            this.ugPending.DataMember = "PendingList";
            this.ugPending.DataSource = this.pendingEventsDS1;
            appearance7.BackColor = System.Drawing.Color.Transparent;
            this.ugPending.DisplayLayout.Appearance = appearance7;
            this.ugPending.DisplayLayout.AutoFitStyle = Infragistics.Win.UltraWinGrid.AutoFitStyle.ResizeAllColumns;
            ultraGridColumn23.Header.Caption = "Call #";
            ultraGridColumn23.Header.VisiblePosition = 2;
            ultraGridColumn23.Width = 95;
            ultraGridColumn24.Header.VisiblePosition = 3;
            ultraGridColumn24.Hidden = true;
            ultraGridColumn25.Header.Caption = "Paged / Faxed To";
            ultraGridColumn25.Header.VisiblePosition = 5;
            ultraGridColumn25.Width = 123;
            ultraGridColumn26.Header.Caption = "Organization";
            ultraGridColumn26.Header.VisiblePosition = 6;
            ultraGridColumn26.Width = 205;
            ultraGridColumn27.Header.Caption = "Created By";
            ultraGridColumn27.Header.VisiblePosition = 7;
            ultraGridColumn27.Width = 91;
            ultraGridColumn28.Header.VisiblePosition = 8;
            ultraGridColumn28.Hidden = true;
            ultraGridColumn29.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn29.Header.VisiblePosition = 9;
            ultraGridColumn29.Hidden = true;
            ultraGridColumn30.Format = "MM/dd/yyyy HH:mm";
            ultraGridColumn30.Header.Caption = "Time";
            ultraGridColumn30.Header.VisiblePosition = 4;
            ultraGridColumn30.Width = 91;
            ultraGridColumn31.Header.Caption = "Type";
            ultraGridColumn31.Header.VisiblePosition = 1;
            ultraGridColumn31.Width = 66;
            ultraGridColumn32.Header.VisiblePosition = 10;
            ultraGridColumn32.Hidden = true;
            ultraGridColumn33.Header.VisiblePosition = 11;
            ultraGridColumn33.Hidden = true;
            ultraGridColumn34.Header.VisiblePosition = 12;
            ultraGridColumn34.Hidden = true;
            ultraGridColumn35.Header.VisiblePosition = 13;
            ultraGridColumn35.Hidden = true;
            ultraGridColumn36.Header.VisiblePosition = 14;
            ultraGridColumn36.Hidden = true;
            ultraGridColumn37.Header.VisiblePosition = 15;
            ultraGridColumn37.Hidden = true;
            ultraGridColumn38.Header.Caption = "In Queue";
            ultraGridColumn38.Header.VisiblePosition = 19;
            ultraGridColumn38.Width = 91;
            ultraGridColumn39.Header.VisiblePosition = 16;
            ultraGridColumn39.Hidden = true;
            ultraGridColumn40.Header.VisiblePosition = 17;
            ultraGridColumn40.Hidden = true;
            ultraGridColumn40.Width = 154;
            ultraGridColumn41.Header.VisiblePosition = 21;
            ultraGridColumn41.Hidden = true;
            ultraGridColumn41.Width = 75;
            ultraGridColumn42.Header.VisiblePosition = 20;
            ultraGridColumn42.Hidden = true;
            ultraGridColumn42.Width = 74;
            ultraGridColumn43.AllowGroupBy = Infragistics.Win.DefaultableBoolean.False;
            ultraGridColumn43.DataType = typeof(System.Drawing.Bitmap);
            ultraGridColumn43.Header.Caption = "";
            ultraGridColumn43.Header.VisiblePosition = 0;
            ultraGridColumn43.Width = 39;
            ultraGridColumn44.Header.VisiblePosition = 18;
            ultraGridColumn44.Hidden = true;
            ultraGridBand1.Columns.AddRange(new object[] {
            ultraGridColumn23,
            ultraGridColumn24,
            ultraGridColumn25,
            ultraGridColumn26,
            ultraGridColumn27,
            ultraGridColumn28,
            ultraGridColumn29,
            ultraGridColumn30,
            ultraGridColumn31,
            ultraGridColumn32,
            ultraGridColumn33,
            ultraGridColumn34,
            ultraGridColumn35,
            ultraGridColumn36,
            ultraGridColumn37,
            ultraGridColumn38,
            ultraGridColumn39,
            ultraGridColumn40,
            ultraGridColumn41,
            ultraGridColumn42,
            ultraGridColumn43,
            ultraGridColumn44});
            this.ugPending.DisplayLayout.BandsSerializer.Add(ultraGridBand1);
            this.ugPending.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            appearance8.BackColor = System.Drawing.Color.Transparent;
            this.ugPending.DisplayLayout.Override.CardAreaAppearance = appearance8;
            this.ugPending.DisplayLayout.Override.CellClickAction = Infragistics.Win.UltraWinGrid.CellClickAction.RowSelect;
            appearance9.BackColor = System.Drawing.Color.WhiteSmoke;
            appearance9.BackColor2 = System.Drawing.Color.LightGray;
            appearance9.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugPending.DisplayLayout.Override.FilteredInRowAppearance = appearance9;
            appearance10.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance10.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance10.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance10.FontData.BoldAsString = "True";
            appearance10.FontData.Name = "Tahoma";
            appearance10.FontData.SizeInPoints = 8F;
            appearance10.ForeColor = System.Drawing.Color.White;
            appearance10.ThemedElementAlpha = Infragistics.Win.Alpha.Transparent;
            this.ugPending.DisplayLayout.Override.HeaderAppearance = appearance10;
            this.ugPending.DisplayLayout.Override.HeaderClickAction = Infragistics.Win.UltraWinGrid.HeaderClickAction.SortMulti;
            appearance11.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(89)))), ((int)(((byte)(135)))), ((int)(((byte)(214)))));
            appearance11.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(7)))), ((int)(((byte)(59)))), ((int)(((byte)(150)))));
            appearance11.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            this.ugPending.DisplayLayout.Override.RowSelectorAppearance = appearance11;
            this.ugPending.DisplayLayout.Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            appearance12.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(251)))), ((int)(((byte)(230)))), ((int)(((byte)(148)))));
            appearance12.BackColor2 = System.Drawing.Color.FromArgb(((int)(((byte)(238)))), ((int)(((byte)(149)))), ((int)(((byte)(21)))));
            appearance12.BackGradientStyle = Infragistics.Win.GradientStyle.Vertical;
            appearance12.ForeColor = System.Drawing.Color.Black;
            this.ugPending.DisplayLayout.Override.SelectedRowAppearance = appearance12;
            this.ugPending.Font = new System.Drawing.Font("Tahoma", 7F);
            this.ugPending.Location = new System.Drawing.Point(13, 13);
            this.ugPending.Name = "ugPending";
            this.ugPending.Size = new System.Drawing.Size(803, 144);
            this.ugPending.TabIndex = 0;
            this.ugPending.Text = "Pending Events for Same Organization";
            this.ugPending.UltraGridType = Statline.Stattrac.Windows.Forms.UltraGridType.ReadOnly;
            this.ugPending.InitializeRow += new Infragistics.Win.UltraWinGrid.InitializeRowEventHandler(this.ultraGrid1_InitializeRow);
            this.ugPending.DoubleClick += new System.EventHandler(this.ugPending_DoubleClick);
            // 
            // pendingEventsDS1
            // 
            this.pendingEventsDS1.DataSetName = "PendingEventsDS";
            this.pendingEventsDS1.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // btnRefresh
            // 
            this.btnRefresh.Location = new System.Drawing.Point(366, 272);
            this.btnRefresh.Name = "btnRefresh";
            this.btnRefresh.Size = new System.Drawing.Size(75, 23);
            this.btnRefresh.TabIndex = 1;
            this.btnRefresh.Text = "&Refresh";
            this.btnRefresh.UseVisualStyleBackColor = true;
            this.btnRefresh.Click += new System.EventHandler(this.btnRefresh_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(498, 272);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 3;
            this.btnCancel.Text = "&Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // FormPendingEventsPop
            // 
            this.AcceptButton = this.btnRefresh;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(881, 319);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnRefresh);
            this.Controls.Add(this.ugPending);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "FormPendingEventsPop";
            this.Text = "Pending Events";
            this.Leave += new System.EventHandler(this.FormPendingEventsPop_Leave);
            ((System.ComponentModel.ISupportInitialize)(this.ugPending)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pendingEventsDS1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Statline.Stattrac.Windows.Forms.UltraGrid ugPending;
        private Statline.Stattrac.Data.Types.Dashboard.PendingEventsDS pendingEventsDS1;
        private Statline.Stattrac.Windows.Forms.Button btnRefresh;
        private Statline.Stattrac.Windows.Forms.Button btnCancel;
    }
}