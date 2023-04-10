using System;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data;
using System.Text;
using System.Diagnostics;
using System.Data.SqlClient;
using System.IO;
using System.Data.Common;

namespace Statline.Stattrac.Framework
{
	/// <summary>
	/// Base command wrapper
	/// </summary>
	public class BaseCommand
	{
		#region Internal Fields
		/// <summary>
		/// The object to encapsulate a command to excecute against the database
		/// </summary>
		internal DbCommand command;

		/// <summary>
		/// The Enterprise library database object.  
		/// </summary>
		internal Database database;
		#endregion

		#region Internal Fields
		/// <summary>
		/// Only the Faramwork should access the constructor
		/// </summary>
		/// <param name="CommandWrapper"></param>
		internal BaseCommand(Database database, DbCommand CommandWrapper)
		{
			this.database = database;
			command = CommandWrapper;
            command.CommandTimeout =  BaseConfiguration.GetSettingInt(SettingName.CommandTimeout);
		}
		#endregion

		#region Public Methods
		/// <summary>
		/// Add the parameter into the command object
		/// </summary>
		/// <param name="name"></param>
		/// <param name="type"></param>
		/// <param name="value"></param>
		public void AddInParameterForSelect(string columnName, DbType dbType, object value)
		{
			database.AddInParameter(command, columnName, dbType, value);
		}

		/// <summary>
		/// Add the parameter for save sproc
		/// </summary>
		/// <param name="columnName"></param>
		/// <param name="dbType"></param>
		/// <param name="dataRowVersion"></param>
		public void AddInParameterForSave(string columnName, DbType dbType, DataRowVersion dataRowVersion)
		{
			database.AddInParameter(command, "@" + columnName, dbType, columnName, dataRowVersion);
		}
        public void AddInParameterForSave(string columnName, DbType dbType, object value)
        {
            database.AddInParameter(command, "@" + columnName, dbType, value);
        }

		#endregion

		#region Internal Methods
		public void SetParameterToOutput(string columnName)
		{
			((IDataParameter)command.Parameters["@" + columnName]).Direction = ParameterDirection.InputOutput;
		}
		#endregion
	}
}
