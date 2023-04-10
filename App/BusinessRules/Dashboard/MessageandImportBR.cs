using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class MessageandImportBR : BaseBR
    {
        public MessageandImportBR()
		{
            AssociatedDA = new MessageandImportDA();
            AssociatedDataSet = new MessageandImportDS();
		}

        #region Public Properties

        public string CallNumber
        {
            get { return ((MessageandImportDA)AssociatedDA).CallNumber; }
            set { ((MessageandImportDA)AssociatedDA).CallNumber = value; }
        }
        public string StartDateTime
        {
            get { return ((MessageandImportDA)AssociatedDA).StartDateTime; }
            set { ((MessageandImportDA)AssociatedDA).StartDateTime = value; }
        }
        public string EndDateTime
        {
            get { return ((MessageandImportDA)AssociatedDA).EndDateTime; }
            set { ((MessageandImportDA)AssociatedDA).EndDateTime = value; }
        }
        public string ReferralDonorFirstName
        {
            get { return ((MessageandImportDA)AssociatedDA).ReferralDonorFirstName; }
            set { ((MessageandImportDA)AssociatedDA).ReferralDonorFirstName = value; }
        }
        public string ReferralDonorLastName
        {
            get { return ((MessageandImportDA)AssociatedDA).ReferralDonorLastName; }
            set { ((MessageandImportDA)AssociatedDA).ReferralDonorLastName = value; }
        }
        public string OrganizationName
        {
            get { return ((MessageandImportDA)AssociatedDA).OrganizationName; }
            set { ((MessageandImportDA)AssociatedDA).OrganizationName = value; }
        }
        public string SourceCodeName
        {
            get { return ((MessageandImportDA)AssociatedDA).SourceCodeName; }
            set { ((MessageandImportDA)AssociatedDA).SourceCodeName = value; }
        }
        public string Optn
        {
            get { return ((MessageandImportDA)AssociatedDA).Optn; }
            set { ((MessageandImportDA)AssociatedDA).Optn = value; }
        }
        public string MessageType
        {
            get { return ((MessageandImportDA)AssociatedDA).MessageType; }
            set { ((MessageandImportDA)AssociatedDA).MessageType = value; }
        }
        public string MessageCallerName
        {
            get { return ((MessageandImportDA)AssociatedDA).MessageCallerName; }
            set { ((MessageandImportDA)AssociatedDA).MessageCallerName = value; }
        }
        public string MessageCallerOrganization
        {
            get { return ((MessageandImportDA)AssociatedDA).MessageCallerOrganization; }
            set { ((MessageandImportDA)AssociatedDA).MessageCallerOrganization = value; }
        }
        public string StatEmployeeFirstName
        {
            get { return ((MessageandImportDA)AssociatedDA).StatEmployeeFirstName; }
            set { ((MessageandImportDA)AssociatedDA).StatEmployeeFirstName = value; }
        }
        public string StatEmployeeLastName
        {
            get { return ((MessageandImportDA)AssociatedDA).StatEmployeeLastName; }
            set { ((MessageandImportDA)AssociatedDA).StatEmployeeLastName = value; }
        }
        #endregion
    }
}
