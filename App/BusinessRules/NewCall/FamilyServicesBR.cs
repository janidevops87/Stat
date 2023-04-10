using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.NewCall
{
	public class FamilyServicesBR : BaseBR
	{
		public FamilyServicesBR()
		{
			AssociatedDataSet = new FamilyServicesDS();
		}

		public int CallId
		{
			get { return callId; }
			set 
			{
				callId = value;
				AssociatedDA = new FamilyServicesDA(value);
			}
		}

		private int callId;

		protected override void BusinessRulesAfterSelect()
		{
			FamilyServicesDS familyServicesDS = (FamilyServicesDS)AssociatedDataSet;
			if ((callId != int.MinValue) && familyServicesDS.FsbCaseStatus.Count == 0)
			{
				FamilyServicesDS.FsbCaseStatusRow fsbCaseStatusRow = familyServicesDS.FsbCaseStatus.NewFsbCaseStatusRow();
				fsbCaseStatusRow.CallId = callId;
				fsbCaseStatusRow.LastStatEmployeeId = StattracIdentity.Identity.UserId;
				fsbCaseStatusRow.LastModified = GeneralConstant.CreateInstance().CurrentDateTime.AddMilliseconds(-10);
				fsbCaseStatusRow.ListFsbStatusId = (int)ListFamilyServiceStatus.SecondaryPending;
				familyServicesDS.FsbCaseStatus.AddFsbCaseStatusRow(fsbCaseStatusRow);
			}
		}
	}
}
