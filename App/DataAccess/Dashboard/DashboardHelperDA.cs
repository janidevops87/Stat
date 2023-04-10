using System.Data;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class DashboardHelperDA : BaseDA
    {
        #region Private Fields
		private int callId;
		#endregion

		#region Constructor
        public DashboardHelperDA(int callId)
            : base("DashboardFindCall")
		{
			this.callId = callId;
            SetTablesSelect("DashboardFindCall");
		}
		#endregion

		#region Overridden Methods
		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
            commandWrapper.AddInParameterForSelect("callNumber", DbType.Int32, callId);
            commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
		}
		#endregion
    }
}
