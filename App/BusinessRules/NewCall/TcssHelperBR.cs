using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.DataAccess.NewCall;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.NewCall
{
	public class TcssHelperBR : BaseBR
	{
		#region Constructor
		public TcssHelperBR(){}
		#endregion

		public TcssHelperDS SelectDoesCallExist(int callId, int callTypeID)
		{
			AssociatedDataSet = new TcssHelperDS();
			AssociatedDA = new TcssHelperDA(callId,callTypeID);
			return (TcssHelperDS)Select();
		}
	}
}
