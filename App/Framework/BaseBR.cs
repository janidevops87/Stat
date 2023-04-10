using System;
using System.Data;
using System.Data.Common;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Framework
{
	/// <summary>
	/// Base class for all business rules object.
	/// </summary>
	public class BaseBR
	{
		#region Protected FieldataSet
		/// <summary>
		/// The BaseDA object used transfer data between the database and the business layer
		/// </summary>
		private BaseDA baseDA;

		/// <summary>
		/// Stores all the data needed by this business object
		/// </summary>
		private DataSet dataSet;

		/// <summary>
		/// The constant values
		/// </summary>
		private static BusinessRulesConstant constant = BusinessRulesConstant.CreateInstance();
		#endregion

		#region Public Properties
		/// <summary>
		/// The dataset assosiated with the control
		/// </summary>
		public DataSet AssociatedDataSet
		{
			get { return dataSet; }
			set { dataSet = value; }
		}

		protected BaseDA AssociatedDA
		{
			get { return baseDA; }
			set { baseDA = value; }
		}

		protected static BusinessRulesConstant BRConstant
		{
			get { return constant; }
		}
		#endregion

		#region Public Method
        /// <summary>
        /// Executes a SQL Command that does not return a table. Provides a means to captue output parameter
        /// </summary>
        /// Created By: Bret Knoll
        /// Created On: 11/03/2010
        protected void ExecuteNonQuery()
        {

            try
            {
                if (baseDA != null)
                    baseDA.ExecuteNonQuery();
            }
            catch (BaseException)
            {
                /// If this is a BaseException type than we already handled it
                throw;
            }
            catch (Exception ex)
            {
                BaseLogger.LogBaseBrException(ex, dataSet);
                throw new BaseException("Error in BaseBR.ExecuteNonQuery");
            }

        }
		/// <summary>
		/// 
		/// </summary>
		/// <returns></returns>
		/// 8/5/2009 Bret
		protected DataSet Select()
		{
			try
			{
				// Call the select method
				if (baseDA != null)
					baseDA.Select(dataSet);
			}
			catch (BaseException ex)
            {
                BaseLogger.LogBaseBrException(ex, dataSet, "BaseBR.Select Try/Catch.BaseException: ");
                throw new BaseException("");
            }
			catch (Exception ex)
			{
				BaseLogger.LogBaseBrException(ex, dataSet, "BaseBR.Select Try/Catch.Exception: ");
				throw new BaseException("");
			}
			return AssociatedDataSet;
		}
		/// <summary>
		/// Selects the data from the database based on the select paramenters and retuens a dataset
		/// </summary>
		/// <returns></returns>
		protected virtual DataSet SelectDataSet(bool clearDataSet)
		{
			try
            {
                // Validates any business rules before selecting from the database
                BusinessRulesBeforeSelect();

				// clear the dataset so that it does not have any old data.
				if (clearDataSet)
					AssociatedDataSet.Clear();

				// Call the select method
				if (baseDA != null)
					baseDA.Select(dataSet);

				// Validates any business rules after selecting from the database
				BusinessRulesAfterSelect();
			}
			catch (BaseException ex)
            {
                BaseLogger.LogBaseBrException(ex, dataSet, "BaseBR.SelectDataSet Try/Catch.BaseException: ");
                throw new BaseException("");
            }
			catch (Exception ex)
			{
				BaseLogger.LogBaseBrException(ex, dataSet, "BaseBR.SelectDataSet Try/Catch.Exception: ");
				throw new BaseException("");
			}
			return AssociatedDataSet;
		}
		/// <summary>
		/// Selects the data from the database based on the select paramenters and retuens a dataset        /// 
		/// </summary>
		/// <returns></returns>
		public virtual DataSet SelectDataSet()
		{
			return SelectDataSet(true);
		}
		/// <summary>
		/// Save the Dataset and returns the latest data from the database
		/// </summary>
		public void SaveDataSet()
		{
			try
			{
				// Validates any business rules before opening the transaction. 
				// This way we don't we keep the transaction as short lived as possible
				BusinessRulesBeforeSave();
			}
			catch (BaseException)
			{
				/// If this is a BaseException type than we already handled it
				throw;
			}
			catch (Exception ex)
			{
				BaseLogger.LogBaseBrException(ex, dataSet);
				throw new BaseException("");
			}

			// Save the dataset within a transaction
			BaseDatabase database = new BaseDatabase();
			DbTransaction txn = database.BeginTransaction();
			try
			{
				Save(dataSet, txn);
				txn.Commit();
			}
			catch (BaseException)
			{
				/// If this is a BaseException type than we already handled it
				throw;
			}
			catch (Exception ex)
			{
				txn.Rollback();
				BaseLogger.LogBaseBrException(ex, dataSet);
				throw new BaseException("");
			}
			finally
			{
				BaseDatabase.CommitTransaction(txn);
			}

			try
			{
				// Validates any business rules before opening the transaction. 
				// This way we don't we keep the transaction as short lived as possible
				BusinessRulesAfterSave();
			}
			catch (BaseException)
			{
				/// If this is a BaseException type than we already handled it
				throw;
			}
			catch (Exception ex)
			{
				BaseLogger.LogBaseBrException(ex, dataSet);
				throw new BaseException("");
			}
			//8/6/09 bjk moved to below BusinessRulesAfterSave to allow for capturing IDs
			dataSet.Clear(); // Clear the dataset to remove old items

		}
		#endregion

		#region Protected Virtual MethodataSet
		/// <summary>
		/// Save the dataset with the transaction already set
		/// </summary>
		/// <param name="dataSet"></param>
		/// <param name="txn"></param>
		protected virtual void Save(DataSet saveDataSet, DbTransaction transaction)
		{
			baseDA.Save(saveDataSet, transaction);
		}

		/// <summary>
		/// Validates all business rules before selecting data from the database
		/// </summary>
		protected virtual void BusinessRulesBeforeSelect() { }

		/// <summary>
		/// Validates all business rules after selecting data from the database
		/// </summary>
		protected virtual void BusinessRulesAfterSelect() { }

		/// <summary>
		/// Validates all business rules before saving data from the database
		/// </summary>
		protected virtual void BusinessRulesBeforeSave() { }

		/// <summary>
		/// Validates all business rules after saving data from the database
		/// </summary>
		protected virtual void BusinessRulesAfterSave() { }
		#endregion
	}
}
