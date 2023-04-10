using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
	public class FamilyServiceActiveCaseBR : BaseBR
	{
		public FamilyServiceActiveCaseBR()
		{
			AssociatedDA = new FamilyServiceActiveCasesDA();
			AssociatedDataSet = new FsbActiveCasesDS();
		}
        public string CallId
        {
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).CallId; }
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).CallId = value; }
        }
		public string MostRecentStatus
		{
			set { ((FamilyServiceActiveCasesDA)AssociatedDA).MostRecentStatus = value; }
			get { return ((FamilyServiceActiveCasesDA)AssociatedDA).MostRecentStatus; }
		}

		public DateTime MinLastUpdateDate
		{
			set { ((FamilyServiceActiveCasesDA)AssociatedDA).MinLastUpdateDate = value; }
			get { return ((FamilyServiceActiveCasesDA)AssociatedDA).MinLastUpdateDate; }
		}

		public DateTime MaxLastUpdateDate
		{
			set { ((FamilyServiceActiveCasesDA)AssociatedDA).MaxLastUpdateDate = value; }
			get { return ((FamilyServiceActiveCasesDA)AssociatedDA).MaxLastUpdateDate; }
		}

        public string SourceCodeName
        {
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).SourceCodeName = value; }
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).SourceCodeName; }
        }

        public string PatientFirst
        {
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).PatientFirst = value; }
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).PatientFirst; }
        }

        public string PatientLast
        {
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).PatientLast = value; }
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).PatientLast; }
        }

        public string CoordinatorFirst
        {
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).CoordinatorFirst = value; }
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).CoordinatorFirst; }
        }

        public string CoordinatorLast
        {
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).CoordinatorLast = value; }
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).CoordinatorLast; }
        }

        public string MostRecentComment
        {
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).MostRecentComment = value; }
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).MostRecentComment; }
        }

        public string PreviousCoordinatorFirst
        {
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).PreviousCoordinatorFirst = value; }
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).PreviousCoordinatorFirst; }
        }

        public string PreviousCoordinatorLast
        {
            set { ((FamilyServiceActiveCasesDA)AssociatedDA).PreviousCoordinatorLast = value; }
            get { return ((FamilyServiceActiveCasesDA)AssociatedDA).PreviousCoordinatorLast; }
        }

	}
}
