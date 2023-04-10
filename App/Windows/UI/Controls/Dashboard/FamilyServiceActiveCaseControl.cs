using System;
using System.Drawing;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.Enum;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.Constant.List;
using Statline.Stattrac.Security;


using Statline.Stattrac.Windows.Forms;


namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
    public partial class FamilyServiceActiveCaseControl : BaseGridSearch
    {
        private SecurityHelper securityHelper;
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();

        public FamilyServiceActiveCaseControl()
        {
            InitializeComponent();
            //FilterCondition filterConditionFrom = new FilterCondition();
            //FilterCondition filterConditionTo = new FilterCondition();
            //filterConditionFrom.CompareValue = DateTime.MinValue;
            //ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].FilterConditions.Add(filterConditionFrom);
            //filterConditionTo.CompareValue = DateTime.MaxValue;
            //ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].FilterConditions.Add(filterConditionTo);
            securityHelper = Security.SecurityHelper.GetInstance();
            if (!securityHelper.Authorized(SecurityRule.Delete_Call.ToString()))
                btnDelete.Visible = false;
            TimerEnabled = true;
            if (GRConstant.SelectedTab != "FS Active Cases (F5)")
                return;
            this.recycleToolStripMenuItem.Click += new System.EventHandler(this.btnDelete_Click);
            InitializeBR(new FamilyServiceActiveCaseBR());
            ultraGrid.InitializeRow += new InitializeRowEventHandler(ultraGrid_InitializeRow);
            ultraGrid.AfterRowFilterChanged += new AfterRowFilterChangedEventHandler(ultraGrid_AfterRowFilterChanged);
        }

        void ultraGrid_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].Column.MaskInput = "mm/dd/yyyy hh:mm";
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].Column.MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeBoth;
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].Column.MaskInput = "mm/dd/yyyy hh:mm";
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].Column.MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeBoth;
            ultraGrid.DisplayLayout.Bands[0].Override.TipStyleCell = Infragistics.Win.UltraWinGrid.TipStyle.Hide;
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallId"].Column.Width = 54;
        }
        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;

                if (cellsCollection["PatientFirst"].Value != DBNull.Value)
                    generalConstant.DeletePatientFirstName = (string)cellsCollection["PatientFirst"].Value;
                if (cellsCollection["PatientLast"].Value != DBNull.Value)
                    generalConstant.DeletePatientLastName = (string)cellsCollection["PatientLast"].Value;
                DeleteCasesPopUp deleteCasesPopUp = new Statline.Stattrac.Windows.UI.Controls.Dashboard.DeleteCasesPopUp();
                deleteCasesPopUp.ShowDialog();
                if (generalConstant.DeleteCall)
                {
                    Cursor.Current = Cursors.WaitCursor;
                    //recycle call
                    InitializeBR(new RecycledCasesBR());
                    RecycledCasesBR recycledCasesBR = (RecycledCasesBR)BusinessRule;
                    recycledCasesBR.RecycleCallsDelete((int)cellsCollection[0].Value, StattracIdentity.Identity.UserId);
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
                    Reload();
                    Cursor.Current = Cursors.Default;
                }
            }
        }
        private void ultraGrid_AfterRowFilterChanged(object sender, AfterRowFilterChangedEventArgs e)
        {
            //if (e.NewColumnFilter.FilterConditions.Count == 0)
            //{
            //    RefreshPage();
            //}
            //else if (e.Column.Key == "MostRecentStatus" &&
            //    e.NewColumnFilter.FilterConditions.Count == 1 &&
            //    e.NewColumnFilter.FilterConditions[0].CompareValue.ToString().ToLower(GRConstant.StattracCulture) == ListFsbStatus.Closed.ToLower(GRConstant.StattracCulture))
            //{
            //    bool isFilterCriteriaMet = true;
            //    FamilyServiceActiveCaseBR familyServiceActiveCaseBR = (FamilyServiceActiveCaseBR)BusinessRule;
            //    FilterConditionsCollection lastModifiedFilters = ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].FilterConditions;
            //    if (lastModifiedFilters.Count == 2)
            //    {
            //        for (int index = 0; index < lastModifiedFilters.Count; index++)
            //        {
            //            if (lastModifiedFilters[index].ComparisionOperator == FilterComparisionOperator.GreaterThan)
            //            {
            //                familyServiceActiveCaseBR.MinLastUpdateDate = DateTime.Parse(lastModifiedFilters[index].CompareValue.ToString(), GRConstant.StattracCulture).ToUniversalTime();
            //            }
            //            else if (lastModifiedFilters[index].ComparisionOperator == FilterComparisionOperator.LessThan)
            //            {
            //                familyServiceActiveCaseBR.MaxLastUpdateDate = DateTime.Parse(lastModifiedFilters[index].CompareValue.ToString(), GRConstant.StattracCulture).ToUniversalTime();
            //            }
            //            else
            //            {
            //                 isFilterCriteriaMet = false;
            //            }
            //        }
            //    }
            //    else
            //    {
            //        isFilterCriteriaMet = false;
            //    }

            //    if(isFilterCriteriaMet)
            //    {
            //        familyServiceActiveCaseBR.MostRecentStatus = ListFsbStatus.Closed;
            //        RefreshPage();
            //        familyServiceActiveCaseBR.MostRecentStatus = null;
            //        familyServiceActiveCaseBR.MinLastUpdateDate = DateTime.MinValue;
            //        familyServiceActiveCaseBR.MaxLastUpdateDate = DateTime.MinValue;
            //    }
            //    else
            //    {
            //        BaseMessageBox.Show(UIConstant.FamilyServiceActiveCaseControlDateRangeRequired);
            //        e.NewColumnFilter.FilterConditions.Clear();
            //    }
            //}
        }

        private void ultraGrid_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            CellsCollection cellsCollection = e.Row.Cells;
            //isasporganization was slowing the sql significantly...use code below to show asp created
            //if (cellsCollection["IsAspLeaseOrganization"].Value.ToString() == "1")
            //{
            //    e.Row.CellAppearance.BackColor = Color.LightBlue;
            //    e.Row.ToolTipText = "Client Created";
            //}
            if (StattracIdentity.Identity.UserOrganizationId == Convert.ToInt32(GeneralConstant.Organizations.Statline))
            {
                if (cellsCollection["OrganizationID"].Value.ToString() != Convert.ToInt32(GeneralConstant.Organizations.Statline).ToString())
                {
                    e.Row.CellAppearance.BackColor = Color.LightBlue;
                    e.Row.ToolTipText = "Client Created";
                }
            }
            if (cellsCollection["MostRecentStatus"].Value.ToString() == ListFsbStatus.SecondaryPending)
            {
                DateTime lastModified = (DateTime)cellsCollection["LastModified"].Value;
                if (lastModified.AddMinutes((int)(cellsCollection["expirationminutes"].Value)) < GRConstant.CurrentDateTime)
                {
                    e.Row.CellAppearance.BackColor = Color.LightCoral;
                }
            }
        }

        protected override void UltraGridDoubleClick()
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                NavigateToEditScreen((int)cellsCollection[0].Value);
            }
        }

        protected override void NavigateToAddScreen()
        {
            NavigateToEditScreen(int.MinValue);
        }

        private void NavigateToEditScreen(int newValue)
        {
            if (AllowNavigateToEditScreen())
            {
                GeneralConstant generalConstant = GeneralConstant.CreateInstance();
                generalConstant.ReferralId = newValue;
                ((BaseForm)FindForm()).LoadSubControl(AppScreenType.NewCall, AppScreenType.NewCallFamilyServices);
            }
        }

        public override void BindDataToUI()
        {
            ultraGrid.UltraGridType = UltraGridType.Search;
            if (BusinessRule != null)
            {
                ultraGrid.DataSource = BusinessRule.AssociatedDataSet;
                base.BindDataToUI();
                int rowsFound = ultraGrid.Rows.Count;
                int callId = int.MinValue;
                string strcallId = GetFilterConditionString("CallId");
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

        private void btnSearch_Click(object sender, EventArgs e)
        {
        //    FamilyServiceActiveCaseBR familyServiceActiveCaseBR = (FamilyServiceActiveCaseBR)BusinessRule;
        //    familyServiceActiveCaseBR.CallId = GetFilterConditionString("CallId");
        //    familyServiceActiveCaseBR.CoordinatorFirst = GetFilterConditionString("CoordinatorFirst");
        //    familyServiceActiveCaseBR.CoordinatorLast = GetFilterConditionString("CoordinatorLast");
        //    familyServiceActiveCaseBR.MostRecentComment = GetFilterConditionString("MostRecentComment");
        //    familyServiceActiveCaseBR.MostRecentStatus = GetFilterConditionString("MostRecentStatus");
        //    familyServiceActiveCaseBR.PatientFirst = GetFilterConditionString("PatientFirst");
        //    familyServiceActiveCaseBR.PatientLast = GetFilterConditionString("PatientLast");
        //    familyServiceActiveCaseBR.PreviousCoordinatorFirst = GetFilterConditionString("PreviousCoordinatorFirst");
        //    familyServiceActiveCaseBR.PreviousCoordinatorLast = GetFilterConditionString("PreviousCoordinatorLast");
        //    familyServiceActiveCaseBR.SourceCodeName = GetFilterConditionString("SourceCodeName");

        //    //FilterConditionsCollection lastModifiedFilters = ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastUpdateDate"].FilterConditions;
        //    //if (lengthOfSearchFilter == int.MaxValue)
        //    //{
        //    //    isFilterCriteriaMet = true;
        //    //}
        //    //else
        //    //{
        //    DateTime testDT;
        //    string filterValue;
        //    filterValue = GetFilterConditionString("LastModified");
        //    if (filterValue != null)
        //        familyServiceActiveCaseBR.MinLastUpdateDate = DateTime.Parse(GetFilterConditionString("LastModified"));
        //    if (familyServiceActiveCaseBR.MinLastUpdateDate != null)
        //    {
        //        ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = Convert.ToDateTime(familyServiceActiveCaseBR.MinLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
        //    }
        //    else
        //    {
        //        try
        //        {
        //            testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption);
        //            familyServiceActiveCaseBR.MinLastUpdateDate = testDT;
        //        }
        //        catch
        //        {
        //            ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
        //        }
        //    }
        //    filterValue = GetFilterConditionString("ToDate");
        //    if (filterValue != null)
        //        familyServiceActiveCaseBR.MaxLastUpdateDate = DateTime.Parse(GetFilterConditionString("ToDate"));
        //    if (familyServiceActiveCaseBR.MaxLastUpdateDate != null)
        //    {
        //        ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(familyServiceActiveCaseBR.MaxLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
        //    }
        //    else
        //    {
        //        try
        //        {
        //            testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption);
        //            familyServiceActiveCaseBR.MaxLastUpdateDate = testDT;
        //        }
        //        catch
        //        {
        //            ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
        //        }
        //    }
        //    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].ClearFilterConditions();
        //    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].ClearFilterConditions();

        //    RefreshPage();
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

        protected override void ReloadGrid()
        {
            Cursor.Current = Cursors.WaitCursor;
            InitializeBR(new FamilyServiceActiveCaseBR());
            FamilyServiceActiveCaseBR familyServiceActiveCaseBR = (FamilyServiceActiveCaseBR)BusinessRule;
            familyServiceActiveCaseBR.CallId = GetFilterConditionString("CallId");
            familyServiceActiveCaseBR.CoordinatorFirst = GetFilterConditionString("CoordinatorFirst");
            familyServiceActiveCaseBR.CoordinatorLast = GetFilterConditionString("CoordinatorLast");
            familyServiceActiveCaseBR.MostRecentComment = GetFilterConditionString("MostRecentComment");
            familyServiceActiveCaseBR.MostRecentStatus = GetFilterConditionString("MostRecentStatus");
            familyServiceActiveCaseBR.PatientFirst = GetFilterConditionString("PatientFirst");
            familyServiceActiveCaseBR.PatientLast = GetFilterConditionString("PatientLast");
            familyServiceActiveCaseBR.PreviousCoordinatorFirst = GetFilterConditionString("PreviousCoordinatorFirst");
            familyServiceActiveCaseBR.PreviousCoordinatorLast = GetFilterConditionString("PreviousCoordinatorLast");
            familyServiceActiveCaseBR.SourceCodeName = GetFilterConditionString("SourceCodeName");
            string filterValueFrom = null;
            string filterValueTo = null;
            string filterValueStatus = null;
            if (familyServiceActiveCaseBR.MostRecentStatus != null)
                filterValueStatus = familyServiceActiveCaseBR.MostRecentStatus.ToLower();
            filterValueFrom = GetFilterConditionString("LastModified");
            filterValueTo = GetFilterConditionString("ToDate");
            if (filterValueStatus != null && filterValueStatus.Contains("closed") && filterValueFrom == null && filterValueTo == null)
            {
                BaseMessageBox.Show("You are not allowed to search for closed cases without dates");
            }
            else
            {
                DateTime testDT;

                if (filterValueFrom != null)
                {
                    familyServiceActiveCaseBR.MinLastUpdateDate = DateTime.Parse(GetFilterConditionString("LastModified"));
                    ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = Convert.ToDateTime(familyServiceActiveCaseBR.MinLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
                }
                else
                    ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
                //if (familyServiceActiveCaseBR.MinLastUpdateDate != null)
                //{
                //    ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = Convert.ToDateTime(familyServiceActiveCaseBR.MinLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
                //}
                //else
                //{
                    try
                    {
                        testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption);
                        familyServiceActiveCaseBR.MinLastUpdateDate = testDT;
                    }
                    catch
                    {
                        ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
                    }
                //}

                if (filterValueTo != null)
                {
                    familyServiceActiveCaseBR.MaxLastUpdateDate = DateTime.Parse(GetFilterConditionString("ToDate"));
                    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(familyServiceActiveCaseBR.MaxLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
                }
                else
                    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";

                //if (familyServiceActiveCaseBR.MaxLastUpdateDate != null)
                //{
                //    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(familyServiceActiveCaseBR.MaxLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
                //}
                //else
                //{
                    try
                    {
                        testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption);
                        familyServiceActiveCaseBR.MaxLastUpdateDate = testDT;
                    }
                    catch
                    {
                        ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
                    }
                //}
                ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].ClearFilterConditions();
                ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].ClearFilterConditions();

                RefreshPage();
            }
            Cursor.Current = Cursors.Default;
        }

        public void Reload()
        {
            this.ReloadGrid();
        }

        private void btnClearFilter_Click(object sender, EventArgs e)
        {
            Cursor.Current = Cursors.WaitCursor;
            ClearFilter();
        }

        private void ClearFilter()
        {
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters.ClearAllFilters();
            FamilyServiceActiveCaseBR familyServiceActiveCaseBR = (FamilyServiceActiveCaseBR)BusinessRule;
            //familyServiceActiveCaseBR.MinLastUpdateDate = DateTime.MinValue;
            //familyServiceActiveCaseBR.MaxLastUpdateDate = DateTime.MaxValue;
            //familyServiceActiveCaseBR.SelectDataSet();
            ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
            ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
            //RefreshPage();
            ReloadGrid();
        }

        private void ultraGrid_CellDataError(object sender, CellDataErrorEventArgs e)
        {
            //bool valid = false;
            Infragistics.Win.UltraWinGrid.UltraGrid ug = sender as Infragistics.Win.UltraWinGrid.UltraGrid;
            switch (ug.ActiveCell.Column.Key)
            {
                case "LastModified":
                    ultraGrid.ValidDateTime(ug.ActiveCell);
                    e.RaiseErrorEvent = false;
                    //valid = ultraGrid.ValidDateTime(ug.ActiveCell);
                    //e.RaiseErrorEvent = valid;
                    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].ClearFilterConditions();
                    break;
                case "LastModifiedBegin":
                case "LastModifiedEnd":
                case "ToDate":
                    ultraGrid.ValidDateTime(ug.ActiveCell);
                    e.RaiseErrorEvent = false;
                    //valid = ultraGrid.ValidDateTime(ug.ActiveCell);
                    //e.RaiseErrorEvent = valid;
                    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].ClearFilterConditions();
                    break;

            }            
        }
        
    }
}
