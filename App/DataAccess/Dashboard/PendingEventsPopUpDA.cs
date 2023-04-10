using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class PendingEventsPopUpDA : BaseDA
    {
        #region Private Fields
        private string vTZ;
        private string OrgName;
        #endregion

        #region Constructor
        public PendingEventsPopUpDA()
            : base("DashboardPendingPopUpSelect")
        {
            SetTablesSelect("PendingList");
        }
        #endregion

        #region Public Properties
      
        public string TZ
        {
            get { return vTZ; }
            set { vTZ = value; }
        }
        public string orgName
        {
            get { return OrgName; }
            set { OrgName = value; }
        }

        #endregion

        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            commandWrapper.AddInParameterForSelect("LeaseOrg", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
            commandWrapper.AddInParameterForSelect("vTZ", DbType.String, "MT");
            commandWrapper.AddInParameterForSelect("OrgName", DbType.String, OrgName);
        }
        #endregion
    }
}
