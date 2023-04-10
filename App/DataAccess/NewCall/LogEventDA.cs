using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class LogEventDA : BaseDA
    {
        #region Private Fields
       
        #endregion

        #region Constructor
        public LogEventDA()
            : base("")
        {
            SetTablesSelect("LogEvent");
            ListTableSave.Add(new TableSave("LogEvent", "InsertLogEvent", "UpdateLogEvent", "DeleteLogEvent"));
        }
        #endregion

        #region Public Properties
      
        #endregion
        //AddParameterForSelectDataSet
        #region Methods
        
        #endregion
    }
}
