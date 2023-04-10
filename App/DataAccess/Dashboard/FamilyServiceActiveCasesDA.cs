using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
	public class FamilyServiceActiveCasesDA : BaseDA
	{
		public FamilyServiceActiveCasesDA()
			: base("FsbActiveCasesSelect")
		{
			SetTablesSelect("FsbActiveCases");
		}
        private string callId;
		private string mostRecentStatus;
        private string sourceCodeName;
        private string patientFirst;
        private string patientLast;
        private string coordinatorFirst;
        private string coordinatorLast;
        private string previousCoordinatorFirst;
        private string previousCoordinatorLast;
        private string mostRecentComment;

        public string CallId
        {
            get { return callId; }
            set { callId = value; }
        }

		public string MostRecentStatus
		{
			get { return mostRecentStatus; }
			set { mostRecentStatus = value; }
		}

		private DateTime minLastUpdateDate;
		public DateTime MinLastUpdateDate
		{
			get { return minLastUpdateDate; }
			set { minLastUpdateDate = value; }
		}

		private DateTime maxLastUpdateDate;
		public DateTime MaxLastUpdateDate
		{
			get { return maxLastUpdateDate; }
			set { maxLastUpdateDate = value; }
		}

        public string SourceCodeName
        {
            get { return sourceCodeName; }
            set { sourceCodeName = value; }
        }

        public string PatientFirst
        {
            get { return patientFirst; }
            set { patientFirst = value; }
        }

        public string PatientLast
        {
            get { return patientLast; }
            set { patientLast = value; }
        }

        public string CoordinatorFirst
        {
            get { return coordinatorFirst; }
            set { coordinatorFirst = value; }
        }

        public string CoordinatorLast
        {
            get { return coordinatorLast; }
            set { coordinatorLast = value; }
        }

        public string MostRecentComment
        {
            get { return mostRecentComment; }
            set { mostRecentComment = value; }
        }

        public string PreviousCoordinatorFirst
        {
            get { return previousCoordinatorFirst; }
            set { previousCoordinatorFirst = value; }
        }

        public string PreviousCoordinatorLast
        {
            get { return previousCoordinatorLast; }
            set { previousCoordinatorLast = value; }
        }

		protected override void  AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
			commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
			commandWrapper.AddInParameterForSelect("MostRecentStatus", DbType.String, mostRecentStatus);
            commandWrapper.AddInParameterForSelect("SourceCodeName", DbType.String, sourceCodeName);
            commandWrapper.AddInParameterForSelect("PatientFirst", DbType.String, patientFirst);
            commandWrapper.AddInParameterForSelect("PatientLast", DbType.String, patientLast);
            commandWrapper.AddInParameterForSelect("CoordinatorFirst", DbType.String, coordinatorFirst);
            commandWrapper.AddInParameterForSelect("CoordinatorLast", DbType.String, coordinatorLast);
            commandWrapper.AddInParameterForSelect("MostRecentComment", DbType.String, mostRecentComment);
            commandWrapper.AddInParameterForSelect("PreviousCoordinatorFirst", DbType.String, previousCoordinatorFirst);
            commandWrapper.AddInParameterForSelect("PreviousCoordinatorLast", DbType.String, previousCoordinatorLast);
            if (!string.IsNullOrEmpty(callId))
                commandWrapper.AddInParameterForSelect("CallId", DbType.String, callId);
			if(minLastUpdateDate != DateTime.MinValue)
				commandWrapper.AddInParameterForSelect("MinLastUpdatDate", DbType.DateTime, minLastUpdateDate);
			if (maxLastUpdateDate != DateTime.MinValue)
				commandWrapper.AddInParameterForSelect("MaxLastUpdatDate", DbType.DateTime, maxLastUpdateDate);
            commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
		}
	}
}
