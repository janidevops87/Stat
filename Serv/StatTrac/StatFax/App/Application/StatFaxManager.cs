using Microsoft.ApplicationInsights;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.Registry.Api.Client;
using Statline.Registry.Api.Client.Http.Compatibility;
using Statline.StatTrac.Data.StatFax;
using Statline.StatTrac.Data.Types;
using System;
using System.Threading.Tasks;

namespace Statline.StatTrac.StatFax.Application
{
    public class StatFaxManager
    {
        private static readonly TelemetryClient tc = StatFaxTelemetryClient.Initialize();

        #region Create Event Log
        public static void InsertStatFaxLogEvent(StatFaxData sfData)
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
                    StatFaxDB.InsertStatFaxLogEvent(sfData);

                    //committ the application
                    tHelper.CommittTransaction();
                }
                catch(Exception ex)
                {
                    tc.TrackExceptionWithFlush(ex);
                    tHelper.RollBackTransaction();
                    throw;
                }
            }
        }
        #endregion

        #region Get StatFax Queue
        public static void GetStatFaxQueue(StatFaxData ds)
        {
            //StatFaxData ds = new StatFaxData();

            Statline.StatTrac.Data.StatFax.StatFaxDB.GetDocumentRequestQueue(ds);

            //return ds.FaxQueue;
        }

        public static void GetStatFaxQueueSingle(StatFaxData ds, string jobID)
        {
            //StatFaxData ds = new StatFaxData();

            StatFaxDB.GetDocumentRequestSingle(ds, jobID);

            //return ds.FaxQueue;
        }
        #endregion

        #region Get Registry Data
        public static async Task GetRegistryDataAsync(
            StatFaxData ds, 
            int donorDmvId, 
            int donorRegId, 
            int donorDsnId)
        {
            // For DLA source the ID is stored in both RegId and DmvId.
            // For now, use Registry API only for DLA, but should
            // eventually do this for all registry types.
            if (donorRegId == donorDmvId & donorRegId != 0)
            {
                await GetRegistryDataViaRegistryApiAsync(ds, donorDmvId, donorRegId, donorDsnId).ConfigureAwait(false);
            }
            else
            {
                Statline.StatTrac.Data.StatFax.StatFaxDB.GetRegistryData(ds, donorDmvId, donorRegId, donorDsnId);
            }
        }

        private static async Task GetRegistryDataViaRegistryApiAsync(
            StatFaxData ds, 
            int donorDmvId, 
            int donorRegId, 
            int donorDsnId)
        {
            var registryClient = HttpRegistryApiClientFactory.Instance.CreateClient();

            var donorDetails  = await registryClient.GetDlaDonorDetailsAsync(donorRegId).ConfigureAwait(false);

            ds.RegistryData.AddRegistryDataRowFromDonorDetails(donorDetails);
        }
        #endregion

        public static void UpdateFax(int faxQID, string jobID)
        {
            StatFaxDB.UpdateDocumentRequest(faxQID, jobID);
            //return ds.RegistryData;
        }

        public static void UpdateFaxDelete(string jobID)
        {
            StatFaxDB.UpdateDocumentRequestDelete(jobID);
            //return ds.RegistryData;
        }
    }
}
