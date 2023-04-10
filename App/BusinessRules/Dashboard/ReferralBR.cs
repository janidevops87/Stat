using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class ReferralBR : BaseBR
    {
        private GeneralConstant grConstant;
        public ReferralBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            //if (grConstant.SelectedTab == "Referrals (F1)")
            //{
                AssociatedDA = new ReferralDA();
                AssociatedDataSet = new ReferralDS();
            //}
		}

        #region Public Properties

        public string CallNumber
        {
            get { return ((ReferralDA)AssociatedDA).CallNumber; }
            set { ((ReferralDA)AssociatedDA).CallNumber = value; }
        }
        public string StartDate
        {
            get { return ((ReferralDA)AssociatedDA).StartDate; }
            set { ((ReferralDA)AssociatedDA).StartDate = value; }
        }
        public string StartTime
        {
            get { return ((ReferralDA)AssociatedDA).StartTime; }
            set { ((ReferralDA)AssociatedDA).StartTime = value; }
        }
        public string EndDate
        {
            get { return ((ReferralDA)AssociatedDA).EndDate; }
            set { ((ReferralDA)AssociatedDA).EndDate = value; }
        }
        public string EndTime
        {
            get { return ((ReferralDA)AssociatedDA).EndTime; }
            set { ((ReferralDA)AssociatedDA).EndTime = value; }
        }
        public string StatAbbreviation
        {
            get { return ((ReferralDA)AssociatedDA).StatAbbreviation; }
            set { ((ReferralDA)AssociatedDA).StatAbbreviation = value; }
        }
        public string ReferralDonorFirstName
        {
            get { return ((ReferralDA)AssociatedDA).ReferralDonorFirstName; }
            set { ((ReferralDA)AssociatedDA).ReferralDonorFirstName = value; }
        }
        public string ReferralDonorLastName
        {
            get { return ((ReferralDA)AssociatedDA).ReferralDonorLastName; }
            set { ((ReferralDA)AssociatedDA).ReferralDonorLastName = value; }
        }
        public string OrganizationName
        {
            get { return ((ReferralDA)AssociatedDA).OrganizationName; }
            set { ((ReferralDA)AssociatedDA).OrganizationName = value; }
        }
        public string SourceCodeName
        {
            get { return ((ReferralDA)AssociatedDA).SourceCodeName; }
            set { ((ReferralDA)AssociatedDA).SourceCodeName = value; }
        }
        public string PreviousReferralTypeName
        {
            get { return ((ReferralDA)AssociatedDA).PreviousReferralTypeName; }
            set { ((ReferralDA)AssociatedDA).PreviousReferralTypeName = value; }
        }
        public string CurrentReferralTypeName
        {
            get { return ((ReferralDA)AssociatedDA).CurrentReferralTypeName; }
            set { ((ReferralDA)AssociatedDA).CurrentReferralTypeName = value; }
        }
        public string StatEmployeeFirstName
        {
            get { return ((ReferralDA)AssociatedDA).StatEmployeeFirstName; }
            set { ((ReferralDA)AssociatedDA).StatEmployeeFirstName = value; }
        }
        public string StatEmployeeLastName
        {
            get { return ((ReferralDA)AssociatedDA).StatEmployeeLastName; }
            set { ((ReferralDA)AssociatedDA).StatEmployeeLastName = value; }
        }
       
        #endregion
    }
}
