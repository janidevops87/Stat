using System;
using System.Data;
using System.Runtime.Serialization;
using System.Security.Permissions;

namespace Statline.Stattrac.Framework
{
	[Serializable]
	public class BaseException : Exception
	{
		#region Private Fields
		/// <summary>
		/// Is this Exception already logged
		/// </summary>
		private bool isExceptionAlreadyLogged;
		#endregion

		#region Constructors
		/// <summary>
		/// Base Exception
		/// </summary>
		/// <param name="message"></param>
		/// <param name="isExceptionAlreadyLogged"></param>
		public BaseException(string message, bool isExceptionAlreadyLogged)
			: base(message)
		{
			this.isExceptionAlreadyLogged = isExceptionAlreadyLogged;
		}

		public BaseException() : base() { }
		public BaseException(string message) : base(message) { }
		public BaseException(string message, Exception innerException) : base(message, innerException) { }
		protected BaseException(SerializationInfo info, StreamingContext context) : base(info, context) { }

		[SecurityPermission(SecurityAction.LinkDemand, Flags=SecurityPermissionFlag.SerializationFormatter)]
		public override void GetObjectData(SerializationInfo info, System.Runtime.Serialization.StreamingContext context)
		{
			base.GetObjectData(info, context);
		}
		#endregion

		#region Public Properties
		/// <summary>
		/// Is this Exception already logged
		/// </summary>
		public bool IsExceptionAlreadyLogged
		{
			get { return isExceptionAlreadyLogged; }
		}
		#endregion
	}
}
