using System;

namespace Statline.Framework
{
	/// <summary>
	/// The database transaction that needs to be preformed
	/// </summary>
	public enum TransactionType
	{
		None = 0,
		Add = 1,
		Update = 2,
		Delete = 3
	}
}
