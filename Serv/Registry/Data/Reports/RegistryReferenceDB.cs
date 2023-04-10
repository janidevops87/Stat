using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.Registry.Data.Types.Reports;
using System.Data.Common;

namespace Statline.Registry.Data.Reports
{
    /// <summary>
    /// Summary description for RegistryReferenceDB.
    /// </summary>
    public class RegistryReferenceDB
    {
        #region Registry Outreach Events
        public static void FillRegistryOutreachEvents(
            RegistryData dataSet,
            string state
            )
        {
            string procedureName = "sps_EventCategoryLookup";
            //get db reference
            Database _db = DBCommands.GetDataBase(state);
            
            //set table to fill
            string[] dataTableList = { dataSet.EventCategory.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "EventCategoryID", DbType.Int32, null);
            _db.AddInParameter(command, "State", DbType.String, state);
            _db.AddInParameter(command, "ViewActive", DbType.Boolean, null);

            try
            {
                DBCommands.LoadDataSet(
                    _db,
                    command,
                    dataSet,
                    dataTableList,
                    procedureName);
            }
            catch
            {
                throw;         
            }
        }
        #endregion
 
        #region Registry Outreach SubEvents
        public static void FillRegistryOutreachSubEvents(
            RegistryData dataSet,
            Int32  eventCategory,
            string state
            )
        {
            string procedureName = "sps_EventSubCategoryLookup";
            //get db reference
            Database _db = DBCommands.GetDataBase(state);

            //set table to fill
            string[] dataTableList = { dataSet.EventSubCategory.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "EventSubCategoryID", DbType.Int32, null);
            _db.AddInParameter(command, "EventCategoryID", DbType.Int32, eventCategory);
            _db.AddInParameter(command, "State", DbType.String, state);
            _db.AddInParameter(command, "ViewActive", DbType.Boolean, null);

            try
            {
                DBCommands.LoadDataSet(
                    _db,
                    command,
                    dataSet,
                    dataTableList,
                    procedureName);
            }
            catch
            {
                throw;
            }

        }
                #endregion

        #region Registry ZipCodeRegion
        public static void FillZipCodeCityRegion(
            RegistryData dataSet,
            string state
            )
        {
            string procedureName = "sps_Common_GetZipCodeCityRegion";

            //get db reference
            Database _db = DBCommands.GetDataBase(DatabaseInstance.DMV_Common);

            //set table to fill
            string[] dataTableList = { dataSet.ZipCodeCityRegion.TableName };

            //build command object
            DbCommand command = _db.GetStoredProcCommand(procedureName);
            _db.AddInParameter(command, "State", DbType.String, state);

            try
            {
                DBCommands.LoadDataSet(
                    _db,
                    command,
                    dataSet,
                    dataTableList,
                    procedureName);
            }
            catch
            {
                throw;
            }
        }
        #endregion    
    }
}
