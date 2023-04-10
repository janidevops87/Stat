using System;
using Statline.Data;
using Statline.StatTrac.Data.Report;
using Statline.StatTrac.Data.Referral;
using Statline.StatTrac.Data.Types;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;


namespace Statline.StatTrac.Referral
{
    public class ReferralManager
    {
        #region Referral List
        public static ReferralData.ReferralListDataTable FillReferralList(string CallNumber, string PatientFirstName, string PatientLastName, DateTime startDateTime, DateTime endDateTime, Int32 OrganizationID, Int32 ReportGroupID, Int32 SpecialSearchCriteria, string BasedOnDT, string timeZone)
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillReferralList(ds, CallNumber, PatientFirstName, PatientLastName, startDateTime, endDateTime, OrganizationID, ReportGroupID, SpecialSearchCriteria, BasedOnDT, timeZone);
            }
            catch
            {
                //throw;
            }

            return ds.ReferralList;
        }
        #endregion

        #region ReportGroup
        public static ReferralData.WebReportGroupListDataTable FillReportGroupList1(int userOrgID)
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillReportGroupList(ds, userOrgID);
            }
            catch
            {
                throw;
            }

            return ds.WebReportGroupList;
        }

        #endregion

        #region Organization
        public static ReportReferenceData.OrganizationListDataTable FillOrganzationList(int reportGroupID)
        {
            ReportReferenceData ds = new ReportReferenceData();

            try
            {
                ReportReferenceDB.FillOrganizationList(ds, reportGroupID);
            }
            catch
            {
                throw;
            }

            return ds.OrganizationList;
        }
        #endregion

        #region Single Referral
        public static ReferralData.ReferralSingleDataTable FillReferralSingle(int CallID, int UserOrgID, int reportGroupID, string timeZone)
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillReferralSingle(ds, CallID, UserOrgID, reportGroupID, timeZone);
            }
            catch
            {
                throw;
            }

            return ds.ReferralSingle;
        }
        #endregion

        #region Approacher List
        public static ReferralData.ApproacherListDataTable FillApproacherList(int CallID)
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillApproacherList(ds, CallID);
            }
            catch
            {
                throw;
            }

            return ds.ApproacherList;
        }
        #endregion

        #region Approacher Type
        public static ReferralData.ApproacherTypeListDataTable FillApproacherTypeList()
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillApproacherTypeList(ds);
            }
            catch
            {
                throw;
            }

            return ds.ApproacherTypeList;
        }
        #endregion

        #region Appropriate List
        public static ReferralData.AppropriateListDataTable FillAppropriateList()
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillAppropriateList(ds);
            }
            catch
            {
                throw;
            }

            return ds.AppropriateList;
        }
        #endregion

        #region Approach List
        public static ReferralData.ApproachListDataTable FillApproachList()
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillApproachList(ds);
            }
            catch
            {
                throw;
            }

            return ds.ApproachList;
        }
        #endregion

        #region Consent List
        public static ReferralData.ConsentListDataTable FillConsentList()
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillConsentList(ds);
            }
            catch
            {
                throw;
            }

            return ds.ConsentList;
        }
        #endregion

        #region Recovery List
        public static ReferralData.RecoveryListDataTable FillRecoveryList()
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillRecoveryList(ds);
            }
            catch
            {
                throw;
            }

            return ds.RecoveryList;
        }
        #endregion

        #region Donor Category
        public static void FillDonorCategoryList(ReferralData ds, int OrganizationID, string SourceCodeName)
        //public static ReferralData.DonorCategoryDataTable FillDonorCategoryList(int OrganizationID, string SourceCodeName)
        {
            //ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillDonorCategoryList(ds, OrganizationID, SourceCodeName);
            }
            catch
            {
                throw;
            }
            //return ds.DonorCategory;
        }
        #endregion

        #region Get Referral
        public static void FillReferralReport(ReferralData ds, int CallID)
        //public static ReferralData.ReferralUpdateDataTable FillReferralReport(int CallID)
        {
            //ReferralData ds = new ReferralData();
            try
            {
                //Statline.StatTrac.Data.Referral.ReferralDB.FillCall(ds, CallID);
                //Statline.StatTrac.Data.Referral.ReferralDB.FillReferral(ds, CallID);
                //Statline.StatTrac.Data.Referral.ReferralDB.FillLogEvent(ds, CallID);
                Statline.StatTrac.Data.Referral.ReferralDB.FillReferralReport(ds, CallID);
            }
            catch
            {
                throw;
            }

            //return ds.ReferralUpdate;
        }
        #endregion

        #region Update Referral
        public static void UpdateReferral(ReferralData referralData, int callID)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to update Referral data
                    ReferralDB.UpdateReferral(
                        db,
                        referralData,
                        callID,
                        tHelper.DbTransaction);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }


            }
        }
        #endregion

        #region Is Contact Required
        public static bool isContactRequired(ReferralData referralData, Int32 callID, Int32 organizationID )
        {   
            //Set default contact required value
            bool contactRequired = true;
            
            //Set initialize contact required counts
            int activeContactRequired = 1;
            //this count gets incremented when a contact is required for a Schedule Group
            int numberOfContactsRequired = 0;


            {  //Get data from Referral ds
                ReferralData ds = new ReferralData();
                try
                {   //load data values

                    //Get the organizationID for the following data load
                    //Int32 organizationID = Convert.ToInt32(referralData.Tables["ReferralUpdate"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralCallerOrganizationID"]);

                    Statline.StatTrac.Data.Referral.ReferralDB.FillCall(ds, callID);
                    Statline.StatTrac.Data.Referral.ReferralDB.FillReferral(ds, callID);
                    Statline.StatTrac.Data.Referral.ReferralDB.FillLogEvent(ds, callID);

                    //Get the organizationID for the following data load
                    //Int32 organizationID = Convert.ToInt32(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralCallerOrganizationID"]);
                    Statline.StatTrac.Data.Referral.ReferralDB.FillScheduleGroupContactRequired(ds, callID, organizationID);

                }
                catch
                {
                    throw;
                }

                //Get referral disposition: Appropriate values
                int referralOrganAppropriate = Convert.ToInt16(ds.Referral.Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralOrganAppropriateID"]) == 1 ? 1 : 2;
                int referralBoneAppropriate = Convert.ToInt16(ds.Referral.Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralBoneAppropriateID"]) == 1 ? 1 : 2;
                int referralTissueAppropriate = Convert.ToInt16(ds.Referral.Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralTissueAppropriateID"]) == 1 ? 1 : 2;
                int referralSkinAppropriate = Convert.ToInt16(ds.Referral.Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralSkinAppropriateID"]) == 1 ? 1 : 2;
                int referralValvesAppropriate = Convert.ToInt16(ds.Referral.Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralValvesAppropriateID"]) == 1 ? 1 : 2;
                int referralEyesTransAppropriate = Convert.ToInt16(ds.Referral.Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralEyesTransAppropriateID"]) == 1 ? 1 : 2;
                int referralEyesRschAppropriate = Convert.ToInt16(ds.Referral.Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralEyesRschAppropriateID"]) == 1 ? 1 : 2;

                //Get referral disposition: Approach values
                int referralOrganApproach = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralOrganApproachID"]);
                int referralBoneApproach = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralBoneApproachID"]);
                int referralTissueApproach = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralTissueApproachID"]);
                int referralSkinApproach = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralSkinApproachID"]);
                int referralValvesApproach = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralValvesApproachID"]);
                int referralEyesTransApproach = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralEyesTransApproachID"]);
                int referralEyesRschApproach = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralEyesRschApproachID"]);

                //Get referral disposition: Consent values
                int referralOrganConsent = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralOrganConsentID"]);
                int referralBoneConsent = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralBoneConsentID"]);
                int referralTissueConsent = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralTissueConsentID"]);
                int referralSkinConsent = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralSkinConsentID"]);
                int referralValvesConsent = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralValvesConsentID"]);
                int referralEyesTransConsent = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralEyesTransConsentID"]);
                int referralEyesRschConsent = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralEyesRschConsentID"]);

                //Get General Consent - Yes(1,2),  No(3)
                int referralGeneralConsent = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralGeneralConsent"]);
                int referralApproachTypeID = Convert.ToInt16(referralData.Tables["Referral"].Rows[ConstHelper.DEFAULTFIRSTRECORD]["ReferralApproachTypeID"]);


                //If appropriate is ruled out if one of the following approach options is true:
                //  (2)Unknown (allow)
                //  (3)Family Unavailable
                //  (4)Coroner Ruleout
                //  (5)Arrest
                //  (6)Med RO)
                //  (7)Time/Logistics
                //  (8)Never Brain Dead
                //  (9)High Risk
                //  (11)Unapproachable

                if (referralOrganApproach > 2 && referralOrganApproach < 12) { referralOrganAppropriate = 2; }
                if (referralBoneApproach > 2 && referralBoneApproach < 12) { referralBoneAppropriate = 2; }
                if (referralTissueApproach > 2 && referralTissueApproach < 12) { referralTissueAppropriate = 2; }
                if (referralSkinApproach > 2 && referralSkinApproach < 12) { referralSkinAppropriate = 2; }
                if (referralValvesApproach > 2 && referralValvesApproach < 12) { referralValvesAppropriate = 2; }
                if (referralEyesTransApproach > 2 && referralEyesTransApproach < 12) { referralEyesTransAppropriate = 2; }
                if (referralEyesRschApproach > 2 && referralEyesRschApproach < 12) { referralEyesRschAppropriate = 2; }

                // If any Approach items are 'Yes', continue and see if contact has been made.
                // If any Approach items not 'Yes', then this is a potiential ruleout, see if contact has been made
                // If other conditions exist, set contact required to False and get out(see else below.)
                if (
                    (
                        (referralOrganApproach == 1) ||
                        (referralBoneApproach == 1) ||
                        (referralTissueApproach == 1) ||
                        (referralSkinApproach == 1) ||
                        (referralValvesApproach == 1) ||
                        (referralEyesTransApproach == 1) ||
                        (referralEyesRschApproach == 1)
                    ) ||
                    (
                        (referralOrganApproach > 1) ||
                        (referralBoneApproach > 1) ||
                        (referralTissueApproach > 1) ||
                        (referralSkinApproach > 1) ||
                        (referralValvesApproach > 1) ||
                        (referralEyesTransApproach > 1) ||
                        (referralEyesRschApproach > 1)
                    )
                   )
                {
         //Start Schedule Group Loop
                    string scheduleGroupID; //Start Scheule Group Loop
                    for (int scheduleGroupLoop = 0; scheduleGroupLoop < ds.ScheduleGroupContactRequired.Rows.Count; scheduleGroupLoop++)
                    {
                    //Set ScheduleGroupID
                    scheduleGroupID = ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["ScheduleGroupID"].ToString();
                        
                    // Set the contact required default to 1 prior to checking if contact has been made.
                    activeContactRequired = activeContactRequired = 1;

                    //set criteria schedule group data
                    //If value is 0, set to 1(option unchecked: look for Approapriate = yes ) else set to 2(option checked: look for non-appropriate categories)
                    int scheduleGroupOrgan = ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleGroupOrgan"].ToString() == "0" ? 1 : 2 ;
                    int scheduleGroupBone = ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleGroupBone"].ToString() == "0" ? 1 : 2;
                    int scheduleGroupTissue = ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleGroupTissue"].ToString() == "0" ? 1 : 2;
                    int scheduleGroupSkin = ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleGroupSkin"].ToString() == "0" ? 1 : 2;
                    int scheduleGroupValves = ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleGroupValves"].ToString() == "0" ? 1 : 2;
                    int scheduleGroupEyes = ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleGroupEyes"].ToString() == "0" ? 1 : 2;
                    int scheduleGroupResearch = ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleGroupResearch"].ToString() == "0" ? 1 : 2;

                    //Contact Rules
                    int scheduleGroupNoContactOnDny = Convert.ToInt16(ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleNoContactOnDny"]);
                    int scheduleGroupContactOnCnsnt = Convert.ToInt16(ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleContactOnCnsnt"]);
                    int scheduleGroupContactOnAprch = Convert.ToInt16(ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleContactOnAprch"]);
                    int scheduleGroupContactOnCononor = Convert.ToInt16(ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleContactOnCrnr"]);
                    int scheduleGroupContactOnStatCnsnt = Convert.ToInt16(ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleContactOnStatCnsnt"]);
                    int scheduleGroupResearchOnCoronorOnly = Convert.ToInt16(ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CriteriaScheduleContactOnCoronerOnly"]);

                    int contactCategoryID = Convert.ToInt16(ds.ScheduleGroupContactRequired.Rows[scheduleGroupLoop]["CategoryID"]);


                   // See if schedule group contact is required
                   // compare appropriate: (yes = 1, ruleouts = 2) with criteria schedule group
                   // options: (appropriate = 1, ruleouts = 2)
                   // If matches are obtained contact is required
                   // *************************************************
 
                   switch (contactCategoryID){
                   case 1: //Organ
                           if (referralOrganAppropriate == 1 &&
                                (referralOrganAppropriate == scheduleGroupOrgan
                                )
                               )
                           {
                               activeContactRequired = 1;
                               //check for exceptions:
                               //Contact rule 1. Do Not contact organization if general consent is denied.
                               if (scheduleGroupNoContactOnDny == 1 && (referralGeneralConsent == 3)) { activeContactRequired = 0; }

                           }
                           else 
                           {
                               activeContactRequired = 0;
                               //check for exceptions

                           }
                       break;

                   case 2: //Bone
                       if ((referralBoneAppropriate == 1 &&
                            (referralOrganAppropriate == scheduleGroupOrgan || scheduleGroupOrgan == 1) 
                             //referralBoneAppropriate == scheduleGroupBone
                            )
                           )
                       {
                           activeContactRequired = 1;
                           //check for exceptions:
                           //Contact rule 1. Do Not contact organization if general consent is denied.
                           if (scheduleGroupNoContactOnDny == 1 && (referralGeneralConsent == 3)) { activeContactRequired = 0; }
                       }
                       else
                       {
                           activeContactRequired = 0;
                           //check for exceptions
                           //Contact rule 2. contact organization if any category is not appropriate and consent is Yes.
                           if ((scheduleGroupContactOnCnsnt == 1 && (referralGeneralConsent == 1 || referralGeneralConsent == 2)) //&& 
                               // (referralOrganAppropriate > 1 ||
                               //     referralBoneAppropriate > 1 
                               //)
                              ) { activeContactRequired = 1; }
                           //Contact rule 3. Contact group if coroner's case and general consent is granted.
                           //Contact rule 4. Contact group if coroner's case only.
                       }
                       break;
                   case 3: //Tissue
                       if ((referralTissueAppropriate == 1 &&
                            (referralOrganAppropriate == scheduleGroupOrgan || scheduleGroupOrgan == 1) &&
                            (referralBoneAppropriate == scheduleGroupBone || scheduleGroupBone == 1)
                            )
                           )
                       {
                           activeContactRequired = 1;
                           //check for exceptions:
                           //Contact rule 1. Do Not contact organization if general consent is denied.
                           if (scheduleGroupNoContactOnDny == 1 && (referralGeneralConsent == 3)) { activeContactRequired = 0; }
                       }
                       else
                       {
                           activeContactRequired = 0;
                           //check for exceptions
                           //Contact rule 2: contact organization if any category is not appropriate and consent is Yes.
                           if ((scheduleGroupContactOnCnsnt == 1 && (referralGeneralConsent == 1 || referralGeneralConsent == 2)) //&& 
                               // (referralOrganAppropriate > 1 ||
                               //     referralBoneAppropriate > 1 
                               //)
                              ) { activeContactRequired = 1; }
                           //Contact rule 3. Contact group if coroner's case and general consent is granted.
                           //Contact rule 4. Contact group if coroner's case only.
                       }
                       break;
                   case 4: //Skin
                       if ((referralSkinAppropriate == 1 &&
                            (referralOrganAppropriate == scheduleGroupOrgan || scheduleGroupOrgan == 1)&&
                            (referralBoneAppropriate == scheduleGroupBone || scheduleGroupBone == 1)&&
                            (referralTissueAppropriate == scheduleGroupTissue || scheduleGroupTissue == 1)
                            )
                           )
                       {
                           activeContactRequired = 1;
                           //check for exceptions:
                           //Contact rule 1. Do Not contact organization if general consent is denied.
                           if (scheduleGroupNoContactOnDny == 1 && (referralGeneralConsent == 3)) { activeContactRequired = 0; }
                       }
                       else
                       {
                           activeContactRequired = 0;
                           //check for exceptions
                           //Contact rule 2: contact organization if any category is not appropriate and consent is Yes.
                           if ((scheduleGroupContactOnCnsnt == 1 && (referralGeneralConsent == 1 || referralGeneralConsent == 2)) //&& 
                              //(referralOrganAppropriate > 1 ||
                              //      referralBoneAppropriate > 1 ||
                              //      referralTissueAppropriate > 1
                              // )
                              ) { activeContactRequired = 1; }
                           //Contact rule 3. Contact group if coroner's case and general consent is granted.
                           //Contact rule 4. Contact group if coroner's case only.
                       }
                       break;
                   case 5: //Valves
                       if ((referralValvesAppropriate == 1 &&
                            (referralOrganAppropriate == scheduleGroupOrgan || scheduleGroupOrgan == 1)&&
                            (referralBoneAppropriate == scheduleGroupBone || scheduleGroupBone == 1)&&
                            (referralTissueAppropriate == scheduleGroupTissue || scheduleGroupTissue == 1)&&
                            (referralSkinAppropriate == scheduleGroupSkin || scheduleGroupSkin == 1)
                            //referralValvesAppropriate == scheduleGroupValves
                            )
                           )
                       {
                           activeContactRequired = 1;
                           //check for exceptions:
                           //Contact rule 1. Do Not contact organization if general consent is denied.
                           if (scheduleGroupNoContactOnDny == 1 && (referralGeneralConsent == 3)) { activeContactRequired = 0; }
                       }
                       else
                       {
                           activeContactRequired = 0;
                           //check for exceptions:
                           //Contact rule 2. Contact organization if any category is not appropriate and consent is Yes.
                           if ((scheduleGroupContactOnCnsnt == 1 && (referralGeneralConsent == 1 || referralGeneralConsent == 2)) //&& 
                               // (referralOrganAppropriate > 1 ||
                               //     referralBoneAppropriate > 1 ||
                               //     referralTissueAppropriate > 1 ||
                               //     referralSkinAppropriate > 1
                               //)
                              ) { activeContactRequired = 1; }
                           //Contact rule 3. Contact group if coroner's case and general consent is granted.
                           //Contact rule 4. Contact group if coroner's case only.
                       }
                       break;
                   case 6: //EyesTrans
                       if ((referralEyesTransAppropriate == 1 &&
                            (referralOrganAppropriate == scheduleGroupOrgan || scheduleGroupOrgan == 1)&&
                            (referralBoneAppropriate == scheduleGroupBone || scheduleGroupBone == 1)&&
                            (referralTissueAppropriate == scheduleGroupTissue || scheduleGroupTissue == 1)&&
                            (referralSkinAppropriate == scheduleGroupSkin || scheduleGroupSkin == 1) &&
                            (referralValvesAppropriate == scheduleGroupValves || scheduleGroupValves == 1)
                           )
                           )
                       {
                           activeContactRequired = 1;
                           //check for exceptions:
                           //Contact rule 1. Do Not contact organization if general consent is denied.
                           if (scheduleGroupNoContactOnDny == 1 && (referralGeneralConsent == 3)) { activeContactRequired = 0; }
                       }
                       else
                       {
                           activeContactRequired = 0;
                           //check for exceptions:
                           //Contact rule 2. contact organization if any category is not appropriate and consent is Yes.
                           if ((scheduleGroupContactOnCnsnt == 1 && (referralGeneralConsent == 1 ||referralGeneralConsent == 2)) //&& 
                               // (referralOrganAppropriate > 1 ||
                               //     referralBoneAppropriate > 1 ||
                               //     referralTissueAppropriate > 1 ||
                               //     referralSkinAppropriate > 1 ||
                               //     referralValvesAppropriate > 1
                               //)
                              ) { activeContactRequired = 1; }
                           //Contact rule 3. Contact group if coroner's case and general consent is granted.
                           //Contact rule 4. Contact group if coroner's case only.
                       }
                       break;
                   case 7: //EyesRescearch
                       if ((referralEyesRschAppropriate == 1 &&
                            (referralOrganAppropriate == scheduleGroupOrgan || scheduleGroupOrgan == 1)&&
                            (referralBoneAppropriate == scheduleGroupBone || scheduleGroupBone == 1)&&
                            (referralTissueAppropriate == scheduleGroupTissue || scheduleGroupTissue == 1)&&
                            (referralSkinAppropriate == scheduleGroupSkin || scheduleGroupSkin == 1) &&
                            (referralValvesAppropriate == scheduleGroupValves || scheduleGroupValves == 1) &&
                            (referralEyesTransAppropriate == scheduleGroupEyes || scheduleGroupEyes == 1)
                            )
                           )
                       {
                           activeContactRequired = 1;
                           //check for exceptions:
                           //Contact rule 1. Do Not contact organization if general consent is denied.
                           if (scheduleGroupNoContactOnDny == 1 && (referralGeneralConsent == 3)) { activeContactRequired = 0; }
                           //if ((scheduleGroupNoContactOnDny == 1 && referralGeneralConsent == 3) || (scheduleGroupNoContactOnDny == 1 && referralGeneralConsent == -1)) { activeContactRequired = 0; }
                       }
                       else
                       {
                           activeContactRequired = 0;
                           //check for exceptions:
                           //Contact rule 2. contact organization if any category is not appropriate and consent is Yes.
                           if ((scheduleGroupContactOnCnsnt == 1 && (referralGeneralConsent == 1 || referralGeneralConsent == 2)) //&& 
                               // (referralOrganAppropriate > 1 ||
                               //     referralBoneAppropriate > 1 ||
                               //     referralTissueAppropriate > 1 ||
                               //     referralSkinAppropriate > 1 ||
                               //     referralValvesAppropriate > 1 ||
                               //     referralEyesTransAppropriate > 1
                               //)
                              ){ activeContactRequired = 1; }
                           //Contact rule 3. Contact group if coroner's case and general consent is granted.
                           //Contact rule 4. Contact group if coroner's case only.
                       }
                       break;

                   default: break;                   
                   } //End switch

                   if (activeContactRequired == 1) //Enter loop
                   {
                       //See if contact has been made and if it has, set contact required to back to false
                       //Filter only ScheduleGroupIDs needed and Build array
                       string filterLogEvent = "ScheduleGroupID = " + scheduleGroupID;
                       DataRow[] logEventScheduleGroupID = ds.LogEvent.Select(filterLogEvent);

                       //Start EventLogLoop
                       for (int logEventLoop = 0; logEventLoop < logEventScheduleGroupID.Length; logEventLoop++)
                       {   // Set the contact required default to 1 prior to checking if contact has been made.

                           //Compare ScheduleGroupIDs with LogEvent and see if contact is confirmed.
                           if (
                               ((logEventScheduleGroupID[logEventLoop].ItemArray[12].ToString() == scheduleGroupID) && //ScheduleGroupID
                                (logEventScheduleGroupID[logEventLoop].ItemArray[16].ToString() == "1")) //LogEventContactConfirmed
                               )
                           {
                               //contact has been made, no contact required for this Schedule Group
                               activeContactRequired = 0;
                           }

                       }//End LogEventLoop
                   }
                    if (activeContactRequired == 1)
                    {
                        numberOfContactsRequired = numberOfContactsRequired + activeContactRequired;
                        //may also want to capture the SecheduleGroup and Organization names and put into array here
                    }
                    
                    }//End ScheduleGroupID Loop

                }
                else
                {
                    // Approach ruled out
                    numberOfContactsRequired = 0;
                }

            
            }

            if (numberOfContactsRequired == 0)
            {
                contactRequired = false;
            }
            else
            {
                contactRequired = true;
            }

        return contactRequired;
        }
        #endregion

        #region Create Event Log
        public static void InsertReferralReportLogEvent(ReferralData referralData)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to update referral pass referralData and transaction
                    ReferralDB.InsertReferralReportLogEvent(referralData);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }


            }
        }
        #endregion

        #region Lock Call
        public static void LockCall(int callID, int callOpenByID, int callOpenByWebPersonID, int callSaveLastByID, int auditLogTypeID, int checkCallOpenByID)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {
                try
                {
                    tHelper.StartTransaction();
                    //try to update Person pass userData and transaction
                    ReferralDB.LockCall(
                        callID,
                        callOpenByID,
                        callOpenByWebPersonID,
                        callSaveLastByID,
                        auditLogTypeID,
                        checkCallOpenByID);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch (Exception ex)
                {
                    tHelper.RollBackTransaction();
                    throw;
                }
            }
        }
        #endregion

        #region Person List
        public static ReferralData.PersonbyOrgDataTable FillPersonList(int OrganizationId)
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillPersonList(ds, OrganizationId);
            }
            catch
            {
                throw;
            }

            return ds.PersonbyOrg;
        }
        #endregion

        #region Log Event List
        public static ReferralData.LogEventListDataTable FillLogEventList(int CallID, string timeZone)
        {
            ReferralData ds = new ReferralData();
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillLogEventList(ds, CallID, timeZone);
            }
            catch
            {
                throw;
            }

            return ds.LogEventList;
        }
        #endregion

        #region Get Call Lock
        public static int GetCallLocked(int callID, int callOpenByID, int ReturnVal)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to insert Schedule pass scheduleData and transaction
                    ReturnVal = ReferralDB.GetCallLocked(callID, callOpenByID);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }
                return ReturnVal;
            }
        }
        #endregion
        #region Get SourceCodeName
        public static string GetSourceCodeName(int callID ,string ReturnVal)
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try to Get SourceCodeName
                    ReturnVal = ReferralDB.GetSourceCodeName(callID);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }
                return ReturnVal;
            }
        }
        #endregion

        #region Referral Facility Compliance
        //public static ReferralData.ReferralFacilityComplianceDataTable FillReferralFacilityCompliance(DateTime referralStartDateTime, DateTime referralEndDateTime, Int32 reportGroupID, Int32 organizationID, string sourceCodeName, int displayMT)
        //{
        //    ReferralData ds = new ReferralData();
        //    try
        //    {
        //        Statline.StatTrac.Data.Referral.ReferralDB.FillReferralFacilityCompliance(ds, referralStartDateTime, referralEndDateTime, reportGroupID, organizationID, sourceCodeName, displayMT);
        //    }
        //    catch
        //    {
        //        throw;
        //    }

        //    return ds.ReferralFacilityCompliance;
        //}
        public static void FillReferralFacilityCompliance(ReferralData ds,DateTime referralStartDateTime, DateTime referralEndDateTime, Int32 reportGroupID, Int32 organizationID, string sourceCodeName, int displayMT)
        {
           
            try
            {
                Statline.StatTrac.Data.Referral.ReferralDB.FillReferralFacilityCompliance(ds, referralStartDateTime, referralEndDateTime, reportGroupID, organizationID, sourceCodeName, displayMT);
            }
            catch
            {
                throw;
            }

            
        }
        #endregion

        #region Update Referral Facility Compliance
        public static void UpdateOrganizationDeaths(ReferralData referralData)
        //public static void FillReferralFacilityCompliance(ReferralData referralData)
        {
            // get db instance - need dw instance!! jth 10/08
            Database db = DBCommands.GetDataBase(DatabaseInstance.DataWarehouse);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    //try to update Schedule pass scheduleData and transaction
                    ReferralDB.UpdateOrganizationDeaths(referralData);

                    //committ the application
                }
                catch
                {
                    tHelper.RollBackTransaction();
                    throw;
                }
            }
        }
        #endregion

        #region Get Referral Search Count
        public static int FillReferralListCount(string CallNumber, string PatientFirstName, string PatientLastName, DateTime startDateTime, DateTime endDateTime,
            Int32 OrganizationID, Int32 ReportGroupID, Int32 SpecialSearchCriteria, string BasedOnDT, string timeZone, int returnVal)
        {
                try
                {
                    //try to insert Schedule pass scheduleData and transaction
                    returnVal = ReferralDB.FillReferralListCount(CallNumber, PatientFirstName, PatientLastName, startDateTime, endDateTime,
                                    OrganizationID, ReportGroupID, SpecialSearchCriteria, BasedOnDT, timeZone);
                   
                }
                catch
                {
                    //throw;
                }
                return returnVal;
        }
        #endregion


    }
}
