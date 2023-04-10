using System;
using Statline.Registry.Data.Reports;
using Statline.Registry.Data.Types.Reports;
using System.Security;

[assembly: AllowPartiallyTrustedCallers]

namespace Statline.Registry.Reports
{
    public class RegistryReferenceManager
    {
        #region Fill Registry Outreach Events
        public static void FillRegistryOutreachList(
            RegistryData ds,
            String state)
        {
            try
            {
                RegistryReferenceDB.FillRegistryOutreachEvents(
                ds,
                state);
            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region Fill Registry Outreach Sub Events
        public static void FillRegistryOutreachSubList(
            RegistryData ds,
            Int32 eventCategory,
            String state)
        {
            RegistryReferenceDB.FillRegistryOutreachSubEvents(
                ds,
                eventCategory,
                state);
        }
        #endregion

        #region Fill Registry ZipCodeCityRegion
        public static void FillRegistryZipCodeCityRegion(
            RegistryData ds,
            String state)
        {
            try
            {
                string[] stateList = state.Split(new Char[] { ',' });
                for (int loopCount = 0; stateList.Length > loopCount; loopCount++)
                {
                    RegistryReferenceDB.FillZipCodeCityRegion(
                    ds,
                    stateList[loopCount]);
                }
            }
            catch
            {
                throw;
            }
        }

        public static  RegistryData.ZipCodeCityRegionDataTable FillRegistryZipCodeCityRegion(
            String state)
        {
            RegistryData ds = new RegistryData();
            if(state == null || state.Length < 1)
                return ds.ZipCodeCityRegion;
            try
            {
                string[] stateList = state.Split(new Char[]{','});
                for (int loopCount = 0; stateList.Length > loopCount; loopCount++)
                {
                    RegistryReferenceDB.FillZipCodeCityRegion(
                    ds,
                    stateList[loopCount]);
                }
            }
            catch
            {
                throw;
            }
            return ds.ZipCodeCityRegion;
        }

        #endregion

        public static void FillRegistryZipCodeCityRegion()
        {
            throw new Exception("The method or operation is not implemented.");
        }
    }
}
