using System;
using System.Drawing;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using System.Windows.Forms;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class UpdateControl : BaseGridSearch
    {
        private MainControl mainControl;

        public UpdateControl()
        {
            InitializeComponent();
            btnDelete.Visible = false;
            FilterCondition filterConditionFrom = new FilterCondition();
            FilterCondition filterConditionTo = new FilterCondition();
            if (mainControl == null)
                mainControl = new MainControl();
            filterConditionFrom.CompareValue = System.DateTime.Now - System.TimeSpan.FromHours(12);
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].FilterConditions.Add(filterConditionFrom);
            filterConditionTo.CompareValue = System.DateTime.Now + System.TimeSpan.FromHours(12);
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].FilterConditions.Add(filterConditionTo);
            recycleToolStripMenuItem.Visible = false;
            this.openInReadOnlyToolStripMenuItem.Click += new System.EventHandler(this.ultraGrid_RightClick);
            if (GRConstant.SelectedTab != "Updates (F7)")
                return;
            InitializeBR(new UpdateBR());
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

        protected override void ReloadGrid()
        {
            Cursor.Current = Cursors.WaitCursor;
            // create the Business rule object
            InitializeBR(new UpdateBR());
            UpdateBR updateBR = (UpdateBR)BusinessRule;
            DateTime testDT;
            updateBR.CallNumber = GetFilterConditionString("CallNumber");
            updateBR.StatAbbreviation = GetFilterConditionString("StateAbbrv");
            updateBR.OrganizationName = GetFilterConditionString("OrganizationName");
            updateBR.ReferralDonorFirstName = GetFilterConditionString("ReferralDonorFirstName");
            updateBR.ReferralDonorLastName = GetFilterConditionString("ReferralDonorLastName");
            updateBR.PreviousReferralTypeName = GetFilterConditionString("PrevReferralTypeName");
            updateBR.CurrentReferralTypeName = GetFilterConditionString("ReferralTypeName");
            updateBR.SourceCodeName = GetFilterConditionString("SourceCodeName");
            updateBR.StatEmployeeFirstName = GetFilterConditionString("StatEmployeeFirstName");
            updateBR.StatEmployeeLastName = GetFilterConditionString("StatEmployeeLastName");
            updateBR.StartDate = GetFilterConditionString("CallDateTime");
            if (updateBR.StartDate != null)
            {
                ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption = Convert.ToDateTime(updateBR.StartDate).ToString("MM/dd/yyyy HH:mm");
            }
            else
            {
                try
                {
                    testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption);
                    updateBR.StartDate = testDT.ToString();
                }
                catch
                {
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption = "Date/Time";
                }
            }
            updateBR.EndDate = GetFilterConditionString("ToDate");
            if (updateBR.EndDate != null)
            {
                ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(updateBR.EndDate).ToString("MM/dd/yyyy HH:mm");
            }
            else
            {
                try
                {
                    testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption);
                    updateBR.EndDate = testDT.ToString();
                }
                catch
                {
                    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
                }
            }
            int lengthOfSearchFilter = GetLengthOfDateTimeFilter(updateBR);
            TimeSpan timediff = DateTime.Parse(updateBR.EndDate) - DateTime.Parse(updateBR.StartDate);
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
                    RefreshPage();
                    Cursor.Current = Cursors.Default;
                }
            }
            //refresh pending events and incompletes
            mainControl.LoadGrids();
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

        public void Reload()
        {
            this.ReloadGrid();
        }

        private void ultraGrid_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ultraGrid.DisplayLayout.Bands[0].Override.TipStyleCell = Infragistics.Win.UltraWinGrid.TipStyle.Hide;
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].Column.MaskInput = "mm/dd/yyyy hh:mm";
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].Column.MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeBoth;
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].Column.MaskInput = "mm/dd/yyyy hh:mm";
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].Column.MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeBoth;
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallNumber"].Column.Width = 66;
        }

        private void ultraGrid_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                NavigateToEditScreen((int)cellsCollection[0].Value);
            }
        }
        private void ultraGrid_RightClick(object sender, EventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
                openstatTrac.Open(AppScreenType.VBReferralReadOnly, (int)cellsCollection[0].Value);
            }
        }
        protected void NavigateToEditScreen(int callID)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(AppScreenType.VBReferral, callID);

        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(AppScreenType.VBNew, 0);
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

        private int GetLengthOfDateTimeFilter(UpdateBR updateBR)
        {
            // start at one to allow 7 days minimum search
            int length = 1;
            if (updateBR.CallNumber != null)
            {
                // if 7 or more numbers are entered than ignore the date range.
                if (updateBR.CallNumber.Length > 6)
                {
                    return int.MaxValue;
                }
                else
                {
                    length += updateBR.CallNumber.Length;
                }
            }
            if (updateBR.OrganizationName != null)
                length += updateBR.OrganizationName.Length;
            if (updateBR.PreviousReferralTypeName != null)
                length += updateBR.PreviousReferralTypeName.Length;
            if (updateBR.StatAbbreviation != null)
                length += updateBR.StatAbbreviation.Length;
            if (updateBR.ReferralDonorFirstName != null)
                length += updateBR.ReferralDonorFirstName.Length;
            if (updateBR.ReferralDonorLastName != null)
                length += updateBR.ReferralDonorLastName.Length;
            if (updateBR.SourceCodeName != null)
                length += updateBR.SourceCodeName.Length;
            if (updateBR.StatEmployeeFirstName != null)
                length += updateBR.StatEmployeeFirstName.Length;
            if (updateBR.StatEmployeeLastName != null)
                length += updateBR.StatEmployeeLastName.Length;
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

        private void ultraGrid_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
                contextMenuStrip1.Show(Control.MousePosition.X, Control.MousePosition.Y);
        }
    }
}

