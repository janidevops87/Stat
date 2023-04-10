using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;


namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class RestoreCasesBR : BaseBR
    {
        public RestoreCasesBR()
		{
            AssociatedDA = new RestoreCasesDA();
            AssociatedDataSet = new RecycledRestoreDS();
		}

        #region Public Properties

        
        public int callID
        {
            get { return ((RestoreCasesDA)AssociatedDA).CallID; }
            set { ((RestoreCasesDA)AssociatedDA).CallID = value; }
        }
        
        #endregion
    }
}
