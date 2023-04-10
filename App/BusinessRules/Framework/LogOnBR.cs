using System;
using System.DirectoryServices;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.Framework
{
	public class LogOnBR : BaseBR
	{
        public static bool ValidateUser(string activeDirectory, string userName, string password, bool isAuthenticated, bool isFullLogin)
		{
			bool returnValue = false;

            if (Environment.UserName == userName && !isAuthenticated && password.Length == 0 && !isFullLogin)
			{
				returnValue = true;
			}
			else
			{
                try
                {
                    DirectoryEntry entry = new DirectoryEntry(activeDirectory, userName, password);
                    DirectorySearcher searcher = new DirectorySearcher(entry);
                    searcher.FindOne();
                    returnValue = true;
                }
                catch
                {
                    returnValue = false;
                    //exception is handled at another location
                    //throw new BaseException(BRConstant.InvalidLogOn, true);
                }
			}
			return returnValue;
		}
	}
}
