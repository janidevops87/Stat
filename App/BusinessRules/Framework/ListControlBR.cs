using System.Data;
using System.Collections;
using Statline.Stattrac.Framework;
using Statline.Stattrac.DataAccess.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.BusinessRules.Framework
{
	/// <summary>
	/// Summary description for ListControlBR.
	/// </summary>
	public class ListControlBR : BaseBR
	{
		#region Constructor
		public ListControlBR(string sprocName)
		{
			AssociatedDataSet = new ListControlDS();
			AssociatedDA = new ListControlDA(sprocName);
		}
        /// <summary>
        /// Takes a paramList of storedProcedure parameters. 
        /// Parameters are passed as strings to the stored procedure 
        /// </summary>
        /// <param name="sprocName"></param>
        /// <param name="paramList"></param>
        public ListControlBR(string sprocName, Hashtable paramList)
        {
            AssociatedDataSet = new ListControlDS();
            AssociatedDA = new ListControlDA(sprocName, paramList);

        }
		public ListControlBR(string sprocName, int listId, string fieldValue, string unosValue)
		{
			AssociatedDataSet = new ListControlDS();
			AssociatedDA = new ListControlDA(sprocName, listId, fieldValue, unosValue);
		}

		public DataSet SelectOrganizationBySourceCode(int sourceCodeId)
		{
			((ListControlDA)AssociatedDA).SourceCodeId = sourceCodeId;
			return SelectDataSet();
		}

		public DataSet SelectClinicalCoordinatorByReferralFacility(int organizationId)
		{
			((ListControlDA)AssociatedDA).OrganizationId = organizationId;
			return SelectDataSet();
		}

		public DataSet SelectTransplantSurgeonContactByOrganization(int sourceCodeId, int organizationId)
		{
			((ListControlDA)AssociatedDA).SourceCodeId = sourceCodeId;
			((ListControlDA)AssociatedDA).OrganizationId = organizationId;
			return SelectDataSet();
		}
		#endregion
	}
    public static class DataSetConversion
    {
        public static ListControlDS ListControlDS(this DataSet dataset)
        {
            try
            {
                return (ListControlDS)dataset;
            }
            catch
            {
                return null;
            }
        }
    }
}