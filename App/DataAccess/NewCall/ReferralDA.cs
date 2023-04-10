using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using System.Data;

namespace Statline.Stattrac.DataAccess.NewCall
{
    public enum ReferralDASprocs
    {
            ReferralInsert ,
            ReferralUpdate ,
            ReferralDelete ,
            ReferralSelect ,
            ReferralSelectDataSet


    }
    public class ReferralDA : BaseDA
    {
        public ReferralDA()
            : base(ReferralDASprocs.ReferralSelectDataSet.ToString())
		{
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("Referral", "ReferralInsert", "ReferralUpdate", "ReferralDelete"));

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

            switch ((ReferralDASprocs)Enum.Parse(typeof(ReferralDASprocs), SpSelect, true))
            {
                case ReferralDASprocs.ReferralSelectDataSet:

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

            SpSelect = ReferralDASprocs.ReferralSelectDataSet.ToString();
            SetTablesSelect(
                "Call",
                "Referral"
                );
        }
        public void SelectReferral()
        {
            IsMultipleRecords = true;
            SetDefaultTableSelect();
        }
    }
}
