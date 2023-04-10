using System;
using System.Drawing;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.List;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.Forms;

namespace Statline.Stattrac.Windows.UI.Controls.Dashboard
{
	public partial class TcssActiveCasesControl : BaseGridSearch
	{
        private SecurityHelper securityHelper;

		public TcssActiveCasesControl()
		{
			InitializeComponent();
            //FilterCondition filterConditionFrom = new FilterCondition();
            //FilterCondition filterConditionTo = new FilterCondition();
            //filterConditionFrom.CompareValue = DateTime.MinValue;
            //ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].FilterConditions.Add(filterConditionFrom);
            //filterConditionTo.CompareValue = DateTime.MaxValue;
            //ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].FilterConditions.Add(filterConditionTo);
            this.openInReadOnlyToolStripMenuItem.Click += new System.EventHandler(this.TcssActiveCasesControl_RightClick);
            this.recycleToolStripMenuItem.Click += new System.EventHandler(this.btnDelete_Click);
            securityHelper = Security.SecurityHelper.GetInstance();
            if (!securityHelper.Authorized(SecurityRule.Delete_Call.ToString()))
            {
                btnDelete.Visible = false;
                recycleToolStripMenuItem.Visible = false;
            }
            TimerEnabled = true;
            if (GRConstant.SelectedTab != "OASIS Active Cases (F6)")
                return;
			InitializeBR(new TcssActiveCasesBR());

            //ultraGrid.InitializeLayout += new InitializeLayoutEventHandler(ultraGrid_InitializeLayout);
            ultraGrid.InitializeRow += new InitializeRowEventHandler(ultraGrid_InitializeRow);
            ultraGrid.AfterRowFilterChanged += new AfterRowFilterChangedEventHandler(ultraGrid_AfterRowFilterChanged);
		}

		private void ultraGrid_InitializeLayout(object sender, InitializeLayoutEventArgs e)
		{
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].Column.MaskInput = "mm/dd/yyyy hh:mm";
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].Column.MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeBoth;
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].Column.MaskInput = "mm/dd/yyyy hh:mm";
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].Column.MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeBoth;
            //for (int index = 0; index < ultraGrid.DisplayLayout.Bands[0].Columns.Count; index++)
            //{
            //    ultraGrid.DisplayLayout.Bands[0].Columns[index].CellMultiLine = Infragistics.Win.DefaultableBoolean.True;
            //}
            ultraGrid.DisplayLayout.Bands[0].ColumnFilters["CallId"].Column.Width = 54;
		}

		private void ultraGrid_InitializeRow(object sender, InitializeRowEventArgs e)
		{
			CellsCollection cellsCollection = e.Row.Cells;
            DateTime lastModified = (DateTime)cellsCollection["LastModified"].Value;
            //if (cellsCollection["MostRecentStatus"].Value.ToString() == "Receipt Pending")
            //{
                if (lastModified.AddMinutes((int)(cellsCollection["expirationminutes"].Value) + (int)(cellsCollection["pendingexpirationminutes"].Value)) < GRConstant.CurrentDateTime)
                //if (lastModified.AddMinutes(3) < GRConstant.CurrentDateTime)
                {
                    e.Row.CellAppearance.BackColor = Color.LightCoral;
                }
                //else if (lastModified.AddMinutes(2) < GRConstant.CurrentDateTime)
                else if (lastModified.AddMinutes((int)(cellsCollection["pendingexpirationminutes"].Value)) < GRConstant.CurrentDateTime)
                {
                    e.Row.CellAppearance.BackColor = Color.Yellow;
                }
            //}

            //if (cellsCollection["MostRecentStatus"].Value.ToString() == ListFsbStatus.SecondaryPending)
            //{
            //    //DateTime lastModified = (DateTime)cellsCollection["LastModified"].Value;
            //    if (lastModified.AddMinutes(20) < GRConstant.CurrentDateTime)
            //    {
            //        e.Row.CellAppearance.BackColor = Color.LightCoral;
            //    }
            //    else if (lastModified.AddMinutes(10) < GRConstant.CurrentDateTime)
            //    {
            //        e.Row.CellAppearance.BackColor = Color.Yellow;
            //    }
            //}
		}

		public override void BindDataToUI()
		{
            //ultraGrid.UltraGridType = UltraGridType.Search;
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

		/// <summary>
		/// Search for closed cases
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void btnSearchClosed_Click(object sender, EventArgs e)
		{
            //bool isFilterCriteriaMet = false;
            //TcssActiveCasesBR tcssActiveCasesBR = (TcssActiveCasesBR)BusinessRule;
            //tcssActiveCasesBR.CallId = GetFilterConditionString("CallId");
            //tcssActiveCasesBR.ReferralNumber = GetFilterConditionString("ReferralNumber");
            //tcssActiveCasesBR.Client = GetFilterConditionString("Client");
            //tcssActiveCasesBR.ImportOfferNumber = GetFilterConditionString("ImportOfferNumber");
            //tcssActiveCasesBR.OrganType = GetFilterConditionString("OrganType");
            //tcssActiveCasesBR.OptnNumber = GetFilterConditionString("OptnNumber");
            //tcssActiveCasesBR.MatchId = GetFilterConditionString("MatchId");
            //tcssActiveCasesBR.TransplantSurgeonContact = GetFilterConditionString("TransplantSurgeonContact");
            //tcssActiveCasesBR.ClinicalCoordinator = GetFilterConditionString("ClinicalCoordinator");
            //tcssActiveCasesBR.CoordinatorFirstName = GetFilterConditionString("CoordinatorFirstName");
            //tcssActiveCasesBR.CoordinatorLastName = GetFilterConditionString("CoordinatorLastName");
            //tcssActiveCasesBR.MostRecentStatus = GetFilterConditionString("MostRecentStatus");
            //tcssActiveCasesBR.MostRecentComment = GetFilterConditionString("MostRecentComment");
            //int lengthOfSearchFilter = GetLengthOfDateTimeFilter(tcssActiveCasesBR);

	
            ////FilterConditionsCollection lastModifiedFilters = ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].FilterConditions;
            //if (lengthOfSearchFilter == int.MaxValue)
            //{
            //    isFilterCriteriaMet = true;	
            //}
            //else
            //{
            //    DateTime testDT;
            //    string filterValue;
            //    filterValue = GetFilterConditionString("LastModified");
            //    if (filterValue != null)
            //        tcssActiveCasesBR.MinLastUpdateDate = DateTime.Parse(GetFilterConditionString("LastModified"));
            //    if (tcssActiveCasesBR.MinLastUpdateDate != null)
            //    {
            //        ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = Convert.ToDateTime(tcssActiveCasesBR.MinLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
            //    }
            //    else
            //    {
            //        try
            //        {
            //            testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption);
            //            tcssActiveCasesBR.MinLastUpdateDate = testDT;
            //        }
            //        catch
            //        {
            //            ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
            //        }
            //    }
            //    filterValue = GetFilterConditionString("ToDate");
            //    if (filterValue != null)
            //        tcssActiveCasesBR.MaxLastUpdateDate = DateTime.Parse(GetFilterConditionString("ToDate"));
            //    if (tcssActiveCasesBR.MaxLastUpdateDate != null)
            //    {
            //        ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(tcssActiveCasesBR.MaxLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
            //    }
            //    else
            //    {
            //        try
            //        {
            //            testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption);
            //            tcssActiveCasesBR.MaxLastUpdateDate = testDT;
            //        }
            //        catch
            //        {
            //            ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
            //        }
            //    }
            //    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].ClearFilterConditions();
            //    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["ToDate"].ClearFilterConditions();
            //    //for (int index = 0; index < lastModifiedFilters.Count; index++)
            //    //{
            //    //    if (lastModifiedFilters[index].ComparisionOperator == FilterComparisionOperator.GreaterThan)
            //    //    {
            //    //        tcssActiveCasesBR.MinLastUpdateDate = DateTime.Parse(lastModifiedFilters[index].CompareValue.ToString(), GRConstant.StattracCulture).ToUniversalTime();
            //    //    }
            //    //    else if (lastModifiedFilters[index].ComparisionOperator == FilterComparisionOperator.LessThan)
            //    //    {
            //    //        tcssActiveCasesBR.MaxLastUpdateDate = DateTime.Parse(lastModifiedFilters[index].CompareValue.ToString(), GRConstant.StattracCulture).ToUniversalTime();
            //    //    }
            //    //}
            //    // If both date time are entered than the filter criteria is met
            //    //if (tcssActiveCasesBR.MinLastUpdateDate != DateTime.MinValue && tcssActiveCasesBR.MaxLastUpdateDate != DateTime.MinValue)
            //    //{
            //    //    TimeSpan diffDateTime = tcssActiveCasesBR.MaxLastUpdateDate.Subtract(tcssActiveCasesBR.MinLastUpdateDate);
            //    //    if (diffDateTime.Days < 90 && diffDateTime.Days < lengthOfSearchFilter)
            //    //    {
            //            //isFilterCriteriaMet = true;										
            //    //    }
            //    //}
            //}
            ////if (isFilterCriteriaMet)
            ////{
            ////    tcssActiveCasesBR.IsDisplayClosed = true;
            ////    RefreshPage();
            ////    tcssActiveCasesBR.IsDisplayClosed = false;
            ////    tcssActiveCasesBR.CallId = null;
            ////    tcssActiveCasesBR.ReferralNumber = null;
            ////    tcssActiveCasesBR.Client = null;
            ////    tcssActiveCasesBR.ImportOfferNumber = null;
            ////    tcssActiveCasesBR.OrganType = null;
            ////    tcssActiveCasesBR.OptnNumber = null;
            ////    tcssActiveCasesBR.MatchId = null;
            ////    tcssActiveCasesBR.TransplantSurgeonContact = null;
            ////    tcssActiveCasesBR.ClinicalCoordinator = null;
            ////    tcssActiveCasesBR.CoordinatorFirstName = null;
            ////    tcssActiveCasesBR.CoordinatorLastName = null;
            ////    tcssActiveCasesBR.MostRecentStatus = null;
            ////    tcssActiveCasesBR.MostRecentComment = null;
            ////    tcssActiveCasesBR.MinLastUpdateDate = DateTime.MinValue;
            ////    tcssActiveCasesBR.MaxLastUpdateDate = DateTime.MinValue;
            ////}
            ////else
            ////{
            ////    BaseMessageBox.Show(UIConstant.TcssActiveCaseControlDateRangeRequired(lengthOfSearchFilter));
            ////}
            //RefreshPage();
		}

		/// <summary>
		/// If there is not column filters than reload the data from the database
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void ultraGrid_AfterRowFilterChanged(object sender, AfterRowFilterChangedEventArgs e)
		{
            //bool isRelaodDataFromDatabase = true;
            //for (int columnIndex = 0; columnIndex < ultraGrid.DisplayLayout.Bands[0].ColumnFilters.Count; columnIndex++)
            //{
            //    if (ultraGrid.DisplayLayout.Bands[0].ColumnFilters[columnIndex].FilterConditions.Count == 1)
            //    {
            //        isRelaodDataFromDatabase = false;
            //    }
            //}
            //if (isRelaodDataFromDatabase)
            //{
            //    RefreshPage();
            //}
		}

		/// <summary>
		/// Get the filter condition
		/// </summary>
		/// <param name="columnName"></param>
		/// <returns></returns>
        /// 
        protected override void ReloadGrid()
        {
            Cursor.Current = Cursors.WaitCursor;
            bool isFilterCriteriaMet = false;
            InitializeBR(new TcssActiveCasesBR());
            TcssActiveCasesBR tcssActiveCasesBR = (TcssActiveCasesBR)BusinessRule;
            tcssActiveCasesBR.CallId = GetFilterConditionString("CallId");
            tcssActiveCasesBR.ReferralNumber = GetFilterConditionString("ReferralNumber");
            tcssActiveCasesBR.Client = GetFilterConditionString("Client");
            tcssActiveCasesBR.ImportOfferNumber = GetFilterConditionString("ImportOfferNumber");
            tcssActiveCasesBR.OrganType = GetFilterConditionString("OrganType");
            tcssActiveCasesBR.OptnNumber = GetFilterConditionString("OptnNumber");
            tcssActiveCasesBR.MatchId = GetFilterConditionString("MatchId");
            tcssActiveCasesBR.TransplantSurgeonContact = GetFilterConditionString("TransplantSurgeonContact");
            tcssActiveCasesBR.ClinicalCoordinator = GetFilterConditionString("ClinicalCoordinator");
            tcssActiveCasesBR.CoordinatorFirstName = GetFilterConditionString("CoordinatorFirstName");
            tcssActiveCasesBR.CoordinatorLastName = GetFilterConditionString("CoordinatorLastName");
            tcssActiveCasesBR.MostRecentStatus = GetFilterConditionString("MostRecentStatus");
            tcssActiveCasesBR.MostRecentComment = GetFilterConditionString("MostRecentComment");
            int lengthOfSearchFilter = GetLengthOfDateTimeFilter(tcssActiveCasesBR);

            string filterValueFrom = null;
            string filterValueTo = null;
            string filterValueStatus = null;
            if (tcssActiveCasesBR.MostRecentStatus != null)
                filterValueStatus = tcssActiveCasesBR.MostRecentStatus.ToLower();
            filterValueFrom = GetFilterConditionString("LastModified");
            filterValueTo = GetFilterConditionString("ToDate");
            tcssActiveCasesBR.IsDisplayClosed = false;
            if (filterValueStatus != null && filterValueStatus.Contains("closed") && filterValueFrom == null && filterValueTo == null)
            {
                BaseMessageBox.Show("You are not allowed to search for closed cases without dates");
                
            }

            //FilterConditionsCollection lastModifiedFilters = ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].FilterConditions;
            //if (lengthOfSearchFilter == int.MaxValue)
            //{
            //    isFilterCriteriaMet = true;
            //}
            else
            {
                if (filterValueStatus != null && filterValueStatus.Contains("closed"))
                {
                    tcssActiveCasesBR.IsDisplayClosed = true;
                    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["MostRecentStatus"].ClearFilterConditions();
                }
                DateTime testDT;
                string filterValue;
                filterValue = GetFilterConditionString("LastModified");
                if (filterValue != null)
                {
                    tcssActiveCasesBR.MinLastUpdateDate = DateTime.Parse(GetFilterConditionString("LastModified"));
                    ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = Convert.ToDateTime(tcssActiveCasesBR.MinLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
                }
                else
                    ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
                //if (tcssActiveCasesBR.MinLastUpdateDate != null)
                //{
                //    ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = Convert.ToDateTime(tcssActiveCasesBR.MinLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
                //}
                //else
                //{
                    //ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
                    try
                    {
                        testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption);
                        tcssActiveCasesBR.MinLastUpdateDate = testDT;
                    }
                    catch
                    {
                        ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
                    }
                //}
                filterValue = GetFilterConditionString("ToDate");
                if (filterValue != null)
                {
                    tcssActiveCasesBR.MaxLastUpdateDate = DateTime.Parse(GetFilterConditionString("ToDate"));
                    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(tcssActiveCasesBR.MaxLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
                }
                else
                    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
                //if (tcssActiveCasesBR.MaxLastUpdateDate != null)
                //{
                //    ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = Convert.ToDateTime(tcssActiveCasesBR.MaxLastUpdateDate).ToString("MM/dd/yyyy HH:mm");
                //}
                //else
                //{
                    //ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
                    try
                    {
                        testDT = DateTime.Parse(ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption);
                        tcssActiveCasesBR.MaxLastUpdateDate = testDT;
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

		/// <summary>
		/// Get the length of teh date time that is allowed
		/// </summary>
		/// <param name="tcssActiveCasesBR"></param>
		/// <returns></returns>
		private int GetLengthOfDateTimeFilter(TcssActiveCasesBR tcssActiveCasesBR)
		{
			// start at one to allow 7 days minimum search
			int length = 1;
			if (tcssActiveCasesBR.CallId != null)
			{
				// if 7 or more numbers are entered than ignore the date range.
				if (tcssActiveCasesBR.CallId.Length > 6)
				{
					return int.MaxValue;
				}
				else
				{
					length += tcssActiveCasesBR.CallId.Length;
				}
			}
			if (tcssActiveCasesBR.ReferralNumber != null)
			{
				length += tcssActiveCasesBR.ReferralNumber.Length;
			}
			if (tcssActiveCasesBR.Client != null)
			{
				length += tcssActiveCasesBR.Client.Length;
			}
			if (tcssActiveCasesBR.ImportOfferNumber != null)
			{
				length += tcssActiveCasesBR.ImportOfferNumber.Length;
			}
			if (tcssActiveCasesBR.OrganType != null)
			{
				length += tcssActiveCasesBR.OrganType.Length;
			}
			if (tcssActiveCasesBR.OptnNumber != null)
			{
				length += tcssActiveCasesBR.OptnNumber.Length;
			}
			if (tcssActiveCasesBR.MatchId != null)
			{
				length += tcssActiveCasesBR.MatchId.Length;
			}
			if (tcssActiveCasesBR.TransplantSurgeonContact != null)
			{
				length += tcssActiveCasesBR.TransplantSurgeonContact.Length;
			}
			if (tcssActiveCasesBR.ClinicalCoordinator != null)
			{
				length += tcssActiveCasesBR.ClinicalCoordinator.Length;
			}
			if (tcssActiveCasesBR.CoordinatorFirstName != null)
			{
				length += tcssActiveCasesBR.CoordinatorFirstName.Length;
			}
			if (tcssActiveCasesBR.CoordinatorLastName != null)
			{
				length += tcssActiveCasesBR.CoordinatorLastName.Length;
			}
			if (tcssActiveCasesBR.MostRecentStatus != null)
			{
				length += tcssActiveCasesBR.MostRecentStatus.Length;
			}
			if (tcssActiveCasesBR.MostRecentComment != null)
			{
				length += tcssActiveCasesBR.MostRecentComment.Length;
			}
			// for each value entered they are allowed 7 more days
			return length * 7;
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
                        recycledCasesBR.CallRecycleUpdateOasis(Convert.ToInt32(cellsCollection[0].Value), 0, StattracIdentity.Identity.UserId);
                        //BindDataToUI();
                        break;
                    default:
                        break;
                }
            }
            this.ReloadGrid();
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
            TcssActiveCasesBR tcssActiveCasesBR = (TcssActiveCasesBR)BusinessRule;
            //tcssActiveCasesBR.MinLastUpdateDate = DateTime.MinValue;
            //tcssActiveCasesBR.MaxLastUpdateDate = DateTime.MaxValue;
            //tcssActiveCasesBR.SelectDataSet();
            ultraGrid.DisplayLayout.Bands[0].Columns["LastModified"].Header.Caption = "Update Date";
            ultraGrid.DisplayLayout.Bands[0].Columns["ToDate"].Header.Caption = "";
            this.ReloadGrid();
            //RefreshPage();
        }

        private void ultraGrid_CellDataError(object sender, CellDataErrorEventArgs e)
        {
            Infragistics.Win.UltraWinGrid.UltraGrid ug = sender as Infragistics.Win.UltraWinGrid.UltraGrid;
            switch (ug.ActiveCell.Column.Key)
            {
                case "LastModified":
                    ultraGrid.ValidDateTime(ug.ActiveCell);
                    e.RaiseErrorEvent = false;
                    ultraGrid.DisplayLayout.Bands[0].ColumnFilters["LastModified"].ClearFilterConditions();
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


        protected override void UltraGridDoubleClick()
        {
            Cursor.Current = Cursors.WaitCursor;
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                GeneralConstant generalConstant = GeneralConstant.CreateInstance();
                generalConstant.OasisReadOnly = false;
                NavigateToEditScreen(int.Parse(cellsCollection["CallId"].Value.ToString()),
                    (int)cellsCollection["TcssDonorId"].Value, (int)cellsCollection["TcssRecipientId"].Value);
                Cursor.Current = Cursors.Default;
            }
        }
        private void TcssActiveCasesControl_RightClick(object sender, EventArgs e)
        {
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                GeneralConstant generalConstant = GeneralConstant.CreateInstance();
                generalConstant.OasisReadOnly = true;
                NavigateToEditScreen(int.Parse(cellsCollection["CallId"].Value.ToString()),
                    (int)cellsCollection["TcssDonorId"].Value, (int)cellsCollection["TcssRecipientId"].Value);
            }
        }
        private void NavigateToEditScreen(int callId, int donorId, int recipientId)
        {
            if (AllowNavigateToEditScreen())
            {
                GeneralConstant generalConstant = GeneralConstant.CreateInstance();
                generalConstant.ReferralId = callId;
                generalConstant.TcssDonorId = donorId;
                generalConstant.TcssRecipientId = recipientId;
                ((BaseForm)FindForm()).LoadSubControl(AppScreenType.NewCall, AppScreenType.Tcss);
            }
        }
        protected override void NavigateToAddScreen()
        {
            GeneralConstant generalConstant = GeneralConstant.CreateInstance();
            generalConstant.OasisReadOnly = false;
            NavigateToEditScreen(int.MinValue, int.MinValue, int.MinValue);
        }
	}
}
