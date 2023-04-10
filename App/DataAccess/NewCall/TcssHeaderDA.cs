using System;
using System.Collections.Generic;
using Statline.Stattrac.Framework;
using System.Data;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.DataAccess.NewCall
{
	public class TcssHeaderDA : BaseDA
	{
		#region Private Fields
		private int recipientId;
		#endregion

		#region Constructor
		public TcssHeaderDA()
			: base("TcssHeaderSelect")
		{
			SetTablesSelect("TcssHeader");
		}
		#endregion

		public int RecipientId
		{
			get { return recipientId; }
			set { recipientId = value; }
		}

		#region Overridden Methods
		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
			commandWrapper.AddInParameterForSelect("@TcssRecipientId", DbType.Int32, recipientId);
		}
		#endregion
	}
}
