using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Collections.Generic;

namespace Statline.Framework
{
	/// <summary>
	/// The command that should be used be the rest of the projects.
	/// By encapsulating the real SqlCommand we are able to modify it in one place
	/// and have it apply to the whole application
	/// </summary>
	public class BaseDbCommand
	{
		#region Fields
		/// <summary>
		/// The actual sql command object
		/// </summary>
		internal SqlCommand DbCommand { get; private set; }

        public int CommandTimeout
        {
            get { return DbCommand.CommandTimeout; }
            set { DbCommand.CommandTimeout = value; }
        }
        #endregion

        #region Constructor
        /// <summary>
        /// Wrapper for the Actual Sql Command
        /// This is private so taht the user uses the CreateInstance method to get an instance
        /// THis follows the design patterns practice
        /// </summary>
        /// <param name="command"></param>
        private BaseDbCommand(SqlCommand command)
		{
			DbCommand = command;
		}
		#endregion

		#region Methods
		/// <summary>
		/// Returns a new Command object with the specified sproc name
		/// </summary>
		public static BaseDbCommand CreateInstance(string sprocName)
		{
			SqlConnection connection = new SqlConnection(BaseIdentity.CurrentIdentity.ConnectionString); // Create the connection
			SqlCommand command = connection.CreateCommand(); // Create the command
			command.CommandType = CommandType.StoredProcedure; // Make the command always a stored procedure
			command.CommandText = sprocName; // Add the name of the sproc to be called
			return new BaseDbCommand(command);
		}

		/// <summary>
		/// Returns a new Command object with the specified sproc name, and connection string
		/// </summary>
		public static BaseDbCommand CreateInstance(string sprocName, string connectionString)
		{
			SqlConnection connection = new SqlConnection(connectionString); // Create the connection
			SqlCommand command = connection.CreateCommand(); // Create the command
			command.CommandType = CommandType.StoredProcedure; // Make the command always a stored procedure
			command.CommandText = sprocName; // Add the name of the sproc to be called
			return new BaseDbCommand(command);
		}

		/// <summary>
		/// Adds an input parameter with the specified value and gets the rest of teh dat from the baseFieldMetaData
		/// </summary>
		/// <param name="baseFieldMetaData"></param>
		/// <param name="value"></param>
		public void AddInputParameter(BaseFieldMetaData baseFieldMetaData, object value)
		{
			SqlParameter param = new SqlParameter();
			param.ParameterName = baseFieldMetaData.Name;
			param.SqlDbType = baseFieldMetaData.DbType;
			param.Value = value;
			if (baseFieldMetaData.DbType == SqlDbType.Char ||
				baseFieldMetaData.DbType == SqlDbType.VarChar ||
				baseFieldMetaData.DbType == SqlDbType.NChar ||
				baseFieldMetaData.DbType == SqlDbType.NVarChar)
			{
				param.Size = baseFieldMetaData.Length;
			}
			param.Precision = baseFieldMetaData.Precision;
			param.Scale = baseFieldMetaData.Scale;
			DbCommand.Parameters.Add(param);            
		}

		/// <summary>
		/// 
		/// </summary>
		/// <param name="parameterName">The Name of the parameter</param>
		/// <param name="dbType">The type of field</param>
		/// <param name="value">The value for the parameter</param>
		public void AddInputParameter(string parameterName, DbType dbType, object value)
		{
			SqlParameter param = new SqlParameter();
			param.ParameterName = parameterName;
			param.SqlValue = dbType;
			param.Value = value;
			DbCommand.Parameters.Add(param);
		}
        /// <summary>
        /// call to change the direction of input paramater to InputOutput
        /// </summary>
        public void ChangeParameterToInputOutput(string parameterName)
        {
            if(DbCommand.Parameters.Contains(parameterName))
                DbCommand.Parameters[parameterName].Direction = ParameterDirection.InputOutput;
        }
        public string GetOutputParameter(string parameterName)
        {
            string paramValue = "";
            if (DbCommand.Parameters.Contains(parameterName))
                paramValue = DbCommand.Parameters[parameterName].Value.ToString();
            return paramValue;

        }
		/// <summary>
		/// Opens the database connection and returns the data reader object
		/// </summary>
		/// <returns></returns>
		public BaseDbDataReader ExecuteReader()
		{
			DbCommand.Connection.Open();
			return new BaseDbDataReader(DbCommand.ExecuteReader());
		}

		/// <summary>
		/// Closes the data reader object
		/// </summary>
		public void Close()
		{
			if (DbCommand.Connection != null) // check to make sure we still have a reference to teh reader before closing it and disposing it 
			{
				DbCommand.Connection.Close();
				DbCommand.Connection.Dispose();
			}
		}
		#endregion
	}
}
