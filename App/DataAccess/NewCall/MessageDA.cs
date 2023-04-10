using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using System.Data;

namespace Statline.Stattrac.DataAccess.NewCall
{
    public enum MessageDASprocs
    {
            MessageInsert ,
            MessageUpdate ,
            MessageDelete ,
            MessageSelect ,
            MessageSelectDataSet

    }
    public class MessageDA : BaseDA
    {
        public MessageDA()
            : base(MessageDASprocs.MessageSelectDataSet.ToString() )
        {
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("Call", "CallInsert", "CallUpdate", "CallDelete"));
            ListTableSave.Add(new TableSave("Message", "MessageInsert", "MessageUpdate", "MessageDelete"));

        }
        #region private fields
        private Int32 _callID;
        private Int32 _organizationID;
        private Boolean _isMultipleRecords;


        #endregion
        #region class fields
        public Int32 CallID
        {
            get { return _callID; }
            set { _callID = value; }
        }
        public Int32 OrganizationID
        {
            get { return _organizationID; }
            set { _organizationID = value; }
        }
        public Boolean IsMultipleRecords
        {
            get { return _isMultipleRecords; }
            set { _isMultipleRecords = value; }
        }


        #endregion
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((MessageDASprocs)Enum.Parse(typeof(MessageDASprocs), SpSelect, true))
            {
                case MessageDASprocs.MessageSelectDataSet:
                    commandWrapper.AddInParameterForSelect("CallID", DbType.Int32, CallID);
                    break;

                default:
                    break;
            }
        }
        protected override void GetParameterValuesPostExecuteNonQuery(System.Data.Common.DbParameterCollection dbParameters)
        {


        }
        #endregion
        public void SetDefaultTableSelect()
        {

            SpSelect = MessageDASprocs.MessageSelectDataSet.ToString();
            SetTablesSelect(
                "Call",
                "Message"
                );
        }

        public void SelectMessage()
        {
            IsMultipleRecords = true;
            SetDefaultTableSelect();
        }   
    }
}
