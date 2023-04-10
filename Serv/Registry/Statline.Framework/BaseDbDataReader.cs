using System.Data;
using System.Data.SqlClient;

namespace Statline.Framework
{
	/// <summary>
	/// The DataReader that should be used be the rest of the projects.
	/// </summary>
	public class BaseDbDataReader
	{
		#region Fields
		/// <summary>
		/// The actual sql DataReader object
		/// </summary>
		public SqlDataReader DbDataReader { get; private set; }

		public int FieldCount { get { return DbDataReader.FieldCount; } }
		#endregion

		#region Constructor
		/// <summary>
		/// Wrapper for the Actual Sql DataReader
		/// </summary>
		/// <param name="DataReader"></param>
		internal BaseDbDataReader(SqlDataReader DataReader)
		{
			DbDataReader = DataReader;
		}
		#endregion

		#region Methods
		/// <summary>
		/// Advances the reader to the next record
		/// </summary>
		/// <returns></returns>
		public bool Read()
		{
			return DbDataReader.Read();
		}

		/// <summary>
		/// Closes the object
		/// </summary>
		public void Close()
		{
			DbDataReader.Close();
		}

		/// <summary>
		/// Gets the value of teh specified column as string
		/// </summary>
		/// <param name="i"></param>
		/// <returns></returns>
		public string GetString(int i)
		{
			return DbDataReader.GetString(i);
		}
		#endregion
	}
}
