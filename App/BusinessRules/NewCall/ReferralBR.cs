using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.NewCall;
using System.Data;
using Statline.Stattrac.DataAccess.NewCall;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.BusinessRules.NewCall
{
    public class ReferralBR : BaseBR
    {
        #region fields
        public Int32 OrganizationID
        {
            get { return ((ReferralDA)AssociatedDA).OrganizationID; }
            set { ((ReferralDA)AssociatedDA).OrganizationID = value; }
        }
        /// <summary>
        /// Set this when organizationID or organization Information is changed acrossed multiple records.
        /// </summary>
        public Boolean IsOrganizationReassignment
        {
            get { return ((ReferralDA)AssociatedDA).IsMultipleRecords; }
            set { ((ReferralDA)AssociatedDA).IsMultipleRecords = value; }
        }
        #endregion
        #region Constructor

        public ReferralBR()
		{            
            AssociatedDataSet = new ReferralDS();            
            AssociatedDA = new ReferralDA();
         }
        #endregion
        #region overridden Methods
        protected override void BusinessRulesBeforeSave()
        {
            //the method ReassignCall is allowing the UI to make calls for each selected row. 
            //after each selection a new record is added to a table causing currently modified tables to change from modified to unchanged.
            // set all rows to modified
            if (IsOrganizationReassignment)
            {

                ((ReferralDS)AssociatedDataSet).Referral.ToList().ForEach(referralRow =>
                    {
                        if (referralRow.RowState == DataRowState.Unchanged)
                            referralRow.SetModified();
                    });
            }

        }
        #endregion
        #region protected methods
        protected void Select()
        {
            base.Select();
            ((ReferralDA)AssociatedDA).SetDefaultTableSelect();
        }
        #endregion
        #region public methods
        public void SelectReferral(int callID)
        {
            ((ReferralDA)AssociatedDA).CallID = callID;
            ((ReferralDA)AssociatedDA).SelectReferral();
            Select();

        }

        public void ReassignCall(ReferralDS.ReferralRow deleteRow, int orginalOrganizationID,  int newOrganizationID)
        {            
            int nextIndex = -1;
            //determine what calltype
                    nextIndex = NextIndex(((ReferralDS)AssociatedDataSet).Referral);
                    SelectReferral(deleteRow.CallID);
                    //change the value of organization IDS if they equal the original value
                    if (((ReferralDS)AssociatedDataSet).Referral[nextIndex].ReferralCallerOrganizationID == orginalOrganizationID)
                    ((ReferralDS)AssociatedDataSet).Referral[nextIndex].ReferralCallerOrganizationID = newOrganizationID;
                    if(((ReferralDS)AssociatedDataSet).Referral[nextIndex].ReferralCoronerOrgID == orginalOrganizationID)
                        ((ReferralDS)AssociatedDataSet).Referral[nextIndex].ReferralCoronerOrgID = newOrganizationID;

        }
        /// <summary>
        /// simple method determines the index for a given record. The idea is as records are added to the table the index will increase.
        /// </summary>
        /// <param name="dataTable"></param>
        /// <returns></returns>
        private Int32 NextIndex(DataTable dataTable )        
        {
            int index = 0;
            int rowCount = dataTable.Rows.Count;

            if (rowCount > 0)
                index = rowCount;

            return index;

        }
        #endregion

        public void ReassignField(int fieldID, DataColumn fieldName, DataColumn reassignColumn, Object orginalID, Object newID)
        {
            //check table for record 
            DataRow[] row;
            string query = string.Format("{0} = {1}", fieldName.ColumnName, fieldID);
            row = ((ReferralDS)AssociatedDataSet).Tables[fieldName.Table.TableName].Select(query);
            if (row.Count() == 0)
                //load the record
                switch (fieldName.Table.TableName)
                {
                    case "Referral":
                        SelectReferral(fieldID);
                        break;
                }
            //table has the record
            row = ((ReferralDS)AssociatedDataSet).Tables[reassignColumn.Table.TableName].Select(query);
            if (row.Count() == 0)
                return;
            if (row[GeneralConstant.CreateInstance().FirstRow][reassignColumn.ColumnName].Equals(orginalID))            
                row[GeneralConstant.CreateInstance().FirstRow][reassignColumn.ColumnName] = newID;


        }
    }
}