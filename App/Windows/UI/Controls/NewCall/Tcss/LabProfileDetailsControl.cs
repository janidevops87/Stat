using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class LabProfileDetailsControl : BaseEditControl
	{
		public LabProfileDetailsControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			cbToxicologyScreen.BindData("TcssListToxicologyScreenSelect");

			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			ugLabProfile.DataSource = dataSet;
			ugLabProfile.DataMember = ((TcssBR)BusinessRule).UiLabProfile;
			ugLabProfile.DisplayLayout.Bands[0].Columns[0].Hidden = true;
			ugLabProfile.DisplayLayout.Bands[0].Columns[1].SortIndicator = Infragistics.Win.UltraWinGrid.SortIndicator.Ascending;
			if (ugLabProfile.Rows.Count > 0)
			{
				ugLabProfile.DisplayLayout.Rows[ugLabProfile.Rows.Count - 1].Cells[2].Activate();
			}


			ugLabValues.DataSource = dataSet;
			ugLabValues.DataMember = dataSet.TcssDonorLabValues.TableName;
			ugLabValues.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorLabValues.SampleDateTimeColumn.ColumnName].SortIndicator = Infragistics.Win.UltraWinGrid.SortIndicator.Ascending;

			ugCompleteBloodCount.DataSource = dataSet;
			ugCompleteBloodCount.DataMember = dataSet.TcssDonorCompleteBloodCount.TableName;
			ugCompleteBloodCount.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorCompleteBloodCount.SampleDateTimeColumn.ColumnName].SortIndicator = Infragistics.Win.UltraWinGrid.SortIndicator.Ascending;

			string tableName = dataSet.TcssDonorLab.TableName;
			cbToxicologyScreen.BindData("TcssListToxicologyScreenSelect");
			cbToxicologyScreen.BindDataSet(dataSet, tableName, dataSet.TcssDonorLab.TcssListToxicologyScreenIdColumn.ColumnName);
			txtResults.BindDataSet(dataSet, tableName, dataSet.TcssDonorLab.ResultsColumn.ColumnName);
			txtOtherLabs.BindDataSet(dataSet, tableName, dataSet.TcssDonorLab.OtherLabsColumn.ColumnName);
            txtHbA1c.BindDataSet(dataSet, tableName, dataSet.TcssDonorLab.HbA1cColumn.ColumnName);
            dtHbA1cDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorLab.HbA1cDateTimeColumn.ColumnName);
		}
       
        private void ugCompleteBloodCount_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            ugCompleteBloodCount.DisplayLayout.Bands[0].SortedColumns.RefreshSort(true);
        }

        private void ugLabValues_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
        {
            ugLabValues.DisplayLayout.Bands[0].SortedColumns.RefreshSort(true);
        }

        private void ugLabValues_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ugLabValues.DisplayLayout.Bands[0].Columns["SampleDateTime"].MaskInput = "mm/dd/yyyy hh:mm";
        }

        private void ugCompleteBloodCount_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ugCompleteBloodCount.DisplayLayout.Bands[0].Columns["SampleDateTime"].MaskInput = "mm/dd/yyyy hh:mm";
        }

        private void ugLabProfile_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            ugLabProfile.DisplayLayout.Bands[0].Columns[1].MaskInput = "mm/dd/yyyy hh:mm";
        }
	}
}
