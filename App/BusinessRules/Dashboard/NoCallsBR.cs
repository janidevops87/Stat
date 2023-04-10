using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class NoCallsBR : BaseBR
    {
        public NoCallsBR()
		{
            AssociatedDA = new NoCallsDA();
            AssociatedDataSet = new NoCallsDS();
		}

        #region Public Properties

        public string CallNumber
        {
            get { return ((NoCallsDA)AssociatedDA).CallNumber; }
            set { ((NoCallsDA)AssociatedDA).CallNumber = value; }
        }
        public string StartDateTime
        {
            get { return ((NoCallsDA)AssociatedDA).StartDateTime; }
            set { ((NoCallsDA)AssociatedDA).StartDateTime = value; }
        }
        public string EndDateTime
        {
            get { return ((NoCallsDA)AssociatedDA).EndDateTime; }
            set { ((NoCallsDA)AssociatedDA).EndDateTime = value; }
        }
        public string NoCallTypeName
        {
            get { return ((NoCallsDA)AssociatedDA).NoCallTypeName; }
            set { ((NoCallsDA)AssociatedDA).NoCallTypeName = value; }
        }
        public string NoCallDescription
        {
            get { return ((NoCallsDA)AssociatedDA).NoCallDescription; }
            set { ((NoCallsDA)AssociatedDA).NoCallDescription = value; }
        }
        public string StatEmployeeFirstName
        {
            get { return ((NoCallsDA)AssociatedDA).StatEmployeeFirstName; }
            set { ((NoCallsDA)AssociatedDA).StatEmployeeFirstName = value; }
        }
        public string StatEmployeeLastName
        {
            get { return ((NoCallsDA)AssociatedDA).StatEmployeeLastName; }
            set { ((NoCallsDA)AssociatedDA).StatEmployeeLastName = value; }
        }
        public string SourceCodeName
        {
            get { return ((NoCallsDA)AssociatedDA).SourceCodeName; }
            set { ((NoCallsDA)AssociatedDA).SourceCodeName = value; }
        }
        #endregion
    }
}
