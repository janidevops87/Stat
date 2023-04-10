using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class IncompletesBR : BaseBR
    {
        public IncompletesBR()
		{
            AssociatedDA = new IncompletesDA();
            AssociatedDataSet = new IncompletesDS();
		}

        #region Public Properties

        //public int LeaseOrg
        //{
        //    get { return ((IncompletesDA)AssociatedDA).leaseOrg; }
        //    set { ((IncompletesDA)AssociatedDA).leaseOrg = value; }
        //}
        public string TZ
        {
            get { return ((IncompletesDA)AssociatedDA).TZ; }
            set { ((IncompletesDA)AssociatedDA).TZ = value; }
        }
       
        #endregion
    }
}
