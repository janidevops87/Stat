using System;
using Statline.Stattrac.Framework;
using System.Threading;

namespace Statline.Stattrac.Constant
{
	public class StattracIdentity : BaseIdentity
	{
		public StattracIdentity(string name, bool isAuthenticated, string databaseInstance)
			: base(name, isAuthenticated, databaseInstance) 
		{
            //add code to get Uesr Roles
            //Create BR, DA, DS
            //
		}

		public static StattracIdentity Identity
		{
			get
			{
				return Thread.CurrentPrincipal.Identity as StattracIdentity;
			}
		}

		#region Fields
		private int userId;
        private int userOrganizationId;
        private string userName;
        private string userOrganizationName;
		#endregion

		#region Properties
		public int UserId
		{
			get { return userId; }
			set { userId = value; }
		}
        public int UserOrganizationId
        {
            get { return userOrganizationId; }
            set { userOrganizationId = value;}
        }
        public string UserName
        {
            get { return userName; }
            set { userName = value; }
        }
        public string UserOrganizationName
        {
            get { return userOrganizationName; }
            set { userOrganizationName = value; }
        }

		#endregion
	}
}
