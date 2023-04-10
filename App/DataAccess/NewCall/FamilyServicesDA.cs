using System;
using System.Collections.Generic;
using Statline.Stattrac.Framework;
using System.Data;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.DataAccess.Dashboard
{
	public class FamilyServicesDA : BaseDA
	{
		private int callId;

		public FamilyServicesDA(int callId)
			: base("FamilyServicesSelectDataSet")
		{
			SetTablesSelect("FsbCase", "FsbCaseStatus");
			ListTableSave.Add(new TableSave("FsbCaseStatus", "FsbCaseStatusInsert", "FsbCaseStatusUpdate", "FsbCaseStatusDelete"));
			this.callId = callId;
		}

		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
			commandWrapper.AddInParameterForSelect("@StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
			commandWrapper.AddInParameterForSelect("@CallId", DbType.Int32, callId);
		}

		protected override void AddParameterForInsert(DataTable table, BaseCommand commandWrapper)
		{
			base.AddParameterForInsert(table, commandWrapper);
			commandWrapper.SetParameterToOutput("FsbCaseStatusId");
		}
	}
}
