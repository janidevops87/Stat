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

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class RecycledCasesControl : BaseGridSearch
    {
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        private MainControl mainControl;

        public RecycledCasesControl()
        {
            InitializeComponent();
            btnDelete.Visible = false;
            lblCallType.Visible = true;
            cbCallType.Visible = true; 
            FilterCondition filterConditionFrom = new FilterCondition();
            FilterCondition filterConditionTo = new FilterCondition();
            if (mainControl == null)
                mainControl = new MainControl();
            filterConditionFrom.CompareValue = System.DateTime.Now - System.TimeSpan.FromHours(12);
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].FilterConditions.Add(filterConditionFrom);
            filterConditionTo.CompareValue = System.DateTime.Now + System.TimeSpan.FromHours(12);
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].FilterConditions.Add(filterConditionTo);
            cbCallType.BindData("RecycleListCallTypeSelect");
            if (GRConstant.SelectedTab != "Recycled Cases (F8)")
                return;
            InitializeBR(new RecycledCasesBR());
        }

        public override void BindDataToUI()
        {
            if (BusinessRule != null)
            {
                ultraGrid.DataSource = BusinessRule.AssociatedDataSet;
                base.BindDataToUI();
                int rowsFound = ultraGrid.Rows.Count;
                int callId = int.MinValue;
                string strcallId = GetFilterConditionString("CallNumber");
                //handle if call not found and tell what tab
                if (int.TryParse(strcallId, out callId) && rowsFound == 0)
                {
                    DashboardHelperBR dashboardHelperBR = new DashboardHelperBR();
                    string textWhatTab;
                    textWhatTab = dashboardHelperBR.DashboardFindCall(callId);
                    BaseMessageBox.Show(callId + textWhatTab);
                }
            }
        }

        private void ultraGrid_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ultraGrid.ColumnDisplay(0, typeof(Cases), recycledCasesDS1.RecycledCases);
            if (cbCallType.SelectedIndex > 0)
            {
                if (Convert.ToInt32(cbCallType.SelectedValue) == 1)
                {
                    ultraGrid.ColumnDisplay(0, typeof(Cases), recycledCasesDS1.RecycledCases);
                    ultraGrid.DisplayLayout.Bands[0].Columns["OrganizationName"].Header.Caption = "Referral Facility";
                    ultraGrid.DisplayLayout.Bands[0].Columns["ReferralDonorFirstName"].Header.VisiblePosition = 6;
                    ultraGrid.DisplayLayout.Bands[0].Columns["ReferralDonorLastName"].Header.VisiblePosition = 7;
                    ultraGrid.DisplayLayout.Bands[0].Columns["OrganizationName"].Header.VisiblePosition = 8;
                    ultraGrid.DisplayLayout.Bands[0].Columns["SourceCodeName"].Header.VisiblePosition = 11;
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallNumber"].Width = 70;
                }
                
                if (Convert.ToInt32(cbCallType.SelectedValue) == 2 || Convert.ToInt32(cbCallType.SelectedValue) == 4)
                {
                    ultraGrid.ColumnDisplay(0, typeof(Messages), recycledCasesDS1.RecycledCases);
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallNumber"].Width = 81;
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Width = 142;
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallNumber"].Header.Caption = "Call #";
                    ultraGrid.DisplayLayout.Bands[0].Columns["MessageTypeName"].Header.Caption = "Type";
                    ultraGrid.DisplayLayout.Bands[0].Columns["MessageImportUNOSID"].Header.Caption = "OPTN #";
                    ultraGrid.DisplayLayout.Bands[0].Columns["PersonFirst"].Header.Caption = "For First Name";
                    ultraGrid.DisplayLayout.Bands[0].Columns["PersonLast"].Header.Caption = "For Last Name";
                    ultraGrid.DisplayLayout.Bands[0].Columns["OrganizationName"].Header.Caption = "Message for Organization";
                    ultraGrid.DisplayLayout.Bands[0].Columns["MessageCallerName"].Header.Caption = "Caller Name";
                    ultraGrid.DisplayLayout.Bands[0].Columns["MessageCallerOrganization"].Header.Caption = "Caller Organization";
                    ultraGrid.DisplayLayout.Bands[0].Columns["PersonFirst"].Header.VisiblePosition = 6;
                    ultraGrid.DisplayLayout.Bands[0].Columns["PersonLast"].Header.VisiblePosition = 7;
                    ultraGrid.DisplayLayout.Bands[0].Columns["OrganizationName"].Header.VisiblePosition = 8;
                    ultraGrid.DisplayLayout.Bands[0].Columns["MessageTypeName"].Header.VisiblePosition = 9;
                    ultraGrid.DisplayLayout.Bands[0].Columns["MessageImportUNOSID"].Header.VisiblePosition = 10;
                    ultraGrid.DisplayLayout.Bands[0].Columns["MessageCallerName"].Header.VisiblePosition = 11;
                    ultraGrid.DisplayLayout.Bands[0].Columns["MessageCallerOrganization"].Header.VisiblePosition = 12;
                    ultraGrid.DisplayLayout.Bands[0].Columns["SourceCodeName"].Header.VisiblePosition = 13;
                }
                if (Convert.ToInt32(cbCallType.SelectedValue) == 6)
                {
                    ultraGrid.ColumnDisplay(0, typeof(Oasis), recycledCasesDS1.RecycledCases);
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallId"].Header.Caption = "Oasis #";
                    ultraGrid.DisplayLayout.Bands[0].Columns["ImportOfferNumber"].Header.Caption = "Import #";
                    //ultraGrid.DisplayLayout.Bands[0].Columns["ReferralNumber"].Header.Caption = "Ref #";
                    ultraGrid.DisplayLayout.Bands[0].Columns["OrganType"].Header.Caption = "Organ Type";
                    ultraGrid.DisplayLayout.Bands[0].Columns["OptnNumber"].Header.Caption = "Optn #";
                    ultraGrid.DisplayLayout.Bands[0].Columns["MatchId"].Header.Caption = "Match ID";
                    ultraGrid.DisplayLayout.Bands[0].Columns["TransplantSurgeonContact"].Header.Caption = "Tx Surgeon";
                    ultraGrid.DisplayLayout.Bands[0].Columns["ClinicalCoordinator"].Header.Caption = "Clinical Coord.";
                    ultraGrid.DisplayLayout.Bands[0].Columns["CoordinatorFirstName"].Header.Caption = "Coord. First";
                    ultraGrid.DisplayLayout.Bands[0].Columns["CoordinatorLastName"].Header.Caption = "Coord. Last";
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallId"].Width = 70;
                }
            }
            ultraGrid.DisplayLayout.Bands[0].Override.TipStyleCell = Infragistics.Win.UltraWinGrid.TipStyle.Hide;
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].Column.MaskInput = "mm/dd/yyyy hh:mm";
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].Column.MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeBoth;
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].Column.MaskInput = "mm/dd/yyyy hh:mm";
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].Column.MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeBoth;
        }

        private void ultraGrid_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            CellsCollection cellsCollection = e.Row.Cells;
            //if (StattracIdentity.Identity.UserOrganizationId == Convert.ToInt32(GeneralConstant.Organizations.Statline))
            //{
            //if (cellsCollection["OrganizationID"].Value.ToString() != Convert.ToInt32(GeneralConstant.Organizations.Statline).ToString())
            if (cellsCollection["OrganizationID"].Value.ToString() != (StattracIdentity.Identity.UserOrganizationId).ToString())
            {
                e.Row.CellAppearance.BackColor = Color.LightBlue;
                e.Row.ToolTipText = "Client Created";
            }
            //}
        }

        protected override void ReloadGrid()
        {
            Cursor.Current = Cursors.WaitCursor;
            //refresh pending events and incompletes
            mainControl.LoadGrids();
            // create the Business rule object
            InitializeBR(new RecycledCasesBR());
            RecycledCasesBR recycledCasesBR = (RecycledCasesBR)BusinessRule;
            DateTime testDT;
            recycledCasesBR.CallNumber = GetFilterConditionString("CallNumber");
            recycledCasesBR.OrganizationName = GetFilterConditionString("OrganizationName");
            recycledCasesBR.SourceCodeName = GetFilterConditionString("SourceCodeName");
            recycledCasesBR.StatEmployeeFirstName = GetFilterConditionString("StatEmployeeFirstName");
            recycledCasesBR.StatEmployeeLastName = GetFilterConditionString("StatEmployeeLastName");
            if (Convert.ToInt32(cbCallType.SelectedValue) == 1)
            {
                recycledCasesBR.ReferralDonorFirstName = GetFilterConditionString("ReferralDonorFirstName");
                recycledCasesBR.ReferralDonorLastName = GetFilterConditionString("ReferralDonorLastName");
                recycledCasesBR.PreviousReferralTypeName = GetFilterConditionString("PrevReferralTypeName");
                recycledCasesBR.CurrentReferralTypeName = GetFilterConditionString("ReferralTypeName");
            }
            if (Convert.ToInt32(cbCallType.SelectedValue) == 2 || Convert.ToInt32(cbCallType.SelectedValue) == 4)
            {
                recycledCasesBR.CurrentReferralTypeName = GetFilterConditionString("MessageTypeName");
                recycledCasesBR.MessageCallerOrganization = GetFilterConditionString("MessageCallerOrganization");
                recycledCasesBR.Optn = GetFilterConditionString("MessageImportUNOSID");
                recycledCasesBR.ReferralDonorFirstName = GetFilterConditionString("PersonFirst");
                recycledCasesBR.ReferralDonorLastName = GetFilterConditionString("PersonLast");
            }
            if (Convert.ToInt32(cbCallType.SelectedValue) == 6)
            {
                recycledCasesBR.CallNumber = GetFilterConditionString("CallId");
                recycledCasesBR.Client = GetFilterConditionString("Client");
                recycledCasesBR.ImportOfferNumber = GetFilterConditionString("ImportOfferNumber");
                recycledCasesBR.OrganType = GetFilterConditionString("OrganType");
                recycledCasesBR.OptnNumber = GetFilterConditionString("OptnNumber");
                recycledCasesBR.MatchId = GetFilterConditionString("MatchId");
                recycledCasesBR.TransplantSurgeonContact = GetFilterConditionString("TransplantSurgeonContact");
                recycledCasesBR.ClinicalCoordinator = GetFilterConditionString("ClinicalCoordinator");
            }
            recycledCasesBR.StartDate = GetFilterConditionString("CallDateTime");
            if (recycledCasesBR.StartDate != null)
            {
                ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption = Convert.ToDateTime(recycledCasesBR.StartDate).ToString("MM/dd/yyyy HH:mm");
            }
            else
            {
                try
                {
                    testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption);
                    recycledCasesBR.StartDate = testDT.ToString();
                }
                catch
                {
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption = "Date/Time";
                }
            }
            recycledCasesBR.EndDate = GetFilterConditionString("ToDate");
            if (recycledCasesBR.EndDate != null)
            {
                ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(recycledCasesBR.EndDate).ToString("MM/dd/yyyy HH:mm");
            }
            else
            {
                try
                {
                    testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption);
                    recycledCasesBR.EndDate = testDT.ToString();
                }
                catch
                {
                    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
                }
            }
            int lengthOfSearchFilter = GetLengthOfDateTimeFilter(recycledCasesBR);
            TimeSpan timediff = DateTime.Parse(recycledCasesBR.EndDate) - DateTime.Parse(recycledCasesBR.StartDate);
            if (timediff.Days > 90)
            {
                BaseMessageBox.Show("You are not allowed to search for more than 90 days...thank you.");

            }
            else
            {
                int useableTimeDiffDays;
                //if there is a fraction, add a day
                // else use days without a decimal
                if (timediff.TotalDays % timediff.Days > 0)
                {
                    useableTimeDiffDays = timediff.Days + 1;
                }
                else
                {
                    useableTimeDiffDays = timediff.Days;
                }
                if (useableTimeDiffDays > lengthOfSearchFilter)
                {
                    BaseMessageBox.Show("You have exceeded the number of days in the date range per character of search criteria.  You are allowed 7 days per character up to 90 days. Thank you.");
                    //ClearFilter();
                }
                else
                {
                    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].ClearFilterConditions();
                    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].ClearFilterConditions();
                    if (cbCallType.SelectedIndex > 0)
                        recycledCasesBR.CallRecycleType(Convert.ToInt32(cbCallType.SelectedValue));
                    RefreshPage();
                    Cursor.Current = Cursors.Default;
                }
            }
        }

        private string GetFilterConditionString(string columnName)
        {
            string returnValue = null;
            FilterConditionsCollection filterConditions = ultraGrid.DisplayLayout.Bands[0].ColumnFilters[columnName].FilterConditions;
            if (filterConditions.Count == 1)
            {
                returnValue = filterConditions[0].CompareValue.ToString();
            }
            return returnValue;
        }
        public void Reload()
        {
            this.ReloadGrid();
        }
                
        private void RestoreCall_Click()
        {
            Cursor.Current = Cursors.WaitCursor;
            RecycledCasesBR recycledCasesBR = (RecycledCasesBR)BusinessRule;
            if ((cbCallType.SelectedIndex > 0) && (Convert.ToInt32(cbCallType.SelectedValue) == 6))
            {
                recycledCasesBR.CallRecycleUpdateOasis(generalConstant.RecycleCallID, 1, StattracIdentity.Identity.UserId);
            }
            else
            {
                recycledCasesBR.RecycleCallsRestore(generalConstant.RecycleCallID, StattracIdentity.Identity.UserId);
            }
            //write log event
            InitializeBR(new LogEventBR());
            LogEventBR logEventBR = (LogEventBR)BusinessRule;
            LogEventDS logEventDS = (LogEventDS)BusinessRule.AssociatedDataSet;
            LogEventDS.LogEventRow row;
            row = logEventDS.LogEvent.NewLogEventRow();
            row["CallID"] = generalConstant.RecycleCallID;
            row["LogEventTypeID"] = Convert.ToInt32(LogEventTypeConstant.EventType.Note);
            row["LogEventName"] = "Restored Call";
            row["LogEventDesc"] = "Call restored by " + StattracIdentity.Identity.UserName + " on " + System.DateTime.Now.ToString();
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
            Reload();
            Cursor.Current = Cursors.Default;
        }

        private void cbCallType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbCallType.SelectedIndex > 0)
            {
                InitializeBR(new RecycledCasesBR());
                RecycledCasesBR recycledCasesBR = (RecycledCasesBR)BusinessRule;
                recycledCasesBR.CallRecycleType(Convert.ToInt32(cbCallType.SelectedValue));
                RefreshPage();
                //Reload();
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(AppScreenType.VBNew, 0);
            Cursor.Current = Cursors.Default;
        }

        private void btnClearFilter_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            ClearFilter();
        }

        private void ClearFilter()
        {
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters.ClearAllFilters();
            FilterCondition filterConditionFrom = new FilterCondition();
            FilterCondition filterConditionTo = new FilterCondition();
            filterConditionFrom.CompareValue = System.DateTime.Now - System.TimeSpan.FromHours(12);
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].FilterConditions.Add(filterConditionFrom);
            filterConditionTo.CompareValue = System.DateTime.Now + System.TimeSpan.FromHours(12);
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].FilterConditions.Add(filterConditionTo);
            this.ReloadGrid();
        }

        private void ultraGrid_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                GRConstant.RecycleCallID = (int)cellsCollection["CallID"].Value;
                if (Convert.ToInt32(cbCallType.SelectedValue) == 1 || Convert.ToInt32(cbCallType.SelectedValue) == 0)
                {
                    RestoreCasesPopUp restoreCasesPopUp = new Statline.Stattrac.Windows.UI.Controls.Dashboard.RestoreCasesPopUp();
                    restoreCasesPopUp.ShowDialog();
                }
                if (Convert.ToInt32(cbCallType.SelectedValue) == 2 || Convert.ToInt32(cbCallType.SelectedValue) == 4)
                {
                    RestoreMessagesPopUp restoreCasesPopUp = new Statline.Stattrac.Windows.UI.Controls.Dashboard.RestoreMessagesPopUp();
                    restoreCasesPopUp.ShowDialog();
                }
                if (Convert.ToInt32(cbCallType.SelectedValue) == 6)
                {
                    GRConstant.ReferralId = (int)cellsCollection["CallID"].Value;
                    GRConstant.TcssDonorId = (int)cellsCollection["TcssDonorId"].Value;
                    GRConstant.TcssRecipientId = (int)cellsCollection["TcssRecipientId"].Value;
                    if (cellsCollection["MatchId"].Value != DBNull.Value)
                        GRConstant.OasisMatchID = (string)cellsCollection["MatchId"].Value;
                    if (cellsCollection["OptnNumber"].Value != DBNull.Value)
                        GRConstant.OasisOPTN = (string)cellsCollection["OptnNumber"].Value;
                    if (cellsCollection["OrganType"].Value != DBNull.Value)
                        GRConstant.OasisOrgan = (string)cellsCollection["OrganType"].Value;
                    RestoreOASISPopUp restoreOASISPopUp = new Statline.Stattrac.Windows.UI.Controls.Dashboard.RestoreOASISPopUp();
                    restoreOASISPopUp.ShowDialog();
                    GRConstant.ReferralId = int.MinValue;
                }
                if (generalConstant.RestoreCall)
                {
                    RestoreCall_Click();
                    if (Convert.ToInt32(cbCallType.SelectedValue) == 1 || Convert.ToInt32(cbCallType.SelectedValue) == 0)
                    {
                        UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
                        openstatTrac.Open(AppScreenType.VBReferral, GRConstant.RecycleCallID);
                    }
                    if (Convert.ToInt32(cbCallType.SelectedValue) == 2 || Convert.ToInt32(cbCallType.SelectedValue) == 4)
                    {
                        UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
                        openstatTrac.Open(AppScreenType.VBMessage, GRConstant.RecycleCallID);
                    }
                    if (Convert.ToInt32(cbCallType.SelectedValue) == 6)
                    {
                        ((BaseForm)FindForm()).LoadSubControl(AppScreenType.NewCall, AppScreenType.Tcss);
                    }
                }
            }
        }

        private int GetLengthOfDateTimeFilter(RecycledCasesBR recycledCasesBR)
        {
            // start at one to allow 7 days minimum search
            int length = 1;
            if (recycledCasesBR.CallNumber != null)
            {
                // if 7 or more numbers are entered than ignore the date range.
                if (recycledCasesBR.CallNumber.Length > 6)
                {
                    return int.MaxValue;
                }
                else
                {
                    length += recycledCasesBR.CallNumber.Length;
                }
            }
            //next group all grids have in common
            if (recycledCasesBR.StatEmployeeFirstName != null)
            {
                length += recycledCasesBR.StatEmployeeFirstName.Length;
            }
            if (recycledCasesBR.StatEmployeeLastName != null)
            {
                length += recycledCasesBR.StatEmployeeLastName.Length;
            }
            if (recycledCasesBR.SourceCodeName != null)
            {
                length += recycledCasesBR.SourceCodeName.Length;
            }
            if (recycledCasesBR.OrganizationName != null)
            {
                length += recycledCasesBR.OrganizationName.Length;
            }
            //filter test by type now
            if (Convert.ToInt32(cbCallType.SelectedValue) == 1 || Convert.ToInt32(cbCallType.SelectedValue) == 0)
            {
                if (recycledCasesBR.ReferralDonorFirstName != null)
                    length += recycledCasesBR.ReferralDonorFirstName.Length;
                if (recycledCasesBR.ReferralDonorLastName != null)
                    length += recycledCasesBR.ReferralDonorLastName.Length;
                if (recycledCasesBR.PreviousReferralTypeName != null)
                    length += recycledCasesBR.PreviousReferralTypeName.Length;
            }
            if (Convert.ToInt32(cbCallType.SelectedValue) == 2 || Convert.ToInt32(cbCallType.SelectedValue) == 4)
            {
                if (recycledCasesBR.CurrentReferralTypeName != null)
                    length += recycledCasesBR.CurrentReferralTypeName.Length; 
                if (recycledCasesBR.MessageCallerOrganization != null)
                    length += recycledCasesBR.MessageCallerOrganization.Length;
                if (recycledCasesBR.Optn != null)
                    length += recycledCasesBR.Optn.Length;
                if (recycledCasesBR.ReferralDonorFirstName != null)
                    length += recycledCasesBR.ReferralDonorFirstName.Length;
                if (recycledCasesBR.ReferralDonorLastName != null)
                    length += recycledCasesBR.ReferralDonorLastName.Length;
            }
            if (Convert.ToInt32(cbCallType.SelectedValue) == 6)
            {
                if (recycledCasesBR.Client != null)
                    length += recycledCasesBR.Client.Length;
                if (recycledCasesBR.ImportOfferNumber != null)
                    length += recycledCasesBR.ImportOfferNumber.Length;
                if (recycledCasesBR.OrganType != null)
                    length += recycledCasesBR.OrganType.Length;
                if (recycledCasesBR.OptnNumber != null)
                    length += recycledCasesBR.OptnNumber.Length;
                if (recycledCasesBR.MatchId != null)
                    length += recycledCasesBR.MatchId.Length;
                if (recycledCasesBR.TransplantSurgeonContact != null)
                    length += recycledCasesBR.TransplantSurgeonContact.Length;
                if (recycledCasesBR.ClinicalCoordinator != null)
                    length += recycledCasesBR.ClinicalCoordinator.Length;
            }
            
            // for each value entered they are allowed 7 more days
            return length * 7;
        }

        private void ultraGrid_CellDataError(object sender, CellDataErrorEventArgs e)
        {
            UltraGrid ug = sender as UltraGrid;
            switch (ug.ActiveCell.Column.Key)
            {                     
                case "CallDateTime":
                    ultraGrid.ValidDateTime(ug.ActiveCell);
                    e.RaiseErrorEvent = false;
                    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].ClearFilterConditions();
                    break;
                case "ToDate":
                    ultraGrid.ValidDateTime(ug.ActiveCell);
                    e.RaiseErrorEvent = false;
                    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].ClearFilterConditions();
                    break;

            }
        }
    }
}
