using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.BusinessRules.Framework
{
    public class TranslateDBConnection : ITranslateDBConnection
    {
        private static TranslateDBConnection translateDBConnection;
        protected TranslateDBConnection()
        { }
        public static TranslateDBConnection CreateInstance()
        {
            if (translateDBConnection == null)
                translateDBConnection = new TranslateDBConnection();
            return translateDBConnection;
            
        }
        /// <summary>
        /// Convert databaseInstance to DatabaseInstance Enum
        /// </summary>
        /// <param name="databaseInstance"></param>
        /// <returns></returns>
        public Statline.Stattrac.Constant.ConnectionType GetHistoricalDBConnection(string databaseInstance)
        {
            DatabaseInstance databaseInstanceEnum;
            databaseInstanceEnum = (DatabaseInstance)Enum.Parse(typeof(DatabaseInstance), databaseInstance);

            return GetHistoricalDBConnection(databaseInstanceEnum);
        }

        #region ITranslateDBConnection Members
        public Statline.Stattrac.Constant.ConnectionType GetHistoricalDBConnection(DatabaseInstance databaseInstance)
        {
            ConnectionType connectionType = ConnectionType.TEST_CONN;
            switch (databaseInstance)
            {
                case DatabaseInstance.Production:
                    connectionType =  ConnectionType.PROD_CONN;
                    break;
                case DatabaseInstance.Test:
                    connectionType = ConnectionType.TEST_CONN;
                    break;
                case DatabaseInstance.Training:
                    connectionType = ConnectionType.TRAINING_CONN;
                    break;
                case DatabaseInstance.ProductionArchive:
                    connectionType = ConnectionType.ARCHIVE;
                    break;
                case DatabaseInstance.Development:
                    connectionType = ConnectionType.DEVELOPMENT;
                    break;
                case DatabaseInstance.Backup:
                    connectionType = ConnectionType.PROD_BKUP_CONN;
                    break;
            }
            return connectionType;

        }


        #endregion
    }
}
