using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class TestDiagnosesControl : BaseEditControl
	{
		public TestDiagnosesControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			ugTestDiagnoses.DataSource = dataSet;
			ugTestDiagnoses.DataMember = dataSet.TcssDonorTest.TableName;
			ugTestDiagnoses.BindValueList("TcssListTestTypeSelect", "TcssListTestTypeId");
			ugTestDiagnoses.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorTest.TestDateTimeColumn.ColumnName].SortIndicator = SortIndicator.Ascending;
		}

        private void ugTestDiagnoses_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ugTestDiagnoses.DisplayLayout.Bands[0].Columns["TestDateTime"].MaskInput = "mm/dd/yyyy hh:mm";
        }
	}
}
