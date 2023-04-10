using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using System.Data;
using Statline.Stattrac.Constant;
using System.Threading;

namespace Statline.Stattrac.DataAccess.Organization
{
    public enum OrganizationAssociatedCallDASprocs
    {
            ReferralSelect ,
            ReferralInsert ,
            ReferralUpdate ,
            ReferralDelete ,
            OrganizationPhoneSelect ,
            MessageSelect ,
            MessageInsert ,
            MessageUpdate ,
            MessageDelete ,
            AssociatedCallSelect

    }
    public class OrganizationAssociatedCallDA : BaseDA
    {
        public OrganizationAssociatedCallDA()
            : base(OrganizationAssociatedCallDASprocs.AssociatedCallSelect.ToString())
		{
           
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("Referral", "ReferralInsert", "ReferralUpdate", "ReferralDelete"));
            ListTableSave.Add(new TableSave("Message", "MessageInsert", "MessageUpdate", "MessageDelete"));
            stattracIdentity = (StattracIdentity)Thread.CurrentPrincipal.Identity;
        }
        #region private fields
        private StattracIdentity stattracIdentity;        
        private Int32 _callID;
        private Int32 _organizationID;
        private Int32 _phoneID;        

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
        public Int32 PhoneID
        {
            get { return _phoneID; }
            set { _phoneID = value; }
        }

        #endregion
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((OrganizationAssociatedCallDASprocs)Enum.Parse(typeof(OrganizationAssociatedCallDASprocs), SpSelect, true))
            {
                case OrganizationAssociatedCallDASprocs.ReferralSelect:

                    commandWrapper.AddInParameterForSelect("CallID", DbType.Int32, CallID);
                    break;
                case OrganizationAssociatedCallDASprocs.MessageSelect:
                    commandWrapper.AddInParameterForSelect("CallID", DbType.Int32, CallID);
                    break;
                case OrganizationAssociatedCallDASprocs.AssociatedCallSelect:
                    if(OrganizationID > 0)
                        commandWrapper.AddInParameterForSelect("OrganizationID", DbType.Int32, OrganizationID);
                    if(PhoneID > 0)
                        commandWrapper.AddInParameterForSelect("PhoneID", DbType.Int32, PhoneID);
                    commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, stattracIdentity.UserOrganizationId);
                    commandWrapper.AddInParameterForSelect("DBInstance", DbType.String, GeneralConstant.CreateInstance().CurrentDB);
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

            SpSelect =  OrganizationAssociatedCallDASprocs.AssociatedCallSelect.ToString();
            SetTablesSelect(
                "AssociatedCall"
                );
        }
        public void SelectAssociatedCall()
        {
            SetDefaultTableSelect();
            
        }
        public void SelectReferral()
        {
            SpSelect =  OrganizationAssociatedCallDASprocs.ReferralSelect.ToString();

            SetTablesSelect("Referral");

        }

        public void SelectMessage()
        {
            SpSelect = OrganizationAssociatedCallDASprocs.MessageSelect.ToString();

            SetTablesSelect("Message");

        }

        public void SelectOrganizationPhone()
        {
            SpSelect = OrganizationAssociatedCallDASprocs.OrganizationPhoneSelect.ToString();

            SetTablesSelect("OrganizationPhone");

        }


    }
}
