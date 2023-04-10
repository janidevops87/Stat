using System;
using System.Data;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Windows.UI.Header
{
	public partial class TcssHeader : BaseUserControl
	{
		#region Private Fields
		private CurrencyManager _tcssDonorCurrencyManager;
		private ListControlDS _tcssOrganTypeDs;
		private ListControlDS _tcssSourceCodeDs;
		private ListControlDS _tcssDonorStatusDs;
        private ListControlDS _tcssRecipientOfferInformationDs;
		#endregion

		#region Constructor
		public TcssHeader()
		{
			InitializeComponent();
		}
		#endregion

		#region Public Methods
		public new void InitializeBR(BaseBR businessRule)
		{
            base.InitializeBR(businessRule);
            
		}

		public override void BindDataToUI()
		{
			TcssDS tcssDs = (TcssDS)BusinessRule.AssociatedDataSet;

			// create a datatable for each list using ListControl
			ListControlBR tcssOrganTypeBr = new ListControlBR("TcssListOrganTypeSelect");
			_tcssOrganTypeDs = (ListControlDS)tcssOrganTypeBr.SelectDataSet();

			ListControlBR tcssSourceCodeBr = new ListControlBR("ListSourceCodeSelect");
			_tcssSourceCodeDs = (ListControlDS)tcssSourceCodeBr.SelectDataSet();

			ListControlBR tcssDonorStatusBr = new ListControlBR("TcssListStatusSelect");
			_tcssDonorStatusDs = (ListControlDS)tcssDonorStatusBr.SelectDataSet();

            ListControlBR tcssRecipientOfferInformationBr = new ListControlBR("TcssListCloseReasonSelect");
            _tcssRecipientOfferInformationDs = (ListControlDS)tcssRecipientOfferInformationBr.SelectDataSet();


			_tcssDonorCurrencyManager = (CurrencyManager)BindingContext[tcssDs, tcssDs.TcssDonor.TableName];
			_tcssDonorCurrencyManager.ItemChanged += new ItemChangedEventHandler(_tcssDonorCurrencyManager_ItemChanged);

			//txtTxSurgeon.BindDataSet(tcssDs, tcssDs.TcssDonorContactInformation.TableName, tcssDs.TcssDonorContactInformation.TransplantSurgeonContactIdColumn.ColumnName);
			//txtClinicalCoord.BindDataSet(tcssDs, tcssDs.TcssDonorContactInformation.TableName, tcssDs.TcssDonorContactInformation.ClinicalCoordinatorIdColumn.ColumnName); 
		
			txtMatchId.BindDataSet(tcssDs, tcssDs.TcssRecipientOfferInformation.TableName, tcssDs.TcssRecipientOfferInformation.MatchIdColumn.ColumnName);
			txtTcssNum.BindDataSet(tcssDs, tcssDs.Call.TableName, tcssDs.Call.CallIDColumn.ColumnName);
			txtClient.BindDataSet(tcssDs, tcssDs.TcssRecipientOfferInformation.TableName, tcssDs.TcssRecipientOfferInformation.ClientNameColumn.ColumnName);

			txtOptnNum.BindDataSet(tcssDs, tcssDs.TcssDonor.TableName, tcssDs.TcssDonor.OptnNumberColumn.ColumnName);
			txtImportOfferNumber.BindDataSet(tcssDs, tcssDs.TcssRecipientOfferInformation.TableName, tcssDs.TcssRecipientOfferInformation.ImportOfferNumberColumn.ColumnName);
			txtReferralNumber.BindDataSet(tcssDs, tcssDs.TcssRecipientOfferInformation.TableName, tcssDs.TcssRecipientOfferInformation.ReferralNumberColumn.ColumnName);
			txtTcssDateTime.BindDataSet(tcssDs, tcssDs.TcssDonor.TableName, tcssDs.TcssDonor.LastUpdateDateColumn.ColumnName);

			if (tcssDs.TcssDonorContactInformation.Count == 1)
			{
				txtTxSurgeon.BindDataSet(tcssDs, tcssDs.TcssDonorContactInformation.TableName, tcssDs.TcssDonorContactInformation.TransplantSurgeonContactOtherColumn.ColumnName);
				txtClinicalCoord.BindDataSet(tcssDs, tcssDs.TcssDonorContactInformation.TableName, tcssDs.TcssDonorContactInformation.ClinicalCoordinatorOtherColumn.ColumnName);
			}

			SetValuesForIDColumns();

            cbSourceCode.BindData("ListSourceCodeSelect");
            cbOrganType.BindData("TcssListOrganTypeSelect");
            
            String tableName = tcssDs.Call.TableName;
            cbSourceCode.BindDataSet(tcssDs, tableName, tcssDs.Call.SourceCodeIDColumn.ColumnName);
            
            tableName = tcssDs.TcssRecipientOfferInformation.TableName;
            cbClient.BindDataSet(tcssDs, tableName, tcssDs.TcssRecipientOfferInformation.ClientIdColumn.ColumnName);
            cbOrganType.BindDataSet(tcssDs, tableName, tcssDs.TcssRecipientOfferInformation.TcssListOrganTypeIdColumn.ColumnName);

		}

		private string GetFieldValue(ListControlDS listControlDs, int listId)
		{
			string returnString = "";
			ListControlDS.ListControlRow listControlRow = listControlDs.ListControl.FindByListId(listId);

			if (listControlRow != null)
				returnString = listControlRow.FieldValue;
			return returnString;
		}

		private void SetValuesForIDColumns()
		{
			TcssDS tcssDs = (TcssDS)BusinessRule.AssociatedDataSet;

			if (tcssDs.TcssDonor.Rows.Count < 1)
				return;

			if (tcssDs.TcssRecipientOfferStatusInformation.Count > 0)
			{
				TcssDS.TcssRecipientOfferInformationRow row = tcssDs.TcssRecipientOfferInformation[0];
                //if (!row.IsTcssListOrganTypeIdNull())
                //    txtOrganType.Text = GetFieldValue(_tcssOrganTypeDs, row.TcssListOrganTypeId);
                //if (!row.IsClientIdNull())
                //    txtClient.Text = GetFieldValue(_tcssSourceCodeDs, row.ClientId);
                string selectMaxDateClose = string.Format("MAX({0})",tcssDs.TcssRecipientOfferStatusInformation.LastUpdateDateColumn.ColumnName);
                DateTime lastUpdateDateClose = Convert.ToDateTime(tcssDs.TcssRecipientOfferStatusInformation.Compute(selectMaxDateClose, string.Empty));
                string selectdonorStatInformationClose = string.Format("{0}>=#{1}# AND {0}<#{2}#",
                                                                                 tcssDs.TcssRecipientOfferStatusInformation.LastUpdateDateColumn.
                                                                                       ColumnName, TruncateToSecond(lastUpdateDateClose), lastUpdateDateClose.AddSeconds(1));
                DataRow[] tcssDonorStatusInformationRow = tcssDs.TcssRecipientOfferStatusInformation.Select(selectdonorStatInformationClose);
                int listStatusId = 0;
                if (tcssDonorStatusInformationRow.Length > 0)
                {
                    listStatusId = Convert.ToInt32(tcssDonorStatusInformationRow[0][tcssDs.TcssRecipientOfferStatusInformation.TcssListStatusIdColumn.ColumnName]);
                }
                txtMostRecentStatus.Text = GetFieldValue(_tcssDonorStatusDs, listStatusId); //row.MostRecentStatus;

                string selectMaxDate = string.Format("MAX({0})",tcssDs.TcssRecipientOfferInformation.LastUpdateDateColumn.ColumnName);
                DateTime lastUpdateDate = Convert.ToDateTime(tcssDs.TcssRecipientOfferInformation.Compute(selectMaxDate, string.Empty));
                string selectdonorStatInformation = string.Format("{0}>=#{1}# AND {0}<#{2}#",
                                                                                  tcssDs.TcssRecipientOfferInformation.LastUpdateDateColumn.
                                                                                        ColumnName, TruncateToSecond(lastUpdateDate), lastUpdateDate.AddSeconds(1));
                DataRow[] tcssRecipientOfferInformationRow = tcssDs.TcssRecipientOfferInformation.Select(selectdonorStatInformation);
                listStatusId = 0;
                if (tcssRecipientOfferInformationRow.Length > 0)
				{
                    if (!tcssDs.TcssRecipientOfferInformation[0].IsTcssListCloseReason2IdNull())
                        listStatusId = Convert.ToInt32(tcssRecipientOfferInformationRow[0][tcssDs.TcssRecipientOfferInformation.TcssListCloseReason2IdColumn.ColumnName]);
				}
				// got the ID need to get the value now.
                lblClosedStatusText.Text = GetFieldValue(_tcssRecipientOfferInformationDs, listStatusId);
			}
		}

		private void _tcssDonorCurrencyManager_ItemChanged(object sender, System.Windows.Forms.ItemChangedEventArgs e)
		{
			SetValuesForIDColumns();
		}

		private DateTime TruncateToSecond(DateTime dateTime)
		{
			return new DateTime(dateTime.Year, dateTime.Month, dateTime.Day, dateTime.Hour, dateTime.Minute, dateTime.Second, dateTime.Kind);
		}
		#endregion

        private void cboSourceCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!(cbSourceCode.SelectedValue is int))
                return;
            txtSourceCode.Text = cbSourceCode.Text;
            cbClient.Visible = true;
            cbClient.BindOrganizationBySourceCode((int)cbSourceCode.SelectedValue);
            cbClient.Visible = false;
        }

        private void cbClient_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!(cbClient.SelectedValue is int))
                return;

            txtClient.Text = cbClient.Text;
        }

        private void cbOrganType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!(cbOrganType.SelectedValue is int))
                return;

            txtOrganType.Text = cbOrganType.Text;
        }

        private void btn_Issues_Click(object sender, EventArgs e)
        {
            ((BaseForm)FindForm()).LoadInFormPromptForm(AppScreenType.None, AppScreenType.ReportIssueFeedbackup);
        }
	}
}
