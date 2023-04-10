using System;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class FluidsBloodControl : BaseEditControl
	{
		public FluidsBloodControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{

			cbAntihypertensives.BindData("TcssListAntihypertensiveSelect");
			cbInsulin.BindData("TcssListInsulinSelect");
			cbT4.BindData("TcssListT4Select");
			cbT3.BindData("TcssListT3Select");
			cbDiuretics.BindData("TcssListDiureticSelect");
			cbSteroids.BindData("TcssListSteroidSelect");
			cbIsThereDextrose.BindData("TcssListDextroseInIvFluidsSelect");
			cbArginineVasopressin.BindData("TcssListArginineVasopressinSelect");
			cbDdavp.BindData("TcssListDdavpSelect");
			cbVasodilators.BindData("TcssListVasodilatorSelect");
			cbNumberOfTransfusion.BindData("TcssListNumberOfTransfusionSelect");
			cbOtherBloodProductId.BindData("TcssListOtherBloodProductSelect");
            cbHeparin.BindData("TcssListHeparinSelect");
            cbTotalParenteralNutrition.BindData("TcssListTotalParenteralNutritionSelect");

			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			string tableName = dataSet.TcssDonorFluidBlood.TableName;
			cbAntihypertensives.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListAntihypertensiveIdColumn.ColumnName);
			dtInsulinEndDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.InsulinEndDateTimeColumn.ColumnName);
			dtlInsulinBeginDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.InsulinBeginDateTimeColumn.ColumnName);
			cbInsulin.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListInsulinIdColumn.ColumnName);
			cbT4.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListT4IdColumn.ColumnName);
			cbT3.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListT3IdColumn.ColumnName);
			txtDiureticsSpecify.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.DiureticDetailColumn.ColumnName);
			cbDiuretics.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListDiureticIdColumn.ColumnName);
			txtSteroidsSpecify.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.SteroidsDetailColumn.ColumnName);
			cbSteroids.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListSteroidIdColumn.ColumnName);
			cbIsThereDextrose.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListDextroseInIvFluidsIdColumn.ColumnName);
            cbTotalParenteralNutrition.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListTotalParenteralNutritionIdColumn.ColumnName);
			txtIvFluids.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.IvFluidsColumn.ColumnName);
			txtOtherSpecify3.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.OtherSpecify3Column.ColumnName);
			txtOtherSpecify2.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.OtherSpecify2Column.ColumnName);
			txtOtherSpecify1.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.OtherSpecify1Column.ColumnName);
			txtTotalParenteralNutrition.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TotalParenteralNutritionColumn.ColumnName);
			dtArginineEndDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.ArginlineEndDateTimeColumn.ColumnName);
			dtArginineBeginDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.ArginlineBeginDateTimeColumn.ColumnName);
			cbArginineVasopressin.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListArginineVasopressinIdColumn.ColumnName);
			cbDdavp.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListDdavpIdColumn.ColumnName);
			cbVasodilators.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListVasodilatorIdColumn.ColumnName);
			cbNumberOfTransfusion.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListNumberOfTransfusionIdColumn.ColumnName);
			cbOtherBloodProductId.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListOtherBloodProductIdColumn.ColumnName);
			txtOtherBloodProductsDetails.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.OtherBloodProductsDetailsColumn.ColumnName);
            cbHeparin.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.TcssListHeparinIdColumn.ColumnName);
            dtHeparinBeginDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.HeparinBeginDateColumn.ColumnName);
            dtHeparinEndDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.HeparinEndDateColumn.ColumnName);
            txtHeparin.BindDataSet(dataSet, tableName, dataSet.TcssDonorFluidBlood.HeparinDosageColumn.ColumnName);

			ugMedications.DataSource = dataSet;
			ugMedications.DataMember = dataSet.TcssDonorMedication.TableName;
			ugMedications.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorMedication.StartDateColumn.ColumnName].SortIndicator = Infragistics.Win.UltraWinGrid.SortIndicator.Ascending;

			ugMedications.BindValueList("TcssListMedicationSelect", "TcssListMedicationId");
			ugMedications.BindValueList("TcssListMedicationDoseUnitSelect", "TcssListMedicationDoseUnitId");
		}

		/// <summary>
		/// Requirement 3071: 1.4.3.1.1
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void cbSteroids_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (cbSteroids.SelectedIndex > 0 && (int)cbSteroids.SelectedValue == (int)TcssListSteroid.Yes)
			{
				txtSteroidsSpecify.Enabled = true;
			}
			else
			{
				txtSteroidsSpecify.Enabled = false;
				txtSteroidsSpecify.Text = string.Empty;
			}
		}

		/// <summary>
		/// Requirement 3071: 1.5.2.1.1
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void cbOtherBloodProductId_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (cbOtherBloodProductId.SelectedIndex > 0 && (int)cbOtherBloodProductId.SelectedValue == (int)TcssListOtherBloodProduct.Yes)
			{
				txtOtherBloodProductsDetails.Enabled = true;
			}
			else
			{
				txtOtherBloodProductsDetails.Enabled = false;
				txtOtherBloodProductsDetails.Text = string.Empty;
			}
		}

        private void ugMedications_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ugMedications.DisplayLayout.Bands[0].Columns["StartDate"].MaskInput = "mm/dd/yyyy hh:mm";
            ugMedications.DisplayLayout.Bands[0].Columns["StopDateTime"].MaskInput = "mm/dd/yyyy hh:mm";
        }
	}
}
