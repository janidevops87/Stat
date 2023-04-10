using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class VitalSignsDetailsControl : BaseEditControl
	{
		public VitalSignsDetailsControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			ugVitalSign.DataSource = dataSet;
			ugVitalSign.DataMember = ((TcssBR)BusinessRule).UiVitalSign;
			ugVitalSign.DisplayLayout.Bands[0].Columns["From Date/Time"].SortIndicator = Infragistics.Win.UltraWinGrid.SortIndicator.Ascending;
            ugVitalSign.DisplayLayout.Bands[0].Columns["From Date/Time"].MaskInput = "mm/dd/yyyy hh:mm";
            ugVitalSign.DisplayLayout.Bands[0].Columns["To Date/Time"].MaskInput = "mm/dd/yyyy hh:mm";
			ugVitalSign.DisplayLayout.Bands[0].Columns[0].Hidden = true;
            //hiding the second average bp field
            ugVitalSign.DisplayLayout.Bands[0].Columns[6].Hidden = true;

			// Requirement 3070: 1.2.1: By default, the oldest record will be displayed first (on the left) and the most 
			// recent record will display last (on the right).
			ugVitalSign.DisplayLayout.Bands[0].Columns[1].SortIndicator = Infragistics.Win.UltraWinGrid.SortIndicator.Ascending;

			// Requirement 3070: 1.2.2 By default, the screen will set the focus to the most recent record.
			// This means the scroll bar is moved all the way to the right.
			if (ugVitalSign.Rows.Count > 0)
			{
				ugVitalSign.DisplayLayout.Rows[ugVitalSign.Rows.Count - 1].Cells[3].Activate();
			}
		}
	}
}
