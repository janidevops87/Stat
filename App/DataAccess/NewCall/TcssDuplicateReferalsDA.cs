using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.DataAccess.NewCall
{
	public class TcssDuplicateReferalsDA : BaseDA
	{
		#region Private Field
		private int currentCallId;
		private int sourceCodeId;
		private int tcssListOrganTypeId;
		private string matchId;
		private string optnNumber;
		#endregion

		#region Constructor
		public TcssDuplicateReferalsDA()
			: base("TcssDuplicateReferalsSelect")
		{
			SetTablesSelect("TcssDuplicateReferals");
		}
		#endregion

		#region Public Properties
		public int CurrentCallId
		{
			get { return currentCallId; }
			set { currentCallId = value; }
		}
		public int SourceCodeId
		{
			get { return sourceCodeId; }
			set { sourceCodeId = value; }
		}
		public int TcssListOrganTypeId
		{
			get { return tcssListOrganTypeId; }
			set { tcssListOrganTypeId = value; }
		}
		public string MatchId
		{
			get { return matchId; }
			set { matchId = value; }
		}
		public string OptnNumber
		{
			get { return optnNumber; }
			set { optnNumber = value; }
		}
		#endregion

		#region Methods
		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
			commandWrapper.AddInParameterForSelect("CurrentCallId", DbType.Int32, currentCallId);
			commandWrapper.AddInParameterForSelect("SourceCodeId", DbType.Int32, sourceCodeId);
			commandWrapper.AddInParameterForSelect("TcssListOrganTypeId", DbType.Int32, tcssListOrganTypeId);
			commandWrapper.AddInParameterForSelect("MatchId", DbType.String, matchId);
			commandWrapper.AddInParameterForSelect("OptnNumber", DbType.String, optnNumber);
            commandWrapper.AddInParameterForSelect("@OrgID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
		}
		#endregion
	}
}
