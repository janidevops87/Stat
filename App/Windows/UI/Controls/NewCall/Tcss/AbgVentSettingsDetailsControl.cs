using System;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class AbgVentSettingsControl : BaseEditControl
	{
		public AbgVentSettingsControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;

            string tableName = dataSet.TcssDonorAbgSummary.TableName;
            txtHowManyDaysVented.BindDataSet(dataSet, tableName, dataSet.TcssDonorAbgSummary.HowManyDaysVentedColumn.ColumnName);

            ugAbgVentSettings.DataSource = dataSet;
			ugAbgVentSettings.DataMember = dataSet.TcssDonorAbg.TableName;
			ugAbgVentSettings.BindValueList("TcssListVentSettingModeSelect", "TcssListVentSettingModeId");
			ugAbgVentSettings.DisplayLayout.Bands[0].Columns[dataSet.TcssDonorAbg.SampleDateTimeColumn.ColumnName].SortIndicator = SortIndicator.Ascending;
		}

		/// <summary>
		/// Requirement 3079: 1.2.8.1 Mode, Other is entered if Other is selected from the Mode list.
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void ugAbgVentSettings_InitializeRow(object sender, InitializeRowEventArgs e)
		{
			ModeOtherToggle(e.Row.Cells["TcssListVentSettingModeId"]);
            ugAbgVentSettings.DisplayLayout.Bands[0].SortedColumns.RefreshSort(true);
		}

		/// <summary>
		/// Requirement 3079: 1.2.8.1 Mode, Other is entered if Other is selected from the Mode list.
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void ugAbgVentSettings_AfterCellUpdate(object sender, CellEventArgs e)
		{
			ModeOtherToggle(e.Cell);
		}

		/// <summary>
		/// Requirement 3079: 1.2.8.1 Mode, Other is entered if Other is selected from the Mode list.
		/// </summary>
		/// <param name="cell"></param>
		private void ModeOtherToggle(UltraGridCell cell)
		{
			if (cell.Column.Key == "TcssListVentSettingModeId" && // Make sure we are looking at the anser column
				cell.Value != DBNull.Value && // make sure the value is not null
				(int)cell.Value == (int)TcssListVentSettingMode.Other) // If Other is seleceted 
			{
				cell.Row.Cells["ModeOther"].Activation = Activation.AllowEdit;
			}
			else
			{
				cell.Row.Cells["ModeOther"].Activation = Activation.NoEdit;
			}
		}

        private void ugAbgVentSettings_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            ugAbgVentSettings.DisplayLayout.Bands[0].Columns["SampleDateTime"].MaskInput = "mm/dd/yyyy hh:mm";
        }
	}
}
