using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Dashboard
{
	public class PendingCasesDA : BaseDA
	{
		#region Constructor
		public PendingCasesDA() : base("DashboardPendingCasesSelect")
		{
			SetTablesSelect("PendingCasesList");
		}
		#endregion
	}
}
