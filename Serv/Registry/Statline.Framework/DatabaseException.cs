using System;
using System.Text;
using System.Data.SqlClient;

namespace Statline.Framework
{
	/// <summary>
	/// An Exception that has already been logged
	/// </summary>
	public class DatabaseException : BaseException
	{
		public DatabaseException(Exception innerExcpetion, BaseDbCommand dbCommand)
			: base("DB Ex: " + dbCommand.DbCommand.CommandText, innerExcpetion)
		{
			StringBuilder sb = new StringBuilder();
			SqlCommand sqlCommand = dbCommand.DbCommand;
			ExceptionList.Add("ConnectionString", sqlCommand.Connection.ConnectionString);

			sb.Append("EXEC " + sqlCommand.CommandText + " ");
			if (sqlCommand.Parameters != null)
			{
				for (int i = 0; i < sqlCommand.Parameters.Count; i++)
				{
					if ((sqlCommand.Parameters[i].Value != null) && (sqlCommand.Parameters[i].Value.ToString() != ""))
						sb.Append("@" + sqlCommand.Parameters[i].ParameterName + "='" + sqlCommand.Parameters[i].Value + "'");
					if (i < sqlCommand.Parameters.Count - 1)
						sb.Append(","); // If this is not the last parameter then add a comma
				}
			}
			ExceptionList.Add("DatabaseException", sb.ToString());
		}
	}
}
