using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class RecycledCasesBR : BaseBR
    {
        public RecycledCasesBR()
		{
            AssociatedDA = new RecycledCasesDA();
            AssociatedDataSet = new RecycledCasesDS();
		}

        #region Public Properties

        public string CallNumber
        {
            get { return ((RecycledCasesDA)AssociatedDA).CallNumber; }
            set { ((RecycledCasesDA)AssociatedDA).CallNumber = value; }
        }
        public string StartDate
        {
            get { return ((RecycledCasesDA)AssociatedDA).StartDate; }
            set { ((RecycledCasesDA)AssociatedDA).StartDate = value; }
        }
        public string StartTime
        {
            get { return ((RecycledCasesDA)AssociatedDA).StartTime; }
            set { ((RecycledCasesDA)AssociatedDA).StartTime = value; }
        }
        public string EndDate
        {
            get { return ((RecycledCasesDA)AssociatedDA).EndDate; }
            set { ((RecycledCasesDA)AssociatedDA).EndDate = value; }
        }
        public string EndTime
        {
            get { return ((RecycledCasesDA)AssociatedDA).EndTime; }
            set { ((RecycledCasesDA)AssociatedDA).EndTime = value; }
        }
        public string ReferralDonorFirstName
        {
            get { return ((RecycledCasesDA)AssociatedDA).ReferralDonorFirstName; }
            set { ((RecycledCasesDA)AssociatedDA).ReferralDonorFirstName = value; }
        }
        public string ReferralDonorLastName
        {
            get { return ((RecycledCasesDA)AssociatedDA).ReferralDonorLastName; }
            set { ((RecycledCasesDA)AssociatedDA).ReferralDonorLastName = value; }
        }
        public string OrganizationName
        {
            get { return ((RecycledCasesDA)AssociatedDA).OrganizationName; }
            set { ((RecycledCasesDA)AssociatedDA).OrganizationName = value; }
        }
        public string SourceCodeName
        {
            get { return ((RecycledCasesDA)AssociatedDA).SourceCodeName; }
            set { ((RecycledCasesDA)AssociatedDA).SourceCodeName = value; }
        }
        public string PreviousReferralTypeName
        {
            get { return ((RecycledCasesDA)AssociatedDA).PreviousReferralTypeName; }
            set { ((RecycledCasesDA)AssociatedDA).PreviousReferralTypeName = value; }
        }
        public string CurrentReferralTypeName
        {
            get { return ((RecycledCasesDA)AssociatedDA).CurrentReferralTypeName; }
            set { ((RecycledCasesDA)AssociatedDA).CurrentReferralTypeName = value; }
        }
        public string StatEmployeeFirstName
        {
            get { return ((RecycledCasesDA)AssociatedDA).StatEmployeeFirstName; }
            set { ((RecycledCasesDA)AssociatedDA).StatEmployeeFirstName = value; }
        }
        public string StatEmployeeLastName
        {
            get { return ((RecycledCasesDA)AssociatedDA).StatEmployeeLastName; }
            set { ((RecycledCasesDA)AssociatedDA).StatEmployeeLastName = value; }
        }
        public string Optn
        {
            get { return ((RecycledCasesDA)AssociatedDA).Optn; }
            set { ((RecycledCasesDA)AssociatedDA).Optn = value; }
        }
        
        public string MessageCallerName
        {
            get { return ((RecycledCasesDA)AssociatedDA).MessageCallerName; }
            set { ((RecycledCasesDA)AssociatedDA).MessageCallerName = value; }
        }
        public string MessageCallerOrganization
        {
            get { return ((RecycledCasesDA)AssociatedDA).MessageCallerOrganization; }
            set { ((RecycledCasesDA)AssociatedDA).MessageCallerOrganization = value; }
        }
        public string Client
        {
            get { return ((RecycledCasesDA)AssociatedDA).Client; }
            set { ((RecycledCasesDA)AssociatedDA).Client = value; }
        }
        public string ImportOfferNumber
        {
            get { return ((RecycledCasesDA)AssociatedDA).ImportOfferNumber; }
            set { ((RecycledCasesDA)AssociatedDA).ImportOfferNumber = value; }
        }
        public string ReferralNumber
        {
            get { return ((RecycledCasesDA)AssociatedDA).ReferralNumber; }
            set { ((RecycledCasesDA)AssociatedDA).ReferralNumber = value; }
        }
        public string OrganType
        {
            get { return ((RecycledCasesDA)AssociatedDA).OrganType; }
            set { ((RecycledCasesDA)AssociatedDA).OrganType = value; }
        }
        public string OptnNumber
        {
            get { return ((RecycledCasesDA)AssociatedDA).OptnNumber; }
            set { ((RecycledCasesDA)AssociatedDA).OptnNumber = value; }
        }
        public string MatchId
        {
            get { return ((RecycledCasesDA)AssociatedDA).MatchId; }
            set { ((RecycledCasesDA)AssociatedDA).MatchId = value; }
        }
        public string TransplantSurgeonContact
        {
            get { return ((RecycledCasesDA)AssociatedDA).TransplantSurgeonContact; }
            set { ((RecycledCasesDA)AssociatedDA).TransplantSurgeonContact = value; }
        }
        public string ClinicalCoordinator
        {
            get { return ((RecycledCasesDA)AssociatedDA).ClinicalCoordinator; }
            set { ((RecycledCasesDA)AssociatedDA).ClinicalCoordinator = value; }
        }
        
        public void ExecuteNonQuery()
        {
            base.ExecuteNonQuery();
            ((RecycledCasesDA)AssociatedDA).SetDefaultTablesSelect();
        }
        public void RecycleCallsDelete(int callID, int lastSavedbyID)
        {
            //set values in the BR used to CheckForUserName
            CallID = callID;
            LastPersonID = lastSavedbyID;
            
            //Setup DA for query
            ((RecycledCasesDA)AssociatedDA).CallRecycleDelete();
            ExecuteNonQuery();
        }
        public void RecycleCallsRestore(int callID, int lastSavedbyID)
        {
            //set values in the BR used to CheckForUserName
            CallID = callID;
            LastPersonID = lastSavedbyID;

            //Setup DA for query
            ((RecycledCasesDA)AssociatedDA).CallRecycleRestore();
            ExecuteNonQuery();
        }
        public void CallRecycleUpdateOasis(int callID, int inactiveFlag, int lastSavedbyID)
        {
            //set values in the BR used to CheckForUserName
            CallID = callID;
            InactiveFlag = inactiveFlag;
            LastPersonID = lastSavedbyID;

            //Setup DA for query
            ((RecycledCasesDA)AssociatedDA).CallRecycleUpdateOasis();
            ExecuteNonQuery();
        }
        public void CallRecycleType(int recycleTypeID)
        {
            //Setup DA for query
            ((RecycledCasesDA)AssociatedDA).CallRecycleType(recycleTypeID);
        }
        public int CallID
        {
            get
            {
                return ((RecycledCasesDA)AssociatedDA).CallID;
            }
            set
            {
                ((RecycledCasesDA)AssociatedDA).CallID = value;
            }

        }
        public int LastPersonID
        {
            get
            {
                return ((RecycledCasesDA)AssociatedDA).LastPersonID;
            }
            set
            {
                ((RecycledCasesDA)AssociatedDA).LastPersonID = value;
            }
        }
        public int InactiveFlag
        {
            get
            {
                return ((RecycledCasesDA)AssociatedDA).InactiveFlag;
            }
            set
            {
                ((RecycledCasesDA)AssociatedDA).InactiveFlag = value;
            }
        }
        #endregion
    }
}
