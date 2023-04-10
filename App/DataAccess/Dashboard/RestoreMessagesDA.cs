using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class RestoreMessagesDA : BaseDA
    {
        #region Private Fields
        private int callID;
        #endregion

        #region Constructor
        public RestoreMessagesDA()
            : base("DashboardRecycleRestoreMessagesSelect")
		{
            SetTablesSelect("RecycleRestoreMessagesList");
        }
        #endregion

        #region Public Properties
        public int CallID
        {
            get { return callID; }
            set { callID = value; }
        }
        
        #endregion

        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            commandWrapper.AddInParameterForSelect("callID", DbType.Int32, callID);
            
        }
        #endregion
    }
}
