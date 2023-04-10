using System;
using System.Collections.Generic;

namespace Statline.Stattrac.Framework
{
	public class StatTracException : ApplicationException
	{
		internal protected Dictionary<string, object> ExceptionList { get; set; }

		public StatTracException()
			: base()
		{
			ExceptionList = new Dictionary<string, object>();
		}
		public StatTracException(string message)
			: base(message)
		{
			ExceptionList = new Dictionary<string, object>();
		}
		public StatTracException(string message, Exception innerExcpetion)
			: base(message, innerExcpetion)
		{
			ExceptionList = new Dictionary<string, object>();
		}
	}
}
