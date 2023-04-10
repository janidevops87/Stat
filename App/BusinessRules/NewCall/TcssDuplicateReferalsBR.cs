using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.DataAccess.NewCall;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.NewCall
{
	public class TcssDuplicateReferalsBR : BaseBR
	{
		#region Constructor
		public TcssDuplicateReferalsBR()
		{
			AssociatedDataSet = new TcssDuplicateReferalsDS();
			AssociatedDA = new TcssDuplicateReferalsDA();
		}
		#endregion

		#region Properties
		public int CurrentCallId
		{
			get { return ((TcssDuplicateReferalsDA)AssociatedDA).CurrentCallId; }
			set { ((TcssDuplicateReferalsDA)AssociatedDA).CurrentCallId = value; }
		}
		public int SourceCodeId
		{
			get { return ((TcssDuplicateReferalsDA)AssociatedDA).SourceCodeId; }
			set { ((TcssDuplicateReferalsDA)AssociatedDA).SourceCodeId = value; }
		}
		public int TcssListOrganTypeId
		{
			get { return ((TcssDuplicateReferalsDA)AssociatedDA).TcssListOrganTypeId; }
			set { ((TcssDuplicateReferalsDA)AssociatedDA).TcssListOrganTypeId = value; }
		}
		public string MatchId
		{
			get { return ((TcssDuplicateReferalsDA)AssociatedDA).MatchId; }
			set { ((TcssDuplicateReferalsDA)AssociatedDA).MatchId = value; }
		}
		public string OptnNumber
		{
			get { return ((TcssDuplicateReferalsDA)AssociatedDA).OptnNumber; }
			set { ((TcssDuplicateReferalsDA)AssociatedDA).OptnNumber = value; }
		}
		#endregion


	}
}

