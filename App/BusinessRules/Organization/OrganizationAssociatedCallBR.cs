using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.DataAccess.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.BusinessRules.Organization
{
    public class OrganizationAssociatedCallBR : BaseBR
    {
        private GeneralConstant grConstant;
        private ListControlBR organizationList;
        #region fields
        public Int32 OrganizationID
        {
            get { return ((OrganizationAssociatedCallDA)AssociatedDA).OrganizationID ; }
            set { ((OrganizationAssociatedCallDA)AssociatedDA).OrganizationID = value; }
        }

        #endregion
        #region Constructor
        public OrganizationAssociatedCallBR()
		{            
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new OrganizationAssociatedCallDS();            
            AssociatedDA = new OrganizationAssociatedCallDA();
         }
        #endregion
        #region overridden Methods
        protected override void BusinessRulesBeforeSave()
        {
            //the method ReassignCall is allowing the UI to make calls for each selected row. 
            //after each selection a new record is added to a table causing currently modified tables to change from modified to unchanged.
            // set all rows to modified
            ((OrganizationAssociatedCallDS)AssociatedDataSet).Message.ToList().ForEach(messageRow => 
            {
                if (messageRow.RowState == DataRowState.Unchanged)
                    messageRow.SetModified();
            }
                );
            ((OrganizationAssociatedCallDS)AssociatedDataSet).Referral.ToList().ForEach(referralRow => 
                {
                    if (referralRow.RowState == DataRowState.Unchanged)
                        referralRow.SetModified();
                });

        }
        #endregion
        protected void Select()
        {
            base.Select();
            ((OrganizationAssociatedCallDA)AssociatedDA).SetDefaultTableSelect();
        }

        /// <summary>
        /// selects associated Referrals.
        /// Assumes organizationID or phoneID is zero
        /// </summary>
        /// <param name="organizationID"></param>
        /// <param name="phoneID"></param>
        public void SelectAssociatedCall(int organizationID, int phoneID)
        {
            //first select by current database
            ((OrganizationAssociatedCallDA)AssociatedDA).OrganizationID = organizationID;
            ((OrganizationAssociatedCallDA)AssociatedDA).PhoneID = phoneID;
            ((OrganizationAssociatedCallDA)AssociatedDA).SelectAssociatedCall();
            Select();

            //now if the current database is not archive search archive
            if (grConstant.CurrentDB  == Constant.DatabaseInstance.ProductionArchive.ToString())
                return;
            //capture current DB and reset at end
            string _currentDB = grConstant.CurrentDB;
            try
            {
                BaseIdentity.CurrentIdentity.DatabaseInstance = Constant.DatabaseInstance.ProductionArchive.ToString();
                grConstant.CurrentDB = Constant.DatabaseInstance.ProductionArchive.ToString();
                OrganizationAssociatedCallBR tempBr = new OrganizationAssociatedCallBR();
                //the DA is created reset the DB Instance.
                BaseIdentity.CurrentIdentity.DatabaseInstance = _currentDB;
                tempBr.AssociatedDataSet = AssociatedDataSet;                
                tempBr.SelectAssociatedCall(organizationID, phoneID);
            }
            finally
            {
                BaseIdentity.CurrentIdentity.DatabaseInstance = _currentDB;
                grConstant.CurrentDB = _currentDB;
            }

        }

 
        public void SelectOrganizationPhone(int organizationID)
        {
            ((OrganizationAssociatedCallDA)AssociatedDA).OrganizationID = organizationID;
            ((OrganizationAssociatedCallDA)AssociatedDA).SelectOrganizationPhone();
            Select();

        }


       public void SelectMessage(int callID)
        {
            ((OrganizationAssociatedCallDA)AssociatedDA).CallID = callID;
            ((OrganizationAssociatedCallDA)AssociatedDA).SelectMessage();
            Select();

        }
        public void SelectReferral(int callID)
        {
            ((OrganizationAssociatedCallDA)AssociatedDA).CallID = callID;
            ((OrganizationAssociatedCallDA)AssociatedDA).SelectReferral();
            Select();

        }
        public void ReassignCall(List<OrganizationAssociatedCallDS.AssociatedCallRow> rows, int originalOrganizationID, int newOrganizationID, int originalPhoneID, int newPhoneID)
        {
            string _currentDB = grConstant.CurrentDB; 
            string originalOrganizationName = "";
            string newOrganizationName = "";
            if (organizationList == null)
            {
                organizationList = new ListControlBR("OrganizationListSelect");
                organizationList.SelectDataSet();
            }
            ListControlDS.ListControlRow lookupRow;
            lookupRow = organizationList.AssociatedDataSet.ListControlDS().ListControl.FirstOrDefault(row => row.ListId == originalOrganizationID);
            if (lookupRow != null)
                originalOrganizationName = lookupRow.FieldValue;
            lookupRow = null;
            lookupRow = organizationList.AssociatedDataSet.ListControlDS().ListControl.FirstOrDefault(row => row.ListId == newOrganizationID);
            if (lookupRow != null)
                newOrganizationName = lookupRow.FieldValue;

            foreach (OrganizationAssociatedCallDS.AssociatedCallRow row in rows)
            {

                try
                {
                    if (row.DBInstance == DatabaseInstance.ProductionArchive.ToString())
                    {
                        BaseIdentity.CurrentIdentity.DatabaseInstance = Constant.DatabaseInstance.ProductionArchive.ToString();
                        grConstant.CurrentDB = Constant.DatabaseInstance.ProductionArchive.ToString();
                    
                    }

                    string callType = row.CallTypeName;
                    int callID = row.CallID;
                    DataColumn callIDDataColumn;
                    //check if the call Type exists and continue if it does not
                    if (callType.Length == 0)
                    {
                        string message =  String.Format("Call Type is required to reassign!\nCall: {0} will not be reassinged.", row.CallID);
                        System.Windows.Forms.MessageBox.Show(message, "Call Type Required", System.Windows.Forms.MessageBoxButtons.OK);
                        continue;
                    }
                    switch (callType)
                    {
                        case "Referral":
                            ReferralBR referralBR = new ReferralBR();
                            callIDDataColumn =  ((ReferralDS)referralBR.AssociatedDataSet).Referral.CallIDColumn;
                            DataColumn callerOrganizationIDColumn = ((ReferralDS)referralBR.AssociatedDataSet).Referral.ReferralCallerOrganizationIDColumn;
                            DataColumn referralCallerPhoneIDColumn = ((ReferralDS)referralBR.AssociatedDataSet).Referral.ReferralCallerPhoneIDColumn;
                            DataColumn referralCoronerOrgIDColumn = ((ReferralDS)referralBR.AssociatedDataSet).Referral.ReferralCoronerOrgIDColumn;
                            DataColumn referralCoronerOrganizationColumn = ((ReferralDS)referralBR.AssociatedDataSet).Referral.ReferralCoronerOrganizationColumn;
                            
                            referralBR.ReassignField(callID, callIDDataColumn,  callerOrganizationIDColumn, originalOrganizationID ,newOrganizationID);
                            referralBR.ReassignField(callID, callIDDataColumn, referralCoronerOrgIDColumn, originalOrganizationID, newOrganizationID);
                            referralBR.ReassignField(callID, callIDDataColumn, referralCoronerOrganizationColumn, originalOrganizationName, newOrganizationName);

                            referralBR.ReassignField(callID, callIDDataColumn,  referralCallerPhoneIDColumn, originalPhoneID, newPhoneID);
                             
                            referralBR.SaveDataSet();

                            break;
                        case "Message":
                            MessageBR messageBR = new MessageBR();
                            callIDDataColumn = ((MessageDS)messageBR.AssociatedDataSet).Message.CallIDColumn;
                            DataColumn organizationIDColumn = ((MessageDS)messageBR.AssociatedDataSet).Message.OrganizationIDColumn;
                            DataColumn messageCallerPhoneColumn = ((MessageDS)messageBR.AssociatedDataSet).Message.MessageCallerPhoneColumn;
                            messageBR.ReassignField(callID, callIDDataColumn, organizationIDColumn, originalOrganizationID, newOrganizationID);
                            
                            Hashtable paramList = new Hashtable();
                            paramList.Add("PhoneID", originalPhoneID);

                            ListControlBR listControlBR = new ListControlBR("PhoneListSelect", paramList);
                            string originalPhone = "";
                            if (((ListControlDS)listControlBR.AssociatedDataSet).ListControl.Count > 0)
                                originalPhone = ((ListControlDS)listControlBR.AssociatedDataSet).ListControl.First(listRow => listRow.ListId == originalPhoneID).FieldValue;

                            paramList.Clear();
                            paramList.Add("PhoneID", newPhoneID);
                            listControlBR = new ListControlBR("PhoneListSelect", paramList);

                            string newPhone = "";
                            if (((ListControlDS)listControlBR.AssociatedDataSet).ListControl.Count > 0)
                                newPhone = ((ListControlDS)listControlBR.AssociatedDataSet).ListControl.First(listRow => listRow.ListId == newPhoneID).FieldValue;
                            
                            if(originalPhone.Length > 0 && newPhone.Length > 0)
                                messageBR.ReassignField(callID, callIDDataColumn, messageCallerPhoneColumn, originalPhone, newPhone);

                            messageBR.SaveDataSet();
                            break;
                        case "OASIS":
                            TcssBR tcssBR = new TcssBR();
                            callIDDataColumn = tcssBR.AssociatedDataSet.tcssDs().TcssRecipientOfferInformation.CallIdColumn;
                            DataColumn clientIDColumn = tcssBR.AssociatedDataSet.tcssDs().TcssRecipientOfferInformation.ClientIdColumn;
                            tcssBR.ReassignField(callID, callIDDataColumn, clientIDColumn, originalOrganizationID, newOrganizationID);
                            tcssBR.SaveDataSet();
                            break;
                        default:
                            break;
                    
                    }
                }//end of Try
                finally
                {
                    BaseIdentity.CurrentIdentity.DatabaseInstance = _currentDB;
                    grConstant.CurrentDB = _currentDB;
                }


            }

        }
        public void ReassignCall(OrganizationAssociatedCallDS.OrganizationDeleteRow deleteRow, int orginalOrganizationID,  int newOrganizationID)
        {
            int nextIndex = -1;
            //determine what calltype
            switch (deleteRow.CallTypeName)
            { 
                case "Referral":
                    nextIndex = NextIndex(((OrganizationAssociatedCallDS)AssociatedDataSet).Referral);
                    SelectReferral(deleteRow.CallID);
                    //change the value of organization IDS if they equal the original value
                    if (((OrganizationAssociatedCallDS)AssociatedDataSet).Referral[nextIndex].ReferralCallerOrganizationID == orginalOrganizationID)
                    ((OrganizationAssociatedCallDS)AssociatedDataSet).Referral[nextIndex].ReferralCallerOrganizationID = newOrganizationID;
                    if(((OrganizationAssociatedCallDS)AssociatedDataSet).Referral[nextIndex].ReferralCoronerOrgID == orginalOrganizationID)
                        ((OrganizationAssociatedCallDS)AssociatedDataSet).Referral[nextIndex].ReferralCoronerOrgID = newOrganizationID;

                    break;
                case "Message":
                    nextIndex = NextIndex(((OrganizationAssociatedCallDS)AssociatedDataSet).Message);
                    SelectMessage(deleteRow.CallID);
                    if (((OrganizationAssociatedCallDS)AssociatedDataSet).Message[nextIndex].OrganizationID == orginalOrganizationID)
                        ((OrganizationAssociatedCallDS)AssociatedDataSet).Message[nextIndex].OrganizationID = newOrganizationID;
                    break;
                case "Oasis":
                    new NotImplementedException("The code to change organizationID for Oasis has not been implemented");
                    break;
                default:
                    break;
            }
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

        public void ClearAssociatedCallRow(Int32 callID)
        {
            OrganizationAssociatedCallDS.AssociatedCallRow associatedCallRow = ((OrganizationAssociatedCallDS)AssociatedDataSet).AssociatedCall.FirstOrDefault(row => row.CallID == callID);
            if (associatedCallRow != null)
            {
                associatedCallRow.Delete();
                associatedCallRow.AcceptChanges();
            }

        }
    }
}
