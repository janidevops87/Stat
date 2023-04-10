using System;
using System.Data;
using System.Linq;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.BusinessRules.Dashboard
{
    public class BulletinBoardBR : BaseBR
    {
        public BulletinBoardBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDA = new BulletinBoardDA();
            AssociatedDataSet = new BulletinBoardDS();
        }

        public string UserOrganizationID
        {
            set { ((BulletinBoardDA)AssociatedDA).UserOrganizationID = value; }
            get { return ((BulletinBoardDA)AssociatedDA).UserOrganizationID; }
        }
        
        public void AddEmptyRow(BulletinBoardDS.BulletinBoardDataTable table)
        {
            BulletinBoardDS bulletinBoard = ((BulletinBoardDS)AssociatedDataSet);
            SetDefaultValue(bulletinBoard.BulletinBoard);
            BulletinBoardDS.BulletinBoardRow newRow = table.NewBulletinBoardRow();
            newRow.DateTimeStatus = "Created";
            newRow.SavedBy = StattracIdentity.Identity.UserName.ToString();
            bulletinBoard.BulletinBoard.AddBulletinBoardRow(newRow);
        }

#region Overridden Methods
        protected override void BusinessRulesAfterSelect()
        {
            ((BulletinBoardDS)AssociatedDataSet).BulletinBoard
                .ToList().ForEach
                (delegate(BulletinBoardDS.BulletinBoardRow row)
                {
                    row.AcceptChanges();
                });
        }
        protected override void BusinessRulesBeforeSave()
        {
            //check the state of each table if the data has changed update the lastmodified, logtype and LastStatEmployeeID
            BulletinBoardDS bulletinBoardDS = (BulletinBoardDS)AssociatedDataSet;
            for (int forLoop = 0; forLoop < bulletinBoardDS.Tables.Count; forLoop++)
            {
                SetDefaultModifiedValues(bulletinBoardDS.Tables[forLoop]);
                SetDefaultCreateValues(bulletinBoardDS.Tables[forLoop]);
            }                

        }

#endregion
#region Fields/Properties
        private GeneralConstant grConstant;
        private int userOrganizationID;

#endregion
#region Private Methods
        private void SetDefaultModifiedValues(DataTable table)
        {   //
            table.Select().ToList().ForEach(delegate(DataRow row)
            {
                if (row.RowState != DataRowState.Modified)
                    return;

                if (row.Table.Columns.Contains("LastStatEmployeeID"))
                    row[row.Table.Columns["LastStatEmployeeID"].Ordinal] = StattracIdentity.Identity.UserId;
                if (row.Table.Columns.Contains("LastModified"))
                    row[row.Table.Columns["LastModified"].Ordinal] = grConstant.CurrentDateTime;
                if (row.Table.Columns.Contains("AuditLogTypeID"))
                    row[row.Table.Columns["AuditLogTypeID"].Ordinal] = GeneralConstant.AuditLogType.Modify;
            });
        }
    private void SetDefaultCreateValues(DataTable table)
        {   //
            table.Select().ToList().ForEach(delegate(DataRow row)
            {
                if (row.RowState != DataRowState.Added)
                    return;
                
                if (row.Table.Columns.Contains("OrganizationID"))
                    row[row.Table.Columns["OrganizationID"].Ordinal] = StattracIdentity.Identity.UserOrganizationId;
                if (row.Table.Columns.Contains("CreateDate"))
                    row[row.Table.Columns["CreateDate"].Ordinal] = grConstant.CurrentDateTime;
                if (row.Table.Columns.Contains("LastStatEmployeeID"))
                    row[row.Table.Columns["LastStatEmployeeID"].Ordinal] = StattracIdentity.Identity.UserId;
                if (row.Table.Columns.Contains("LastModified"))
                    row[row.Table.Columns["LastModified"].Ordinal] = grConstant.CurrentDateTime;
                if (row.Table.Columns.Contains("AuditLogTypeID"))
                    row[row.Table.Columns["AuditLogTypeID"].Ordinal] = GeneralConstant.AuditLogType.Create;

            });

        }
    /// Set the default value in the table
    /// </summary>
    /// <param name="dataTable"></param>
    private void SetDefaultValue(DataTable dataTable)
    {
        BulletinBoardDS bulletinBoardDS = (BulletinBoardDS)AssociatedDataSet;
        if (dataTable.Columns.Contains("Organization"))
            dataTable.Columns["Organization"].DefaultValue = "";
        if (dataTable.Columns.Contains("Alert"))
            dataTable.Columns["Alert"].DefaultValue = "";
        if (dataTable.Columns.Contains("DateTimeStatus"))
            dataTable.Columns["DateTimeStatus"].DefaultValue = "";
        if (dataTable.Columns.Contains("SavedBy"))
            dataTable.Columns["SavedBy"].DefaultValue = "";
        if (dataTable.Columns.Contains("CreateDate"))
            dataTable.Columns["CreateDate"].DefaultValue = grConstant.CurrentDateTime;
        if (dataTable.Columns.Contains("OrganizationID") && !dataTable.Columns["OrganizationID"].AutoIncrement)
        {
            dataTable.Columns["OrganizationID"].DefaultValue = StattracIdentity.Identity.UserOrganizationId;
        }
        if (dataTable.Columns.Contains("LastModified"))
            dataTable.Columns["LastModified"].DefaultValue = grConstant.CurrentDateTime;
        if (dataTable.Columns.Contains("LastStatEmployeeID"))
            dataTable.Columns["LastStatEmployeeID"].DefaultValue = StattracIdentity.Identity.UserId;
        if (dataTable.Columns.Contains("AuditLogTypeID"))
            dataTable.Columns["AuditLogTypeID"].DefaultValue = GeneralConstant.AuditLogType.Create;
    }

#endregion

    }
}
