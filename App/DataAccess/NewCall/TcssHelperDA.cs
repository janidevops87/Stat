using System.Data;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.NewCall
{
	public class TcssHelperDA : BaseDA
	{
		#region Private Fields
		private int callId;
        private int callTypeID;
		#endregion

		#region Constructor
		public TcssHelperDA(int callId, int callTypeID)
			: base("SelectDoesCallExist")
		{
			this.callId = callId;
            this.callTypeID = callTypeID;
			SetTablesSelect("DoesCallExist");
		}
		#endregion

		#region Overridden Methods
		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
			commandWrapper.AddInParameterForSelect("@CallId", DbType.Int32, callId);
            commandWrapper.AddInParameterForSelect("@CallTypeID", DbType.Int32, callTypeID);
		}
		#endregion
	}
}
