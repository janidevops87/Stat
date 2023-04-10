using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class LogEventLockDA : BaseDA
    {
        #region Private Fields
        private string logEventOrg;
        private int logEventID;
        //private int statEmployeeID;
        #endregion

        #region Constructor
        public LogEventLockDA()
            : base("LogEventLockSelect")
        {
            SetTablesSelect("LogEventLock");
            ListTableSave.Add(new TableSave("LogEventLock", "LogEventLockInsert", "LogEventLockUpdate", "LogEventLockDelete"));
        }
        #endregion

        #region Public Properties
        public string LogEventOrg
        {
            get { return logEventOrg; }
            set { logEventOrg = value; }
        }
        public int LogEventID
        {
            get { return logEventID; }
            set { logEventID = value; }
        }
        //public int StatEmployeeID
        //{
        //    get { return statEmployeeID; }
        //    set { statEmployeeID = value; }
        //}
        #endregion

        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            commandWrapper.AddInParameterForSelect("LogEventOrg", DbType.String, logEventOrg);
        }

        protected override void AddParameterForDelete(DataTable table, BaseCommand commandWrapper)
        {
            //base.AddParameterForDelete(table, commandWrapper);
            commandWrapper.AddInParameterForSave("LogEventOrg", DbType.String, logEventOrg);
            commandWrapper.AddInParameterForSave("LogEventID", DbType.Int32, logEventID);
            commandWrapper.AddInParameterForSave("StatEmployeeID", DbType.Int32, StattracIdentity.Identity.UserId);
        }
        #endregion
    }

}
