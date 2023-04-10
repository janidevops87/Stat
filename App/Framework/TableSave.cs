using System;

namespace Statline.Stattrac.Framework
{
	/// <summary>
	/// Use this class to encapsulate the assosiated sprocs for insert, update, and delete
	/// </summary>
	/// <remarks>
	/// We make the properties internal so that only classes in this project can have access 
	/// </remarks>
	public class TableSave
	{
		#region Private Fields
		/// <summary>
		/// Name of the Table
		/// </summary>
		private string tableName;

		/// <summary>
		/// Name of the Insert Sproc
		/// </summary>
		private string insertSproc;

		/// <summary>
		/// Name of the Update Sproc
		/// </summary>
		private string updateSproc;

		/// <summary>
		/// Name of the Delete Sproc
		/// </summary>
		private string deleteSproc; 
		#endregion

		#region Constructor
		/// <summary>
		/// Explicitly define the sproc names
		/// </summary>
		/// <param name="tableName"></param>
		/// <param name="insertSproc"></param>
		/// <param name="updateSproc"></param>
		/// <param name="deleteSproc"></param>
		public TableSave(string tableName, string insertSproc, string updateSproc, string deleteSproc)
		{
			this.tableName = tableName;
			this.insertSproc = insertSproc;
			this.updateSproc = updateSproc;
			this.deleteSproc = deleteSproc;
		} 
		#endregion

		#region Internal Properties
		/// <summary>
		/// Name of the Table.
		/// </summary>
		internal string TableName
		{
			get { return tableName; }
		}

		/// <summary>
		/// Name of the Insert Sproc
		/// </summary>
		internal string InsertSproc
		{
			get { return insertSproc; }
		}

		/// <summary>
		/// Name of the Update Sproc
		/// </summary>
		internal string UpdateSproc
		{
			get { return updateSproc; }
		}

		/// <summary>
		/// Name of the Delete Sproc
		/// </summary>
		internal string DeleteSproc
		{
			get { return deleteSproc; }
		} 
		#endregion
	}
}
