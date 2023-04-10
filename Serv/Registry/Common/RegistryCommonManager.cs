using System;
using Statline.Data;
using Statline.Registry.Data;
using Statline.Registry.Data.Common;
using Statline.Registry.Data.Types;
using Statline.Registry.Data.Types.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;

namespace Statline.Registry.Common
{
    public class RegistryCommonManager
    {
        #region FillEventCategory
        public static RegistryCommon.EventCategoryDataTable FillEventCategory(
                Int32 EventCategoryID,
                Int32 RegistryOwnerID,
                Int32 EventCategoryActive            
                )
            {
                RegistryCommon ds = new RegistryCommon();
                try
                {
                    Statline.Registry.Data.Common.RegistryCommonDB.GetEventCategory(ds,
                        EventCategoryID,
                        RegistryOwnerID,
                        EventCategoryActive
                        );
                }
                catch
                { 
                    throw;
                }
                return ds.EventCategory;
            
            }
        #endregion
        #region FillEventCategoryEdit
        public static RegistryCommon.EventCategoryDataTable FillEventCategoryEdit(RegistryCommon ds,
                Int32 EventCategoryID,
                Int32 RegistryOwnerID,
                Int32 EventCategoryActive
                )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetEventCategory(ds,
                    EventCategoryID,
                    RegistryOwnerID,
                    EventCategoryActive
                    );
            }
            catch
            {
                throw;
            }
            return ds.EventCategory;

        }
        #endregion
        #region FillEventSubCategory
            public static RegistryCommon.EventSubCategoryDataTable FillEventSubCategory(
                Int32 EventSubCategoryID, 
                Int32 EventCategoryID,
                Int32 EventSubCategoryActive
                )
            {
                RegistryCommon ds = new RegistryCommon();
                try
                {
                    Statline.Registry.Data.Common.RegistryCommonDB.GetEventSubCategory(ds,
                        EventSubCategoryID,
                        EventCategoryID,
                        EventSubCategoryActive
                        );
                }
                catch
                {
                    throw;
                }
                return ds.EventSubCategory;

            }
        #endregion
        #region FillEventSubCategoryEdit
        public static RegistryCommon.EventSubCategoryDataTable FillEventSubCategoryEdit(RegistryCommon ds,
            Int32 EventSubCategoryID,
            Int32 EventCategoryID,
            Int32 EventSubCategoryActive
            )
        {
            // RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetEventSubCategory(ds,
                    EventSubCategoryID,
                    EventCategoryID,
                    EventSubCategoryActive
                    );
            }
            catch
            {
                throw;
            }
            return ds.EventSubCategory;

        }
        #endregion
        #region FillEventRegistry
            public static RegistryCommon.EventRegistryDataTable FillEventRegistry(RegistryCommon ds,
                Int32 RegistryID
                )
            {
                try
                {
                    Statline.Registry.Data.Common.RegistryCommonDB.GetEventRegistry(ds,
                        RegistryID
                        );
                }
                catch
                {
                    throw;
                }
                return ds.EventRegistry;

            }
        #endregion
        #region FillIDologyLog
            public static RegistryCommon.IDologyLogDataTable FillIDologyLog(
                Int32 IDologyLogID
                )
            {
                RegistryCommon ds = new RegistryCommon();
                try
                {
                    Statline.Registry.Data.Common.RegistryCommonDB.GetIDologyLog(ds,
                        IDologyLogID
                        );
                }
                catch
                {
                    throw;
                }
                return ds.IDologyLog;

            }
            #endregion
        #region FillRegistry
            public static RegistryCommon.RegistryDataTable FillRegistry(RegistryCommon ds,
                Int32 RegistryID
                )
            {
                try
                {
                    Statline.Registry.Data.Common.RegistryCommonDB.GetRegistry(ds,
                        RegistryID
                        );
                }
                catch
                {
                    throw;
                }
                return ds.Registry;

            }
        #endregion
        #region FillRegistryAddr
            public static RegistryCommon.RegistryAddrDataTable FillRegistryAddr(RegistryCommon ds,
                Int32 RegistryID,
                Int32 AddrTypeID
                )
            {
                try
                {
                    Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryAddr(ds,
                        RegistryID,
                        AddrTypeID
                        );
                }
                catch
                {
                    throw;
                }
                return ds.RegistryAddr;

            }
        #endregion
        #region FillRegistryDigitalCertificate
        public static RegistryCommon.RegistryDigitalCertificateDataTable FillRegistryDigitalCertificate(
            Int32 RegistryID
            )
        {
            RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryDigitalCertificate(ds,
                    RegistryID
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryDigitalCertificate;

        }
    #endregion
        #region FillRegistryOwner
        public static RegistryCommon.RegistryOwnerDataTable FillRegistryOwner(RegistryCommon ds,
            Int32 RegistryOwnerID,
            String RegistryOwnerRouteName
            )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwner(ds,
                    RegistryOwnerID,
                    RegistryOwnerRouteName
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwner;

        }
        #endregion
        #region FillRegistryOwnerGrantedAccess
        public static RegistryCommon.RegistryOwnerGrantedAccessDataTable FillRegistryOwnerGrantedAccess(
            Int32 RegistryOwnerID,
            String RegistryOwnerRouteName
            )
        {
            RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwner(ds,
                    RegistryOwnerID,
                    RegistryOwnerRouteName
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerGrantedAccess;

        }
        #endregion
        #region FillRegistryOwnerStateConfig
        public static RegistryCommon.RegistryOwnerStateConfigDataTable FillRegistryOwnerStateConfig(
            Int32 RegistryOwnerID,
            Int16 DisplayAllStates
            )

        {
            RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwnerStateConfig(ds,
                    RegistryOwnerID,
                    DisplayAllStates
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerStateConfig;

        }
        #endregion

        #region FillDropDownListState
        public static RegistryCommon.RegistryOwnerStateConfigDataTable FillDropDownListState(RegistryCommon ds,
            Int32 RegistryOwnerID
            )
        {

            Int16 DisplayallStates = 1;

            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwnerStateConfig(ds,
                    RegistryOwnerID,
                    DisplayallStates
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerStateConfig;

        }
        #endregion
        #region FillDataListRegistrySearchResults
        public static RegistryCommon.DataListRegistrySearchResultsDataTable FillDataListRegistrySearchResults(RegistryCommon ds,
            String      FirstName,
            String      MiddleName,
            String      LastName,
            String      City,
            String      State,
            String      Zip,
            String      License,
            String      WebRegistryID,
            String      DOB,
            String      DisplayWebDonors,
            String      DisplayDMVDonors,
            String      DisplayWebPendingSignature,
            String      DisplayDMVDonorYesOnly,
            String      StateSelection,
            String      RegistryOwnerID,
            String      DisplayNoDonors
            )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetDataListRegistrySearchResults(ds,
                    FirstName,
                    MiddleName,
                    LastName,
                    City,
                    State,
                    Zip,
                    License,
                    WebRegistryID,
                    DOB,
                    DisplayWebDonors,
                    DisplayDMVDonors,
                    DisplayWebPendingSignature,
                    DisplayDMVDonorYesOnly,
                    StateSelection,
                    RegistryOwnerID,
                    DisplayNoDonors
                    );
            }
            catch
            {
                throw;
            }
            return ds.DataListRegistrySearchResults;

        }
        #endregion
        #region FillRegistryStatisticsReport
        public static RegistryCommon.RegistryStatisticsReportDataTable FillRegistryStatisticsReport(
            String StateSelection
            )
        {
            RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryStatisticsReport(ds,
                    StateSelection
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryStatisticsReport;

        }
        #endregion
        #region FillDataFormElectronicSignature
        public static RegistryCommon.DataFormElectronicSignatureDataTable FillDataFormElectronicSignature(RegistryCommon ds,
            Int32 RegistryID
            )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetFormElectronicSignature(ds,
                    RegistryID
                    );
            }
            catch
            {
                throw;
            }
            return ds.DataFormElectronicSignature;

        }
        #endregion
        #region FillDataFormVerification
        public static RegistryCommon.DataFormVerificationDataTable FillDataFormVerification(RegistryCommon ds,
            Int32 SourceID,
            string Source,
            string State
            )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetFormVerification(ds,
                    SourceID,
                    Source,
                    State
                    );
            }
            catch
            {
                throw;
            }
            return ds.DataFormVerification;

        }
        #endregion
        #region FillRegistryOwnerEnrollmentText
        public static RegistryCommon.RegistryOwnerEnrollmentTextDataTable FillRegistryOwnerEnrollmentText(RegistryCommon ds,
            Int32 RegistryOwnerID,
            string LanguageCode
            )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwnerEnrollmentFormText(ds,
                    RegistryOwnerID,
                    LanguageCode
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerEnrollmentText;

        }
                #endregion
        #region FillRegistryOwnerEnrollmentConfirmationText
        public static RegistryCommon.RegistryOwnerEnrollmentTextDataTable FillRegistryOwnerEnrollmentConfirmationText(RegistryCommon ds,
            Int32 RegistryOwnerID,
            string RegistryOwnerLanguageCode
            )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwnerEnrollmentConfirmationText(ds,
                    RegistryOwnerID,
                    RegistryOwnerLanguageCode
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerEnrollmentText;

        }
                #endregion
        #region FillRegistryOwnerElectronicSignatureText
        public static RegistryCommon.RegistryOwnerElectronicSignatureTextDataTable FillRegistryOwnerElectronicSignatureText(RegistryCommon ds,
            Int32 RegistryOwnerID,
            string LanguageCode
            )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwnerElectronicSignatureText(ds,
                    RegistryOwnerID,
                    LanguageCode
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerElectronicSignatureText;

        }
                #endregion
        #region FillRegistryOwnerStateVerificationText
        public static RegistryCommon.RegistryOwnerStateConfigDataTable FillRegistryOwnerStateVerificationText(RegistryCommon ds,
            Int32 RegistryOwnerID,
            string RegistryOwnerStateAbbrv,
            string RegistryOwnerDMVSource
            )
        {
            //RegistryCommon ds = new RegistryCommon();
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwnerStateVerificationText(ds,
                    RegistryOwnerID,
                    RegistryOwnerStateAbbrv,
                    RegistryOwnerDMVSource
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerStateConfig;

        }
                #endregion

        #region UpdateRegistry
        public static RegistryCommon.RegistryDataTable UpdateRegistry(RegistryCommon ds 
            //Int32 LastStatEmployeeID
            )
        {
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.UpdateRegistry(ds
                    //LastStatEmployeeID
                    );
            }
            catch
            {
                throw;
            }
            return ds.Registry;

        }
        #endregion
        #region UpdateRegistryAddr
        public static RegistryCommon.RegistryAddrDataTable UpdateRegistryAddr(RegistryCommon ds
            )
        {
            try
            {
                RegistryCommonDB.UpdateRegistryAddr(ds
                );
            }
            catch
            {
                throw;
            }
            return ds.RegistryAddr;

        }
        #endregion
        #region UpdateEventRegistry
        public static RegistryCommon.EventRegistryDataTable UpdateEventRegistry(RegistryCommon ds
            //Int32 LastStatEmployeeID
            )
        {
            try
            {
                RegistryCommonDB.UpdateEventRegistry(ds
                    //LastStatEmployeeID
                    );
            }
            catch
            {
                throw;
            }
            return ds.EventRegistry;

        }
                #endregion
        #region UpdateIDologyLog
        public static RegistryCommon.IDologyLogDataTable UpdateIDologyLog(RegistryCommon ds
            //Int32 LastStatEmployeeID
            )
        {
            try
            {
                RegistryCommonDB.UpdateIDologyLog(ds
                    //LastStatEmployeeID
                    );
            }
            catch
            {
                throw;
            }
            return ds.IDologyLog;

        }
        #endregion
        #region UpdateRegistryDigitalCertificate
        public static RegistryCommon.RegistryDigitalCertificateDataTable UpdateRegistryDigitalCertificate(RegistryCommon ds
            //Int32 LastStatEmployeeID
            )
        {
            try
            {
                RegistryCommonDB.UpdateRegistryDigitalCertificate(ds
                    //LastStatEmployeeID
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryDigitalCertificate;

        }
                #endregion
        #region UpdateEventCategory
        public static RegistryCommon.EventCategoryDataTable UpdateEventCategory(RegistryCommon ds
            //Int32 LastStatEmployeeID
            )
        {
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.UpdateEventCategory(ds
                    //LastStatEmployeeID
                    );
            }
            catch
            {
                throw;
            }
            return ds.EventCategory;

        }
                #endregion
        #region UpdateEventSubCategory
        public static RegistryCommon.EventSubCategoryDataTable UpdateEventSubCategory(RegistryCommon ds
            //Int32 LastStatEmployeeID
            )
        {
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.UpdateEventSubCategory(ds
                    //LastStatEmployeeID
                    );
            }
            catch
            {
                throw;
            }
            return ds.EventSubCategory;

        }
                #endregion
        
        #region GetExistingDonor
        public static int GetExistingDonor(
            Int32 registryID,
            Int32 registryOwnerID,
            string firstName,
            string lastName,
            string lastFourSSN,
            string license,
            string DOB,

            int ReturnVal
            )
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try 
                    ReturnVal = RegistryCommonDB.GetExistingDonor(registryID, registryOwnerID, firstName, lastName, lastFourSSN, license, DOB);

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
        #region GetRegistryOwnerUserOrg
        public static int GetRegistryOwnerUserOrg(
            Int32 UserOrgID,
            int ReturnVal
            )
        {
            // get db instance
            Database db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //create transaction within using
            using (TransactionHelper tHelper = new TransactionHelper(db))
            {

                try
                {
                    tHelper.StartTransaction();
                    //try 
                    ReturnVal = RegistryCommonDB.GetRegistryOwnerUserOrg(UserOrgID);

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

        #region GetActiveStatesByOwner
        public static RegistryCommon.RegistryOwnerStateConfigDataTable GetActiveStatesByOwner(RegistryCommon ds,
            Int32 RegistryOwnerID,
            Int16 DisplayAllStates
            )
        {
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwnerStateConfig(ds,
                    RegistryOwnerID,
                    DisplayAllStates
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerStateConfig;

        }
                #endregion

        #region GetRegistryOwnerStateDMVSearchOptions
        public static RegistryCommon.RegistryOwnerStateConfigDataTable GetRegistryOwnerStateDMVSearchOptions(RegistryCommon ds,
            Int32 RegistryOwnerID
            )
        {
            try
            {
                Statline.Registry.Data.Common.RegistryCommonDB.GetRegistryOwnerStateDMVSearchOptions(ds,
                    RegistryOwnerID
                    );
            }
            catch
            {
                throw;
            }
            return ds.RegistryOwnerStateConfig;

        }
     #endregion


    }
}
