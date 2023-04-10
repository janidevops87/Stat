using System;
using System.Drawing;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class SerologiesControl : BaseEditControl
	{
		public SerologiesControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			ugSerologies.DataSource = dataSet;
			ugSerologies.DataMember = dataSet.TcssDonorSerologies.TableName;

			ugSerologies.BindValueList("TcssListSerologyQuestionSelect", dataSet.TcssDonorSerologies.TcssListSerologyQuestionIdColumn.ColumnName);
			ugSerologies.BindValueList("TcssListSerologyAnswerSelect", dataSet.TcssDonorSerologies.TcssListSerologyAnswerIdColumn.ColumnName);
		}

		/// <summary>
		/// Requirement 3077: 1.4
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void ugSerologies_InitializeRow(object sender, Infragistics.Win.UltraWinGrid.InitializeRowEventArgs e)
		{
			SetAnswerColor(e.Row.Cells["TcssListSerologyAnswerId"]);
		}
	
		/// <summary>
		/// Requirement 3077: 1.4
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void ugSerologies_AfterCellUpdate(object sender, Infragistics.Win.UltraWinGrid.CellEventArgs e)
		{
			SetAnswerColor(e.Cell);
		}

		/// <summary>
		/// Requirement 3077: 1.4
		/// </summary>
		/// <param name="cell"></param>
		private void SetAnswerColor(UltraGridCell cell)
		{
			if (cell.Column.Key == "TcssListSerologyAnswerId" && // Make sure we are looking at the anser column
				cell.Value != DBNull.Value && // make sure the value is not null
				(int)cell.Value == (int)TcssListSerologyAnswer.Positive) // If positive is seleceted 
			{
				// Set the background to red
				cell.Appearance.BackColor = Color.Red;
			}
			else
			{
				// set the background to nothing.
				cell.Appearance.BackColor = Color.Empty;
			}
		}
	}
}
