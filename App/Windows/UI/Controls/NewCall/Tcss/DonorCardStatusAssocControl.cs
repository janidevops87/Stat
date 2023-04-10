using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class DonorCardStatusAssocControl : BaseEditControl
	{
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
		public DonorCardStatusAssocControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			cbStatusOfImportData.BindData("TcssListStatusOfImportDataSelect");
            if (generalConstant.OasisImportClick == true)
                cbStatusOfImportData.Enabled = true;
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			string tableName = dataSet.TcssRecipientOfferInformation.TableName;
			cbStatusOfImportData.BindDataSet(dataSet, tableName, dataSet.TcssRecipientOfferInformation.TcssListStatusOfImportDataIdColumn.ColumnName);
            //two non visible controls to bind the data to, for saving later and not having to re-select, must be briefly visible to bind
            txtStatusSetByStatEmployeeId.Visible = true;
            dtStatusSetDateTime.Visible = true;
            txtStatusSetByStatEmployeeId.BindDataSet(dataSet, tableName, dataSet.TcssRecipientOfferInformation.StatusSetByStatEmployeeIdColumn.ColumnName);
            dtStatusSetDateTime.BindDataSet(dataSet, tableName, dataSet.TcssRecipientOfferInformation.StatusSetDateTimeColumn.ColumnName);
            txtStatusSetByStatEmployeeId.Visible = false;
            dtStatusSetDateTime.Visible = false;
			if (!dataSet.TcssRecipientOfferInformation[0].IsStatusSetByStatEmployeeNameNull())
			{
				txtStatusSetBy.Text = dataSet.TcssRecipientOfferInformation[0].StatusSetByStatEmployeeName.ToString();
			}
			if (!dataSet.TcssRecipientOfferInformation[0].IsStatusSetDateTimeNull())
			{
				txtDateTime.Text = dataSet.TcssRecipientOfferInformation[0].StatusSetDateTime.ToString(WindowsConstant.CreateInstance().DateTimeFormat);
			}
			ugAssociatedDonorCards.DataSource = dataSet;
            ugAssociatedDonorCards.DataMember = dataSet.TcssDonorToRecipient.TableName;
		}

		private void cbStatusOfImportData_SelectedIndexChanged(object sender, System.EventArgs e)
		{
            if (cbStatusOfImportData.SelectedValue != null && cbStatusOfImportData.SelectedIndex > 0)
			{
				switch ((TcssListStatusOfImportData)cbStatusOfImportData.SelectedValue)
				{
					case TcssListStatusOfImportData.DonorCardDataSufficient:
                        if (GRConstant.OasisReadOnly == false)
						    TcssManager.ToggleEditForDataScrapeFromUnos(true);
						break;
					case TcssListStatusOfImportData.DonorCardDataInsufficient:
                        //TcssManager.DeleteDataBeforeImport();
                        //TcssManager.ReLoadDataFromDatabase();
                        TcssManager.EnableSave();
						break;
					default:
						break;
				}
			}
		}

		private void ugAssociatedDonorCards_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
		{
            //TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
            //if (e.Row.Cells["CallId"].Value is int)
            //{
            //    //int callId = (int)e.Row.Cells["CallId"].Value;
            //    //if (e.Row.Cells["CallId"].Value is int && callId == dataSet.TcssRecipientOfferInformation[0].CallId)
            //    //{
            //    //    e.Row.Hidden = true;
            //    //}
            //}
		}

        private void DonorCardStatusAssocControl_Leave(object sender, System.EventArgs e)
        {
            GRConstant.OasisImportClick = false;
        }

        private void cbStatusOfImportData_Leave(object sender, System.EventArgs e)
        {//bind the data and it has to be briefly visible to bind
            txtStatusSetByStatEmployeeId.Visible = true;
            dtStatusSetDateTime.Visible = true;
            txtStatusSetByStatEmployeeId.Text = StattracIdentity.Identity.UserId.ToString();
            dtStatusSetDateTime.Value = GRConstant.CurrentDateTime;
            txtStatusSetByStatEmployeeId.Focus();
            cbStatusOfImportData.Focus();
            txtStatusSetByStatEmployeeId.Visible = false;
            dtStatusSetDateTime.Visible = false;
        }
	}
}
