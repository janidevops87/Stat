using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class MedicalSocialHistoryControl : BaseEditControl
	{
		public MedicalSocialHistoryControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			cbMeetCdcGuidelines.BindData("TcssListDonorMeetCdcGuidelinesSelect");
			cbOtherDrugUse.BindData("TcssListOtherDrugUseSelect");
			cbHeavyAlcoholUse.BindData("TcssListHeavyAlcoholUseSelect");
			cbCigaretteUseContinued.BindData("TcssListCigaretteUseContinuedSelect");
			cbCigaretteUse.BindData("TcssListCigaretteUseSelect");
			cbChestTrauma.BindData("TcssListChestTraumaSelect");
			cbHistoryOfGastrointestinalDisease.BindData("TcssListHistoryOfGastrointestinalDiseaseSelect");
			cbHistoryOfCoronaryArteryDisease.BindData("TcssListHistoryOfCoronaryArteryDiseaseSelect");
			cbCompliantWithTreatment.BindData("TcssListCompliantWithTreatmentSelect");
			cbHypertensionHistory.BindData("TcssListHypertensionHistorySelect");
			cbHistoryOfCancer.BindData("TcssListHistoryOfCancerSelect");
			cbHistoryOfDiabetes.BindData("TcssListHistoryOfDiabetesSelect");

			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			string tableName = dataSet.TcssDonorMedSoc.TableName;
			cbMeetCdcGuidelines.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListDonorMeetCdcGuidelinesIdColumn.ColumnName);
			cbOtherDrugUse.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListOtherDrugUseIdColumn.ColumnName);
			cbHeavyAlcoholUse.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListHeavyAlcoholUseIdColumn.ColumnName);
			cbCigaretteUseContinued.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListCigaretteUseContinuedIdColumn.ColumnName);
			cbCigaretteUse.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListCigaretteUseIdColumn.ColumnName);
			cbChestTrauma.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListChestTraumaIdColumn.ColumnName);
			cbHistoryOfGastrointestinalDisease.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListHistoryOfGastrointestinalDiseaseIdColumn.ColumnName);
			cbHistoryOfCoronaryArteryDisease.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListHistoryOfCoronaryArteryDiseaseIdColumn.ColumnName);
			cbCompliantWithTreatment.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListCompliantWithTreatmentIdColumn.ColumnName);
			cbHypertensionHistory.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListHypertensionHistoryIdColumn.ColumnName);
			cbHistoryOfCancer.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListHistoryOfCancerIdColumn.ColumnName);
			cbHistoryOfDiabetes.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.TcssListHistoryOfDiabetesIdColumn.ColumnName);
			txtMedSocComments.BindDataSet(dataSet, tableName, dataSet.TcssDonorMedSoc.CommentsColumn.ColumnName);
		}
	}
}
