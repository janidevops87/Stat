using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class DuplicateReferalsForm : Form
	{
		public DuplicateReferalsForm()
		{
			InitializeComponent();
			isLoadDuplicateReferral = false;
		}

		private bool isLoadDuplicateReferral;
		public bool IsLoadDuplicateReferral
		{
			get { return isLoadDuplicateReferral; }
		}

		public void ShowDialog(int currentCallId, int sourceCodeId, int tcssListOrganTypeId, string matchId, string optnNumber)
		{
			//DuplicateReferalsForm duplicateReferalsForm = new DuplicateReferalsForm();
			TcssDuplicateReferalsBR tcssDuplicateReferalsBR = new TcssDuplicateReferalsBR();
			tcssDuplicateReferalsBR.CurrentCallId = currentCallId;
			tcssDuplicateReferalsBR.SourceCodeId = sourceCodeId;
			tcssDuplicateReferalsBR.TcssListOrganTypeId = tcssListOrganTypeId;
			tcssDuplicateReferalsBR.MatchId = matchId;
			tcssDuplicateReferalsBR.OptnNumber = optnNumber;
			tcssDuplicateReferalsDS = (TcssDuplicateReferalsDS)tcssDuplicateReferalsBR.SelectDataSet();
			// If there are more than 1 possible duplicate then show the popup
			if (tcssDuplicateReferalsDS.TcssDuplicateReferals.Count > 0)
			{
				ugTcssDuplicateReferals.DataSource = tcssDuplicateReferalsDS;
				ugTcssDuplicateReferals.DataMember = "TcssDuplicateReferals";
				ugTcssDuplicateReferals.DataBind();
				ShowDialog();
			}
		}

		private void ugTcssDuplicateReferals_DoubleClickRow(object sender, Infragistics.Win.UltraWinGrid.DoubleClickRowEventArgs e)
		{
			if (ugTcssDuplicateReferals.Selected.Rows.Count == 1 && ugTcssDuplicateReferals.Selected.Rows[0].Cells != null)
			{
				CellsCollection cellsCollection = ugTcssDuplicateReferals.Selected.Rows[0].Cells;
				string callId = cellsCollection["CallId"].Value.ToString();
				string tcssDonorId = cellsCollection["TcssDonorId"].Value.ToString();
				string tcssRecipientId = cellsCollection["TcssRecipientId"].Value.ToString();

				GeneralConstant generalConstant = GeneralConstant.CreateInstance();
				generalConstant.ReferralId = (int)cellsCollection["CallId"].Value;
				generalConstant.TcssDonorId = (int)cellsCollection["TcssDonorId"].Value;
				generalConstant.TcssRecipientId = (int)cellsCollection["TcssRecipientId"].Value;
				isLoadDuplicateReferral = true;
				Close();
			}
		}
	}
}
