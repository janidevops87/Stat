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
    public class MessageBR : BaseBR
    {
        #region fields
        public Int32 OrganizationID
        {
            get { return ((MessageDA)AssociatedDA).OrganizationID; }
            set { ((MessageDA)AssociatedDA).OrganizationID = value; }
        }
        /// <summary>
        /// Set this when organizationID or organization Information is changed acrossed multiple records.
        /// </summary>
        public Boolean IsOrganizationReassignment
        {
            get { return ((MessageDA)AssociatedDA).IsMultipleRecords; }
            set { ((MessageDA)AssociatedDA).IsMultipleRecords = value; }
        }

        #endregion
        #region Constructor
        public MessageBR()
		{            
            AssociatedDataSet = new MessageDS();            
            AssociatedDA = new MessageDA();
         }
        #endregion
        #region overridden Methods
        protected override void BusinessRulesBeforeSave()
        {
            //the method ReassignCall is allowing the UI to make calls for each selected row. 
            //after each selection a new record is added to a table causing currently modified tables to change from modified to unchanged.
            // set all rows to modified
            if(IsOrganizationReassignment)
            {
            ((MessageDS)AssociatedDataSet).Message.ToList().ForEach(messageRow => 
            {
                if (messageRow.RowState == DataRowState.Unchanged)
                    messageRow.SetModified();
            }
                );
            }

        }
        #endregion
        protected void Select()
        {
            base.Select();
            ((MessageDA)AssociatedDA).SetDefaultTableSelect();
        }

        public void SelectMessage(int callID)
        {
            ((MessageDA)AssociatedDA).CallID = callID;
            ((MessageDA)AssociatedDA).SelectMessage();
            Select();

        }

        public void ReassignCall(MessageDS.MessageRow deleteRow, int orginalOrganizationID,  int newOrganizationID)
        {
            int nextIndex = -1;
            //determine what calltype
                    nextIndex = NextIndex(((MessageDS)AssociatedDataSet).Message);
                    SelectMessage(deleteRow.CallID);
                    if (((MessageDS)AssociatedDataSet).Message[nextIndex].OrganizationID == orginalOrganizationID)
                        ((MessageDS)AssociatedDataSet).Message[nextIndex].OrganizationID = newOrganizationID;
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
        /// <summary>
        /// locates a record, loads it if it does not exist and reassigns the field.
        /// </summary>
        /// <param name="fieldID"></param>
        /// <param name="fieldName"></param>
        /// <param name="organizationColumn"></param>
        /// <param name="orginalID"></param>
        /// <param name="newID"></param>
        public void ReassignField(int fieldID, DataColumn fieldName,  DataColumn reassignColumn, object orginalValue, Object newValue)
        {
            //check table for record 
            DataRow[] row;
            string query = string.Format("{0} = {1}", fieldName.ColumnName, fieldID);
            row = ((MessageDS)AssociatedDataSet).Tables[fieldName.Table.TableName].Select(query);
             if(row.Count() == 0)
                 //load the record
                  switch(fieldName.Table.TableName)
                  {
                      case "Message":
                          SelectMessage(fieldID);
                          break;
                  }
             //table has the record
             row = ((MessageDS)AssociatedDataSet).Tables[reassignColumn.Table.TableName].Select(query);
             if (row.Count() == 0)
                 return;

             if (row[GeneralConstant.CreateInstance().FirstRow][reassignColumn.ColumnName].Equals(orginalValue))
                 row[GeneralConstant.CreateInstance().FirstRow][reassignColumn.ColumnName] = newValue;
            

        }
    }
}
