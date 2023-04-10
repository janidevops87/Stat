using System;
using System.Drawing;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.Enum;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.Security;
using Statline.Stattrac.Framework;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class MainControl : BaseUserControl
    {
        private SecurityHelper securityHelper; 
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        string file = Application.StartupPath;
        PendingEventsDS pendingEventsDS;
        PendingEventsBR pendingEventsBR;
        IncompletesDS incompletesDS;
        IncompletesBR incompletesBR;
		PendingCasesDS pendingCasesDS;
		PendingCasesBR pendingCasesBR;

        public MainControl()
        {
            InitializeComponent();
            securityHelper = Security.SecurityHelper.GetInstance();
            if (!securityHelper.Authorized(SecurityRule.Delete_Call.ToString()))
            {
                deleteCallToolStripMenuItem.Visible = false;
            }
            incompletesBR = new IncompletesBR();
            incompletesDS = (IncompletesDS)incompletesBR.AssociatedDataSet;
            pendingEventsBR = new PendingEventsBR();
            pendingEventsDS = (PendingEventsDS)pendingEventsBR.AssociatedDataSet;
			pendingCasesBR = new PendingCasesBR();
			pendingCasesDS = (PendingCasesDS)pendingCasesBR.AssociatedDataSet;
			LoadGrids();
        }
        public void LoadGrids(int tryCounter = 1)
        {
            try
            {
                incompletesBR.SelectDataSet();
                pendingEventsBR.SelectDataSet();
                pendingCasesBR.SelectDataSet();
                BindDataToUI();
            }
            catch (Exception ex)
            {
                StatTracLogger.CreateInstance().Write(ex);

                if (int.TryParse(BaseConfiguration.GetSetting(SettingName.LoadGridsMaxAttempts), out var loadGridsMaxAttemptsInt) && tryCounter < loadGridsMaxAttemptsInt)
                {
                    LoadGrids(++tryCounter);
                }
                else
                {
                    BaseMessageBox.ShowError(
                        "An error has occurred while loading data for the dashboard grids. The grids will automatically attempt to gather data again in a few moments. " +
                            $"\n\nIf this error persists, please contact the Help Desk and restart StatTrac.\n\nUTC Timestamp: {DateTime.UtcNow.ToString("MM/dd/yyyy HH:mm:ss.fff")}"
                        , "Error while loading dashboard grids"
                        , owner: ParentForm);
                }
            }
        }
        public override void BindDataToUI()
        {
            base.BindDataToUI();
            BindDataToUIIncompletes();
            BindDataToUIPending();
			BindDataToUIPendingCases();

		}
        public void BindDataToUIPending()
        {
            ugPending.DataMember = pendingEventsDS.PendingList.TableName;
            ugPending.DataSource = pendingEventsDS;
        }

        public void BindDataToUIIncompletes()
        {
            ugIncomplete.DataMember = incompletesDS.IncompleteCalls.TableName;
            ugIncomplete.DataSource = incompletesDS;
        }

		public void BindDataToUIPendingCases()
		{
            ugPendingCases.DataMember = pendingCasesDS.PendingCasesList.TableName;
            ugPendingCases.DataSource = pendingCasesDS;
        }

		private void timer1_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            if (IsDisposed)
                return;
            if (((BaseForm)FindForm()) == null)
                return;
            if (((BaseForm)FindForm()).SelectedUserControlName != "DashboardControl")
                return;
            try
            {
                timer1.Stop();
                LoadGrids();
            }
            catch (Exception ex)
            {

                BaseLogger.LogFormUnhandledException(ex, this);

            }
            finally
            { 
            timer1.Start();
            }
        }

        private void ugPending_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            try //just in case you have some invalid values, you won't be toast
            {
                CellsCollection cellsCollection = e.Row.Cells;
                TimeSpan expireMinutes = System.DateTime.Now - (DateTime)cellsCollection["LogEventDateTime"].Value;
                e.Row.Band.Columns["LogEventDateTime"].Format = "HH:mm:ss";
                e.Row.Band.Columns["LogEventDateTime"].MaskInput = "HH:mm:ss";

                //color precedence...black,light coral (a.k.a. red),blue,green,orange,yellow...so, apply black last and yellow first
                //blue
                if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.OnlineReviewPending).ToString())
                {
                    if (StattracIdentity.Identity.UserOrganizationId == Convert.ToInt32(GeneralConstant.Organizations.Statline))    
                    {
                        e.Row.ToolTipText = "Client Created";
                        e.Row.CellAppearance.BackColor = Color.LightBlue;
                    }
                }
                //purple
                if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.DeclaredCTODPending).ToString())
                {
                   e.Row.CellAppearance.BackColor = Color.MediumPurple;
                }
                //yellow
                if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.PendingEReferral).ToString())
                {
                    e.Row.CellAppearance.BackColor = Color.Yellow;
                }
                //bold
                if (cellsCollection["LogEventOrg"].Value.ToString() == "DonorNet")
                {
                    e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                    e.Row.CellAppearance.BackColor = Color.Black;
                    e.Row.CellAppearance.ForeColor = Color.White;
                }
                else
                {
                    //callout pendings and acknowledget to evaluate show when expired and go to red and then black
                    if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.AcknowledgetoEvaluate).ToString()
                        || cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.CalloutPending).ToString())
                    {
                        int overexpiredminutes;
                        //overexpire is different per event type
                        if (cellsCollection["LogEventTypeID"].Value.ToString() == Convert.ToInt32(LogEventTypeConstant.EventType.AcknowledgetoEvaluate).ToString())
                            overexpiredminutes = Convert.ToInt32(cellsCollection["acknowledgeevalexpireminutes"].Value);
                        else
                            overexpiredminutes = Convert.ToInt32(cellsCollection["overexpirationminutes"].Value);
                        //black
                        if (expireMinutes.TotalMinutes > overexpiredminutes + Convert.ToInt32(cellsCollection["overexpirationminutes"].Value))
                        {
                            e.Row.ToolTipText = "Over Expired";
                            e.Row.CellAppearance.BackColor = Color.Black;
                            e.Row.CellAppearance.ForeColor = System.Drawing.Color.White;
                            e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                        }
                        else
                        {
                            //red
                            e.Row.CellAppearance.BackColor = Color.LightCoral;
                            e.Row.ToolTipText = "Expired";
                        }

                    }
                    else
                    {//the other events show immediately and go red and black after the interval
                        //black
                        if (expireMinutes.TotalMinutes > (Convert.ToInt32(cellsCollection["interval"].Value) + Convert.ToInt32(cellsCollection["overexpirationminutes"].Value)))
                        {
                            e.Row.ToolTipText = "Over Expired";
                            e.Row.CellAppearance.BackColor = Color.Black;
                            e.Row.CellAppearance.ForeColor = System.Drawing.Color.White;
                            e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                        }
                        else
                            //red
                            if (expireMinutes.TotalMinutes > Convert.ToInt32(cellsCollection["interval"].Value))
                            {
                                e.Row.CellAppearance.BackColor = Color.LightCoral;
                                e.Row.ToolTipText = "Expired";   
                            }
                    }
                }
            }
            catch (Exception ex)
            {
                StatTracLogger.CreateInstance().Write(ex);
            }
            this.ugPending.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            //this.ugPending.DisplayLayout.Override.AllowColSizing = AllowColSizing.None;  allow or don't allow column resizing
        }

        private void ugIncomplete_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            try //just in case you have some invalid values, you won't be toast
            {
                CellsCollection cellsCollection = e.Row.Cells;
                TimeSpan expireMinutes = System.DateTime.Now - Convert.ToDateTime(cellsCollection["LastModified"].Value);
                //color precedence...black,light coral (a.k.a. red),blue,orange,yellow...so, apply black last and yellow first
                //blue
                if (StattracIdentity.Identity.UserOrganizationId == Convert.ToInt32(GeneralConstant.Organizations.Statline))
                {
                    if (cellsCollection["OrganizationID"].Value.ToString() != Convert.ToInt32(GeneralConstant.Organizations.Statline).ToString())
                    {
                        e.Row.ToolTipText = "Client Created";
                        e.Row.CellAppearance.BackColor = Color.LightBlue;
                    }
                }
                //do locked
                if (cellsCollection["CallTempExclusive"].Value.ToString() == "-1")
                {
                    if (e.Row.Cells.Exists("icon"))
                    {
                        e.Row.Cells["icon"].Value = "X";
                    }
                }
                //black
                if (expireMinutes.TotalMinutes > Convert.ToInt32(cellsCollection["overexpirationminutes"].Value) + Convert.ToInt32(cellsCollection["expirationminutes"].Value))
                {
                    e.Row.CellAppearance.BackColor = Color.Black;
                    e.Row.ToolTipText = "Over Expired";
                    e.Row.CellAppearance.ForeColor = System.Drawing.Color.White;
                    e.Row.CellAppearance.FontData.Bold = Infragistics.Win.DefaultableBoolean.True;
                }
                else
                {    //red
                    if (expireMinutes.TotalMinutes > Convert.ToInt32(cellsCollection["expirationminutes"].Value))
                    {
                        e.Row.CellAppearance.BackColor = Color.LightCoral;
                        e.Row.ToolTipText = "Expired";
                    }
                }
            }
            catch (Exception ex)
            {
                StatTracLogger.CreateInstance().Write(ex);
            }
            this.ugIncomplete.DisplayLayout.Override.AllowUpdate = Infragistics.Win.DefaultableBoolean.False;
            ugIncomplete.DisplayLayout.Bands[0].Columns["CallDateTime"].Format = "M/d/yy HH:mm";
        }

        private void ugPending_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {   
            Cursor.Current = Cursors.WaitCursor;
            if (ugPending.Selected.Rows.Count == 1 && ugPending.Selected.Rows[0].Cells != null)
            {
                string callType = ugPending.Selected.Rows[0].Cells["CallType"].Value.ToString();
                CellsCollection cellsCollection = ugPending.Selected.Rows[0].Cells;
                LogEventLockedHelperBR logEventLockedHelperBR = new LogEventLockedHelperBR();
                LogEventsLockDS logEventsLockDS = logEventLockedHelperBR.LogEventLocked((int)cellsCollection["LogEventID"].Value);
				// Is call locked realtime
                bool callLockedRealTime;
                callLockedRealTime = false;
                if (logEventsLockDS.LogEventLock.Count == 1)
                {
                    callLockedRealTime = true;
                }
                string logOrg = null;
                try//have to try catch this, because some pages don't have logOrg in them
                {
                    logOrg = (string)cellsCollection["LogEventOrg"].Value;
                }
                catch
                {
                    logOrg = null;
                }
                int lockLogEventId = (int)cellsCollection["LogEventID"].Value;
                GRConstant.OrganizationName = logOrg;
                //SaveLogEventLock(logOrg); 
                InitializeBR(new PendingEventsBR());
                PendingEventsBR pendingEventsBR = (PendingEventsBR)BusinessRule;
                PendingEventsDS pendingEventsDS = (PendingEventsDS)BusinessRule.AssociatedDataSet;
                pendingEventsBR.SelectDataSet();
                logOrg = logOrg.Replace("'", "''").ToUpper();
                string computeString = string.Format("Count(LogEventOrg)");
                string computeString1 = string.Format("LogEventOrg= '" + logOrg + "'");
                int count = Convert.ToInt32(pendingEventsDS.PendingList.Compute(computeString, computeString1));
                if (count > 1 && cellsCollection["CanOpenPopUp"].Value.ToString() == "1" && !callLockedRealTime) // Reinstated via HS:29496 10/07/2011 ccarroll
                //if (count > 1 && !callLockedRealTime)
                {
                    SaveLogEventLock(logOrg);
                    FormPendingEventsPop formPendingEventsPop = new Statline.Stattrac.Windows.UI.Controls.Dashboard.FormPendingEventsPop();
                    formPendingEventsPop.ShowDialog();
                    RemoveLogEventLock(logOrg);
                }
                else
                {
                    UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
                    if (callType.Contains("M") || callType.Contains("I"))
                    {
                        setMessageCallType(callType);
                        openstatTrac.Open(AppScreenType.VBMsgEventLog, (int)cellsCollection["CallID"].Value);
                        
                        // Reset MessageCallType
                        GRConstant.MessageCallTypeID = 0;
                    }
                    else
                        openstatTrac.Open(AppScreenType.VBEventLog, (int)cellsCollection["CallID"].Value);
                    //RemoveLogEventLock(logOrg);
                }
                pendingEventsBR.SelectDataSet();
                BindDataToUIPending();
            }
            Cursor.Current = Cursors.Default;
        }
        private void SaveLogEventLock(string logOrg)
        {
            InitializeBR(new LogEventLockBR());
            LogEventLockBR logEventsLockBR = (LogEventLockBR)BusinessRule;
            LogEventsLockDS logEventsLockDS = (LogEventsLockDS)BusinessRule.AssociatedDataSet;
            LogEventsLockDS.LogEventLockRow row;
            for (int loop = 0; loop < ugPending.Rows.Count; loop++)
            {
                if (ugPending.Rows[loop].Cells["LogEventOrg"].Value.ToString().ToUpper() == logOrg.ToUpper())
                {//only add to logeventlock table if not already locked
                    if (String.IsNullOrEmpty(ugPending.Rows[loop].Cells["CallLocked"].Value.ToString()))
                    {
                        row = logEventsLockDS.LogEventLock.NewLogEventLockRow();
                        row["OrganizationID"] = ugPending.Rows[loop].Cells["OrganizationID"].Value;
                        row["LogEventOrg"] = ugPending.Rows[loop].Cells["LogEventOrg"].Value;
                        row["CallID"] = ugPending.Rows[loop].Cells["CallID"].Value;
                        row["LogEventID"] = ugPending.Rows[loop].Cells["LogEventID"].Value;
                        row["StatEmployeeID"] = StattracIdentity.Identity.UserId;
                        logEventsLockDS.LogEventLock.AddLogEventLockRow(row);
                    }
                }
            }
            base.SaveDataToDB();
            pendingEventsBR.SelectDataSet();
            BindDataToUIPending();
        }

        private void RemoveLogEventLock(string logOrg)
        {
            InitializeBR(new LogEventLockBR());
            LogEventLockBR logEventsLockBR = (LogEventLockBR)BusinessRule;
            LogEventsLockDS logEventsLockDS = (LogEventsLockDS)BusinessRule.AssociatedDataSet;
            
            logEventsLockBR.LogEventOrg = logOrg;
            logEventsLockBR.SelectDataSet();
            for (int loop = 0; loop < logEventsLockDS.LogEventLock.Rows.Count; loop++)
            {
                logEventsLockDS.LogEventLock.Rows[loop].Delete();
                base.SaveDataToDB();
            }
        }

        private void ugIncomplete_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ugIncomplete.DisplayLayout.Bands[0].Override.TipStyleCell = Infragistics.Win.UltraWinGrid.TipStyle.Hide;
            e.Layout.Override.HeaderClickAction = HeaderClickAction.ExternalSortMulti;

            UltraGridLayout layout = e.Layout;
            UltraGridBand band = layout.Bands[0];
            UltraGridColumn iconColumn = band.Columns.Insert(0, "icon");
            iconColumn.DataType = typeof(string);
            iconColumn.Style = Infragistics.Win.UltraWinGrid.ColumnStyle.FormattedText;
            iconColumn.Header.Caption = "";
            iconColumn.Header.Editor = null;
            iconColumn.Width = 22;

        }
        private void ugPending_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ugPending.DisplayLayout.Bands[0].Override.TipStyleCell = Infragistics.Win.UltraWinGrid.TipStyle.Hide;            
            e.Layout.Override.HeaderClickAction = HeaderClickAction.ExternalSortMulti;
        }

        private void ugIncomplete_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            if (ugIncomplete.Selected.Rows.Count == 1 && ugIncomplete.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugIncomplete.Selected.Rows[0].Cells;
                string callType = ugIncomplete.Selected.Rows[0].Cells["CallType"].Value.ToString();
                UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
                if (callType.Contains("M") || callType.Contains("I"))
                {
                    setMessageCallType(callType);
                    openstatTrac.Open(AppScreenType.VBMsgEventLog, (int)cellsCollection[1].Value);

                    //Reset MessageCallType
                    GRConstant.MessageCallTypeID = 0;

                }
                else
                {
                    openstatTrac.Open(AppScreenType.VBEventLog, (int)cellsCollection[1].Value);
                }
                incompletesBR.SelectDataSet();
                BindDataToUIIncompletes();
            }
            Cursor.Current = Cursors.Default;
        }

        private void setMessageCallType(string callType)
        {
            //Set MessageCallType
            if ((bool)callType.Contains("I"))
                GRConstant.MessageCallTypeID = (int)GeneralConstant.CallType.Import; 
            else
                GRConstant.MessageCallTypeID = (int)GeneralConstant.CallType.Message;
        }
        
        private void ugPending_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
                contextMenuStrip1.Show(Control.MousePosition.X, Control.MousePosition.Y);
        }

        private void ugIncomplete_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
                contextMenuStrip1.Show(Control.MousePosition.X, Control.MousePosition.Y);
        }

        private void deleteCallToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CellsCollection cellsCollection = null;
            bool okToProceed = false;
            if (ugIncomplete.Selected.Rows.Count > 0 && ugPending.Selected.Rows.Count > 0)
                BaseMessageBox.Show("Please only select one row");
            else
            {
                if (ugPending.Selected.Rows.Count == 1 && ugPending.Selected.Rows[0].Cells != null)
                {
                    cellsCollection = ugPending.Selected.Rows[0].Cells;
                    okToProceed = true;
                    timer1.Stop();
                }
                else
                {
                    if (ugIncomplete.Selected.Rows.Count == 1 && ugIncomplete.Selected.Rows[0].Cells != null)
                    {
                        cellsCollection = ugIncomplete.Selected.Rows[0].Cells;
                        okToProceed = true;
                        timer1.Stop();
                    }
                }

                if (okToProceed)
                {
                    DeleteCasesPopUp deleteCasesPopUp = new Statline.Stattrac.Windows.UI.Controls.Dashboard.DeleteCasesPopUp();
                    deleteCasesPopUp.ShowDialog();
                    if (generalConstant.DeleteCall)
                    {
                        Cursor.Current = Cursors.WaitCursor;
                        //recycle call
                        InitializeBR(new RecycledCasesBR());
                        RecycledCasesBR recycledCasesBR = (RecycledCasesBR)BusinessRule;
                        recycledCasesBR.RecycleCallsDelete((int)cellsCollection["CallID"].Value, StattracIdentity.Identity.UserId);
                        //write log event
                        InitializeBR(new LogEventBR());
                        LogEventBR logEventBR = (LogEventBR)BusinessRule;
                        LogEventDS logEventDS = (LogEventDS)BusinessRule.AssociatedDataSet;
                        LogEventDS.LogEventRow row;
                        row = logEventDS.LogEvent.NewLogEventRow();
                        row["CallID"] = (int)cellsCollection["CallID"].Value;
                        row["LogEventTypeID"] = Convert.ToInt32(LogEventTypeConstant.EventType.Note);
                        row["LogEventName"] = "Recycled Call";
                        row["LogEventDesc"] = "Referral deleted by " + StattracIdentity.Identity.UserName + " on " + System.DateTime.Now.ToString() + " Reason: " + generalConstant.DeleteReason;
                        row["StatEmployeeID"] = StattracIdentity.Identity.UserId;
                        row["LogEventCallbackPending"] = 0;//setting defaults
                        row["LogEventDateTime"] = System.DateTime.Now;
                        row["ScheduleGroupID"] = 1;//setting defaults
                        row["PersonID"] = -1;//setting defaults
                        row["PhoneID"] = -1;//setting defaults
                        row["LogEventContactConfirmed"] = 0;//setting defaults
                        row["LogEventDeleted"] = 0;//setting defaults
                        row["LastStatEmployeeID"] = StattracIdentity.Identity.UserId;
                        logEventDS.LogEvent.AddLogEventRow(row);
                        base.SaveDataToDB();
                        LoadGrids();
                        Cursor.Current = Cursors.Default;
                        timer1.Start();
                    }
                }
            }
        }

        private void openInReadOnlyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CellsCollection cellsCollection = null;
            string callType = null;
            bool okToProceed = false;
            if (ugIncomplete.Selected.Rows.Count > 0 && ugPending.Selected.Rows.Count > 0)
                BaseMessageBox.Show("Please only select one row");
            else
            {
                if (ugPending.Selected.Rows.Count == 1 && ugPending.Selected.Rows[0].Cells != null)
                {
                    cellsCollection = ugPending.Selected.Rows[0].Cells;
                    callType = ugPending.Selected.Rows[0].Cells["CallType"].Value.ToString();
                    okToProceed = true;
                    timer1.Stop();
                }
                else
                {
                    if (ugIncomplete.Selected.Rows.Count == 1 && ugIncomplete.Selected.Rows[0].Cells != null)
                    {
                        cellsCollection = ugIncomplete.Selected.Rows[0].Cells;
                        callType = ugIncomplete.Selected.Rows[0].Cells["CallType"].Value.ToString();
                        okToProceed = true;
                        timer1.Stop();
                    }
                }
                if (okToProceed)
                {
                    Cursor.Current = Cursors.WaitCursor;
                    UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
                    if (callType.Contains("M") || callType.Contains("I"))
                    {
                        setMessageCallType(callType);
                        openstatTrac.Open(AppScreenType.VBMsgEventLogReadOnly, (int)cellsCollection[0].Value);
                        //Reset MessageCallType
                        GRConstant.MessageCallTypeID = 0;
                    }
                    else
                    {
                        openstatTrac.Open(AppScreenType.VBEventLogReadOnly, (int)cellsCollection[0].Value);
                    }
                    Cursor.Current = Cursors.Default;
                    timer1.Start();
                }
            }
        }

        private void ugPendingCases_DoubleClick(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            if (ugPendingCases.Selected.Rows.Count == 1 && ugPendingCases.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ugPendingCases.Selected.Rows[0].Cells;
                string callType = ugPendingCases.Selected.Rows[0].Cells["ReferralType"].Value.ToString();
                UIMap openstatTrac = VBUIMap.OpenStatTracVBForms.CreateInstance();
                if (callType.Contains("M") || callType.Contains("I"))
                {
                    setMessageCallType(callType);
                    openstatTrac.Open(AppScreenType.VBMsgEventLog, (int)cellsCollection[1].Value);

                    //Reset MessageCallType
                    GRConstant.MessageCallTypeID = 0;

                }
                else
                {
                    openstatTrac.Open(AppScreenType.VBEventLog, (int)cellsCollection[1].Value);
                }
                pendingCasesBR.SelectDataSet();
                BindDataToUIPendingCases();
            }
            Cursor.Current = Cursors.Default;
        }
    }
}
