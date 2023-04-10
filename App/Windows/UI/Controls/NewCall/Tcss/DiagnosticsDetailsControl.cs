using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Data.Types.NewCall;


namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class DiagnosticsDetailsControl : BaseEditControl
	{
		public DiagnosticsDetailsControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;

			// Kidney
			cbKidneyBiopsyLeft.BindData("TcssListKidneyBiopsySelect");
			cbKidneyPumpDeviceLeft.BindData("TcssListKidneyPumpDeviceSelect");
			cbKidneyPumpSolutionLeft.BindData("TcssListKidneyPumpSolutionSelect");

			cbKidneyBiopsyRight.BindData("TcssListKidneyBiopsySelect");
			cbKidneyPumpDeviceRight.BindData("TcssListKidneyPumpDeviceSelect");
			cbKidneyPumpSolutionRight.BindData("TcssListKidneyPumpSolutionSelect");

			// Left kidney
			string tableName = dataSet.TcssDonorDiagnosisKidneyLeft.TableName;
			cbKidneyBiopsyLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyBiopsyIdColumn.ColumnName);
			txtKidneyCommentsLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.CommentColumn.ColumnName);
            txtLeftBiopsyType.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.BiopsyTypeColumn.ColumnName);
			cbKidneyPumpDeviceLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyPumpDeviceIdColumn.ColumnName);
			cbKidneyPumpSolutionLeft.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyLeft.TcssListKidneyPumpSolutionIdColumn.ColumnName);

			// Right Kidney
			tableName = dataSet.TcssDonorDiagnosisKidneyRight.TableName;
			cbKidneyBiopsyRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyBiopsyIdColumn.ColumnName);
			txtKidneyCommentsRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.CommentColumn.ColumnName);
            txtRightBiopsyType.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.BiopsyTypeColumn.ColumnName);
			cbKidneyPumpDeviceRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyPumpDeviceIdColumn.ColumnName);
			cbKidneyPumpSolutionRight.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.TcssListKidneyPumpSolutionIdColumn.ColumnName);

			// Biopsy
			ugKidneyBiopsyLeft.DataSource = dataSet;
			ugKidneyBiopsyLeft.DataMember = dataSet.TcssDonorDiagnosisKidneyBiopsyLeft.TableName;
			ugKidneyBiopsyLeft.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorDiagnosisKidneyBiopsyLeft.DateTimeColumn.ColumnName].SortIndicator = SortIndicator.Ascending;
			ugKidneyBiopsyRight.DataSource = dataSet;
			ugKidneyBiopsyRight.DataMember = dataSet.TcssDonorDiagnosisKidneyBiopsyRight.TableName;
			ugKidneyBiopsyRight.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorDiagnosisKidneyBiopsyRight.DateTimeColumn.ColumnName].SortIndicator = SortIndicator.Ascending;

			// Liver Biopsy
			cbLiverBiopsy.BindData("TcssListLiverBiopsySelect");
			tableName = dataSet.TcssDonorDiagnosisLiver.TableName;
			cbLiverBiopsy.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLiver.TcssListLiverBiopsyIdColumn.ColumnName);
			txtLiverComments.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisKidneyRight.CommentColumn.ColumnName);

			// Other Biopsy
			ugOtherBiopsy.DataSource = dataSet;
			ugOtherBiopsy.DataMember = dataSet.TcssDonorDiagnosisOther.TableName;
			ugOtherBiopsy.BindValueList("TcssListOtherOrganSelect", "TcssListOtherOrganId");

			// Heart Details
			cbHeartMethod.BindData("TcssListDiagnosisHeartMethodSelect");
			tableName = dataSet.TcssDonorDiagnosisHeart.TableName;
			txtLvEjectionFraction.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisHeart.LvEjectionFractionColumn.ColumnName);
			cbHeartMethod.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisHeart.TcssListDiagnosisHeartMethodIdColumn.ColumnName);
			txtShorteningFraction.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisHeart.ShorteningFractionColumn.ColumnName);
			txtSeptalWallThickness.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisHeart.SeptalWallThicknessColumn.ColumnName);
			txtLvPosteriorWallThickness.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisHeart.LvPosteriorWallThicknessColumn.ColumnName);
			txtHeartComments.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisHeart.CommentColumn.ColumnName);

			// Lung Details
			cbChestXray.BindData("TcssListDiagnosisLungChestXraySelect");
			tableName = dataSet.TcssDonorDiagnosisLung.TableName;
            dtDateIntubated.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.DateIntubatedColumn.ColumnName);
			txtLengthOfRightLung.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.LengthOfRightLungColumn.ColumnName);
			txtLengthOfLeftLung.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.LengthOfLeftLungColumn.ColumnName);
			txtAorticKnobWidth.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.AorticKnobWidthColumn.ColumnName);
			txtDiaphragmWidth.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.DiaphragmWidthColumn.ColumnName);
			txtDistRCPAtoLCPA.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.DistanceRcpaToLcpaColumn.ColumnName);
			txtLeftLungComments.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.LeftLungCommentsColumn.ColumnName);
            txtRightLungComments.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.RightLungCommentsColumn.ColumnName);
			cbChestXray.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.TcssListDiagnosisLungChestXrayIdColumn.ColumnName);
			txtDonorPredictedTotalLungCapacity.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.DonorPredictedTotalLungCapacityColumn.ColumnName);
            txtChestCircLandmark.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisLung.ChestCircLandmarkColumn.ColumnName);
			
			// Sputum Grain Stain
			ugSputumGrainStain.DataSource = dataSet;
			ugSputumGrainStain.DataMember = dataSet.TcssDonorDiagnosisLungSputum.TableName;
			ugSputumGrainStain.BindValueList("TcssListCultureTypeSelect", "TcssListCultureTypeId");
			ugSputumGrainStain.BindValueList("TcssListCultureResultSelect", "TcssListCultureResultId");
			ugSputumGrainStain.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorDiagnosisLungSputum.SampleDateTimeColumn.ColumnName].SortIndicator = SortIndicator.Ascending;


			// Pancreas Details
			tableName = dataSet.TcssDonorDiagnosisPancreas.TableName;
			txtPancreasComments.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisPancreas.CommentColumn.ColumnName);

			// Intestine Details
			tableName = dataSet.TcssDonorDiagnosisIntestine.TableName;
			txtIntestineDetails.BindDataSet(dataSet, tableName, dataSet.TcssDonorDiagnosisIntestine.CommentColumn.ColumnName);
		}

        private void ugKidneyBiopsyLeft_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ugKidneyBiopsyLeft.DisplayLayout.Bands[0].Columns["DateTime"].MaskInput = "mm/dd/yyyy hh:mm";
        }

        private void ugKidneyBiopsyRight_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ugKidneyBiopsyRight.DisplayLayout.Bands[0].Columns["DateTime"].MaskInput = "mm/dd/yyyy hh:mm";
            
        }
	}
}
