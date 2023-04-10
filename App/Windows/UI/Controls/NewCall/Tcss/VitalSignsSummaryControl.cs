using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class VitalSignsSummaryControl : BaseEditControl
	{
		public VitalSignsSummaryControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			TcssBR tcssBR = (TcssBR)BusinessRule;
			TcssDS dataSet = (TcssDS)tcssBR.AssociatedDataSet;
            if (!dataSet.TcssRecipientOfferInformation[0].IsTcssListOrganTypeIdNull())
            {
                TcssListOrganType tcssDonorOrganType = (TcssListOrganType)dataSet.TcssRecipientOfferInformation[0].TcssListOrganTypeId;
                switch (tcssDonorOrganType)
                {
                    case TcssListOrganType.Liver:
                        BindOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryLiver];
                        break;
                    case TcssListOrganType.Kidney:
                        BindOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryKidney];
                        break;
                    case TcssListOrganType.Heart:
                        BindOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryHeart];
                        break;
                    case TcssListOrganType.Lung:
                        HideOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryLung];
                        break;
                    case TcssListOrganType.Intestine:
                        BindOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryIntestine];
                        break;
                    case TcssListOrganType.Pancreas:
                        BindOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryPancreas];
                        break;
                    case TcssListOrganType.HeartLung:
                        BindOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryHeartLung];
                        break;
                    case TcssListOrganType.KidneyPancreas:
                        BindOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryKidneyPancreas];
                        break;
                    case TcssListOrganType.MultiOrgan:
                        BindOrganSpecificControls();
                        ugVitalSign.DataSource = dataSet.Tables[tcssBR.UiVitalSignSummaryMultiOrgan];
                        break;
                    default:
                        break;
                }
            }
            
		}

		private void BindOrganSpecificControls()
		{
			TcssBR tcssBR = (TcssBR)BusinessRule;
			TcssDS dataSet = (TcssDS)tcssBR.AssociatedDataSet;
			string tableName = dataSet.TcssDonorVitalSignSummary.TableName;
			txtSao2Initial.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2InitialColumn.ColumnName);
			txtSao2Peak.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2PeakColumn.ColumnName);
			txtSao2Current.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2CurrentColumn.ColumnName);
            dteSao2CurrentFromDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2CurrentFromDateColumn.ColumnName);
            dteSao2CurrentToDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2CurrentToDateColumn.ColumnName);
            dteSao2InitialFromDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2InitialFromDateColumn.ColumnName);
            dteSao2InitialToDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2InitialToDateColumn.ColumnName);
            dteSao2PeakFromDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2PeakFromDateColumn.ColumnName);
            dteSao2PeakToDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorVitalSignSummary.Sao2PeakToDateColumn.ColumnName);
		}

		private void HideOrganSpecificControls()
		{
			lblSao2Initial.Visible = false;
			lblSao2Peak.Visible = false;
			lblSao2Current.Visible = false;
            label1.Visible = false;
            label2.Visible = false;
			txtSao2Initial.Visible = false;
			txtSao2Peak.Visible = false;
			txtSao2Current.Visible = false;
            dteSao2CurrentFromDate.Visible = false;
            dteSao2CurrentToDate.Visible = false;
            dteSao2InitialFromDate.Visible = false;
            dteSao2InitialToDate.Visible = false;
            dteSao2PeakFromDate.Visible = false;
            dteSao2PeakToDate.Visible = false;
		}

        private void ugVitalSign_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            //hiding the date fields of average bp...they don't have names
            ugVitalSign.DisplayLayout.Bands[0].Columns[5].Hidden = true;
            ugVitalSign.DisplayLayout.Bands[0].Columns[6].Hidden = true;
            ugVitalSign.DisplayLayout.Bands[0].Columns[11].Hidden = true;
            ugVitalSign.DisplayLayout.Bands[0].Columns[12].Hidden = true;
        }
	}

}
