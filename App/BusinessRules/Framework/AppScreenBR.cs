using System;
using Statline.Stattrac.Framework;
using Statline.Stattrac.DataAccess.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Framework;


namespace Statline.Stattrac.BusinessRules.Framework
{
	public class AppScreenBR : BaseBR
	{
		public AppScreenBR()
		{
			AssociatedDA = new AppScreenDA();
			AssociatedDataSet = new AppScreenDS();
		}
	}
}
