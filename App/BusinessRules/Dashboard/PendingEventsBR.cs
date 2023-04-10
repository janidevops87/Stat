using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class PendingEventsBR : BaseBR
    {
        public PendingEventsBR()
		{
            AssociatedDA = new PendingEventsDA();
            AssociatedDataSet = new PendingEventsDS();
		}

        #region Public Properties

        //public int LeaseOrg
        //{
        //    get { return ((PendingEventsDA)AssociatedDA).leaseOrg; }
        //    set { ((PendingEventsDA)AssociatedDA).leaseOrg = value; }
        //}
        public string TZ
        {
            get { return ((PendingEventsDA)AssociatedDA).TZ; }
            set { ((PendingEventsDA)AssociatedDA).TZ = value; }
        }
        public string orgName
        {
            get { return ((PendingEventsDA)AssociatedDA).orgName; }
            set { ((PendingEventsDA)AssociatedDA).orgName = value; }
        }
        
        #endregion
    }
}
