using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class FamilyServiceViewBR : BaseBR
    {
        public FamilyServiceViewBR()
        {
            AssociatedDA = new FamilyServiceViewDA();
            AssociatedDataSet = new FamilyServiceViewDS();

        }
        #region Public Properties
        #endregion
    }
}
