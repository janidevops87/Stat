using System.Collections;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Framework
{
	public class ListControlDA : BaseDA
	{
		#region Private Fields
		private string sprocName;
        private Hashtable paramList;
		private int listId;
		private string fieldValue;
		private string unosValue;
		private int sourceCodeId;
		private int organizationId; 
		#endregion


		#region Private Fields
		public int SourceCodeId
		{
			get { return sourceCodeId; }
			set { sourceCodeId = value; }
		}
		public int OrganizationId
		{
			get { return organizationId; }
			set { organizationId = value; }
		}
		#endregion


		#region Constructor
		public ListControlDA(string sprocName)
			: base(sprocName)
		{
			SetTablesSelect("ListControl");
			this.sprocName = sprocName;
			this.listId = int.MinValue;
		}
        /// <summary>
        /// Takes a paramList of storedProcedure parameters. 
        /// Parameters are passed on strings to the stored procedure 
        /// </summary>
        /// <param name="sprocName"></param>
        /// <param name="paramList"></param>
        public ListControlDA(string sprocName, Hashtable paramList)
            : base(sprocName)
        {
            SetTablesSelect("ListControl");
            this.sprocName = sprocName;
            this.paramList = paramList;
        }
		public ListControlDA(string sprocName, int listId, string fieldValue, string unosValue)
			: base(sprocName)
		{
			SetTablesSelect("ListControl");
			this.sprocName = sprocName;
			this.listId = listId;
			this.fieldValue = fieldValue;
			this.unosValue = unosValue;
		} 
		#endregion

		#region Protected Methods
		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
            GeneralConstant generalConstants = GeneralConstant.CreateInstance();

            //loops through the has table paramList and adds string values to parameters
            //7/13/2010 bret I moved this up to the top and added a return
            //The thought is a sproc will either be paramterized using the paramList or the switch statment.
            //If this breaks other code we will need to move it to the bottom and any sproc that does not have a parameter will need to add its name with a break. 
            //
            if (paramList != null)
            {
                foreach (DictionaryEntry de in paramList)
                {
                    commandWrapper.AddInParameterForSelect(de.Key.ToString(), System.Data.DbType.String, de.Value);
                }
                return;
            }

		    switch (sprocName)
			{
				case "LookupListStatEmployee":
				case "LookupListPerson":
				case "AdministrationGroupListSelect":
				case "SourceCodeListSelect":
					commandWrapper.AddInParameterForSelect("StatEmployeeUserId", System.Data.DbType.Int32, StattracIdentity.Identity.UserId);
					break;
                case "SourceCodeByOrganizationIdListSelect":
                    commandWrapper.AddInParameterForSelect("StatEmployeeUserId", System.Data.DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("OrganizationId", System.Data.DbType.Int32, generalConstants.OrganizationId);
                    break;				
                case "OrganizationBySourceCodeSelect":
					commandWrapper.AddInParameterForSelect("SourceCodeId", System.Data.DbType.Int32, sourceCodeId);
					break;
				case "ClinicalCoordinatorByReferralFacilitySelect":
					commandWrapper.AddInParameterForSelect("OrganizationId", System.Data.DbType.Int32, organizationId);
					break;
				case "TransplantSurgeonContactByOrganizationSelect":
					commandWrapper.AddInParameterForSelect("SourceCodeId", System.Data.DbType.Int32, sourceCodeId);
					commandWrapper.AddInParameterForSelect("OrganizationId", System.Data.DbType.Int32, organizationId);
					break;
				case "TcssListLabSelect":
					SetTablesSelect("TcssListLab");
					if (listId != int.MinValue)
					{
						commandWrapper.AddInParameterForSelect("ListId", System.Data.DbType.Int32, listId);
					}
					if (!string.IsNullOrEmpty(fieldValue))
					{
						commandWrapper.AddInParameterForSelect("FieldValue", System.Data.DbType.String, fieldValue);
					}
					if (!string.IsNullOrEmpty(unosValue))
					{
						commandWrapper.AddInParameterForSelect("UnosValue", System.Data.DbType.String, unosValue);
					}
					break;
				case "TcssListVitalSignSelect":
					SetTablesSelect("TcssListVitalSign");
					if (listId != int.MinValue)
					{
						commandWrapper.AddInParameterForSelect("ListId", System.Data.DbType.Int32, listId);
					}
					if (!string.IsNullOrEmpty(fieldValue))
					{
						commandWrapper.AddInParameterForSelect("FieldValue", System.Data.DbType.String, fieldValue);
					}
					if (!string.IsNullOrEmpty(unosValue))
					{
						commandWrapper.AddInParameterForSelect("UnosValue", System.Data.DbType.String, unosValue);
					}
					break;
				default:
					if (listId != int.MinValue)
					{
						commandWrapper.AddInParameterForSelect("ListId", System.Data.DbType.Int32, listId);
					}
					if (!string.IsNullOrEmpty(fieldValue))
					{
						commandWrapper.AddInParameterForSelect("FieldValue", System.Data.DbType.String, fieldValue);
					}
					if (!string.IsNullOrEmpty(unosValue))
					{
						commandWrapper.AddInParameterForSelect("UnosValue", System.Data.DbType.String, unosValue);
					}
					break;
			}

		}
		#endregion
	}
}
