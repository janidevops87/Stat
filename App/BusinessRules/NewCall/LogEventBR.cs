using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;


namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class LogEventBR : BaseBR
    {
        public LogEventBR()
		{
            AssociatedDA = new LogEventDA();
            AssociatedDataSet = new LogEventDS();
		}

        #region Public Properties

        
        #endregion
    }
}
