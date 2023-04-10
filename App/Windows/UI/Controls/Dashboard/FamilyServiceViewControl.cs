using System;
using System.Drawing;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.Enum;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial  class FamilyServiceViewControl : BaseUserControl
    {
        string file = Application.StartupPath;
        public FamilyServiceViewControl()
        {
            InitializeComponent();
            this.openReadOnlyToolStripMenuItem.Click += new System.EventHandler(this.ugPendingSecondaryAlert_RightClick);
            this.openReadOnlyToolStripMenuItem.Click += new System.EventHandler(this.ugPendingSecondaryWIP_RightClick);
            this.openReadOnlyToolStripMenuItem.Click += new System.EventHandler(this.ugPendingSecondaryActivity_RightClick);
            if (GRConstant.SelectedTab != "Family Services (F4)")
            {
                return;
            }
            else
            {
                RefreshPage();
            }
            InitializeBR(new FamilyServiceViewBR());
        }

        public override void BindDataToUI()
        {
            Cursor.Current = Cursors.WaitCursor;
            InitializeBR(new FamilyServiceViewBR());
            FamilyServiceViewBR familyServiceViewBR = (FamilyServiceViewBR)BusinessRule;
            // if (BusinessRule != null)
            //{
            //    ultraGrid.DataSource = BusinessRule.AssociatedDataSet;
            familyServiceViewBR.SelectDataSet();
            FamilyServiceViewDS familyServiceViewDS = (FamilyServiceViewDS)BusinessRule.AssociatedDataSet;
            if (familyServiceViewDS == null)
               return;
            //base.BindDataToUI();
            string pendingSecondaryActivity = "PendingSecondaryActivity";
            string pendingSecondaryAlert = "PendingSecondaryAlert";
            string pendingSecondaryWIP = "PendingSecondaryWIP";

            ugPendingSecondaryActivity.DataMember = pendingSecondaryActivity;
            ugPendingSecondaryActivity.DataSource = familyServiceViewDS;

            ugPendingSecondaryAlert.DataMember = pendingSecondaryAlert;
            ugPendingSecondaryAlert.DataSource = familyServiceViewDS;

            ugPendingSecondaryWIP.DataMember = pendingSecondaryWIP;
            ugPendingSecondaryWIP.DataSource = familyServiceViewDS;
            
            Cursor.Current = Cursors.Default;
            //base.BindDataToUI();
        }

        private void ugPendingSecondaryActivity_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            if (BusinessRule == null)
                return;

            FamilyServiceViewDS familyServiceViewDS = (FamilyServiceViewDS)BusinessRule.AssociatedDataSet;
            if (familyServiceViewDS == null)
                return;
            const int band = 0;
            ugPendingSecondaryActivity.Text = "";
            ugPendingSecondaryActivity.ColumnDisplay(band, typeof(PendingSecondaryActivity), familyServiceViewDS.Tables["PendingSecondaryActivity"]);
            ugPendingSecondaryActivity.UltraGridType = UltraGridType.ReadOnly;
            ugPendingSecondaryActivity.DisplayLayout.Bands[band].Override.HeaderClickAction = HeaderClickAction.SortMulti;
            ugPendingSecondaryActivity.DisplayLayout.Bands[band].Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            ugPendingSecondaryActivity.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            SetDefaultColumnWidth(ugPendingSecondaryActivity);
        }

        private void ugPendingSecondaryAlert_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            if (BusinessRule == null)
                return;

            FamilyServiceViewDS familyServiceViewDS = (FamilyServiceViewDS)BusinessRule.AssociatedDataSet;
            if (familyServiceViewDS == null)
                return;
            const int band = 0;
            ugPendingSecondaryAlert.Text = "";
            ugPendingSecondaryAlert.ColumnDisplay(band, typeof(PendingSecondaryAlert), familyServiceViewDS.Tables["PendingSecondaryAlert"]);
            ugPendingSecondaryAlert.UltraGridType = UltraGridType.ReadOnly;
            ugPendingSecondaryAlert.DisplayLayout.Bands[band].Override.HeaderClickAction = HeaderClickAction.SortMulti;
            ugPendingSecondaryAlert.DisplayLayout.Bands[band].Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            ugPendingSecondaryAlert.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            SetDefaultColumnWidth(ugPendingSecondaryAlert);
        }
        private void ugPendingSecondaryWIP_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            if (BusinessRule == null)
                return;
            FamilyServiceViewDS familyServiceViewDS = (FamilyServiceViewDS)BusinessRule.AssociatedDataSet;
            //if (familyServiceViewDS == null)
            //    return;
            const int band = 0;
            ugPendingSecondaryWIP.Text = "";
            ugPendingSecondaryWIP.ColumnDisplay(band, typeof(PendingSecondaryWIP), familyServiceViewDS.Tables["PendingSecondaryWIP"]);
            ugPendingSecondaryWIP.UltraGridType = UltraGridType.ReadOnly;
            ugPendingSecondaryWIP.DisplayLayout.Bands[band].Override.HeaderClickAction = HeaderClickAction.SortMulti;
            ugPendingSecondaryWIP.DisplayLayout.Bands[band].Override.RowSelectors = Infragistics.Win.DefaultableBoolean.False;
            ugPendingSecondaryWIP.DisplayLayout.CaptionVisible = Infragistics.Win.DefaultableBoolean.False;
            SetDefaultColumnWidth(ugPendingSecondaryWIP);
        }


        private void SetDefaultColumnWidth(Statline.Stattrac.Windows.Forms.UltraGrid ug)
        {
            //define column names
            const string Icon = "icon";
            const string FSCaseOpen = "FSCaseOpen";
            const string FSCaseSystemEvent = "FSCaseSystemEvent";
            const string FSCaseSecondaryComplete = "FSCaseSecondaryComplete";
            const string FSCaseApproached = "FSCaseApproached";
            const string SourceCodeName = "SourceCodeName";
            
            //define column widths
            int IconWidth = 20;
            int XWdith = 18;
            int SourceCodeNameWidth = 60;
            int DefaultWidth = 100;
            
            const int band = 0;

            string columnKey;
            for (int index = 0; index < ug.DisplayLayout.Bands[band].Columns.Count; index++)
            {
                columnKey = ug.DisplayLayout.Bands[band].Columns[index].Key.ToString();
                switch (columnKey)
                {
                    case Icon:
                        ug.DisplayLayout.Bands[band].Columns[index].Width = IconWidth;
                        break;
                    case SourceCodeName:
                        ug.DisplayLayout.Bands[band].Columns[index].Width = SourceCodeNameWidth;
                        break;
                    case FSCaseOpen:
                        ug.DisplayLayout.Bands[band].Columns[index].Width = XWdith;
                        break;
                    case FSCaseSystemEvent:
                        ug.DisplayLayout.Bands[band].Columns[index].Width = XWdith;
                        break;
                    case FSCaseSecondaryComplete:
                        ug.DisplayLayout.Bands[band].Columns[index].Width = XWdith;
                        break;
                    case FSCaseApproached:
                        ug.DisplayLayout.Bands[band].Columns[index].Width = XWdith;
                        break;
                    default:
                        ug.DisplayLayout.Bands[band].Columns[index].Width = DefaultWidth;

                        break;
                }
           }
                
        }

        private void ugPendingSecondaryActivity_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            const int band = 0;
            CellsCollection cellsCollection = e.Row.Cells;
            
            // Set default expireMinutes
            TimeSpan expireMinutes = System.DateTime.Now - System.DateTime.Now;

            if  (cellsCollection["LogEventCalloutDateTime"].Value.ToString()  != String.Empty)
            {
                expireMinutes = System.DateTime.Now - ((DateTime)cellsCollection["LogEventCalloutDateTime"].Value);
            }

            int logEventTypeId = (int)cellsCollection["LogEventTypeID"].Value;
            // Because Callout Pendings are future events, expire values may have negative values
            int greenEvents = (logEventTypeId == Convert.ToInt32(LogEventTypeConstant.EventType.CalloutPending)) ? -10 : 8;
            int expiredEvents = (logEventTypeId == Convert.ToInt32(LogEventTypeConstant.EventType.CalloutPending)) ? 0 : 8;
            int expiredEventsOver = 30; //(logEventTypeId == Convert.ToInt32(LogEventTypeConstant.EventType.CalloutPending)) ? 30 : 30;

           
            if (logEventTypeId == Convert.ToInt32(LogEventTypeConstant.EventType.PagePending))
            {
                e.Row.CellAppearance.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                e.Row.CellAppearance.ForeColor = System.Drawing.Color.Blue;
            }

            if (expireMinutes.TotalMinutes < greenEvents)
            {   
                // New Event - Green Icon (status3)
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.False;
                ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status3.ico"));
                ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["status"].Value = 3;
            }
            if (expireMinutes.TotalMinutes < expiredEvents && expireMinutes.TotalMinutes > greenEvents)
            {
                //Warning Event - Yellow icon (status2)
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.False;
                ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status2.ico"));
                ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["status"].Value = 2;

            }
            if (expireMinutes.TotalMinutes > expiredEvents ) //&& expireMinutes.TotalMinutes < expiredEventsOver)
            {
                //Expired Event - Red icon (status1)
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.False;
                ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status1.ico"));
                ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["status"].Value = 1;

            }

            if (expireMinutes.TotalMinutes > expiredEventsOver)
            {
                //Extra Over Expired Event - Alarm icon (status0)
                //ccarroll 08/05/2011 Removed per wi:28899
                //e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                //ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\Status0.ico"));
                //ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["LogEventName"].Value = "EXPIRED EVENT";
                //ugPendingSecondaryActivity.Rows[e.Row.Index].Cells["status"].Value = 1;

            }

            //icon column needs to be white
            e.Row.Cells["icon"].Appearance.BackColor = System.Drawing.Color.White;

            //reset status sorting
            ugPendingSecondaryActivity.DisplayLayout.Bands[band].SortedColumns.Clear();
            ugPendingSecondaryActivity.DisplayLayout.Bands[band].SortedColumns.Add("status", false, false);
        }

        private void ugPendingSecondaryAlert_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            const int band = 0; 
            CellsCollection cellsCollection = e.Row.Cells;

            // Set default expireMinutes
            TimeSpan expireMinutes = System.DateTime.Now - System.DateTime.Now;
            if (cellsCollection.Exists("FSCaseCreateDateTime"))
            {
                if (cellsCollection["FSCaseCreateDateTime"].Value.ToString() != String.Empty)
                {
                    expireMinutes = System.DateTime.Now - ((DateTime)cellsCollection["FSCaseCreateDateTime"].Value);
                }
            }
            int greenEvents = 10;
            int expiredEvents = 10;
            int expiredEventsOver = 20;

            //icon column needs to be white
            e.Row.Cells["icon"].Appearance.BackColor = System.Drawing.Color.White;
            e.Row.CellAppearance.ForeColor = System.Drawing.Color.Blue;

            if (expireMinutes.TotalMinutes < greenEvents)
            {
                // New Event - Green Icon (status3)
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.False;
                ugPendingSecondaryAlert.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status3.ico"));
                return;
            }
            if (expireMinutes.TotalMinutes < expiredEvents && expireMinutes.TotalMinutes > greenEvents)
            {
                //Warning Event - Yellow icon (status2)
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.False;
                ugPendingSecondaryAlert.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status2.ico"));
                return;
            }
            if (expireMinutes.TotalMinutes > expiredEvents) //&& expireMinutes.TotalMinutes < expiredEventsOver)
            {
                //Warning Event - Red icon (status1)
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                ugPendingSecondaryAlert.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status1.ico"));
                return;
            }
            if (expireMinutes.TotalMinutes > expiredEventsOver)
            {
                //Extra Over Expired Event - Alarm icon (status0)
                //ccarroll 08/05/2011 Removed per wi:28899
                //e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                //ugPendingSecondaryAlert.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\Status0.ico"));
                //ugPendingSecondaryAlert.Rows[e.Row.Index].Cells["OrganizationName"].Value = "EXPIRED EVENT";
                //return;
            }
            //reset status sorting
            ugPendingSecondaryAlert.DisplayLayout.Bands[band].SortedColumns.Clear();
            ugPendingSecondaryAlert.DisplayLayout.Bands[band].SortedColumns.Add("status", false, false);
        }

        private void ugPendingSecondaryWIP_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            const int band = 0;

            // Set default expireMinutes
            TimeSpan expireMinutes = System.DateTime.Now - System.DateTime.Now;
            CellsCollection cellsCollection = e.Row.Cells;
            if(cellsCollection.Exists("FSCaseOpenDateTime"))
            {
                if (cellsCollection["FSCaseOpenDateTime"].Value.ToString() != String.Empty)
                {
                    expireMinutes = System.DateTime.Now - ((DateTime)cellsCollection["FSCaseOpenDateTime"].Value);
                }
            }
            int greenEvents = 10;
            int expiredEvents = 20;
            //int expiredEventsOver = 20;

            //icon column needs to be white
            e.Row.Cells["icon"].Appearance.BackColor = System.Drawing.Color.White;
            if (cellsCollection["PersonOrganizationID"].Value.ToString() != StattracIdentity.Identity.UserOrganizationId.ToString())
                e.Row.CellAppearance.ForeColor = System.Drawing.Color.Blue;

            if (expireMinutes.TotalMinutes < greenEvents)
            {
                // New Event - Green Icon (status3)
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.False;
                ugPendingSecondaryWIP.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status3.ico"));
                return;
            }
            if (expireMinutes.TotalMinutes < expiredEvents && expireMinutes.TotalMinutes > greenEvents)
            {
                //Warning Event - Yellow icon (status2)
                e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.False;
                ugPendingSecondaryWIP.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status2.ico"));
                return;
            }
            if (expireMinutes.TotalMinutes > expiredEvents)
            {
                //Expired Event - Red icon (status1)
                //This is a holding area for Cases and should never be bold. Same as old StatTrac
                //e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                ugPendingSecondaryWIP.Rows[e.Row.Index].Cells["icon"].Value = Image.FromFile(string.Format("{0}{1}", file.Replace(WindowsUIConstant.CreateInstance().DebugPathForImages, ""), "\\images\\status1.ico"));
                return;
            }
            ////reset status sorting
            ugPendingSecondaryWIP.DisplayLayout.Bands[band].SortedColumns.Clear();
            ugPendingSecondaryWIP.DisplayLayout.Bands[band].SortedColumns.Add("status", false, false);
        }

        private void timer1_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            if (IsDisposed)
                return;
            if (GRConstant.SelectedTab != "Family Services (F4)")
                return;
            base.RefreshPage();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            base.RefreshPage();
        }
        private void btnAdd_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(AppScreenType.VBNew, 0);
            Cursor.Current = Cursors.Default;
        }
        private void ugPendingSecondaryActivity_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {
            if (ugPendingSecondaryActivity.Selected.Rows.Count == 1 && ugPendingSecondaryActivity.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugPendingSecondaryActivity.Selected.Rows[0].Cells;
                NavigateToScreen(AppScreenType.VBFS,(int)cellsCollection[0].Value);
            }
        }
        private void ugPendingSecondaryActivity_RightClick(object sender, EventArgs e)
        {
            if (ugPendingSecondaryActivity.Selected.Rows.Count == 1 && ugPendingSecondaryActivity.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugPendingSecondaryActivity.Selected.Rows[0].Cells;
                NavigateToScreen(AppScreenType.VBFSReadOnly, (int)cellsCollection[0].Value);
            }
        }

        private void ugPendingSecondaryAlert_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {
            if (ugPendingSecondaryAlert.Selected.Rows.Count == 1 && ugPendingSecondaryAlert.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugPendingSecondaryAlert.Selected.Rows[0].Cells;
                NavigateToScreen(AppScreenType.VBFSOther,(int)cellsCollection[0].Value);
            }
        }
        private void ugPendingSecondaryAlert_RightClick(object sender, EventArgs e)
        {
            if (ugPendingSecondaryAlert.Selected.Rows.Count == 1 && ugPendingSecondaryAlert.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugPendingSecondaryAlert.Selected.Rows[0].Cells;
                NavigateToScreen(AppScreenType.VBFSOtherReadOnly, (int)cellsCollection[0].Value);
            }
        }

        private void ugPendingSecondaryWIP_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {
            if (ugPendingSecondaryWIP.Selected.Rows.Count == 1 && ugPendingSecondaryWIP.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugPendingSecondaryWIP.Selected.Rows[0].Cells;
                NavigateToScreen(AppScreenType.VBFSOther,(int)cellsCollection[0].Value);
            }
        }
        private void ugPendingSecondaryWIP_RightClick(object sender, EventArgs e)
        {
            if (ugPendingSecondaryWIP.Selected.Rows.Count == 1 && ugPendingSecondaryWIP.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugPendingSecondaryWIP.Selected.Rows[0].Cells;
                NavigateToScreen(AppScreenType.VBFSOtherReadOnly, (int)cellsCollection[0].Value);
            }
        }

        protected void NavigateToScreen(AppScreenType screenType,int callID)
        {
            Cursor.Current = Cursors.WaitCursor;
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(screenType, callID);
            Cursor.Current = Cursors.Default;
        }

        private void ugPendingSecondaryActivity_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
                contextMenuStrip1.Show(Control.MousePosition.X, Control.MousePosition.Y);
        }

        private void ugPendingSecondaryAlert_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
                contextMenuStrip1.Show(Control.MousePosition.X, Control.MousePosition.Y);
        }

        private void ugPendingSecondaryWIP_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
                contextMenuStrip1.Show(Control.MousePosition.X, Control.MousePosition.Y);
        }
    }
}
