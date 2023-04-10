using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.BusinessRules.Framework
{
    public interface ITranslateDBConnection
    {
        ConnectionType GetHistoricalDBConnection(DatabaseInstance databaseInstance);
    }
}
