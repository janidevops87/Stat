using System;
using Statline.Stattrac.DataAccess.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.BusinessRules.Framework
{
	public class GeneralAlertBR : BaseBR
	{
		public GeneralAlertBR()
		{
			AssociatedDA = new GeneralAlertDA();
			AssociatedDataSet = new GeneralAlertDS();
		}
	}
}
