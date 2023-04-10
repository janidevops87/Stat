using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class CommitClientChangesBR : BaseBR
    {
        public CommitClientChangesBR()
		{
            AssociatedDA = new CommitClientChangesDA();
		}
        public void ExecuteNonQuery()
        {
            base.ExecuteNonQuery();
            ((CommitClientChangesDA)AssociatedDA).SetDefaultTablesSelect();
        }
        public string JobName
        {
            get { return ((CommitClientChangesDA)AssociatedDA).JobName; }
            set { ((CommitClientChangesDA)AssociatedDA).JobName = value; }
        }
    }

    
}
