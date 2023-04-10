using System.Data;
using Statline.Stattrac.DataAccess.Framework;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.BusinessRules.Framework
{
	public class StatEmployeeBR : BaseBR
	{
        GeneralConstant generalConstant;
		public StatEmployeeBR(string statEmployeeUserId)
		{
			AssociatedDA = new StatEmployeeDA(statEmployeeUserId);
			AssociatedDataSet = new StatEmployeeDS();
            generalConstant = GeneralConstant.CreateInstance();
		}
        protected void ExecuteNonQuery()
        {
            base.ExecuteNonQuery();
            ((StatEmployeeDA)AssociatedDA).SetTableSelectDefault();
            
        }

        public void AutoDisplaySourceCodeSet()
        {
            ((StatEmployeeDA)AssociatedDA).AutoDisplaySourceCodeSet();
            ExecuteNonQuery();
            generalConstant.AutoDisplaySourceCode = ((StatEmployeeDA)AssociatedDA).SourceCode;
            generalConstant.AutoDisplayCallTypeID = ((StatEmployeeDA)AssociatedDA).SourceCodeDefaultCallTypeID;

            
        }
    }
}
