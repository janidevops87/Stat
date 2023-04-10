using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class PendingEventsPopUpBR : BaseBR
    {
        public PendingEventsPopUpBR()
        {
            AssociatedDA = new PendingEventsPopUpDA();
            AssociatedDataSet = new PendingEventsDS();
        }

        #region Public Properties

        public string TZ
        {
            get { return ((PendingEventsPopUpDA)AssociatedDA).TZ; }
            set { ((PendingEventsPopUpDA)AssociatedDA).TZ = value; }
        }
        public string orgName
        {
            get { return ((PendingEventsPopUpDA)AssociatedDA).orgName; }
            set { ((PendingEventsPopUpDA)AssociatedDA).orgName = value; }
        }

        #endregion
    }
}
