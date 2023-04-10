using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class LabProfileSummaryControl : BaseEditControl
	{
		public LabProfileSummaryControl()
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
                        HideOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryLiver];
                        break;
                    case TcssListOrganType.Kidney:
                        BindOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryKidney];
                        break;
                    case TcssListOrganType.Heart:
                        HideOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryHeart];
                        break;
                    case TcssListOrganType.Lung:
                        HideOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryLung];
                        break;
                    case TcssListOrganType.Intestine:
                        HideOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryIntestine];
                        break;
                    case TcssListOrganType.Pancreas:
                        BindOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryPancreas];
                        break;
                    case TcssListOrganType.HeartLung:
                        HideOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryHeartLung];
                        break;
                    case TcssListOrganType.KidneyPancreas:
                        BindOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryKidneyPancreas];
                        break;
                    case TcssListOrganType.MultiOrgan:
                        BindOrganSpecificControls();
                        ugLabProfileSummary.DataSource = dataSet.Tables[tcssBR.UiLabProfileSummaryMultiOrgan];
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
			string tableName = dataSet.TcssDonorLabProfileSummary.TableName;
			txtAlcHbalcInitial.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcInitialColumn.ColumnName);
            dteAlcHbalcInitialFromDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcInitialFromDateColumn.ColumnName);
            dteAlcHbalcInitialToDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcInitialToDateColumn.ColumnName);
			txtAlcHbalcPeak.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcPeakColumn.ColumnName);
            dteAlcHbalcPeakFromDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcPeakFromDateColumn.ColumnName);
            dteAlcHbalcPeakToDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcPeakToDateColumn.ColumnName);
			txtAlcHbalcCurrent.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcCurrentColumn.ColumnName);
            dteAlcHbalcCurrentFromDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcCurrentFromDateColumn.ColumnName);
            dteAlcHbalcCurrentToDate.BindDataSet(dataSet, tableName, dataSet.TcssDonorLabProfileSummary.AlcHbalcCurrentToDateColumn.ColumnName);
		}

		private void HideOrganSpecificControls()
		{
            label1.Visible = false;
            label2.Visible = false;
			lblAlcHbalcInitial.Visible = false;
			lblAlcHbalcPeak.Visible = false;
			lblAlcHbalcCurrent.Visible = false;
			txtAlcHbalcInitial.Visible = false;
			txtAlcHbalcPeak.Visible = false;
			txtAlcHbalcCurrent.Visible = false;
            dteAlcHbalcInitialFromDate.Visible = false;
            dteAlcHbalcInitialToDate.Visible = false;
            dteAlcHbalcPeakFromDate.Visible = false;
            dteAlcHbalcPeakToDate.Visible = false;
            dteAlcHbalcCurrentFromDate.Visible = false;
            dteAlcHbalcCurrentToDate.Visible = false;
		}
	}
}
