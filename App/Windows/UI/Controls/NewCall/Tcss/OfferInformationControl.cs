using System;
using System.Data;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.BusinessRules.SourceCode;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.SourceCode;
using Statline.Stattrac.Data.Types.TcssList;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class OfferInformationControl : BaseEditControl
	{
		#region Private Fields
		private CurrencyManager tcssCallCurrenycyManager;
		private CurrencyManager tcssDonorCurrenycyManager;
		private CurrencyManager tcssRecipientOfferInformationtcssRecipientCurrencyManager;
		private EventHandler cbKidneyCheckedChanged;
		private EventHandler cbLiverCheckedChanged;
		private EventHandler cbLungCheckedChanged;
		private EventHandler cbOtherCheckedChanged;
		private bool isDuplicateReferralAlreadyLoaded = false;
        private DataView sourceCodeSourceCodeDv;
        //private GeneralConstant generalConstant;
		#endregion
        
		#region Constructor
		public OfferInformationControl()
		{
			InitializeComponent();
			cbKidneyCheckedChanged = new EventHandler(cbKidney_CheckedChanged);
			cbLiverCheckedChanged = new EventHandler(cbLiver_CheckedChanged);
			cbLungCheckedChanged = new EventHandler(cbLung_CheckedChanged);
			cbOtherCheckedChanged = new EventHandler(cbOther_CheckedChanged);
            txtImportOffer.Focus();
		}
		#endregion

		#region Overriden Methods
		/// <summary>
		/// Bind Data to UI
		/// </summary>
		public override void BindDataToUI()
		{
			TcssDS tcssDS = (TcssDS)BusinessRule.AssociatedDataSet;
			tcssCallCurrenycyManager = (CurrencyManager)BindingContext[tcssDS, tcssDS.Call.TableName];
			tcssDonorCurrenycyManager = (CurrencyManager)BindingContext[tcssDS, tcssDS.TcssDonor.TableName];
			tcssRecipientOfferInformationtcssRecipientCurrencyManager = (CurrencyManager)BindingContext[tcssDS, tcssDS.TcssRecipientOfferInformation.TableName];
            //don't enable if already imported offer
            if (tcssDS.TcssRecipientOfferInformation.Count == 1 && !tcssDS.TcssRecipientOfferInformation[0].IsTcssListStatusOfImportDataIdNull())
            {
                txtMatchId.Enabled = false;
                txtOptn.Enabled = false;
                TcssManager.ToggleEditForDataScrapeFromUnos(false);
            }
            else
            {
                txtMatchId.Enabled = true;
                txtOptn.Enabled = true;
                TcssManager.ToggleEditForDataScrapeFromUnos(true);
            }
            if (GRConstant.OasisReadOnly == true)
            {
                TcssManager.DisableSave();
                TcssManager.ToggleEditForDataScrapeFromUnos(false);
            }
            else
            {
                TcssManager.EnableSave();
                TcssManager.ToggleEditForDataScrapeFromUnos(true);
            }

			// Bind Data To DropDownList
            cbCallType.BindData("CallTypeListSelect");
            //cbCallType.BindData("TcssListCallTypeSelect");
			cbSourceCode.BindData("ListSourceCodeSelect");
			cbOrganType.BindData("TcssListOrganTypeSelect");
			cbKidneySubType.BindData("TcssListKidneyTypeSelect");
			cbLiverSubType.BindData("TcssListLiverTypeSelect");
			cbLungSubType.BindData("TcssListLungTypeSelect");

			ddlCloseReason1.BindData("TcssListCloseReasonSelect");
			ddlCloseReason2.BindData("TcssListCloseReasonSelect");

			// Bind Data To Controls from TcssDonor
			string tableName = tcssDS.TcssDonor.TableName;
			txtOptn.BindDataSet(tcssDS, tableName, tcssDS.TcssDonor.OptnNumberColumn.ColumnName);
            //txtCallTakenBy.BindDataSet(tcssDS, tableName, tcssDS.TcssDonor.StatEmployeeIDColumn.ColumnName);
            if (String.IsNullOrEmpty(txtOptn.Text))
            {
                txtCallTakenBy.Text = StattracIdentity.Identity.UserName;
            }
            else
            {
                //GeneralConstant generalConstant = GeneralConstant.CreateInstance();
                txtCallTakenBy.BindDataSet(tcssDS, tableName, tcssDS.TcssDonor.CallTakenByColumn.ColumnName);
            }

			// Call table Bindings
			tableName = tcssDS.Call.TableName;
			cbSourceCode.BindDataSet(tcssDS, tableName, tcssDS.Call.SourceCodeIDColumn.ColumnName);
			cbCallType.BindDataSet(tcssDS, tableName, tcssDS.Call.CallTypeIDColumn.ColumnName);

			// Bind Data To Controls from TcssRecipientOfferInformation
			tableName = tcssDS.TcssRecipientOfferInformation.TableName;
			txtImportOffer.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.ImportOfferNumberColumn.ColumnName);
			cbClient.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.ClientIdColumn.ColumnName);
			txtReferral.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.ReferralNumberColumn.ColumnName);
			cbOrganType.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.TcssListOrganTypeIdColumn.ColumnName);
			cbHeart.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.IsMultiOrganHeartColumn.ColumnName);
			cbIntestine.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.IsMultiOrganIntestineColumn.ColumnName);
			cbPancreas.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.IsMultiOrganPancreasColumn.ColumnName);
			cbKidney.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.IsMultiOrganKidneyColumn.ColumnName);
			cbLiver.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.IsMultiOrganLiverColumn.ColumnName);
			cbLung.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.IsMultiOrganLungColumn.ColumnName);
			cbOther.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.IsMultiOrganOtherColumn.ColumnName);
            cbLungSubType.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.TcssListLungTypeIdColumn.ColumnName);
            cbKidneySubType.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.TcssListKidneyTypeIdColumn.ColumnName);
			cbLiverSubType.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.TcssListLiverTypeIdColumn.ColumnName);
			txtOtherOrganDetail.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.OtherOtherOrganDetailOrganColumn.ColumnName);
			ddlCloseReason1.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.TcssListCloseReason1IdColumn.ColumnName);
			ddlCloseReason2.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.TcssListCloseReason2IdColumn.ColumnName);
			lblCaseClosedBy1.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.CloseByStatEmployee1NameColumn.ColumnName);
			lblCaseCloseDateTime1.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.CloseDate1Column.ColumnName);
			lblCaseClosedBy2.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.CloseByStatEmployee2NameColumn.ColumnName);
			lblCaseCloseDateTime2.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.CloseDate2Column.ColumnName);
			txtMatchId.BindDataSet(tcssDS, tableName, tcssDS.TcssRecipientOfferInformation.MatchIdColumn.ColumnName);
            
			// Bind Data To Grid ValueList
            ugStatusInformation.BindValueList("LookupListStatEmployee", "LastUpdateStatEmployeeId", tcssDS.TcssRecipientOfferStatusInformation, "LastUpdateStatEmployeeName");
            ugStatusInformation.BindValueList("LookupListStatEmployee", "CoordinatorId", tcssDS.TcssRecipientOfferStatusInformation, "CoordinatorName");
			ugStatusInformation.BindValueList("TcssListStatusSelect", "TcssListStatusId");

			// Bind Data To Grid();
			ugStatusInformation.DataSource = tcssDS;
			ugStatusInformation.DataMember = tcssDS.TcssRecipientOfferStatusInformation.TableName;
			ugStatusInformation.BeforeRowUpdate += new Infragistics.Win.UltraWinGrid.CancelableRowEventHandler(ugStatusInformation_BeforeRowUpdate);
            
			// Set the Call Type to oasis
			//cbCallType.SelectedIndex = 1;
			if (cbCallType.Text == "Select A Value" || cbCallType.Text == "")
				cbCallType.SelectedIndex = cbCallType.FindString("Oasis");

			if (tcssDS.TcssRecipientOfferInformation.Count == 1)
			{
                if (!tcssDS.TcssRecipientOfferInformation[0].IsTcssListCloseReason1IdNull())
                {
                    ddlCloseReason1.Enabled = false;
                    lblUserName1.Text = "Case Closed By:";
                    lblPassword1.Text = "Date/Time:";

                    txtUserName1.Visible = false;
                    txtPassword1.Visible = false;
                    lblCaseClosedBy1.Visible = true;
                    lblCaseCloseDateTime1.Visible = true;

                    btnCloseCase1.Visible = false;
                    ddlCloseReason2.Enabled = true;
                    txtUserName2.Visible = true;
                    txtPassword2.Visible = true;
                    btnCloseCase2.Enabled = true;
                    // Only the first signiture exists
                    if (tcssDS.TcssRecipientOfferInformation[0].IsTcssListCloseReason2IdNull())
                    {
                        lblCloseReason1.Visible = false;
                        ddlCloseReason1.Visible = false;
                    }
                    else
                    {
                        lblCloseReason1.Visible = true;
                        ddlCloseReason1.Visible = true;

                        ddlCloseReason2.Enabled = false;
                        lblUserName2.Text = "Case Closed By:";
                        lblPassword2.Text = "Date/Time:";

                        txtUserName2.Visible = false;
                        txtPassword2.Visible = false;
                        lblCaseClosedBy2.Visible = true;
                        lblCaseCloseDateTime2.Visible = true;
                        btnCloseCase2.Enabled = true;
                        //TcssManager.ToggleEditForDataScrapeFromUnos(false);
                        Security.SecurityHelper securityHelper = Security.SecurityHelper.GetInstance();
                        if (!securityHelper.Authorized(SecurityRule.Reopen_OASIS_Case.ToString()))
                            btnCloseCase2.Enabled = false;
                        btnCloseCase2.Text = "Reopen";
                        GeneralConstant generalConstant = GeneralConstant.CreateInstance();
                        generalConstant.OasisReadOnly = true;
                        //TcssManager.DisableSave();
                        TcssManager.ToggleEditForDataScrapeFromUnos(false);
                    }
                }
                else//disable all of closer two stuff
                {
                    ddlCloseReason2.Enabled = false;
                    txtUserName2.Visible = false;
                    txtPassword2.Visible = false;
                    btnCloseCase2.Enabled = false;
                }
			}
		}

		/// <summary>
		/// Load Data from UI
		/// </summary>
		public override void LoadDataFromUI()
		{
			int callId = int.MinValue;
			if (int.TryParse(txtImportOffer.Text, out callId))
			{
				((TcssBR)BusinessRule).CallId = callId;
			}
		}
		#endregion

		#region Private Method
		private void ReopenCase()
		{
			TcssBR tcssBR = (TcssBR)BusinessRule;
			TcssDS tcssDS = (TcssDS)tcssBR.AssociatedDataSet;

			tcssDS.TcssRecipientOfferInformation[0].SetTcssListCloseReason1IdNull();
			tcssDS.TcssRecipientOfferInformation[0].SetCloseByStatEmployee1IdNull();
			tcssDS.TcssRecipientOfferInformation[0].SetCloseDate1Null();
			tcssDS.TcssRecipientOfferInformation[0].SetTcssListCloseReason2IdNull();
			tcssDS.TcssRecipientOfferInformation[0].SetCloseByStatEmployee2IdNull();
			tcssDS.TcssRecipientOfferInformation[0].SetCloseDate2Null();
            
			ddlCloseReason1.Enabled = true;
			ddlCloseReason2.Enabled = true;
			ddlCloseReason1.Visible = true;
			lblCloseReason1.Visible = true;
			lblCloseReason1.Visible = true;
			ddlCloseReason2.Visible = true;
			txtUserName1.Visible = true;
			txtUserName2.Visible = true;
			txtPassword1.Visible = true;
			txtPassword2.Visible = true;
			btnCloseCase1.Visible = true;
			btnCloseCase2.Visible = true;
			lblCaseClosedBy1.Visible = false;
			lblCaseClosedBy2.Visible = false;
			lblCaseCloseDateTime1.Visible = false;
			lblCaseCloseDateTime2.Visible = false;

			lblUserName1.Text = "User Name:";
			lblUserName2.Text = "User Name:";
			lblPassword1.Text = "Password:";
			lblPassword2.Text = "Password:";
			btnCloseCase2.Text = "Close Case";

			ddlCloseReason1.SelectedIndex = -1;
			ddlCloseReason2.SelectedIndex = -1;
			txtUserName1.Text = "";
			txtUserName2.Text = "";
			txtPassword1.Text = "";
			txtPassword2.Text = "";
            //set most recent status to
            int reopen = 10;
            DataRow currentRow = tcssDS.TcssRecipientOfferStatusInformation.NewRow();
            currentRow["TcssListStatusId"] = reopen;
            currentRow["TcssRecipientId"] = tcssDS.TcssRecipientOfferInformation[0].TcssRecipientId;
            currentRow["LastUpdateDate"] = GRConstant.CurrentDateTime;
            currentRow["LastUpdateStatEmployeeId"] = StattracIdentity.Identity.UserId;
            tcssDS.TcssRecipientOfferStatusInformation.Rows.Add(currentRow);

			TcssManager.Save();
            TcssManager.ToggleEditForDataScrapeFromUnos(true);
		}
		#endregion

		#region Private Events
		private void cbSourceCode_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (cbSourceCode.SelectedValue is int)
			{
                
				cbClient.BindOrganizationBySourceCode((int)cbSourceCode.SelectedValue);
                SourceCodeDS sourceCodeDS;
                SourceCodeBR sourceCodeBR;
                sourceCodeBR = new SourceCodeBR();
                sourceCodeDS = (SourceCodeDS)sourceCodeBR.AssociatedDataSet;
                GRConstant.SourceCodeId = Convert.ToInt32(cbSourceCode.SelectedValue);
                sourceCodeBR.SelectSourceCode(GRConstant.SourceCodeId);
                rtfDefaultAlert.DataBindings.Clear();
                sourceCodeSourceCodeDv = new DataView(sourceCodeDS.SourceCode);
                if (sourceCodeDS.SourceCode.Rows.Count > 0)
                {
                    txtGreeting.Text = sourceCodeDS.SourceCode.Rows[0]["SourceCodeDescription"].ToString();
                    rtfDefaultAlert.Text = sourceCodeDS.SourceCode.Rows[0]["SourceCodeDefaultAlert"].ToString();
                    string rtfValue = "{\\rtf1";
                    if (rtfDefaultAlert.Text.Contains(rtfValue))
                    {
                        rtfDefaultAlert.DataBindings.Add("Rtf", sourceCodeSourceCodeDv, sourceCodeDS.SourceCode.SourceCodeDefaultAlertColumn.ColumnName);
                        //rtfDefaultAlert.ScrollBars = RichTextBoxScrollBars.Vertical;
                    }
                    else
                    {
                        rtfDefaultAlert.DataBindings.Add("Text", sourceCodeSourceCodeDv, sourceCodeDS.SourceCode.SourceCodeDefaultAlertColumn.ColumnName);
                    }
                }
			}
            EndCurrentEdit(sender, e);
		}

		private void cbSourceCode_Leave(object sender, EventArgs e)
		{
			// If the source code is not a valid then do not process anything
			if (string.IsNullOrEmpty(cbSourceCode.Text) || cbSourceCode.Text == "Select A Value")
				return;

			EndCurrentEdit(sender, e);
		}

		private void txtReferral_Leave(object sender, EventArgs e)
		{
			TcssHelperBR tcssHelperBR = new TcssHelperBR();
			int callId = int.MinValue;
            int importOfferType =0;
			if (int.TryParse(txtReferral.Text, out callId))
			{
                TcssHelperDS tcssHelperDS = tcssHelperBR.SelectDoesCallExist(callId, importOfferType);
				// If there is a referral with the same callid then it exiss
				if (tcssHelperDS.DoesCallExist.Count != 1)
				{
					BaseMessageBox.Show(callId + " is not a valid Referral Number");
					txtReferral.Text = string.Empty;
				}
			}
            
			//end edit to refelect change on tcssHeader
			EndCurrentEdit(sender, e);
		}

		private void txtMatchId_Leave(object sender, EventArgs e)
		{
			if (!isDuplicateReferralAlreadyLoaded)
            {
                TcssDS tcssDS = (TcssDS)BusinessRule.AssociatedDataSet;
                DuplicateReferalsForm duplicateReferalsForm = new DuplicateReferalsForm();
                //tcssDS.TcssRecipientOfferInformation[0].ClientName = cbClient.Text;
                // On a new call this will not exist but on an existing call we need to make sure that we do 
                // nor return the same call
                int callId = 0;
                if (tcssDS.TcssRecipientOfferInformation.Count == 1)
                {
                    callId = tcssDS.TcssRecipientOfferInformation[0].CallId;
                }

                // Check to see if the data exists before checking for duplicate
                if (cbSourceCode.SelectedIndex > 0 && cbOrganType.SelectedIndex > 0)
                {
                    duplicateReferalsForm.ShowDialog(callId, (int)cbSourceCode.SelectedValue, (int)cbOrganType.SelectedValue,
                        txtMatchId.Text, txtOptn.Text);
                }

                if (duplicateReferalsForm.IsLoadDuplicateReferral)
                {
                    isDuplicateReferralAlreadyLoaded = true;
                    ((BaseForm)FindForm()).LoadSubControl(AppScreenType.NewCall, AppScreenType.Tcss);
                }
                
			}

			else
			{
				isDuplicateReferralAlreadyLoaded = false;
			}
			EndCurrentEdit(sender, e);
		}

		private void EndCurrentEdit(object sender, EventArgs e)
        {
            if (tcssCallCurrenycyManager == null)
                return;
            if (tcssCallCurrenycyManager.Count == 0)
                return;
            if (tcssCallCurrenycyManager != null)
                tcssCallCurrenycyManager.EndCurrentEdit();
            if (tcssDonorCurrenycyManager != null)
                tcssDonorCurrenycyManager.EndCurrentEdit();
            //tcssRecipientOfferInformationtcssRecipientCurrencyManager.CancelCurrentEdit();
            if (tcssRecipientOfferInformationtcssRecipientCurrencyManager != null)
                tcssRecipientOfferInformationtcssRecipientCurrencyManager.EndCurrentEdit();
		}

		private void cbOrganType_SelectedIndexChanged(object sender, EventArgs e)
		{
            if (cbOrganType.SelectedIndex > 0)
            {
                cbKidneySubType.Visible = false;
                cbLiverSubType.Visible = false;
                cbLungSubType.Visible = false;
                cbHeart.Visible = false;
                cbIntestine.Visible = false;
                cbPancreas.Visible = false;
                cbKidney.Visible = false;
                cbLiver.Visible = false;
                cbLung.Visible = false;
                cbOther.Visible = false;
                txtOtherOrganDetail.Visible = false;

                cbKidneySubType.SelectedIndex = -1;
                cbLiverSubType.SelectedIndex = -1;
                cbLungSubType.SelectedIndex = -1;
                cbHeart.Checked = false;
                cbIntestine.Checked = false;
                cbPancreas.Checked = false;
                cbKidney.Checked = false;
                cbLiver.Checked = false;
                cbLung.Checked = false;
                cbOther.Checked = false;
                if (!string.IsNullOrEmpty(txtOtherOrganDetail.Text))
                {
                    txtOtherOrganDetail.Text = "";
                }

                cbLiver.CheckedChanged -= cbLiverCheckedChanged;
                cbKidney.CheckedChanged -= cbKidneyCheckedChanged;
                cbLung.CheckedChanged -= cbLungCheckedChanged;
                cbOther.CheckedChanged -= cbOtherCheckedChanged;

                switch ((TcssListOrganType)cbOrganType.SelectedIndex)
                {
                    case TcssListOrganType.Liver:
                        cbLiverSubType.Visible = true;
                        cbLiverSubType.Location = new System.Drawing.Point(338, 94);
                        cbLiver.CheckedChanged += cbLiverCheckedChanged;
                        break;
                    case TcssListOrganType.Kidney:
                        cbKidneySubType.Visible = true;
                        cbKidneySubType.Location = new System.Drawing.Point(338, 94);
                        cbKidney.CheckedChanged += cbKidneyCheckedChanged;
                        break;
                    case TcssListOrganType.Lung:
                        cbLungSubType.Visible = true;
                        cbLungSubType.Location = new System.Drawing.Point(338, 94);
                        cbLung.CheckedChanged += cbLungCheckedChanged;
                        break;
                    case TcssListOrganType.Intestine:
                        break;
                    case TcssListOrganType.Pancreas:
                        break;
                    case TcssListOrganType.HeartLung:
                        break;
                    case TcssListOrganType.KidneyPancreas:
                        break;
                    case TcssListOrganType.MultiOrgan:
                        cbHeart.Visible = true;
                        cbIntestine.Visible = true;
                        cbPancreas.Visible = true;
                        cbKidney.Visible = true;
                        cbLiver.Visible = true;
                        cbLung.Visible = true;
                        cbOther.Visible = true;

                        cbLiverSubType.Visible = true;
                        cbKidneySubType.Visible = true;
                        cbLungSubType.Visible = true;

                        cbLiverSubType.Location = new System.Drawing.Point(282, 156);
                        cbKidneySubType.Location = new System.Drawing.Point(282, 129);
                        cbLungSubType.Location = new System.Drawing.Point(282, 183);
                        cbOther.CheckedChanged += cbOtherCheckedChanged;
                        break;
                    default:
                        break;
                }
                if (!isDuplicateReferralAlreadyLoaded)
                {
                    TcssDS tcssDS = (TcssDS)BusinessRule.AssociatedDataSet;
                    DuplicateReferalsForm duplicateReferalsForm = new DuplicateReferalsForm();
                    //tcssDS.TcssRecipientOfferInformation[0].ClientName = cbClient.Text;
                    // On a new call this will not exist but on an existing call we need to make sure that we do 
                    // nor return the same call
                    int callId = 0;
                    if (tcssDS.TcssRecipientOfferInformation.Count == 1)
                    {
                        callId = tcssDS.TcssRecipientOfferInformation[0].CallId;
                    }

                    // Check to see if the data exists before checking for duplicate
                    if (cbSourceCode.SelectedIndex > 0 && cbOrganType.SelectedIndex > 0)
                    {
                        duplicateReferalsForm.ShowDialog(callId, (int)cbSourceCode.SelectedValue, (int)cbOrganType.SelectedValue,
                            txtMatchId.Text, txtOptn.Text);
                    }

                    if (duplicateReferalsForm.IsLoadDuplicateReferral)
                    {
                        isDuplicateReferralAlreadyLoaded = true;
                        ((BaseForm)FindForm()).LoadSubControl(AppScreenType.NewCall, AppScreenType.Tcss);
                    }

                }

                else
                {
                    isDuplicateReferralAlreadyLoaded = false;
                }
                //EndCurrentEdit(sender, e);
            }
		}

		private void cbKidney_CheckedChanged(object sender, EventArgs e)
		{
			switch (cbKidney.CheckState)
			{
				case CheckState.Checked:
					cbKidneySubType.Visible = true;
					break;
				case CheckState.Unchecked:
					cbKidneySubType.Visible = false;
					break;
			}
		}

		private void cbLiver_CheckedChanged(object sender, EventArgs e)
		{
			switch (cbLiver.CheckState)
			{
				case CheckState.Checked:
					cbLiverSubType.Visible = true;
					break;
				case CheckState.Unchecked:
					cbLiverSubType.Visible = false;
					break;
			}
		}

		private void cbLung_CheckedChanged(object sender, EventArgs e)
		{
			switch (cbLung.CheckState)
			{
				case CheckState.Checked:
					cbLungSubType.Visible = true;
					break;
				case CheckState.Unchecked:
					cbLungSubType.Visible = false;
					break;
			}
		}

		private void cbOther_CheckedChanged(object sender, EventArgs e)
		{
			switch (cbOther.CheckState)
			{
				case CheckState.Checked:
					txtOtherOrganDetail.Visible = true;
					break;
				case CheckState.Unchecked:
					txtOtherOrganDetail.Visible = false;
					break;
			}
		}
		
		private void ugStatusInformation_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
		{
			// Prevent editing the row 
			if (!e.Row.IsAddRow)
			{
				e.Row.Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
			}
		}

		private void ugStatusInformation_BeforeRowUpdate(object sender, Infragistics.Win.UltraWinGrid.CancelableRowEventArgs e)
		{
			e.Row.Cells["LastUpdateDate"].Value = GRConstant.CurrentDateTime;
            e.Row.Cells["LastUpdateStatEmployeeId"].Value = StattracIdentity.Identity.UserId;
            e.Row.Cells["LastUpdateStatEmployeeName"].Value = StattracIdentity.Identity.UserName;
			if (string.IsNullOrEmpty(e.Row.Cells["TcssListStatusId"].Value.ToString()))
			{
				BaseMessageBox.Show("Status is required");
				ugStatusInformation.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.PrevCell, false, false);
				e.Cancel = true;
			}
		}

		private void btnCloseCase1_Click(object sender, EventArgs e)
        {
            TcssManager.EnableSave();
			TcssBR tcssBR = (TcssBR)BusinessRule;
            bool isAuthenticated = false;
            if (ddlCloseReason1.SelectedIndex < 1)
            {
                BaseMessageBox.Show("You must select a reason");
                TcssManager.DisableSave();
                return;
            }
            if (string.IsNullOrEmpty(txtPassword1.Text))
            {
                BaseMessageBox.Show("Password Cannot be empty");
                TcssManager.DisableSave();
            }
            else
            {
                if (!LogOnBR.ValidateUser(GRConstant.ActiveDirectory, txtUserName1.Text, txtPassword1.Text, isAuthenticated, false))
                {
                    BaseMessageBox.Show("Password and Or User Name Incorrect");
                    TcssManager.DisableSave();
                }
                else
                {
                    StatEmployeeBR statEmployeeBR = new StatEmployeeBR(txtUserName1.Text);
                    StatEmployeeDS statEmployeeDS = (StatEmployeeDS)statEmployeeBR.SelectDataSet();
                    if (statEmployeeDS.StatEmployee.Count == 1)
                    {
                        TcssDS tcssDS = (TcssDS)tcssBR.AssociatedDataSet;
                        tcssDS.TcssRecipientOfferInformation[0].CloseByStatEmployee1Id = statEmployeeDS.StatEmployee[0].StatEmployeeID;
                        tcssDS.TcssRecipientOfferInformation[0].CloseDate1 = GRConstant.CurrentDateTime;
                        TcssManager.EnableSave();
                    }
                    TcssManager.Save();
                }
            }
		}

		private void btnCloseCase2_Click(object sender, EventArgs e)
        {
            TcssManager.EnableSave();
			TcssBR tcssBR = (TcssBR)BusinessRule;
			TcssDS tcssDS = (TcssDS)tcssBR.AssociatedDataSet;
            bool isAuthenticated = false;
            if (btnCloseCase2.Text != "Reopen")
            {
                if (tcssDS.TcssRecipientOfferInformation[0].CloseByStatEmployee1UserName == txtUserName2.Text)
                {
                    BaseMessageBox.Show("Two different users must sign in order to close the case.");
                    txtUserName2.Text = null;
                    txtPassword2.Text = null;
                    TcssManager.DisableSave();
                    return;
                }
            }
            if (ddlCloseReason2.SelectedIndex > 0)
            {
                if (tcssDS.TcssRecipientOfferInformation[0].TcssListCloseReason1Id != tcssDS.TcssRecipientOfferInformation[0].TcssListCloseReason2Id)
                {
                    BaseMessageBox.Show("Could not close the case because the reasons for closing the case does not match");
                    TcssManager.DisableSave();
                    ReopenCase();
                    return;
                }
            }
            
            if (btnCloseCase2.Text == "Close Case")
            {
                if (string.IsNullOrEmpty(txtPassword2.Text))
                {
                    BaseMessageBox.Show("Password Cannot be empty");
                    TcssManager.DisableSave();
                    return;
                }
                else
                {
                    if (!LogOnBR.ValidateUser(GRConstant.ActiveDirectory, txtUserName2.Text, txtPassword2.Text, isAuthenticated, false))
                    {
                        BaseMessageBox.Show("Password and Or User Name Incorrect");
                        TcssManager.DisableSave();
                    }
                    else
                    {
                        int closed = 9;
                        StatEmployeeBR statEmployeeBR = new StatEmployeeBR(txtUserName2.Text);
                        StatEmployeeDS statEmployeeDS = (StatEmployeeDS)statEmployeeBR.SelectDataSet();
                        if (statEmployeeDS.StatEmployee.Count == 1)
                        {
                            tcssDS = (TcssDS)tcssBR.AssociatedDataSet;
                            tcssDS.TcssRecipientOfferInformation[0].CloseByStatEmployee2Id = statEmployeeDS.StatEmployee[0].StatEmployeeID;
                            tcssDS.TcssRecipientOfferInformation[0].CloseDate2 = GRConstant.CurrentDateTime;
                            DataRow currentRow = tcssDS.TcssRecipientOfferStatusInformation.NewRow();
                            currentRow["TcssListStatusId"] = closed;
                            currentRow["TcssRecipientId"] = tcssDS.TcssRecipientOfferInformation[0].TcssRecipientId;
                            currentRow["LastUpdateDate"] = GRConstant.CurrentDateTime;
                            currentRow["LastUpdateStatEmployeeId"] = StattracIdentity.Identity.UserId;
                            tcssDS.TcssRecipientOfferStatusInformation.Rows.Add(currentRow);
                            btnCloseCase2.Enabled = false;
                            TcssManager.EnableSave();
                        }
                        //TcssManager.Save();
                    }
                }
                //else if (LogOnBR.ValidateUser(GRConstant.ActiveDirectory, txtUserName2.Text, txtPassword2.Text, isAuthenticated, false ))
                //{
                //    StatEmployeeBR statEmployeeBR = new StatEmployeeBR(txtUserName2.Text);
                //    StatEmployeeDS statEmployeeDS = (StatEmployeeDS)statEmployeeBR.SelectDataSet();
                //    if (statEmployeeDS.StatEmployee.Count == 1)
                //    {
                //        tcssDS.TcssRecipientOfferInformation[0].CloseByStatEmployee2Id = statEmployeeDS.StatEmployee[0].StatEmployeeID;
                //        tcssDS.TcssRecipientOfferInformation[0].CloseDate2 = GRConstant.CurrentDateTime;
                //        TcssManager.Save();
                //    }
                //}
            }
            if (btnCloseCase2.Text == "Reopen")
            {
                ReopenCase();
            }
			
		}

		#endregion
        

        private void txtOptn_Leave(object sender, EventArgs e)
        {
            if (!isDuplicateReferralAlreadyLoaded)
            {
                TcssDS tcssDS = (TcssDS)BusinessRule.AssociatedDataSet;
                DuplicateReferalsForm duplicateReferalsForm = new DuplicateReferalsForm();
                //tcssDS.TcssRecipientOfferInformation[0].ClientName = cbClient.Text;
                // On a new call this will not exist but on an existing call we need to make sure that we do 
                // nor return the same call
                int callId = 0;
                if (tcssDS.TcssRecipientOfferInformation.Count == 1)
                {
                    callId = tcssDS.TcssRecipientOfferInformation[0].CallId;
                }

                // Check to see if the data exists before checking for duplicate
                if (cbSourceCode.SelectedIndex > 0 && cbOrganType.SelectedIndex > 0)
                {
                    duplicateReferalsForm.ShowDialog(callId, (int)cbSourceCode.SelectedValue, (int)cbOrganType.SelectedValue,
                        txtMatchId.Text, txtOptn.Text);
                }

                if (duplicateReferalsForm.IsLoadDuplicateReferral)
                {
                    isDuplicateReferralAlreadyLoaded = true;
                    ((BaseForm)FindForm()).LoadSubControl(AppScreenType.NewCall, AppScreenType.Tcss);
                }

            }

            else
            {
                isDuplicateReferralAlreadyLoaded = false;
            }
            EndCurrentEdit(sender, e);
        }

        private void cbClient_Leave(object sender, EventArgs e)
        {
            EndCurrentEdit(sender, e);
            //if (cbClient.SelectedIndex > 0)
            //    TcssManager.Save();
        }

        private void txtImportOffer_Leave(object sender, EventArgs e)
        {
            TcssHelperBR tcssHelperBR = new TcssHelperBR();
            int callId = int.MinValue;
            int importOfferType = 2;
            if (int.TryParse(txtImportOffer.Text, out callId))
            {
                TcssHelperDS tcssHelperDS = tcssHelperBR.SelectDoesCallExist(callId,importOfferType);
                // If there is a referral with the same callid then it exiss
                if (tcssHelperDS.DoesCallExist.Count != 1)
                {
                    BaseMessageBox.Show(callId + " is not a valid import offer");
                    txtImportOffer.Text = string.Empty;
                    txtImportOffer.Focus();
                }
            }
            //end edit to refelect change on tcssHeader
            EndCurrentEdit(sender, e);
        }
	}
}
