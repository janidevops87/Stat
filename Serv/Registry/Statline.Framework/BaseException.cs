using System;
using System.Collections.Generic;

namespace Statline.Framework
{
	public class BaseException : ApplicationException
	{
		internal protected Dictionary<string, object> ExceptionList { get; set; }

		public BaseException()
			: base()
		{
			ExceptionList = new Dictionary<string, object>();
		}
		public BaseException(string message)
			: base(message)
		{
			ExceptionList = new Dictionary<string, object>();
		}
		public BaseException(string message, Exception innerExcpetion)
			: base(message, innerExcpetion)
		{
			ExceptionList = new Dictionary<string, object>();
		}
	}
}
