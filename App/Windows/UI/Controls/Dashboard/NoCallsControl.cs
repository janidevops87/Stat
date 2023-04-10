using System;
using System.Drawing;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Security;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class NoCallsControl : BaseGridSearch
    {
        private SecurityHelper securityHelper;
        private MainControl mainControl;

        public NoCallsControl()
        {
            InitializeComponent();
            securityHelper = Security.SecurityHelper.GetInstance();
            if (!securityHelper.Authorized(SecurityRule.Delete_Call.ToString()))
            {
                btnDelete.Visible = false;
                recycleToolStripMenuItem.Visible = false;
            }
            this.recycleToolStripMenuItem.Click += new System.EventHandler(this.btnDelete_Click);
            this.openInReadOnlyToolStripMenuItem.Click += new System.EventHandler(this.ultraGrid_RightClick);
            FilterCondition filterConditionFrom = new FilterCondition();
            FilterCondition filterConditionTo = new FilterCondition();
            if (mainControl == null)
                mainControl = new MainControl();
            filterConditionFrom.CompareValue = System.DateTime.Now - System.TimeSpan.FromHours(12);
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallDateTime"].FilterConditions.Add(filterConditionFrom);
            filterConditionTo.CompareValue = System.DateTime.Now + System.TimeSpan.FromHours(12);
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].FilterConditions.Add(filterConditionTo);
            if (GRConstant.SelectedTab != "No Calls (F9)")
                return;
            InitializeBR(new NoCallsBR());
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
            //refresh pending events and incompletes
            mainControl.LoadGrids();
            // create the Business rule object
            InitializeBR(new NoCallsBR());
            NoCallsBR noCallsBR = (NoCallsBR)BusinessRule;
            DateTime testDT;
            noCallsBR.CallNumber = GetFilterConditionString("CallNumber");
            noCallsBR.NoCallTypeName = GetFilterConditionString("NoCallTypeName");
            noCallsBR.NoCallDescription = GetFilterConditionString("NoCallDescription");
            noCallsBR.SourceCodeName = GetFilterConditionString("SourceCodeName");
            noCallsBR.StatEmployeeFirstName = GetFilterConditionString("StatEmployeeFirstName");
            noCallsBR.StatEmployeeLastName = GetFilterConditionString("StatEmployeeLastName");
            noCallsBR.StartDateTime = GetFilterConditionString("CallDateTime");
            if (noCallsBR.StartDateTime != null)
            {
                ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption = Convert.ToDateTime(noCallsBR.StartDateTime).ToString("MM/dd/yyyy HH:mm");
            }
            else
            {
                try
                {
                    testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption);
                    noCallsBR.StartDateTime = testDT.ToString();
                }
                catch
                {
                    ultraGrid.DisplayLayout.Bands[0].Columns["CallDateTime"].Header.Caption = "Date/Time";
                }
            }
            noCallsBR.EndDateTime = GetFilterConditionString("ToDate");
            if (noCallsBR.EndDateTime != null)
            {
                ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(noCallsBR.EndDateTime).ToString("MM/dd/yyyy HH:mm");
            }
            else
            {
                try
                {
                    testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption);
                    noCallsBR.EndDateTime = testDT.ToString();
                }
                catch
                {
                    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
                }
            }
            int lengthOfSearchFilter = GetLengthOfDateTimeFilter(noCallsBR);
            TimeSpan timediff = DateTime.Parse(noCallsBR.EndDateTime) - DateTime.Parse(noCallsBR.StartDateTime);
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

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                DialogResult dialogResult = BaseMessageBox.ShowYesNo(
                    "Are you sure you want to delete this call");
                switch (dialogResult)
                {
                    case DialogResult.Yes:
                        CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                        InitializeBR(new RecycledCasesBR());
                        RecycledCasesBR recycledCasesBR = (RecycledCasesBR)BusinessRule;
                        recycledCasesBR.RecycleCallsDelete((int)cellsCollection[0].Value, StattracIdentity.Identity.UserId);
                        Reload();
                        break;
                    default:
                        break;
                }
            }
        }

        private void ultraGrid_DoubleClickRow(object sender, DoubleClickRowEventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                NavigateToScreen(AppScreenType.VBNoCall,(int)cellsCollection[0].Value);
            }
            Cursor.Current = Cursors.Default;
        }
        
        private void ultraGrid_RightClick(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                NavigateToScreen(AppScreenType.VBNoCallReadOnly, (int)cellsCollection[0].Value);
            }
            Cursor.Current = Cursors.Default;
        }
        protected void NavigateToScreen(AppScreenType screenType,int callID)
        {
            UIMap openstatTrac = Statline.Stattrac.Windows.VBUIMap.OpenStatTracVBForms.CreateInstance();
            openstatTrac.Open(screenType, callID);
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

        private int GetLengthOfDateTimeFilter(NoCallsBR noCallsBR)
        {
            // start at one to allow 7 days minimum search
            int length = 1;
            if (noCallsBR.CallNumber != null)
            {
                // if 7 or more numbers are entered than ignore the date range.
                if (noCallsBR.CallNumber.Length > 6)
                {
                    return int.MaxValue;
                }
                else
                {
                    length += noCallsBR.CallNumber.Length;
                }
            }
            if (noCallsBR.NoCallDescription != null)
                length += noCallsBR.NoCallDescription.Length;
            if (noCallsBR.NoCallTypeName != null)
                length += noCallsBR.NoCallTypeName.Length;
            if (noCallsBR.SourceCodeName != null)
                length += noCallsBR.SourceCodeName.Length;
            if (noCallsBR.StatEmployeeFirstName != null)
                length += noCallsBR.StatEmployeeFirstName.Length;
            if (noCallsBR.StatEmployeeLastName != null)
                length += noCallsBR.StatEmployeeLastName.Length;
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
