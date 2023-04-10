using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.Dashboard
{

    public class DashboardHelperBR : BaseBR
    {
        private string result = null;
        #region Constructor
        public DashboardHelperBR() { }
        #endregion

        public string DashboardFindCall(int callId)
        {
            DashboardHelperDS dashboardHelperDS;
            dashboardHelperDS = null;
            AssociatedDataSet = new DashboardHelperDS();
            AssociatedDA = new DashboardHelperDA(callId);
            dashboardHelperDS = (DashboardHelperDS)Select();
            if (dashboardHelperDS.DashboardFindCall.Count == 1)
            {
                result = " Unable to find call";
                if (dashboardHelperDS.DashboardFindCall[0].IsReferral == 1)
                    result = " Call is in the Referral Tab";
                else if (dashboardHelperDS.DashboardFindCall[0].IsMessage == 1)
                    result = " Call is in the Message Tab";
                else if (dashboardHelperDS.DashboardFindCall[0].IsNocall == 1)
                    result = " Call is in the No Call Tab";
                else if (dashboardHelperDS.DashboardFindCall[0].IsOasis == 1)
                    result = " Call is in the Oasis Tab";
                else if (dashboardHelperDS.DashboardFindCall[0].IsRecycledCall == 1)
                    result = " Call is in the Recycled Call Tab";
                else if (dashboardHelperDS.DashboardFindCall[0].IsRecycledMsg == 1)
                    result = " Call is in the Recycled Message Tab";
                else if (dashboardHelperDS.DashboardFindCall[0].IsRecycleOasis == 1)
                    result = " Call is in the Recycled OASIS Tab";
                else if (dashboardHelperDS.DashboardFindCall[0].IsFSActive == 1)
                    result = " Call is in the FS Active Tab";
                else if (dashboardHelperDS.DashboardFindCall[0].IsUpdate == 1)
                    result = " Call is in the Update Tab";
            }
            return result;
        }
    }
       
}
