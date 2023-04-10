using System;
using System.Data;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Dashboard
{
	public class TcssActiveCasesDA : BaseDA
	{
		#region Private Field
		private bool isDisplayClosed;
		private string callId;
		private DateTime minLastUpdateDate;
		private DateTime maxLastUpdateDate;
		private string client;
		private string importOfferNumber;
		private string referralNumber;
		private string organType;
		private string optnNumber;
		private string matchId;
		private string transplantSurgeonContact;
		private string clinicalCoordinator;
		private string coordinatorFirstName;
		private string coordinatorLastName;
		private string mostRecentStatus;
		private string mostRecentComment;
		#endregion

		#region Constructor
		public TcssActiveCasesDA()
			: base("TcssActiveCasesSelect")
		{
			SetTablesSelect("TcssActiveCases");
		}
		#endregion

		#region Public Properties
		public bool IsDisplayClosed
		{
			get { return isDisplayClosed; }
			set { isDisplayClosed = value; }
		}
		public string CallId
		{
			get { return callId; }
			set { callId = value; }
		}
		public DateTime MinLastUpdateDate
		{
			get { return minLastUpdateDate; }
			set { minLastUpdateDate = value; }
		}
		public DateTime MaxLastUpdateDate
		{
			get { return maxLastUpdateDate; }
			set { maxLastUpdateDate = value; }
		}
		public string Client
		{
			get { return client; }
			set { client = value; }
		}
		public string ImportOfferNumber
		{
			get { return importOfferNumber; }
			set { importOfferNumber = value; }
		}
		public string ReferralNumber
		{
			get { return referralNumber; }
			set { referralNumber = value; }
		}
		public string OrganType
		{
			get { return organType; }
			set { organType = value; }
		}
		public string OptnNumber
		{
			get { return optnNumber; }
			set { optnNumber = value; }
		}
		public string MatchId
		{
			get { return matchId; }
			set { matchId = value; }
		}
		public string TransplantSurgeonContact
		{
			get { return transplantSurgeonContact; }
			set { transplantSurgeonContact = value; }
		}
		public string ClinicalCoordinator
		{
			get { return clinicalCoordinator; }
			set { clinicalCoordinator = value; }
		}
		public string CoordinatorFirstName
		{
			get { return coordinatorFirstName; }
			set { coordinatorFirstName = value; }
		}
		public string CoordinatorLastName
		{
			get { return coordinatorLastName; }
			set { coordinatorLastName = value; }
		}
		public string MostRecentStatus
		{
			get { return mostRecentStatus; }
			set { mostRecentStatus = value; }
		}
		public string MostRecentComment
		{
			get { return mostRecentComment; }
			set { mostRecentComment = value; }
		}
		#endregion

		#region Methods
		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
			commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
			if (!string.IsNullOrEmpty(callId))
				commandWrapper.AddInParameterForSelect("CallId", DbType.String, callId);
			if (minLastUpdateDate != DateTime.MinValue)
				commandWrapper.AddInParameterForSelect("MinLastUpdatDate", DbType.DateTime, minLastUpdateDate);
			if (maxLastUpdateDate != DateTime.MinValue)
				commandWrapper.AddInParameterForSelect("MaxLastUpdatDate", DbType.DateTime, maxLastUpdateDate);
			if (!string.IsNullOrEmpty(client))
				commandWrapper.AddInParameterForSelect("Client", DbType.String, client);
			if (!string.IsNullOrEmpty(importOfferNumber))
				commandWrapper.AddInParameterForSelect("ImportOfferNumber", DbType.String, importOfferNumber);
			if (!string.IsNullOrEmpty(referralNumber))
				commandWrapper.AddInParameterForSelect("ReferralNumber", DbType.String, referralNumber);
			if (!string.IsNullOrEmpty(organType))
				commandWrapper.AddInParameterForSelect("OrganType", DbType.String, organType);
			if (!string.IsNullOrEmpty(optnNumber))
				commandWrapper.AddInParameterForSelect("OptnNumber", DbType.String, optnNumber);
			if (!string.IsNullOrEmpty(matchId))
				commandWrapper.AddInParameterForSelect("MatchId", DbType.String, matchId);
			if (!string.IsNullOrEmpty(transplantSurgeonContact))
				commandWrapper.AddInParameterForSelect("TransplantSurgeonContact", DbType.String, transplantSurgeonContact);
			if (!string.IsNullOrEmpty(clinicalCoordinator))
				commandWrapper.AddInParameterForSelect("ClinicalCoordinator", DbType.String, clinicalCoordinator);
			if (!string.IsNullOrEmpty(coordinatorFirstName))
				commandWrapper.AddInParameterForSelect("CoordinatorFirstName", DbType.String, coordinatorFirstName);
			if (!string.IsNullOrEmpty(coordinatorLastName))
				commandWrapper.AddInParameterForSelect("CoordinatorLastName", DbType.String, coordinatorLastName);
			if (!string.IsNullOrEmpty(mostRecentStatus))
				commandWrapper.AddInParameterForSelect("MostRecentStatus", DbType.String, mostRecentStatus);
			if (!string.IsNullOrEmpty(mostRecentComment))
				commandWrapper.AddInParameterForSelect("MostRecentComment", DbType.String, mostRecentComment);
			if (isDisplayClosed)
				commandWrapper.AddInParameterForSelect("IsDisplayClosed", DbType.Boolean, isDisplayClosed);
            commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
		}
		#endregion
	}
}
