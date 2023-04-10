using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class UrinalysisCulturesControl : BaseEditControl
	{
		public UrinalysisCulturesControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			ugUrinalysis.DataSource = dataSet;
			ugUrinalysis.DataMember = dataSet.TcssDonorUrinalysis.TableName;
            //ugUrinalysis.BindValueList("TcssListUrinalysisProteinSelect", "TcssListUrinalysisProteinId");
            //ugUrinalysis.BindValueList("TcssListUrinalysisGlucoseSelect", "TcssListUrinalysisGlucoseId");
            //ugUrinalysis.BindValueList("TcssListUrinalysisBloodSelect", "TcssListUrinalysisBloodId");
            //ugUrinalysis.BindValueList("TcssListUrinalysisRbcSelect", "TcssListUrinalysisRbcId");
            //ugUrinalysis.BindValueList("TcssListUrinalysisWbcSelect", "TcssListUrinalysisWbcId");
            //ugUrinalysis.BindValueList("TcssListUrinalysisEpithSelect", "TcssListUrinalysisEpithId");
            //ugUrinalysis.BindValueList("TcssListUrinalysisCastSelect", "TcssListUrinalysisCastId");
            //ugUrinalysis.BindValueList("TcssListUrinalysisBacteriaSelect", "TcssListUrinalysisBacteriaId");
            //ugUrinalysis.BindValueList("TcssListUrinalysisLeukocyteSelect", "TcssListUrinalysisLeukocyteId");
			ugUrinalysis.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorUrinalysis.SampleDateTimeColumn.ColumnName].SortIndicator = SortIndicator.Ascending;

			ugCultures.DataSource = dataSet;
			ugCultures.DataMember = dataSet.TcssDonorCulture.TableName;
			ugCultures.BindValueList("TcssListCultureTypeSelect", "TcssListCultureTypeId");
			ugCultures.BindValueList("TcssListCultureResultSelect", "TcssListCultureResultId");
			ugCultures.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorCulture.SampleDateTimeColumn.ColumnName].SortIndicator = SortIndicator.Ascending;
        }

        private void ugCultures_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ugCultures.DisplayLayout.Bands[0].Columns["SampleDateTime"].MaskInput = "mm/dd/yyyy hh:mm";
        }

        private void ugUrinalysis_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ugUrinalysis.DisplayLayout.Bands[0].Columns["SampleDateTime"].MaskInput = "mm/dd/yyyy hh:mm";
        }

        private void ugUrinalysis_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            ugUrinalysis.DisplayLayout.Bands[0].SortedColumns.RefreshSort(true);
        }

        private void ugCultures_InitializeRow(object sender, InitializeRowEventArgs e)
        {
            ugCultures.DisplayLayout.Bands[0].SortedColumns.RefreshSort(true);
        }
	}
}
