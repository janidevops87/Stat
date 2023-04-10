using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class FamilyServiceViewDA : BaseDA
    {
        public int LeaseOrg { get; set; }
        public string TimeZone { get; set; }
        public int StatEmployee { get; set; }

        public enum DashboardFamilyServiceViewDASprocs
        { 
            DashboardFamilyServiceViewSelectDataSet,
            DashboardPendingSecondaryActivitySelect,
            DashboardPendingSecondaryAlertSelect,
            DashboardPendingSecondaryWIPSelect
        }
        public FamilyServiceViewDA()
            : base("DashboardFamilyServiceViewSelectDataSet")
        {
            SetTablesSelect("UpdatedReferralEvents");
        }
        public void SetDefaultTableSelect()
        {
            SpSelect = DashboardFamilyServiceViewDASprocs.DashboardFamilyServiceViewSelectDataSet.ToString();
            SetTablesSelect(
                "PendingSecondaryActivity",
                "PendingSecondaryAlert",
                "PendingSecondaryWIP"
                );
        }
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            switch ((DashboardFamilyServiceViewDASprocs)Enum.Parse(typeof(DashboardFamilyServiceViewDASprocs), SpSelect, true))
            {
                case DashboardFamilyServiceViewDASprocs.DashboardFamilyServiceViewSelectDataSet:
                    SetDefaultTableSelect();
                    commandWrapper.AddInParameterForSelect("DataSetLeaseOrg", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
                    commandWrapper.AddInParameterForSelect("DataSetTimeZone", DbType.String, "MT");
                    commandWrapper.AddInParameterForSelect("DataSetStatEmployee", DbType.Int32, StattracIdentity.Identity.UserId);
                    break;
                case DashboardFamilyServiceViewDASprocs.DashboardPendingSecondaryActivitySelect:
                    commandWrapper.AddInParameterForSelect("LeaseOrg", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
                    commandWrapper.AddInParameterForSelect("TimeZone", DbType.String, "MT");
                    commandWrapper.AddInParameterForSelect("StatEmployee", DbType.Int32, StattracIdentity.Identity.UserId);
                    break;
                case DashboardFamilyServiceViewDASprocs.DashboardPendingSecondaryAlertSelect:
                    commandWrapper.AddInParameterForSelect("LeaseOrg", DbType.Int32, 0);
                    commandWrapper.AddInParameterForSelect("TimeZone", DbType.String, "MT");
                    commandWrapper.AddInParameterForSelect("StatEmployee", DbType.Int32, StattracIdentity.Identity.UserId);
                    break;
                case DashboardFamilyServiceViewDASprocs.DashboardPendingSecondaryWIPSelect:
                    commandWrapper.AddInParameterForSelect("LeaseOrg", DbType.Int32, 0);
                    commandWrapper.AddInParameterForSelect("TimeZone", DbType.String, "MT");
                    commandWrapper.AddInParameterForSelect("StatEmployee", DbType.Int32, StattracIdentity.Identity.UserId);
                    break;
                default:
                    break;
            }
        }
        public void SelectPendingSecondaryActivity(int leaseOrg, string timeZone, int statEmployee)
        {
            SpSelect = DashboardFamilyServiceViewDASprocs.DashboardPendingSecondaryActivitySelect.ToString();
            LeaseOrg = leaseOrg;
            TimeZone = timeZone;
            StatEmployee = statEmployee;
            SetTablesSelect("PendingSecondaryActivity");
        }
        public void SelectPendingSecondaryAlert(int leaseOrg, string timeZone, int statEmployee)
        {
            SpSelect = DashboardFamilyServiceViewDASprocs.DashboardPendingSecondaryAlertSelect.ToString();
            LeaseOrg = leaseOrg;
            TimeZone = timeZone;
            StatEmployee = statEmployee;
            SetTablesSelect("PendingSecondaryAlert");
        }
        public void SelectPendingSecondaryWIP(int leaseOrg, string timeZone, int statEmployee)
        {
            SpSelect = DashboardFamilyServiceViewDASprocs.DashboardPendingSecondaryWIPSelect.ToString();
            LeaseOrg = leaseOrg;
            TimeZone = timeZone;
            StatEmployee = statEmployee;
            SetTablesSelect("PendingSecondaryWIP");
        }


        #endregion

    }
}
