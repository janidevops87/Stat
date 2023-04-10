using System;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using System.Data.Common;

namespace Statline.Stattrac.Framework
{
	/// <summary>
	/// Manages the connection, transaction to the database
	/// </summary>
	internal class BaseDatabase
	{
		#region Private Fields
		/// <summary>
		/// Enterprise libraay control
		/// </summary>
		private Database database; 
		#endregion

		#region Internal Constructor
        internal BaseDatabase()
        {
            try
            {
                database = DatabaseFactory.CreateDatabase(BaseIdentity.CurrentIdentity.DatabaseInstance);
            }
            catch (Exception ex) { 
                
            }
        }
		#endregion

		#region Internal Methods
		/// <summary>
		/// Gets the Command Wrapper
		/// </summary>
		/// <param name="storedProcedureName"></param>
		/// <returns></returns>
		internal BaseCommand GetStoredProcCommandWrapper(string storedProcedureName)
		{
			return new BaseCommand(database, database.GetStoredProcCommand(storedProcedureName));
		}
		
		/// <summary>
		/// Load the values from the database into the dataset 
		/// </summary>
		/// <param name="thiscommand"></param>
		/// <param name="dataSet"></param>
		/// <param name="tableName"></param>
		internal void LoadDataSet(BaseCommand thiscommand, DataSet dataSet, string[] tableName)
		{
			database.LoadDataSet(thiscommand.command, dataSet, tableName);
            
		}
        /// <summary>
        /// Executes a SQL Command that does not return a table. Provides a means to captue output parameter
        /// </summary>
        /// <param name="thisCommand"></param>
        /// <returns></returns>
        /// Created By: Bret Knoll
        /// Created On: 11/03/2010
        internal void ExecuteNonQuery(BaseCommand baseCommand)
        {
            database.ExecuteNonQuery(baseCommand.command);
        }
		/// <summary>
		/// Save the values from the dataset into the database
		/// </summary>
		/// <param name="dataSet"></param>
		/// <param name="tableName"></param>
		/// <param name="insertCommand"></param>
		/// <param name="updateCommand"></param>
		/// <param name="deleteCommand"></param>
		/// <param name="transaction"></param>
		internal void UpdateDataSet(DataSet dataSet, string tableName,
			BaseCommand insertCommand, BaseCommand updateCommand, BaseCommand deleteCommand, DbTransaction transaction)
		{
			database.UpdateDataSet(dataSet, tableName, insertCommand.command, updateCommand.command, deleteCommand.command, transaction);
		}

		/// <summary>
		/// Begins a transaction
		/// </summary>
		/// <returns></returns>
		internal DbTransaction BeginTransaction()
		{
			DbConnection connection = database.CreateConnection();
			connection.Open();
			return connection.BeginTransaction(IsolationLevel.ReadUncommitted);
		}

		/// <summary>
		/// Commits the transaction
		/// </summary>
		/// <param name="txn"></param>
		internal static void CommitTransaction(IDbTransaction txn)
		{
			// We Need check for the Transaction and Connection since it is possible that the database may close it
			// and throw an exception when we try to access it.
			if (txn != null)
			{
				if (txn.Connection != null)
				{
					txn.Connection.Close();
				}
				// for some reason the need to check for connection again otherwise getting null object
				if (txn.Connection != null)
				{
					txn.Connection.Dispose();
				}
				txn.Dispose();
			}
		}
		#endregion
	}
}
