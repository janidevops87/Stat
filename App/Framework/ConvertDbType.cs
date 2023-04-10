using System;
using System.Data;

namespace Statline.Stattrac.Framework
{
	/// <summary>
	/// Converts one datatype into another
	/// </summary>
	internal class ConvertDbType
	{
		private ConvertDbType() { }

		/// <summary>
		/// Converts Type to DbType
		/// </summary>
		/// <param name="type"></param>
		/// <returns></returns>
		public static DbType GetDbType(Type type)
		{
			DbType dbType;
			switch (type.Name)
			{
				case "Boolean":
					dbType = DbType.Boolean;
					break;
				case "Byte":
					dbType = DbType.Byte;
					break;
				case "DateTime":
					dbType = DbType.DateTime;
					break;
				case "Int16":
					dbType = DbType.Int16;
					break;
				case "Int32":
					dbType = DbType.Int32;
					break;
				case "Int64":
					dbType = DbType.Int64;
					break;
				case "String":
					dbType = DbType.String;
					break;
				case "Decimal":
					dbType = DbType.Decimal;
					break;
				case "Double":
					dbType = DbType.Double;
					break;
				case "Guid":
					dbType = DbType.Guid;
					break;
				default:
					throw new NotImplementedException(type.Name);
			}
			return dbType;
		}
	}
}
