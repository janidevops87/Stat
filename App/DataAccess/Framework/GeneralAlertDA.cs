using System;
using System.Collections.Generic;
using Statline.Stattrac.Framework;
using System.Collections.ObjectModel;

namespace Statline.Stattrac.DataAccess.Framework
{
	public class GeneralAlertDA : BaseDA
	{
		public GeneralAlertDA()
			: base("GeneralAlertSelect")
		{
			SetTablesSelect("GeneralAlert");
		}
	}
}
