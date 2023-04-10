using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class LogEventLockedHelperBR : BaseBR
    {
        #region Constructor
        public LogEventLockedHelperBR() { }
		#endregion

        public LogEventsLockDS LogEventLocked(int logEventID)
		{
            AssociatedDataSet = new LogEventsLockDS();
            AssociatedDA = new LogEventLockedHelperDA(logEventID);
            return (LogEventsLockDS)Select();
		}
    }
}
