using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class CommitClientChangesDA : BaseDA
    {
        public enum CommitClientChangesDASprocs
        {
            spu_CommitClientChanges
        }
        #region Private Fields
        //Parms
        private string jobName;
        #endregion

        #region Constructor
        public CommitClientChangesDA()
            : base("spu_CommitClientChanges")
		{
            //SetTablesSelect("IncompleteCalls");
        }
         public void SetDefaultTablesSelect()
         {
             SpSelect = CommitClientChangesDASprocs.spu_CommitClientChanges.ToString();
         }
        #endregion

        #region Public Properties
        public string JobName
        {
            get { return jobName; }
            set { jobName = value; }
        }
        #endregion

        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            commandWrapper.AddInParameterForSelect("jobName", DbType.String, "Commit Historical Changes - ");
        }
        #endregion
    }
}
