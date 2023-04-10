using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Framework;


namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class LogEventLockBR : BaseBR
    {
        private GeneralConstant grConstant;
        public LogEventLockBR()
        {
            AssociatedDA = new LogEventLockDA();
            AssociatedDataSet = new LogEventsLockDS();
            grConstant = GeneralConstant.CreateInstance();
        }

        #region Public Properties

        public string LogEventOrg
        {
            get { return ((LogEventLockDA)AssociatedDA).LogEventOrg; }
            set { ((LogEventLockDA)AssociatedDA).LogEventOrg = value; }
        }
        public int LogEventID
        {
            get { return ((LogEventLockDA)AssociatedDA).LogEventID; }
            set { ((LogEventLockDA)AssociatedDA).LogEventID = value; }
        }
        //public int StatEmployeeID
        //{
        //    get { return ((LogEventLockDA)AssociatedDA).StatEmployeeID; }
        //    set { ((LogEventLockDA)AssociatedDA).StatEmployeeID = value; }
        //}

        #endregion
    }
}
