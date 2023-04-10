using Statline.Stattrac.Framework;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.DataAccess.Framework
{

    public enum StatEmployeeDASprocs
    {
        StatEmployeeSelectDataSet,
        AutoDisplaySourceCodeGet
    }
	public class StatEmployeeDA : BaseDA
	{
        private string statEmployeeUserId;
        public string SourceCode { get; set; }
        public int SourceCodeDefaultCallTypeID { get; set; }

        public StatEmployeeDA(string statEmployeeUserId)
			: base(StatEmployeeDASprocs.StatEmployeeSelectDataSet.ToString())
		{
            SetTableSelectDefault();
            this.statEmployeeUserId = statEmployeeUserId;
		}

        public void SetTableSelectDefault()
        {
            SpSelect = StatEmployeeDASprocs.StatEmployeeSelectDataSet.ToString();
            SetTablesSelect("StatEmployee", "StatEmployeeRole");
        }

		protected override void  AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
             switch ((StatEmployeeDASprocs)Enum.Parse(typeof(StatEmployeeDASprocs), SpSelect, true))
            {
                 case StatEmployeeDASprocs.StatEmployeeSelectDataSet:
                    commandWrapper.AddInParameterForSelect("StatEmployeeUserId", System.Data.DbType.String, statEmployeeUserId);
                     break;
                 case StatEmployeeDASprocs.AutoDisplaySourceCodeGet:
                     commandWrapper.AddInParameterForSelect("organizationId", System.Data.DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
                     commandWrapper.AddInParameterForSelect("sourceCode", System.Data.DbType.String, "           "); //empty string for length
                     commandWrapper.AddInParameterForSelect("sourceCodeDefaultCallTypeID", System.Data.DbType.Int32, 0);
                     commandWrapper.SetParameterToOutput("sourceCode");
                     commandWrapper.SetParameterToOutput("sourceCodeDefaultCallTypeID");
                     break;

                 default:
                     break;
            }
        }
        protected override void GetParameterValuesPostExecuteNonQuery(System.Data.Common.DbParameterCollection dbParameters)
        {
            switch ((StatEmployeeDASprocs)Enum.Parse(typeof(StatEmployeeDASprocs), SpSelect, true))
            {
                case StatEmployeeDASprocs.AutoDisplaySourceCodeGet:
                    SourceCode = dbParameters["@sourceCode"].Value.ToString();
                    SourceCodeDefaultCallTypeID = Convert.ToInt32(dbParameters["@sourceCodeDefaultCallTypeID"].Value);
                    break;
            }


        }
        public void AutoDisplaySourceCodeSet()
        {
            SpSelect = StatEmployeeDASprocs.AutoDisplaySourceCodeGet.ToString();
        }
    }
}
