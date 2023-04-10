using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
	public class TcssActiveCasesBR : BaseBR
	{
		public TcssActiveCasesBR()
		{
			AssociatedDA = new TcssActiveCasesDA();
			AssociatedDataSet = new TcssActiveCasesDS();
		}

		#region Public Properties
		public bool IsDisplayClosed
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).IsDisplayClosed; }
			set { ((TcssActiveCasesDA)AssociatedDA).IsDisplayClosed = value; }
		}
		public string CallId
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).CallId; }
			set { ((TcssActiveCasesDA)AssociatedDA).CallId = value; }
		}
		public DateTime MinLastUpdateDate
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).MinLastUpdateDate; }
			set { ((TcssActiveCasesDA)AssociatedDA).MinLastUpdateDate = value; }
		}
		public DateTime MaxLastUpdateDate
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).MaxLastUpdateDate; }
			set { ((TcssActiveCasesDA)AssociatedDA).MaxLastUpdateDate = value; }
		}
		public string Client
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).Client; }
			set { ((TcssActiveCasesDA)AssociatedDA).Client = value; }
		}
		public string ImportOfferNumber
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).ImportOfferNumber; }
			set { ((TcssActiveCasesDA)AssociatedDA).ImportOfferNumber = value; }
		}
		public string ReferralNumber
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).ReferralNumber; }
			set { ((TcssActiveCasesDA)AssociatedDA).ReferralNumber = value; }
		}
		public string OrganType
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).OrganType; }
			set { ((TcssActiveCasesDA)AssociatedDA).OrganType = value; }
		}
		public string OptnNumber
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).OptnNumber; }
			set { ((TcssActiveCasesDA)AssociatedDA).OptnNumber = value; }
		}
		public string MatchId
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).MatchId; }
			set { ((TcssActiveCasesDA)AssociatedDA).MatchId = value; }
		}
		public string TransplantSurgeonContact
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).TransplantSurgeonContact; }
			set { ((TcssActiveCasesDA)AssociatedDA).TransplantSurgeonContact = value; }
		}
		public string ClinicalCoordinator
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).ClinicalCoordinator; }
			set { ((TcssActiveCasesDA)AssociatedDA).ClinicalCoordinator = value; }
		}
		public string CoordinatorFirstName
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).CoordinatorFirstName; }
			set { ((TcssActiveCasesDA)AssociatedDA).CoordinatorFirstName = value; }
		}
		public string CoordinatorLastName
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).CoordinatorLastName; }
			set { ((TcssActiveCasesDA)AssociatedDA).CoordinatorLastName = value; }
		}
		public string MostRecentStatus
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).MostRecentStatus; }
			set { ((TcssActiveCasesDA)AssociatedDA).MostRecentStatus = value; }
		}
		public string MostRecentComment
		{
			get { return ((TcssActiveCasesDA)AssociatedDA).MostRecentComment; }
			set { ((TcssActiveCasesDA)AssociatedDA).MostRecentComment = value; }
		}
		#endregion

	}
}
