using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class UpdateBR : BaseBR
    {
        public UpdateBR()
		{
            AssociatedDA = new UpdateDA();
		    AssociatedDataSet = new UpdateDS();
        }
        #region Public Properties

        public string CallNumber
        {
            get { return ((UpdateDA)AssociatedDA).CallNumber; }
            set { ((UpdateDA)AssociatedDA).CallNumber = value; }
        }
        public string StartDate
        {
            get { return ((UpdateDA)AssociatedDA).StartDate; }
            set { ((UpdateDA)AssociatedDA).StartDate = value; }
        }
        public string StartTime
        {
            get { return ((UpdateDA)AssociatedDA).StartTime; }
            set { ((UpdateDA)AssociatedDA).StartTime = value; }
        }
        public string EndDate
        {
            get { return ((UpdateDA)AssociatedDA).EndDate; }
            set { ((UpdateDA)AssociatedDA).EndDate = value; }
        }
        public string EndTime
        {
            get { return ((UpdateDA)AssociatedDA).EndTime; }
            set { ((UpdateDA)AssociatedDA).EndTime = value; }
        }
        public string StatAbbreviation
        {
            get { return ((UpdateDA)AssociatedDA).StatAbbreviation; }
            set { ((UpdateDA)AssociatedDA).StatAbbreviation = value; }
        }
        public string ReferralDonorFirstName
        {
            get { return ((UpdateDA)AssociatedDA).ReferralDonorFirstName; }
            set { ((UpdateDA)AssociatedDA).ReferralDonorFirstName = value; }
        }
        public string ReferralDonorLastName
        {
            get { return ((UpdateDA)AssociatedDA).ReferralDonorLastName; }
            set { ((UpdateDA)AssociatedDA).ReferralDonorLastName = value; }
        }
        public string OrganizationName
        {
            get { return ((UpdateDA)AssociatedDA).OrganizationName; }
            set { ((UpdateDA)AssociatedDA).OrganizationName = value; }
        }
        public string SourceCodeName
        {
            get { return ((UpdateDA)AssociatedDA).SourceCodeName; }
            set { ((UpdateDA)AssociatedDA).SourceCodeName = value; }
        }
        public string PreviousReferralTypeName
        {
            get { return ((UpdateDA)AssociatedDA).PreviousReferralTypeName; }
            set { ((UpdateDA)AssociatedDA).PreviousReferralTypeName = value; }
        }
        public string CurrentReferralTypeName
        {
            get { return ((UpdateDA)AssociatedDA).CurrentReferralTypeName; }
            set { ((UpdateDA)AssociatedDA).CurrentReferralTypeName = value; }
        }
        public string StatEmployeeFirstName
        {
            get { return ((UpdateDA)AssociatedDA).StatEmployeeFirstName; }
            set { ((UpdateDA)AssociatedDA).StatEmployeeFirstName = value; }
        }
        public string StatEmployeeLastName
        {
            get { return ((UpdateDA)AssociatedDA).StatEmployeeLastName; }
            set { ((UpdateDA)AssociatedDA).StatEmployeeLastName = value; }
        }
        #endregion
    }
}
