using System;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Statline.Data;
using Statline.StatTrac.Data.Types;
using System.Windows.Forms;
using System.Data.Common;


namespace Statline.StatTrac.Data 
{
	/// <summary>
	/// Summary description for Roles.
	/// </summary>
	public class AutoImportDB
	{
		#region AutoImport
		
		public static void CreateAutoImport(MessageData dataSet)
		{
			string procedureName = "sps_TestAutoImport";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

			string[] dataTableList = {dataSet.sps_TestAutoImport.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
			
			try
			{
				DBCommands.LoadDataSet(
					_db,
					command,
					dataSet,
					dataTableList,
					procedureName
					);
				//MessageBox.Show("DataSetLoaded");
			}
			catch
			{
				throw;	
			}
		}

		public static void LoadTxCenter(TransplantCenterData ds, string TransplantCode)
		{
			//string procedureName = "GetTxCenter";		//changed temp for debug
			string procedureName = "GetTransplantCenter";
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);

			string[] dataTableList = {ds.TransplantCenter.TableName};

			DbCommand command = _db.GetStoredProcCommand(procedureName);
			//_db.AddInParameter(command, "TxCode", DbType.String, TransplantCode); 
			_db.AddInParameter(command, "TransplantCenterCode", DbType.String, TransplantCode); 
			try
			{
				DBCommands.LoadDataSet(
					_db,
					command,
					ds,
					dataTableList,
					procedureName
					);
				 
				 
				 
			}
			catch
			{
				throw;	
			}
		}

		public static int UpdateCall(
			MessageData dataSet
			)
			
		{
			int rows = 0;
			//Do we need a transaction?
			/* For this dataset and table a transaction is not needed.
			 * Because the method is only updating one table it uses the EnterpriseLibraray's 
			 * functionality can utilitze one of the following update behaviors.
			 * 
			 * UpdateBehavior.Continue; 
			 * UpdateBehavior.Standard;
			 * UpdateBehavior.Transactional;		
			 */ 

			string[] procedureName = {
										 "AutoImportUpdateCall",                       
										 "UpdateCallById",
										 "DeleteCallByName"
									 };
			//get the DB reference. This will be past the the DBCommands Class
			//this does not open a connection and it allows EnterpriseLibrary to control all connections
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//SqlTransaction transaction = (SqlTransaction)_db.GetConnection().BeginTransaction();
			
			// Set the table name to be updated here
			string dataTable = dataSet.Call.TableName;

			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
            _db.AddInParameter(insertCommand, "@Name", DbType.String, "Name", DataRowVersion.Current); 
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Original);
            _db.AddInParameter(updateCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current);
			//Not used
			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "@CallID", DbType.String, "CallID", DataRowVersion.Original);
            
			try
			{
				rows = DBCommands.UpdateDataSet(
					_db,
					dataSet, 
					dataTable, 
					insertCommand, 
					updateCommand, 
					deleteCommand, 
					UpdateBehavior.Transactional);
				//MessageBox.Show("Call Updated");
	
			}
			catch
			{
				throw;
			}
			
			return rows;
		}

		public static int UpdateAutoImport(
			MessageData dataSet
			)
			
		{
			int rows = 0;
			//Do we need a transaction?
			/* For this dataset and table a transaction is not needed.
			 * Because the method is only updating one table it uses the EnterpriseLibraray's 
			 * functionality can utilitze one of the following update behaviors.
			 * 
			 * UpdateBehavior.Continue; 
			 * UpdateBehavior.Standard;
			 * UpdateBehavior.Transactional;		
			 */ 

			string[] procedureName = {
										 "InsertAutoImport",                       
										 "UpdateCallById",
										 "DeleteCallByName"
									 };
			//get the DB reference. This will be past the the DBCommands Class
			//this does not open a connection and it allows EnterpriseLibrary to control all connections
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//SqlTransaction transaction = (SqlTransaction)_db.GetConnection().BeginTransaction();
			
			// Set the table name to be updated here
			string dataTable = dataSet.sps_TestAutoImport.TableName;

			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
			_db.AddInParameter(insertCommand, "@Name", DbType.String, "Name", DataRowVersion.Current); 
			//Not Used
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Original);
			
			//Not Used
			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "@name", DbType.String, "Name", DataRowVersion.Original);

			try
			{
				rows = DBCommands.UpdateDataSet(
					_db,
					dataSet, 
					dataTable, 
					insertCommand, 
					updateCommand, 
					deleteCommand, 
					UpdateBehavior.Transactional);
	
			}
			catch
			{
				throw;
			}
			
			return rows;
		}

		public static int AutoImportInitialize(
			MessageData dataSet
			)
			 
		{	 
			int rows = 0;
			//Do we need a transaction?
			/* For this dataset and table a transaction is not needed.
			 * Because the method is only updating one table it uses the EnterpriseLibraray's 
			 * functionality can utilitze one of the following update behaviors.
			 * 
			 * UpdateBehavior.Continue; 
			 * UpdateBehavior.Standard;
			 * UpdateBehavior.Transactional;		
			 */ 

			string[] procedureName = {
										 "AutoImportInsertCall",                       
										 "UpdateCallById",
										 "DeleteCallByName"
									 };
			//get the DB reference. This will be past the the DBCommands Class
			//this does not open a connection and it allows EnterpriseLibrary to control all connections
			string dataTable = dataSet.Call.TableName;
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//SqlTransaction transaction = (SqlTransaction)_db.GetConnection().BeginTransaction();
			
			// Set the table name to be updated here
			

			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
            _db.AddOutParameter(insertCommand, "@CallID", DbType.Int32, 4);
			_db.AddInParameter(insertCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@SourceCodeID", DbType.Int32, "SourceCodeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@CallExtension", DbType.Int32, "CallExtension", DataRowVersion.Current); 
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Original);
            _db.AddInParameter(updateCommand, "@CallName", DbType.String, "CallName", DataRowVersion.Current);

			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "@name", DbType.String, "Name", DataRowVersion.Original);

			try
			{
				rows = DBCommands.UpdateDataSet(
					_db,
					dataSet, 
					dataTable, 
					insertCommand, 
					updateCommand, 
					deleteCommand, 
					UpdateBehavior.Transactional);
				//MessageBox.Show("CallCreated");
			}
				
			catch  (Exception ex)
			{
				MessageBox.Show(ex.ToString());
				throw;
			}
			
			return rows;
		}
		public static int AutoImportCreateMessage(
			MessageData dataSet
			)
			
		{
			int rows = 0;
			//Do we need a transaction?
			/* For this dataset and table a transaction is not needed.
			 * Because the method is only updating one table it uses the EnterpriseLibraray's 
			 * functionality can utilitze one of the following update behaviors.
			 * 
			 * UpdateBehavior.Continue; 
			 * UpdateBehavior.Standard;
			 * UpdateBehavior.Transactional;		
			 */ 

			string[] procedureName = {
										 "AutoImportInsertMessage",                       
										 "UpdateCallById",
										 "DeleteCallByName"
									 };
			//get the DB reference. This will be past the the DBCommands Class
			//this does not open a connection and it allows EnterpriseLibrary to control all connections
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//SqlTransaction transaction = (SqlTransaction)_db.GetConnection().BeginTransaction();
			
			// Set the table name to be updated here
			string dataTable = dataSet.Message.TableName;

			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0]);
			_db.AddInParameter(insertCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@MessageCallerOrganization", DbType.String, "MessageCallerOrganization", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@MessageDescription", DbType.String, "MessageDescription", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@MessageImportPatient", DbType.String, "MessageImportPatient", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@MessageImportUnosid", DbType.String, "MessageImportUnosid", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@MessageImportCenter", DbType.String, "MessageImportCenter", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@MessageCallerName",DbType.String,"MessageCallerName",DataRowVersion.Current); 
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Original);
            _db.AddInParameter(updateCommand, "@CallName", DbType.String, "Name", DataRowVersion.Current);

			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "@name", DbType.String, "Name", DataRowVersion.Original);

			try
			{
				rows = DBCommands.UpdateDataSet(
					_db,
					dataSet, 
					dataTable, 
					insertCommand, 
					updateCommand, 
					deleteCommand, 
					UpdateBehavior.Transactional);
				//MessageBox.Show("MessageCreated");
			}
				
			catch (Exception ex)
			{
				MessageBox.Show(ex.ToString());
				throw;
			}
			
			return rows;
		}

		public static int AutoImportCreateLogEvent(
			MessageData dataSet
			)
			
		{
			int rows = 0;
			//Do we need a transaction?
			/* For this dataset and table a transaction is not needed.
			 * Because the method is only updating one table it uses the EnterpriseLibraray's 
			 * functionality can utilitze one of the following update behaviors.
			 * 
			 * UpdateBehavior.Continue; 
			 * UpdateBehavior.Standard;
			 * UpdateBehavior.Transactional;		
			 */ 

			string[] procedureName ={ 
										"AutoImportInsertLogEvent",
										"UpdateCallById",
										"DeleteCallByName"
									};                      
										
									 
			//get the DB reference. This will be past the the DBCommands Class
			//this does not open a connection and it allows EnterpriseLibrary to control all connections
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//SqlTransaction transaction = (SqlTransaction)_db.GetConnection().BeginTransaction();
			
			// Set the table name to be updated here
			string dataTable = dataSet.LogEvent.TableName;

			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0] );
			_db.AddInParameter(insertCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventTypeID", DbType.Int32, "LogEventTypeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventName", DbType.String, "LogEventName", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventPhone", DbType.String, "LogEventPhone", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventOrg", DbType.String, "LogEventOrg", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventDesc", DbType.String, "LogEventDesc", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventDateTime", DbType.DateTime, "LogEventDateTime", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventCallbackPending", DbType.Int32, "LogEventCallbackPending", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@ScheduleGroupID", DbType.Int32, "ScheduleGroupID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@PersonID", DbType.Int32, "PersonID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@PhoneID", DbType.Int32, "PhoneID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventContactConfirmed", DbType.Int32, "LogEventContactConfirmed", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "@LogEventCalloutDateTime", DbType.DateTime, "LogEventCalloutDateTime", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventNumber", DbType.Int32, "LogEventNumber", DataRowVersion.Current); 
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Original);
            _db.AddInParameter(updateCommand, "@CallName", DbType.String, "Name", DataRowVersion.Current);

			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "@name", DbType.String, "CallName", DataRowVersion.Original);

			try
			{
				rows = DBCommands.UpdateDataSet(
					_db,
					dataSet, 
					dataTable, 
					insertCommand, 
					updateCommand, 
					deleteCommand, 
					UpdateBehavior.Transactional);
				//MessageBox.Show("LogEventCreated");
			}
				
			catch(Exception ex)
			{
				MessageBox.Show(ex.ToString());
				throw;
			}
			
			return rows;
		}

		public static int AutoImportUpdateWholeDataSet(
			MessageData dataSet
			)
			
		{
			int rows = 0;
			//Do we need a transaction?
			/* For this dataset and table a transaction is not needed.
			 * Because the method is only updating one table it uses the EnterpriseLibraray's 
			 * functionality can utilitze one of the following update behaviors.
			 * 
			 * UpdateBehavior.Continue; 
			 * UpdateBehavior.Standard;
			 * UpdateBehavior.Transactional;		
			 */ 

			string[] procedureName ={ 
										"AutoImportInsertLogEvent",
										"AutoImportInsertMessage",
										"DeleteCallByName"
									};                      
										
									 
			//get the DB reference. This will be past the the DBCommands Class
			//this does not open a connection and it allows EnterpriseLibrary to control all connections
			Database _db = DBCommands.GetDataBase(DatabaseInstance.Transaction);
			
			//SqlTransaction transaction = (SqlTransaction)_db.GetConnection().BeginTransaction();
			
			// Set the table name to be updated here
			string dataTable = dataSet.LogEvent.TableName;

			// build inser, update and delete commands
			DbCommand insertCommand = _db.GetStoredProcCommand(procedureName[0] );
			_db.AddInParameter(insertCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventTypeID", DbType.Int32, "LogEventTypeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventName", DbType.String, "LogEventName", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventPhone", DbType.String, "LogEventPhone", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventOrg", DbType.String, "LogEventOrg", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventDesc", DbType.String, "LogEventDesc", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@StatEmployeeID", DbType.Int32, "StatEmployeeID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventDateTime", DbType.DateTime, "LogEventDateTime", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventCallbackPending", DbType.Int32, "LogEventCallbackPending", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@OrganizationID", DbType.Int32, "OrganizationID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@ScheduleGroupID", DbType.Int32, "ScheduleGroupID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@PersonID", DbType.Int32, "PersonID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@PhoneID", DbType.Int32, "PhoneID", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventContactConfirmed", DbType.Int32, "LogEventContactConfirmed", DataRowVersion.Current);
			_db.AddInParameter(insertCommand, "@LogEventCalloutDateTime", DbType.DateTime, "LogEventCalloutDateTime", DataRowVersion.Current); 
			_db.AddInParameter(insertCommand, "@LogEventNumber", DbType.Int32, "LogEventNumber", DataRowVersion.Current); 
				
			DbCommand updateCommand = _db.GetStoredProcCommand(procedureName[1]);
            _db.AddInParameter(updateCommand, "@CallID", DbType.Int32, "CallID", DataRowVersion.Original);
            _db.AddInParameter(updateCommand, "@CallName", DbType.String, "Name", DataRowVersion.Current);

			DbCommand deleteCommand = _db.GetStoredProcCommand(procedureName[2]);
            _db.AddInParameter(deleteCommand, "@name", DbType.String, "CallName", DataRowVersion.Original);

			try
			{
				rows = DBCommands.UpdateDataSet(
					_db,
					dataSet, 
					dataTable, 
					insertCommand, 
					updateCommand, 
					deleteCommand, 
					UpdateBehavior.Transactional);
				//MessageBox.Show("LogEventCreated");
			}
				
			catch(Exception ex)
			{
				MessageBox.Show(ex.ToString());
				throw;
			}
			
			return rows;
		}
		#endregion

		#region userRoles
		public static void FillUserRolesList()
		{
			
		}


		#endregion
	}
}


