using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Security;
using System.Text;
using System.Xml;

namespace Statline.Framework
{
	public abstract class BaseModel
	{
		#region Fields/Properties
		/// <summary>
		/// Used to lock the object while getting the data from the database
		/// </summary>
		private object lockObject = new object();

		/// <summary>
		/// Define the table schema name, table name and the associated CUD sproc names
		/// This is initilized in the concrete class
		/// </summary>
		protected abstract TableMetaData TableMetaDataItem { get; }

		/// <summary>
		/// Define the properties of each field
		/// This is initilized in the concrete class
		/// </summary>
		public virtual OrderedDictionary FieldMetaDataList { get; protected set; }

		/// <summary>
		/// The data for the object. 
		/// I do not think this need to be an “ordered” since data in this is not guaranteed to exist. 
		/// For example if the model as first name, last name, and age; the user may not enter the first name. In this case the first item will be the last name. 
		/// </summary>
		public Hashtable ObjectData { get; private set; }

		/// <summary>
		/// The transaction that needs to be performed in the database for this object
		/// </summary>
		public TransactionType ObjectTransactionType { get; set; }

		public string SchemaName { get { return TableMetaDataItem.SchemaName; } }
		public string TableName { get { return TableMetaDataItem.TableName; } }
		#endregion

		#region Constructor
		protected BaseModel(string transformKey)
		{
			ObjectData = new Hashtable(); // Initilize the hashtable to hold the data
			ObjectTransactionType = TransactionType.None; // Initilize the object as not needing to perform any changes to the database
			try
			{
				lock (lockObject)
				{
					if (FieldMetaDataList == null || FieldMetaDataList.Count == 0)
					{
						// if the count is 0 then we need to set it to null so the child class re-poplates it.
						// This may be a fix for when the key disappers
						FieldMetaDataList = null;
						InitilizeInstance(); // Call the implenmented method to initilize the object
					}
				}
			}
			catch (Exception ex)
			{
				BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[transformKey]).Write(ex);
				FieldMetaDataList = null; // If there is an error before FieldMetaDataList populates all the field then we want to make sure it gets another chance to populate the data
			}
		}
		#endregion

		#region Methods Public
		public string ToXml()
		{
			StringBuilder sb = new StringBuilder("<" + TableMetaDataItem.SchemaName + "." + TableMetaDataItem.TableName + " ");
			foreach (DictionaryEntry item in FieldMetaDataList)
			{
				if ((ObjectData[item.Key] != null)
					&& !(ObjectData[item.Key] is DBNull))
					sb.Append(item.Key + "='" + SecurityElement.Escape(ObjectData[item.Key].ToString()) + "' ");
			}
			sb.Append("/>");
			return sb.ToString();
		}

		public IList FromXmlList(string xml)
		{
			IList list = this.CreateList();
			XmlDocument xmlDocument = new XmlDocument();
			xmlDocument.LoadXml(xml);
			XmlNodeList xmlNodeList = xmlDocument.SelectNodes("//" + TableMetaDataItem.SchemaName + "." + TableMetaDataItem.TableName);

			for (int index = 0; index < xmlNodeList.Count; index++)
			{
				XmlNode xmlNode = xmlNodeList[index];
				if (xmlNode.Attributes.Count > 1)
				{
					BaseModel baseModel = this.Clone();
					for (int attIndex = 0; attIndex < xmlNode.Attributes.Count; attIndex++)
					{
						string key = xmlNode.Attributes[attIndex].Name;
						object data = xmlNode.Attributes[attIndex].Value;
						// We need to explicitly convert the the guid, this is needed for synch
						if (((BaseFieldMetaData)baseModel.FieldMetaDataList[key]).DbType == SqlDbType.UniqueIdentifier)
							baseModel.ObjectData[key] = Guid.Parse(data.ToString());
						else
							baseModel.ObjectData[key] = data;

					}
					list.Add(baseModel);
				}
			}
			return list;
		}

#if DEBUG // This section is only needed for unit testing
		public override string ToString()
		{
			StringBuilder sb = new StringBuilder();
			foreach (DictionaryEntry item in FieldMetaDataList)
			{
				if (ObjectData[item.Key] != null)
					sb.Append(item.Key + ":" + ObjectData[item.Key].ToString() + "\n");
			}

			return sb.ToString();
		}

		/// <summary>
		/// We need to implement this method in order to run automated test
		/// </summary>
		/// <param name="obj"></param>
		/// <returns></returns>
		public override bool Equals(object obj)
		{
			if (obj == null) // If the object is null then it cannot be equal to the calling object
				return false;

			if (obj.GetType() != this.GetType()) // If the Object is not of the same type than it cannot be equal
				return false;

			BaseModel baseModelObj = (BaseModel)obj;
			StringBuilder errMessage = new StringBuilder();

			foreach (DictionaryEntry item in FieldMetaDataList)
			{
				string itemKey = (string)item.Key;
				// Ignore the logic if the deriverd class asks us to ignore it
				if (IsEqual(baseModelObj, itemKey))
				{
					continue;
				}

				// Ignore if both are null or DBNull
				if ((this.ObjectData[itemKey] == null || this.ObjectData[itemKey] == DBNull.Value) && (baseModelObj.ObjectData[itemKey] == null || baseModelObj.ObjectData[itemKey] == DBNull.Value))
				{
					continue;
				}
				// Error if only one is null or DBNull
				if ((this.ObjectData[itemKey] != null && this.ObjectData[itemKey] != DBNull.Value) && (baseModelObj.ObjectData[itemKey] == null || baseModelObj.ObjectData[itemKey] == DBNull.Value))
				{
					errMessage.AppendFormat("Not Equal: {0}\n Expected: {1}\n Actual: null\n", itemKey, this.ObjectData[itemKey]);
					continue;
				}
				// Error if only one is null or DBNull
				if ((this.ObjectData[itemKey] == null || this.ObjectData[itemKey] == DBNull.Value) && (baseModelObj.ObjectData[itemKey] != null && baseModelObj.ObjectData[itemKey] != DBNull.Value))
				{
					errMessage.AppendFormat("Not Equal: {0}\n Expected: null\n Actual: {1}\n", itemKey, baseModelObj.ObjectData[itemKey]);
					continue;
				}
				
				// For a datetime only compare the minutes
				if (((BaseFieldMetaData)item.Value).DbType == SqlDbType.DateTime)
				{
					double thisTotalSeconds = Math.Floor(((DateTime)this.ObjectData[itemKey]).TimeOfDay.TotalSeconds);
					double objTotalSeconds = Math.Floor(((DateTime)baseModelObj.ObjectData[itemKey]).TimeOfDay.TotalSeconds);
					if (Math.Abs(thisTotalSeconds - objTotalSeconds) > 1) // We can ignore differences in time up to one second
					{
						errMessage.AppendFormat("Not Equal: {0}\n Expected: {1}\n Actual: {2}\n", itemKey, this.ObjectData[itemKey], baseModelObj.ObjectData[itemKey]);
						continue;
					}
				}
				else if (!this.ObjectData[itemKey].Equals(baseModelObj.ObjectData[itemKey])) // If any of the values are not the same than it cannot be equal
				{
					errMessage.AppendFormat("Not Equal: {0}\n Expected: {1}\n Actual: {2}\n", itemKey, this.ObjectData[itemKey], baseModelObj.ObjectData[itemKey]);
					continue;
				}
			}
			if (errMessage.Length > 0)
			{
				//throw new Exception(errMessage.ToString());
				Console.WriteLine(errMessage.ToString());
				return false;
			}
			else{
			return true;
			}
		}

		/// <summary>
		/// Allow Base Object to have a final say in comparing object
		/// </summary>
		/// <param name="baseModelObj"></param>
		/// <param name="key"></param>
		/// <returns></returns>
		protected virtual bool IsEqual(BaseModel baseModelObj, string key)
		{
			return false;
		}

		public override int GetHashCode()
		{
			return base.GetHashCode();
		}
#endif
		#endregion

		#region Methods Protected Abstract
		/// <summary>
		/// Returns a shallow copy of the object
		/// </summary>
		protected abstract BaseModel Clone();

		/// <summary>
		/// Returns a strongly typed empty list
		/// </summary>
		protected abstract IList CreateList();

		/// <summary>
		/// Sets all the properties for the class
		/// </summary>
		protected abstract void InitilizeInstance();
		#endregion

		#region Methods Protected
		/// <summary>Define the table schema name, table name and the associated CUD sproc names</summary>
		/// <param name="schemaName">The table's schema name</param>
		/// <param name="tableName">The table name</param>
		/// <param name="insertSproc">The Insert Sproc name</param>
		/// <param name="updateSproc">The Update Sproc name</param>
		/// <param name="deleteSproc">The Delete Sproc name</param>
		protected TableMetaData CreateTableMetaData(string schemaName, string tableName, string insertSproc, string updateSproc, string deleteSproc)
		{
			return TableMetaData.CreateInstance(schemaName, tableName, insertSproc, updateSproc, deleteSproc);
		}
		#endregion

		#region Methods Get
		/// <summary>
		/// Get an int data
		/// </summary>
		protected int? GetInt(string name)
		{
			return (int?)ObjectData[name];
		}

		/// <summary>
		/// Get an int data
		/// </summary>
		protected long? GetBigInt(string name)
		{
			return (long?)ObjectData[name];
		}

		/// <summary>
		/// Get a decimal data
		/// </summary>
		protected decimal? GetDecimal(string name)
		{
			return (decimal?)ObjectData[name];
		}

		/// <summary>
		/// Get a datetime data
		/// </summary>
		protected DateTime? GetDateTime(string name)
		{
			return (DateTime?)ObjectData[name];
		}

		/// <summary>
		/// Get a string data
		/// </summary>
		protected string GetString(string name)
		{
			if (ObjectData[name] == DBNull.Value)
				return "";
			else
				return (string)ObjectData[name];
		}

		/// <summary>
		/// Get a guid data
		/// </summary>
		protected Guid? GetGuid(string name)
		{
			return (Guid?)ObjectData[name];
		}
		#endregion

		#region Methods Set
		/// <summary>
		/// Set an int data
		/// </summary>
		public void SetInt(string name, string value)
		{
			if (!string.IsNullOrEmpty(value))
			{
				try
				{
					ObjectData[name] = int.Parse(value.Trim());
				}
				catch (FormatException)
				{
					throw new Exception(((BaseFieldMetaData)FieldMetaDataList[name]).Name + " contains an invalid integer: " + value);
				}
			}
		}

		/// <summary>
		/// Set an int data
		/// </summary>
		public void SetBigInt(string name, string value)
		{
			if (!string.IsNullOrEmpty(value))
			{
				try
				{
					ObjectData[name] = long.Parse(value.Trim());
				}
				catch (FormatException)
				{
					throw new Exception(((BaseFieldMetaData)FieldMetaDataList[name]).Name + " contains an invalid integer: " + value);
				}
			}
		}

		/// <summary>
		/// Set a decimal data
		/// </summary>
		public void SetDecimal(string name, string value)
		{
			if (!string.IsNullOrEmpty(value))
			{
				try
				{
					ObjectData[name] = decimal.Parse(value);
				}
				catch (FormatException)
				{
					throw new Exception(((BaseFieldMetaData)FieldMetaDataList[name]).Name + " contains an invalid decimal: " + value);
				}
			}
		}

		/// <summary>
		/// Set a datetime data
		/// </summary>
		public void SetDateTime(string name, string value)
		{
			if (!string.IsNullOrEmpty(value))
			{
				try
				{
					DateTime dateTime = DateTime.Parse(value);
					if (dateTime < new DateTime(1753, 1, 1))
					{
						throw new Exception(((BaseFieldMetaData)FieldMetaDataList[name]).DisplayName + " cannot be older than 01/01/1753");
					}
					ObjectData[name] = value;
				}
				catch (FormatException)
				{
					throw new Exception(((BaseFieldMetaData)FieldMetaDataList[name]).DisplayName + " contains an invalid Date Time: " + value);
				}
			}
		}

		/// <summary>
		/// Set a string data
		/// </summary>
		public void SetString(string name, string value)
		{
			// Treat both null and empty string as a null value
			if (!string.IsNullOrWhiteSpace(value))
			{
				if (value.Length > ((BaseFieldMetaData)FieldMetaDataList[name]).Length)
				{
					throw new Exception(((BaseFieldMetaData)FieldMetaDataList[name]).DisplayName + " cannot exceed "
						+ ((BaseFieldMetaData)FieldMetaDataList[name]).Length);
				}
				ObjectData[name] = value.Trim();
			}
		}

		public void SetNText(string name, string value)
		{
			// Treat both null and empty string as a null value
			if (!string.IsNullOrWhiteSpace(value))
			{
				ObjectData[name] = value.Trim();
			}
		}

		/// <summary>
		/// Set a guid data
		/// </summary>
		public void SetGuid(string name, string value)
		{
			if (!string.IsNullOrEmpty(value))
			{
				try
				{
					ObjectData[name] = new Guid(value);
				}
				catch (FormatException)
				{
					throw new Exception(((BaseFieldMetaData)FieldMetaDataList[name]).Name + " contains an invalid Guid: " + value);
				}
			}
		}
		#endregion

		#region Methods Database Transaction
		/// <summary>
		/// Returns a single object from the database
		/// </summary>
		protected BaseModel SelectSingleItem(BaseDbCommand command, string transformKey)
		{
			BaseModel returnValue = Clone(); // creates a clone of the object
			BaseDbDataReader reader = null;
			try
			{
				reader = command.ExecuteReader(); // Execute the reader
				if (reader.Read()) // Make sure there is data returned from the database
				{
					foreach (DictionaryEntry item in FieldMetaDataList)
					{
						try
						{
							returnValue.ObjectData[item.Key] = reader.DbDataReader[((BaseFieldMetaData)item.Value).Name]; // load the data into the object
						}
						catch (Exception ex)
						{
							throw new BaseException(returnValue.SchemaName + "." + returnValue.TableName +
								" contains invalid key: " + item.Key, ex);
						}
					}
				}
			}
			catch (Exception ex)
			{
				BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[transformKey]).Write(ex);
				throw new DatabaseException(ex, command);
			}
			finally
			{
				if (reader != null)
				{
					reader.Close(); // close the reader
				}
				if (command != null)
				{
					command.Close(); // Close the command
				}
			}
			return returnValue; // return the object
		}

		/// <summary>
		/// Returns a list of objects from the database
		/// </summary>
		protected IList SelectList(BaseDbCommand command, string transformKey)
		{
			IList list = CreateList(); // Create the list that we will return from this method
			BaseDbDataReader reader = null;
			try
			{
				reader = command.ExecuteReader(); // Execute the reader
				while (reader.Read()) // Make sure there is data returned from the database
				{
					BaseModel newDO = Clone(); // creates a clone of the object
					for (int index = 0; index < reader.DbDataReader.FieldCount; index++)
					{
						newDO.ObjectData[reader.DbDataReader.GetName(index)] = reader.DbDataReader[index]; // load the data into the object
					}
					list.Add(newDO); // Add the object into the list
				}
			}
			catch (Exception ex)
			{
				BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[transformKey]).Write(ex);
				throw new DatabaseException(ex, command);
			}
			finally
			{
				if (reader != null)
				{
					reader.Close(); // close the reader
				}
				if (command != null)
				{
					command.Close(); // Close the command
				}
			}
			return list; // return the list
		}

		/// <summary>
		/// Returns a list of objects from the database
		/// </summary>
		protected IList SelectPagedList(BaseDbCommand command, ref int totalRows, int pageNum, int pageSize, string transformKey)
		{
			IList list = CreateList(); // Create the list that we will return from this method
			command.AddInputParameter("PageNum", DbType.Int32, pageNum);
			command.AddInputParameter("PageSize", DbType.Int32, pageSize);

			BaseDbDataReader reader = null;
			try
			{
				reader = command.ExecuteReader(); // Execute the reader
				if (reader.Read()) // Make sure there is data returned from the database
				{
					totalRows = (int)reader.DbDataReader["TotalRows"]; // Get the number of Rows for teh
				}

				reader.DbDataReader.NextResult(); // Get next resultset

				while (reader.Read()) // Make sure there is data returned from the database
				{
					BaseModel newDO = Clone(); // creates a clone of the object
					foreach (DictionaryEntry item in FieldMetaDataList)
					{
						newDO.ObjectData[item.Key] = reader.DbDataReader[((BaseFieldMetaData)item.Value).Name]; // load the data into the object
					}
					list.Add(newDO); // Add the object into the list
				}
			}
			catch (Exception ex)
			{
				BaseLogger.CreateInstance(BaseIdentity.ApplicationSecrets[transformKey]).Write(ex);
				throw new DatabaseException(ex, command);
			}
			finally
			{
				if (reader != null)
				{
					reader.Close(); // close the reader
				}
				if (command != null)
				{
					command.Close(); // Close the command
				}
			}
			return list; // return the list
		}

		/// <summary>
		/// Save the object to the database
		/// </summary>
		public void Save()
		{
			BaseDbCommand command = null;
			switch (ObjectTransactionType)
			{
				case TransactionType.Add:
					command = BaseDbCommand.CreateInstance(TableMetaDataItem.SchemaName + "." + TableMetaDataItem.InsertSproc); // Create the command 
					AddParametersForInsert(command); // Add parameters for the sproc
					break;
				case TransactionType.Update:
					command = BaseDbCommand.CreateInstance(TableMetaDataItem.SchemaName + "." + TableMetaDataItem.UpdateSproc); // Create the command 
					AddParametersForUpdate(command); // Add parameters for the sproc
					break;
				case TransactionType.Delete:
					command = BaseDbCommand.CreateInstance(TableMetaDataItem.SchemaName + "." + TableMetaDataItem.DeleteSproc); // Create the command 
					AddParametersForDelete(command); // Add parameters for the sproc
					break;
				case TransactionType.None:
				default:
					return; // If iit does not need to update chnges to the database than return
			}

			try
			{
				ValidateBusinessRules();
			}
			catch (Exception ex)
			{
				throw new BaseException(ex.Message);
			}

			try
			{
				command.DbCommand.Connection.Open();
				command.DbCommand.ExecuteNonQuery(); // Execute the query
				GetParametersAfterSave(command);
			}
			catch (Exception ex)
			{
				SaveException(ex, command);
			}
			finally
			{
				if (command != null)
				{
					command.Close(); // Close the command
				}
			}
		}
		protected virtual void GetParametersAfterSave(BaseDbCommand command)
		{

		}
		/// <summary>
		/// Add parameter for the Insert Sproc
		/// </summary>
		protected virtual void AddParametersForInsert(BaseDbCommand command)
		{
			AddParametersForInsertUpdate(command);
		}

		/// <summary>
		/// Add parameter for the Update Sproc
		/// </summary>
		protected virtual void AddParametersForUpdate(BaseDbCommand command)
		{
			AddParametersForInsertUpdate(command);
		}

		/// <summary>
		/// Add parameter for the Insert and Update Sproc
		/// </summary>
		protected virtual void AddParametersForInsertUpdate(BaseDbCommand command)
		{
			foreach (DictionaryEntry item in FieldMetaDataList)
			{
				if (ObjectData[item.Key] != null)
				{
					command.AddInputParameter((BaseFieldMetaData)item.Value, ObjectData[item.Key]);
				}
			}
		}

		/// <summary>
		/// Add parameter for the Delete Sproc
		/// </summary>
		protected virtual void AddParametersForDelete(BaseDbCommand command)
		{
			string primaryKey = TableMetaDataItem.TableName + "Id";
			BaseFieldMetaData baseFieldMetaData = (BaseFieldMetaData)FieldMetaDataList[primaryKey]; // Assumes the first item is the primary key with which to delete
			command.AddInputParameter(baseFieldMetaData, ObjectData[primaryKey]);
		}

		protected virtual void SaveException(Exception ex, BaseDbCommand command)
		{
			if (ex is SqlException &&
				((System.Data.SqlClient.SqlException)ex).Class == 16)
			{
				// 16 Indicates general errors that can be corrected by the user.
				// If the developer needs to send some information to the user
				// They should return an error with with level. For exmlae with this on the sql
				// See "OrganEyeOrgan.SerologyInsertUpdate" as an example
				// 		RAISERROR('ERROR MESSAGE', 16, 1); 
				//		RETURN -1
				throw new BaseException(ex.Message);
			}

			throw new DatabaseException(ex, command);
		}

		protected virtual void ValidateBusinessRules()
		{

		}
		#endregion
	}
}
