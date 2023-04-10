using System.Collections.Generic;
using System.Data;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System;

namespace Statline.Stattrac.DataAccess.Dashboard
{
    public class BulletinBoardDA : BaseDA
    {
        #region Private Fields
        private string bulletinBoardID;
        private string userOrganizationID;
        #endregion

        #region Constructor
        public BulletinBoardDA()
            : base("BulletinBoardSelect")
        {
            SetTablesSelect("BulletinBoard");
            ListTableSave.Add(new TableSave("BulletinBoard", "BulletinBoardInsert", "BulletinBoardUpdate", "BulletinBoardDelete"));
        }
        #endregion

        #region Public Properties
        public string BulletinBoardID
        {
            get { return bulletinBoardID; }
            set { bulletinBoardID = value; }
        }
        public string UserOrganizationID
        {
            get { return userOrganizationID; }
            set { userOrganizationID = value; }
        }
        #endregion
        #region Methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            commandWrapper.AddInParameterForSelect("OrganizationID", DbType.Int32, StattracIdentity.Identity.UserOrganizationId);
        }
        #endregion
    }
}
