using System;

namespace Statline.Framework
{
	/// <summary>Define the table schema name, table name and the associated CUD sproc names</summary>
	public class TableMetaData
	{
		#region Internal Properties
		/// <summary>
		/// The table's schema name
		/// </summary>
		public string SchemaName { get; private set; }

		/// <summary>
		/// The table name
		/// </summary>
		public string TableName { get; private set; }

		/// <summary>
		/// The Insert Sproc name
		/// </summary>
		public string InsertSproc { get; private set; }

		/// <summary>
		/// The Update Sproc name
		/// </summary>
		public string UpdateSproc { get; private set; }

		/// <summary>
		/// The Delete Sproc name
		/// </summary>
		public string DeleteSproc { get; private set; }
		#endregion

		#region Constructor
		/// <summary>Define the table schema name, table name and the associated CUD sproc names</summary>
		/// <param name="schemaName">The table's schema name</param>
		/// <param name="tableName">The table name</param>
		/// <param name="insertSproc">The Insert Sproc name</param>
		/// <param name="updateSproc">The Update Sproc name</param>
		/// <param name="deleteSproc">The Delete Sproc name</param>
		private TableMetaData(string schemaName, string tableName, string insertSproc, string updateSproc, string deleteSproc)
		{
			SchemaName = schemaName;
			TableName = tableName;
			InsertSproc = insertSproc;
			UpdateSproc = updateSproc;
			DeleteSproc = deleteSproc;
		}

		/// <summary>Define the table schema name, table name and the associated CUD sproc names</summary>
		/// <param name="schemaName">The table's schema name</param>
		/// <param name="tableName">The table name</param>
		/// <param name="insertSproc">The Insert Sproc name</param>
		/// <param name="updateSproc">The Update Sproc name</param>
		/// <param name="deleteSproc">The Delete Sproc name</param>
		internal static TableMetaData CreateInstance(string schemaName, string tableName, string insertSproc, string updateSproc, string deleteSproc)
		{
			return new TableMetaData(schemaName, tableName, insertSproc, updateSproc, deleteSproc);
		}
		#endregion
	}
}
