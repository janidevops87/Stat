using System.Data;

namespace Statline.Framework
{
	/// <summary>Define the properties of the field</summary>
	public class BaseFieldMetaData
	{
		#region Fields Public
		/// <summary>The name of the field as it appears in the database table</summary>
		public string Name { get; private set; }

		/// <summary>The Sql DataType of the field</summary>
		public SqlDbType DbType { get; private set; }

		/// <summary>The length of the field (only applies to string types)</summary>
		public int Length { get; private set; }

		/// <summary>The Precisions of the field (only applies to decimal)</summary>
		public byte Precision { get; private set; }

		/// <summary>The scale of the field (only applies to decimal)</summary>
		public byte Scale { get; private set; }

		/// <summary>The name of the field in user friendly manner</summary>
		public virtual string DisplayName { get; protected set; }
		#endregion

		#region Constructor
		/// <summary>
		/// Define the properties of the field
		/// </summary>
		/// <param name="name">The name of the field as it appears in the database table</param>
		/// <param name="dbType">The Sql DataType of the field</param>
		/// <param name="length">The length of the field (only applies to string types)</param>
		/// <param name="precision">The Precisions of the field (only applies to decimal)</param>
		/// <param name="scale">The scale of the field (only applies to decimal)</param>
		/// <param name="displayName">The name of teh field in English</param>
		protected BaseFieldMetaData(string name, SqlDbType dbType, int length, byte precision, byte scale, string displayName)
		{
			Name = name;
			DbType = dbType;
			Length = length;
			Precision = precision;
			Scale = scale;
			DisplayName = displayName;
		}

		/// <summary>
		/// Define the properties of the field
		/// </summary>
		/// <param name="name">The name of the field as it appears in the database table</param>
		/// <param name="dbType">The Sql DataType of the field</param>
		/// <param name="length">The length of the field (only applies to string types)</param>
		/// <param name="precision">The Precisions of the field (only applies to decimal)</param>
		/// <param name="scale">The scale of the field (only applies to decimal)</param>
		/// <param name="displayName">The name of teh field in English</param>
		internal static BaseFieldMetaData CreateInstance(string name, SqlDbType dbType, int length, byte precision, byte scale, string displayName)
		{
			return new BaseFieldMetaData(name, dbType, length, precision, scale, displayName);
		}
		#endregion
	}
}
