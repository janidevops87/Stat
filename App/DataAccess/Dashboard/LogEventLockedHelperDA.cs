using System.Data;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class LogEventLockedHelperDA : BaseDA

    {
        #region Private Fields
        private int logEventID;
		#endregion

		#region Constructor
        public LogEventLockedHelperDA(int logEventID)
            : base("LogEventLockedSelect")
		{
            this.logEventID = logEventID;
            SetTablesSelect("LogEventLock");
		}
		#endregion

		#region Overridden Methods
		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
            commandWrapper.AddInParameterForSelect("@LogEventID", DbType.Int32, logEventID);
		}
		#endregion
    }
}
