using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.DataAccess.NewCall;

namespace Statline.Stattrac.BusinessRules.NewCall
{
	public class TcssHeaderBR : BaseBR
	{
		public TcssHeaderBR()
		{
			AssociatedDA = new TcssHeaderDA();
			AssociatedDataSet = new TcssHeaderDS();
		}

		public int RecipientId
		{
			get { return ((TcssHeaderDA)AssociatedDA).RecipientId; }
			set { ((TcssHeaderDA)AssociatedDA).RecipientId = value; }
		}
	}
}
