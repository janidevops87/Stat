using System;
using System.Data;
using System.Xml;
using System.Data.SqlClient;
using System.Collections;

namespace Statline.Data
{
	/// <summary>
	/// The SqlUtil class is intended to encapsulate high performance, scalable
	/// best practices for common uses of SqlClient.
	/// </summary>
	public sealed class SqlUtility
	{
		#region private utility methods & constructors

		//Since this class provides only static methods, make the default constructor private to prevent 
		//instances from being created with "new SqlUtil()".
		private SqlUtility() {}

		/// <summary>
		/// This method is used to attach array of SqlParameters to a SqlCommand.
		/// 
		/// This method will assign a value of DbNull to any parameter with a direction of
		/// InputOutput and a value of null.  
		/// 
		/// This behavior will prevent default values from being used, but
		/// this will be the less common case than an intended pure output parameter (derived as InputOutput)
		/// where the user provided no input value.
		/// </summary>
		/// <param name="command">The command to which the parameters will be added</param>
		/// <param name="commandParameters">an array of SqlParameters tho be added to command</param>
		private static void AttachParameters(SqlCommand command, SqlParameter[] commandParameters)
		{
			foreach (SqlParameter p in commandParameters)
			{
				//check for derived output value with no value assigned
				if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
				{
					p.Value = DBNull.Value;
				}
				
				command.Parameters.Add(p);
			}
		}

		/// <summary>
		/// This method assigns an array of values to an array of SqlParameters.
		/// </summary>
		/// <param name="commandParameters">array of SqlParameters to be assigned values</param>
		/// <param name="parameterValues">array of objects holding the values to be assigned</param>
		private static void AssignParameterValues(SqlParameter[] commandParameters, object[] parameterValues)
		{
			if ((commandParameters == null) || (parameterValues == null)) 
			{
				//do nothing if we get no data
				return;
			}

			// we must have the same number of values as we pave parameters to put them in
			if (commandParameters.Length != parameterValues.Length)
			{
				throw new ArgumentException("Parameter count does not match Parameter Value count.");
			}

			//iterate through the SqlParameters, assigning the values from the corresponding position in the 
			//value array
			for (int i = 0, j = commandParameters.Length; i < j; i++)
			{
				commandParameters[i].Value = parameterValues[i];
			}
		}

		/// <summary>
		/// This method opens (if necessary) and assigns a connection, transaction, command type and parameters 
		/// to the provided command.
		/// </summary>
		/// <param name="command">the SqlCommand to be prepared</param>
		/// <param name="connection">a valid SqlConnection, on which to execute this command</param>
		/// <param name="transaction">a valid SqlTransaction, or 'null'</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParameters to be associated with the command or 'null' if no parameters are required</param>
		private static void PrepareCommand(SqlCommand command, SqlConnection connection, SqlTransaction transaction, CommandType commandType, string commandText, SqlParameter[] commandParameters)
		{
			//if the provided connection is not open, we will open it
			if (connection.State != ConnectionState.Open)
			{
				connection.Open();
			}

			//associate the connection with the command
			command.Connection = connection;

			//set the command text (stored procedure name or SQL statement)
			command.CommandText = commandText;

			//if we were provided a transaction, assign it.
			if (transaction != null)
			{
				command.Transaction = transaction;
			}

			//set the command type
			command.CommandType = commandType;

			//attach the command parameters if they are provided
			if (commandParameters != null)
			{
				AttachParameters(command, commandParameters);
			}

			return;
		}


		#endregion private utility methods & constructors

		#region ExecuteNonQuery

		/// <summary>
		/// Execute a SqlCommand (that returns no resultset and takes no parameters) against the database specified in 
		/// the connection string. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int result = ExecuteNonQuery(connString, CommandType.StoredProcedure, "PublishOrders");
		/// </remarks>
		/// <param name="connectionString">a valid connection string for a SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>an int representing the number of rows affected by the command</returns>
		public static int ExecuteNonQuery(string connectionString, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteNonQuery(connectionString, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns no resultset) against the database specified in the connection string 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int result = ExecuteNonQuery(connString, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="connectionString">a valid connection string for a SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>an int representing the number of rows affected by the command</returns>
		public static int ExecuteNonQuery(string connectionString, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create & open a SqlConnection, and dispose of it after we are done.
			using (SqlConnection cn = new SqlConnection(connectionString))
			{
				cn.Open();

				//call the overload that takes a connection in place of the connection string
				return ExecuteNonQuery(cn, commandType, commandText, commandParameters);
			}
		}

		/// <summary>
		/// Execute a SqlCommand (that returns no resultset and takes no parameters) against the provided SqlConnection. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int result = ExecuteNonQuery(conn, CommandType.StoredProcedure, "PublishOrders");
		/// </remarks>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>an int representing the number of rows affected by the command</returns>
		public static int ExecuteNonQuery(SqlConnection connection, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteNonQuery(connection, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns no resultset) against the specified SqlConnection 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int result = ExecuteNonQuery(conn, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>an int representing the number of rows affected by the command</returns>
		public static int ExecuteNonQuery(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{	
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);
			
			//finally, execute the command.
			int retval = cmd.ExecuteNonQuery();
			
			// detach the SqlParameters from the command object, so they can be used again.
			cmd.Parameters.Clear();
			return retval;
		}

		/// <summary>
		/// Execute a SqlCommand (that returns no resultset and takes no parameters) against the provided SqlTransaction. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int result = ExecuteNonQuery(trans, CommandType.StoredProcedure, "PublishOrders");
		/// </remarks>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>an int representing the number of rows affected by the command</returns>
		public static int ExecuteNonQuery(SqlTransaction transaction, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteNonQuery(transaction, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns no resultset) against the specified SqlTransaction
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int result = ExecuteNonQuery(trans, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>an int representing the number of rows affected by the command</returns>
		public static int ExecuteNonQuery(SqlTransaction transaction, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, transaction.Connection, transaction, commandType, commandText, commandParameters);
			
			//finally, execute the command.
			int retval = cmd.ExecuteNonQuery();
			
			// detach the SqlParameters from the command object, so they can be used again.
			cmd.Parameters.Clear();
			return retval;
		}

		#endregion ExecuteNonQuery

		#region FillDataTable

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset and takes no parameters) against the database specified in 
		/// the connection string. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  DataTable table = new DataTable( );
		///  FillDataTable(table, connString, CommandType.StoredProcedure, "GetOrders");
		/// </remarks>
		/// <param name="dataTable">the DataTable to fill with the resultset generated by the command</param>
		/// <param name="connectionString">a valid connection string for a SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>
		/// The number of rows successfully added to or refreshed in the DataTable. 
		/// </returns>
		public static int FillDataTable( DataTable dataTable, string connectionString, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			int rows =
				FillDataTable(dataTable, connectionString, commandType,
				commandText, (SqlParameter[])null);

			return rows;
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset) against the database specified in the connection string 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  DataTable dataTable = new DataTable( );
		///  FillDataTable(dataTable, connString, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="dataTable">the DataTable to fill with the resultset generated by the command</param>
		/// <param name="connectionString">a valid connection string for a SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>
		/// The number of rows successfully added to or refreshed in the DataTable. 
		/// </returns>
		public static int FillDataTable(DataTable dataTable, string connectionString, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			int rows = 0;

			//create & open a SqlConnection, and dispose of it after we are done.
			using (SqlConnection cn = new SqlConnection(connectionString))
			{
				cn.Open();

				//call the overload that takes a connection in place of the connection string
				rows = FillDataTable(dataTable, cn, commandType,
					commandText, commandParameters);

			}

			return rows;
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset and takes no parameters) against the provided SqlConnection. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  DataTable dataTable = new DataTable( );
		///  FillDataTable(dataTable, conn, CommandType.StoredProcedure, "GetOrders");
		/// </remarks>
		/// <param name="dataTable">the DataTable to fill with the resultset generated by the command</param>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>
		/// The number of rows successfully added to or refreshed in the DataTable. 
		/// </returns>
		public static int FillDataTable(DataTable dataTable, SqlConnection connection, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			int rows =
				FillDataTable(dataTable, connection, commandType, commandText,
				(SqlParameter[])null);

			return rows;
		}
		
		/// <summary>
		/// Execute a SqlCommand (that returns a resultset) against the specified SqlConnection 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  DataTable dataTable = new DataTable( );
		///  FillDataTable(dataTable, conn, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="dataTable">the DataTable to fill with the resultset generated by the command</param>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>
		/// The number of rows successfully added to or refreshed in the DataTable. 
		/// </returns>
		/// <returns>
		/// The number of rows successfully added to or refreshed in the DataTable. 
		/// </returns>
		public static int FillDataTable(DataTable dataTable, SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);
			
			//create the DataAdapter
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			
			//fill the DataTable
			int rows = da.Fill(dataTable);
			
			// detach the SqlParameters from the command object, so they can be used again.			
			cmd.Parameters.Clear();
			
			return rows;
		}
		
		/// <summary>
		/// Execute a SqlCommand (that returns a resultset and takes no parameters) against the provided SqlTransaction. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  DataTable dataTable = new DataTable( );
		///  FillDataTable(dataTable, trans, CommandType.StoredProcedure, "GetOrders");
		/// </remarks>
		/// <param name="dataTable">the DataTable to fill with the resultset generated by the command</param>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>
		/// The number of rows successfully added to or refreshed in the DataTable. 
		/// </returns>
		public static int FillDataTable(DataTable dataTable, SqlTransaction transaction, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			int rows =
				FillDataTable(dataTable, transaction, commandType, commandText,
				(SqlParameter[])null);

			return rows;
		}
		
		/// <summary>
		/// Execute a SqlCommand (that returns a resultset) against the specified SqlTransaction
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  DataTable dataTable = new DataTable( );
		///  FillDataTable(dataTable, trans, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="dataTable">the DataTable to fill with the resultset generated by the command</param>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>
		/// The number of rows successfully added to or refreshed in the DataTable. 
		/// </returns>
		public static int FillDataTable( DataTable dataTable, SqlTransaction transaction, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, transaction.Connection, transaction, commandType, commandText, commandParameters);
			
			//create the DataAdapter
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			
			//fill the DataTable
			int rows = da.Fill(dataTable);
			
			// detach the SqlParameters from the command object, so they can be used again.
			cmd.Parameters.Clear();

			return rows;
		}
		
		#endregion FillDataTable
		
		#region ExecuteReader

		/// <summary>
		/// this enum is used to indicate whether the connection was provided by the caller, or created by SqlUtil, so that
		/// we can set the appropriate CommandBehavior when calling ExecuteReader()
		/// </summary>
		private enum SqlConnectionOwnership	
		{
			/// <summary>Connection is owned and managed by SqlUtil</summary>
			Internal, 
			/// <summary>Connection is owned and managed by the caller</summary>
			External
		}

		/// <summary>
		/// Create and prepare a SqlCommand, and call ExecuteReader with the appropriate CommandBehavior.
		/// </summary>
		/// <remarks>
		/// If we created and opened the connection, we want the connection to be closed when the DataReader is closed.
		/// 
		/// If the caller provided the connection, we want to leave it to them to manage.
		/// </remarks>
		/// <param name="connection">a valid SqlConnection, on which to execute this command</param>
		/// <param name="transaction">a valid SqlTransaction, or 'null'</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParameters to be associated with the command or 'null' if no parameters are required</param>
		/// <param name="connectionOwnership">indicates whether the connection parameter was provided by the caller, or created by SqlUtil</param>
		/// <returns>SqlDataReader containing the results of the command</returns>
		private static SqlDataReader ExecuteReader(SqlConnection connection, SqlTransaction transaction, CommandType commandType, string commandText, SqlParameter[] commandParameters, SqlConnectionOwnership connectionOwnership)
		{	
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, connection, transaction, commandType, commandText, commandParameters);
			
			//create a reader
			SqlDataReader dr;

			// call ExecuteReader with the appropriate CommandBehavior
			if (connectionOwnership == SqlConnectionOwnership.External)
			{
				dr = cmd.ExecuteReader();
			}
			else
			{
				dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
			}
			
			// detach the SqlParameters from the command object, so they can be used again.
			cmd.Parameters.Clear();
			
			return dr;
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset and takes no parameters) against the database specified in 
		/// the connection string. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  SqlDataReader dr = ExecuteReader(connString, CommandType.StoredProcedure, "GetOrders");
		/// </remarks>
		/// <param name="connectionString">a valid connection string for a SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>a SqlDataReader containing the resultset generated by the command</returns>
		public static SqlDataReader ExecuteReader(string connectionString, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteReader(connectionString, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset) against the database specified in the connection string 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  SqlDataReader dr = ExecuteReader(connString, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="connectionString">a valid connection string for a SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>a SqlDataReader containing the resultset generated by the command</returns>
		public static SqlDataReader ExecuteReader(string connectionString, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create & open a SqlConnection
			SqlConnection cn = new SqlConnection(connectionString);
			cn.Open();

			try
			{
				//call the private overload that takes an internally owned connection in place of the connection string
				return ExecuteReader(cn, null, commandType, commandText, commandParameters,SqlConnectionOwnership.Internal);
			}
			catch
			{
				//if we fail to return the SqlDatReader, we need to close the connection ourselves
				cn.Close();
				throw;
			}
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset and takes no parameters) against the provided SqlConnection. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  SqlDataReader dr = ExecuteReader(conn, CommandType.StoredProcedure, "GetOrders");
		/// </remarks>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>a SqlDataReader containing the resultset generated by the command</returns>
		public static SqlDataReader ExecuteReader(SqlConnection connection, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteReader(connection, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset) against the specified SqlConnection 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  SqlDataReader dr = ExecuteReader(conn, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>a SqlDataReader containing the resultset generated by the command</returns>
		public static SqlDataReader ExecuteReader(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//pass through the call to the private overload using a null transaction value and an externally owned connection
			return ExecuteReader(connection, (SqlTransaction)null, commandType, commandText, commandParameters, SqlConnectionOwnership.External);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset and takes no parameters) against the provided SqlTransaction. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  SqlDataReader dr = ExecuteReader(trans, CommandType.StoredProcedure, "GetOrders");
		/// </remarks>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>a SqlDataReader containing the resultset generated by the command</returns>
		public static SqlDataReader ExecuteReader(SqlTransaction transaction, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteReader(transaction, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset) against the specified SqlTransaction
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///   SqlDataReader dr = ExecuteReader(trans, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>a SqlDataReader containing the resultset generated by the command</returns>
		public static SqlDataReader ExecuteReader(SqlTransaction transaction, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//pass through to private overload, indicating that the connection is owned by the caller
			return ExecuteReader(transaction.Connection, transaction, commandType, commandText, commandParameters, SqlConnectionOwnership.External);
		}

		#endregion ExecuteReader

		#region ExecuteScalar
		
		/// <summary>
		/// Execute a SqlCommand (that returns a 1x1 resultset and takes no parameters) against the database specified in 
		/// the connection string. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int orderCount = (int)ExecuteScalar(connString, CommandType.StoredProcedure, "GetOrderCount");
		/// </remarks>
		/// <param name="connectionString">a valid connection string for a SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>an object containing the value in the 1x1 resultset generated by the command</returns>
		public static object ExecuteScalar(string connectionString, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteScalar(connectionString, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a 1x1 resultset) against the database specified in the connection string 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int orderCount = (int)ExecuteScalar(connString, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="connectionString">a valid connection string for a SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>an object containing the value in the 1x1 resultset generated by the command</returns>
		public static object ExecuteScalar(string connectionString, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create & open a SqlConnection, and dispose of it after we are done.
			using (SqlConnection cn = new SqlConnection(connectionString))
			{
				cn.Open();

				//call the overload that takes a connection in place of the connection string
				return ExecuteScalar(cn, commandType, commandText, commandParameters);
			}
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a 1x1 resultset and takes no parameters) against the provided SqlConnection. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int orderCount = (int)ExecuteScalar(conn, CommandType.StoredProcedure, "GetOrderCount");
		/// </remarks>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>an object containing the value in the 1x1 resultset generated by the command</returns>
		public static object ExecuteScalar(SqlConnection connection, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteScalar(connection, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a 1x1 resultset) against the specified SqlConnection 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int orderCount = (int)ExecuteScalar(conn, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>an object containing the value in the 1x1 resultset generated by the command</returns>
		public static object ExecuteScalar(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);
			
			//execute the command & return the results
			object retval = cmd.ExecuteScalar();
			
			// detach the SqlParameters from the command object, so they can be used again.
			cmd.Parameters.Clear();
			return retval;
			
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a 1x1 resultset and takes no parameters) against the provided SqlTransaction. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int orderCount = (int)ExecuteScalar(trans, CommandType.StoredProcedure, "GetOrderCount");
		/// </remarks>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <returns>an object containing the value in the 1x1 resultset generated by the command</returns>
		public static object ExecuteScalar(SqlTransaction transaction, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteScalar(transaction, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a 1x1 resultset) against the specified SqlTransaction
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  int orderCount = (int)ExecuteScalar(trans, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>an object containing the value in the 1x1 resultset generated by the command</returns>
		public static object ExecuteScalar(SqlTransaction transaction, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, transaction.Connection, transaction, commandType, commandText, commandParameters);
			
			//execute the command & return the results
			object retval = cmd.ExecuteScalar();
			
			// detach the SqlParameters from the command object, so they can be used again.
			cmd.Parameters.Clear();
			return retval;
		}

		#endregion ExecuteScalar	

		#region ExecuteXmlReader

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset and takes no parameters) against the provided SqlConnection. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  XmlReader r = ExecuteXmlReader(conn, CommandType.StoredProcedure, "GetOrders");
		/// </remarks>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command using "FOR XML AUTO"</param>
		/// <returns>an XmlReader containing the resultset generated by the command</returns>
		public static XmlReader ExecuteXmlReader(SqlConnection connection, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteXmlReader(connection, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset) against the specified SqlConnection 
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  XmlReader r = ExecuteXmlReader(conn, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="connection">a valid SqlConnection</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command using "FOR XML AUTO"</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>an XmlReader containing the resultset generated by the command</returns>
		public static XmlReader ExecuteXmlReader(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);
			
			XmlReader retval = cmd.ExecuteXmlReader();
			
			// detach the SqlParameters from the command object, so they can be used again.
			cmd.Parameters.Clear();
			return retval;
			
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset and takes no parameters) against the provided SqlTransaction. 
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  XmlReader r = ExecuteXmlReader(trans, CommandType.StoredProcedure, "GetOrders");
		/// </remarks>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command using "FOR XML AUTO"</param>
		/// <returns>an XmlReader containing the resultset generated by the command</returns>
		public static XmlReader ExecuteXmlReader(SqlTransaction transaction, CommandType commandType, string commandText)
		{
			//pass through the call providing null for the set of SqlParameters
			return ExecuteXmlReader(transaction, commandType, commandText, (SqlParameter[])null);
		}

		/// <summary>
		/// Execute a SqlCommand (that returns a resultset) against the specified SqlTransaction
		/// using the provided parameters.
		/// </summary>
		/// <remarks>
		/// e.g.:  
		///  XmlReader r = ExecuteXmlReader(trans, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));
		/// </remarks>
		/// <param name="transaction">a valid SqlTransaction</param>
		/// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
		/// <param name="commandText">the stored procedure name or T-SQL command using "FOR XML AUTO"</param>
		/// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
		/// <returns>an XmlReader containing the resultset generated by the command</returns>
		public static XmlReader ExecuteXmlReader(SqlTransaction transaction, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
		{
			//create a command and prepare it for execution
			SqlCommand cmd = new SqlCommand();
			PrepareCommand(cmd, transaction.Connection, transaction, commandType, commandText, commandParameters);
			
			XmlReader retval = cmd.ExecuteXmlReader();
			
			// detach the SqlParameters from the command object, so they can be used again.
			cmd.Parameters.Clear();
			return retval;			
		}

		#endregion ExecuteXmlReader

		#region public helper functions (not included in the DAAB)
		/// <summary>
		/// Creates an output <see cref="SqlParameter"/> using the specified
		/// <b>SqlDbType</b> and size.
		/// </summary>
		/// <param name="parameterName">The name of the parameter to create.
		/// </param>
		/// <param name="dbType">The type of parameter to create.
		/// </param>
		/// <param name="size">The size of the parameter to create.</param>
		/// <returns>A new <see cref="SqlParameter"/> object.</returns>
		public static SqlParameter CreateOutputSqlParameter(
			string parameterName,
			SqlDbType dbType,
			int size )
		{
			SqlParameter parameter = new SqlParameter( CreateParameterName( parameterName ),
				dbType, size );
			
			parameter.Direction = ParameterDirection.Output;

			return( parameter );
		}

		public static SqlParameter CreateSqlParameter(
			string parameterName,
			SqlDbType dbType,
			int size,
			string sourceColumn )
		{
			SqlParameter parameter = new SqlParameter( CreateParameterName( parameterName ),
				dbType, size, sourceColumn );
			return( parameter );
		}

		public static SqlParameter CreateOutputSqlParameter(
			string parameterName,
			SqlDbType dbType,
			int size,
			string sourceColumn )
		{
			SqlParameter parameter = CreateSqlParameter( parameterName, dbType, size, sourceColumn );
			parameter.Direction = ParameterDirection.Output;
			return( parameter );
		}

		/// <summary>
		/// Created an Identity output paramater
		/// </summary>
		/// <param name="parameterName">The name of the parameter to create.
		/// </param>
		/// <returns>A new <see cref="SqlParameter"/> object.</returns>
		public static SqlParameter CreateIdentityOutputSqlParameter(
			string parameterName )
		{

			SqlParameter parameter = 
				SqlUtility.CreateOutputSqlParameter( parameterName, SqlDbType.Int, 4 );
			
			parameter.Direction = ParameterDirection.Output;

			return( parameter );
		}

		private static string CreateParameterName(
			string parameterName
			)
		{
			return "@" + parameterName;            
		}

		/// <summary>
		/// Creates a <see cref="SqlParameter"/> for a Boolean value using
		/// <b>SqlDbType.Bit</b>.
		/// </summary>
		/// <param name="parameterName">The name of the parameter to add.
		/// </param>
		/// <param name="value">The value of the parameter.</param>
		/// <returns>A new <see cref="SqlParameter"/> object.</returns>
		public static SqlParameter CreateSqlParameter(
			string parameterName,
			bool value )
		{
			SqlParameter parameter = new SqlParameter( CreateParameterName( parameterName ),
				SqlDbType.Bit, 1 );

			if ( value == true )
			{
				parameter.Value = 1;
			}
			else
			{
				parameter.Value = 0;
			}

			return( parameter );
		}

		/// <summary>
		/// Creates a <see cref="SqlParameter"/> for a DateTime value using
		/// <b>SqlDbType.SmallDateTime</b>.
		/// </summary>
		/// <param name="parameterName">The name of the parameter to add.
		/// </param>
		/// <param name="value">The value of the parameter.</param>
		/// <returns>A new <see cref="SqlParameter"/> object.</returns>
		public static SqlParameter CreateSqlParameter(
			string parameterName,
			DateTime value )
		{

			SqlParameter parameter = new SqlParameter( CreateParameterName( parameterName ),
				SqlDbType.SmallDateTime );

			if ( value == DateTime.MinValue )
			{
				parameter.Value = DBNull.Value;
			}
			else
			{
				parameter.Value = value;
			}

			return( parameter );
		}

		/// <summary>
		/// Creates a <see cref="SqlParameter"/> for an integer value using
		/// <b>SqlDbType.Int</b>.
		/// </summary>
		/// <param name="parameterName">The name of the parameter to add.
		/// </param>
		/// <param name="value">The value of the parameter.</param>
		/// <returns>A new <see cref="SqlParameter"/> object.</returns>
		public static SqlParameter CreateSqlParameter(
			string parameterName,
			int value )
		{
			SqlParameter parameter = new SqlParameter( CreateParameterName( parameterName ),
				SqlDbType.Int, 4 );

			parameter.Value = value;
			return( parameter );
		}

		/// <summary>
		/// Creates a <see cref="SqlParameter"/> for a string value using
		/// <b>SqlDbType.VarChar</b>.
		/// </summary>
		/// <param name="parameterName">The name of the parameter to add.
		/// </param>
		/// <param name="value">The value of the parameter.</param>
		/// <param name="maxSize">The maximum length of the string.</param>
		public static SqlParameter CreateSqlParameter(
			string parameterName,
			string value,
			int maxSize )
		{
			SqlParameter parameter = new SqlParameter( CreateParameterName( parameterName ),
				SqlDbType.VarChar, maxSize );

			parameter.Value = EncodeNullString( value );
			return( parameter );
		}

		/// <summary>
		/// Converts a string value to be stored in a database, substituting
		/// <b>DBNull.Value</b> for null or empty ( "" ) strings.
		/// </summary>
		/// <param name="value">The string value to be stored in the database.
		/// </param>
		/// <returns>The string value if it is not null or empty, otherwise
		/// <b>DBNull.Value</b> is returned.</returns>
		public static object EncodeNullString(
			string value )
		{
			if ( value == null || value.Length < 1 )
			{
				return( DBNull.Value );
			}
			else
			{
				return( value );
			}
		}
		#endregion

		#region DateTime Endpoints
		public static DateTime SmallDateTimeMinValue
		{

			get 
			{
				return new DateTime( 1900, 1, 1, 0, 0, 0 );
			}

		}

		public static DateTime SmallDateTimeMaxValue
		{

			get 
			{
				return new DateTime( 2079, 6, 6, 11, 59, 59 );
			}

		}

		public static void NormalizeToSmallDateTimeMinValue( ref DateTime date )
		{
			if( date < SqlUtility.SmallDateTimeMinValue )
			{
				date = SqlUtility.SmallDateTimeMinValue;
			}
		}

		public static void NormalizeToSmallDateTimeMaxValue( ref DateTime date )
		{
			if( date > SqlUtility.SmallDateTimeMaxValue )
			{
				date = SqlUtility.SmallDateTimeMaxValue;
			}
		}
		#endregion

	}
}
