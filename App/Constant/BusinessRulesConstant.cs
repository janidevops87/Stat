
namespace Statline.Stattrac.Constant
{
	/// <summary>
	/// Constants used by the BusinessRules module
	/// </summary>
	public class BusinessRulesConstant
	{
		#region Private Fields
		/// <summary>
		/// Message to display when login is invalid
		/// </summary>
		private readonly string invalidLogOn;
		#endregion

		#region Singleton Implementation
		private static BusinessRulesConstant framework;

		/// <summary>
		/// Initilizes the variables
		/// </summary>
		protected BusinessRulesConstant()
		{
			invalidLogOn = "Invalid Login";
		}

		public static BusinessRulesConstant CreateInstance()
		{
			if (framework == null)
			{
				framework = new BusinessRulesConstant();
			}
			return framework;
		} 
		#endregion

		#region Public Properties
		/// <summary>
		/// Message to display when login is invalid
		/// </summary>
		public string InvalidLogOn
		{
			get { return invalidLogOn; }
		}
		#endregion
	}
}
