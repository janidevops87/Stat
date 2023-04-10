using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class IncompletesDA : BaseDA
    {
        #region Private Fields
        //private int LeaseOrg;
        private string vTZ;
        #endregion

        #region Constructor
        public IncompletesDA()
            : base("DashboardIncompletesSelect")
		{
            SetTablesSelect("IncompleteCalls");
        }
        #endregion

        #region Public Properties
        //public int leaseOrg
        //{
        //    get { return LeaseOrg; }
        //    set { LeaseOrg = value; }
        //}
        public string TZ
        {
            get { return vTZ; }
            set { vTZ = value; }
        }
        #endregion

        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            commandWrapper.AddInParameterForSelect("LeaseOrg", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
            commandWrapper.AddInParameterForSelect("vTZ", DbType.String, "MT");
        }
        #endregion
    }
}
