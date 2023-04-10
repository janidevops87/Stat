using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class RestoreMessagesBR : BaseBR
    {
        public RestoreMessagesBR()
		{
            AssociatedDA = new RestoreMessagesDA();
            AssociatedDataSet = new RecycledRestoreDS();
		}

        #region Public Properties

        
        public int callID
        {
            get { return ((RestoreMessagesDA)AssociatedDA).CallID; }
            set { ((RestoreMessagesDA)AssociatedDA).CallID = value; }
        }
        
        #endregion
    }
}
