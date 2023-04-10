using System;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Statline.Data
{
	/// <summary>
	/// Summary description for TransactionHelper.
	/// </summary>
	public class TransactionHelper : IDisposable
	{
		private IDbConnection dbConnection;
		private IDbTransaction dbTransaction;
		private Database db;

		public TransactionHelper(Database DB)
		{
			db = DB;
		}

		#region Transaction Management
		public IDbTransaction DbTransaction
		{
			get { return dbTransaction; }
			set { dbTransaction = value; }
		}
		public void StartTransaction()
		{
            dbConnection = db.CreateConnection();
			dbConnection.Open();
			dbTransaction = dbConnection.BeginTransaction();
			
		}
		public void RollBackTransaction()
		{
			dbTransaction.Rollback();
			dbConnection.Close();
		}
		public void CommittTransaction()
		{
			dbTransaction.Commit();
			dbConnection.Close();
		}
		#endregion

		#region IDisposable Members

		

		public void Dispose()
		{
			if(dbTransaction!=null)
				dbTransaction.Dispose();

			if(dbConnection !=null)
				dbConnection.Close();
            if(dbConnection != null)
				dbConnection.Dispose();
		}

		#endregion
	}
}
