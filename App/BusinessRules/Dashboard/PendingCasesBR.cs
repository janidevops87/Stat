using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
	public class PendingCasesBR : BaseBR
	{
		#region Constructor
		public PendingCasesBR()
		{
			AssociatedDA = new PendingCasesDA();
			AssociatedDataSet = new PendingCasesDS();
		}
		#endregion
	}
}
