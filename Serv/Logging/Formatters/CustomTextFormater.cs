using System;
using System.Globalization;
using System.Text;
using Microsoft.Practices.EnterpriseLibrary.Logging;
using Microsoft.Practices.EnterpriseLibrary.Logging.Formatters;
using Microsoft.Practices.EnterpriseLibrary.Logging.Configuration;
using System.Collections.Specialized;

namespace Statline.Logging.Formatters
{
	/// <summary>
	/// Summary description for CustomTextFormater.
	/// </summary>
	public class CustomTextFormater : TextFormatter	
	{
		private const string userNameToken = "{userName}";

		
		public CustomTextFormater()
		{}

        public CustomTextFormater(NameValueCollection parameters)
            :base(parameters.Get("template"))
        {}

		public string Format(CustomLogEntry log)
		{
			
			StringBuilder templateBuilder = new StringBuilder(base.Format(log));
			templateBuilder.Replace(userNameToken, log.UserName);

			return templateBuilder.ToString();
			
		}

	}
}
