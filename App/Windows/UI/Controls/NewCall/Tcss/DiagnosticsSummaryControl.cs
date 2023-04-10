using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class DiagnosticsSummaryControl : BaseEditControl
	{
		public DiagnosticsSummaryControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;

			// Kidney
			ugArteryLeft.DataSource = dataSet;
			ugArteryLeft.DataMember = dataSet.TcssDonorDiagnosisKidneyArteryLeft.TableName;
            //if (ugArteryLeft.DisplayLayout.Rows.Count > 0)
            //    ugArteryLeft.DisplayLayout.Rows[0].Cells[dataSet.TcssDonorDiagnosisKidneyArteryLeft.DistanceColumn.ColumnName].Activation = Activation.NoEdit;
			ugVeinsLeft.DataSource = dataSet;
			ugVeinsLeft.DataMember = dataSet.TcssDonorDiagnosisKidneyVeinLeft.TableName;
			ugUreterLeft.DataSource = dataSet;
			ugUreterLeft.DataMember = dataSet.TcssDonorDiagnosisKidneyUreterLeft.TableName;
			ugUreterLeft.BindValueList("TcssListKidneyUreterSelect", "TcssListKidneyUreterId");
			ugUreterLeft.BindValueList("TcssListKidneyUreterTissueQualitySelect", "TcssListKidneyUreterTissueQualityId");

			ugArteryRight.DataSource = dataSet;
			ugArteryRight.DataMember = dataSet.TcssDonorDiagnosisKidneyArteryRight.TableName;
            //if (ugArteryRight.DisplayLayout.Rows.Count > 0)
            //    ugArteryRight.DisplayLayout.Rows[0].Cells[dataSet.TcssDonorDiagnosisKidneyArteryLeft.DistanceColumn.ColumnName].Activation = Activation.NoEdit;
			ugVeinsRight.DataSource = dataSet;
			ugVeinsRight.DataMember = dataSet.TcssDonorDiagnosisKidneyVeinRight.TableName;
			ugUreterRight.DataSource = dataSet;
			ugUreterRight.DataMember = dataSet.TcssDonorDiagnosisKidneyUreterRight.TableName;
			ugUreterRight.BindValueList("TcssListKidneyUreterSelect", "TcssListKidneyUreterId");
			ugUreterRight.BindValueList("TcssListKidneyUreterTissueQualitySelect", "TcssListKidneyUreterTissueQualityId");

			cbAorticCuffLeft.BindData("TcssListKidneyAorticCuffSelect");
			cbFullVenaLeft.BindData("TcssListKidneyFullVenaSelect");
			cbAorticPlaqueLeft.BindData("TcssListKidneyAorticPlaqueSelect");
			cbArterialPlaqueLeft.BindData("TcssListKidneyArterialPlaqueSelect");
			cbInfarctedAreaLeft.BindData("TcssListKidneyInfarctedAreaSelect");
			cbCapsularTearLeft.BindData("TcssListKidneyCapsularTearSelect");
			cbSubcapsularLeft.BindData("TcssListKidneySubcapsularSelect");
			cbHematomaLeft.BindData("TcssListKidneyHematomaSelect");
			cbFatCleanedLeft.BindData("TcssListKidneyFatCleanedSelect");
			cbCystsDiscolorationLeft.BindData("TcssListKidneyCystsDiscolorationSelect");
			cbHorseshoeShapeLeft.BindData("TcssListKidneyHorseshoeShapeSelect");

			cbAorticCuffRight.BindData("TcssListKidneyAorticCuffSelect");
			cbFullVenaRight.BindData("TcssListKidneyFullVenaSelect");
			cbAorticPlaqueRight.BindData("TcssListKidneyAorticPlaqueSelect");
			cbArterialPlaqueRight.BindData("TcssListKidneyArterialPlaqueSelect");
			cbInfarctedAreaRight.BindData("TcssListKidneyInfarctedAreaSelect");
			cbCapsularTearRight.BindData("TcssListKidneyCapsularTearSelect");
			cbSubcapsularRight.BindData("TcssListKidneySubcapsularSelect");
			cbHematomaRight.BindData("TcssListKidneyHematomaSelect");
			cbFatCleanedRight.BindData("TcssListKidneyFatCleanedSelect");
			cbCystsDiscolorationRight.BindData("TcssListKidneyCystsDiscolorationSelect");
			cbHorseshoeShapeRight.BindData("TcssListKidneyHorseshoeShapeSelect");

			// Left kidney
			string tableName = dataSet.TcssDonorDiagnosisKidneyLeft.TableName;
			cbAorticCuffLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyAorticCuffIdColumn.ColumnName);
			cbFullVenaLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyFullVenaIdColumn.ColumnName);
			txtLengthLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.LengthColumn.ColumnName);
			txtWidthLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.WidthColumn.ColumnName);
			cbAorticPlaqueLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyAorticPlaqueIdColumn.ColumnName);
			cbArterialPlaqueLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyArterialPlaqueIdColumn.ColumnName);
			cbInfarctedAreaLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyInfarctedAreaIdColumn.ColumnName);
			cbCapsularTearLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyCapsularTearIdColumn.ColumnName);
			cbSubcapsularLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneySubcapsularIdColumn.ColumnName);
			cbHematomaLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyHematomaIdColumn.ColumnName);
			cbFatCleanedLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyFatCleanedIdColumn.ColumnName);
			cbCystsDiscolorationLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyCystsDiscolorationIdColumn.ColumnName);
			cbHorseshoeShapeLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyHorseshoeShapeIdColumn.ColumnName);
			txtGlomeruliObservedLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.GlomeruliObservedColumn.ColumnName);
			txtGlomeruliSclerosedLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.GlomeruliSclerosedColumn.ColumnName);
			txtSclerosedLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.SclerosedPercentColumn.ColumnName);

			// Right Kidney
			tableName = dataSet.TcssDonorDiagnosisKidneyRight.TableName;
			cbAorticCuffRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyAorticCuffIdColumn.ColumnName);
			cbFullVenaRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyFullVenaIdColumn.ColumnName);
			txtLengthRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.LengthColumn.ColumnName);
			txtWidthRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.WidthColumn.ColumnName);
			cbAorticPlaqueRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyAorticPlaqueIdColumn.ColumnName);
			cbArterialPlaqueRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyArterialPlaqueIdColumn.ColumnName);
			cbInfarctedAreaRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyInfarctedAreaIdColumn.ColumnName);
			cbCapsularTearRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyCapsularTearIdColumn.ColumnName);
			cbSubcapsularRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneySubcapsularIdColumn.ColumnName);
			cbHematomaRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyHematomaIdColumn.ColumnName);
			cbFatCleanedRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyFatCleanedIdColumn.ColumnName);
			cbCystsDiscolorationRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyCystsDiscolorationIdColumn.ColumnName);
			cbHorseshoeShapeRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyHorseshoeShapeIdColumn.ColumnName);
			txtGlomeruliObservedRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.GlomeruliObservedColumn.ColumnName);
			txtGlomeruliSclerosedRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.GlomeruliSclerosedColumn.ColumnName);
			txtSclerosedRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.SclerosedPercentColumn.ColumnName);
		}
	}
}
