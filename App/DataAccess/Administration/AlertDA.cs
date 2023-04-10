using System;
using System.Data;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Administration
{
    public enum AlertDASprocs
    {
        AlertSelectDataSet,
        AlertSelect,
        AlertListSelect,
        AlertOrganizationSelect,
        AlertSourceCodeSelect,
        AlertSearchSelect

    }
    public class AlertDA : BaseDA
    {
        public int AlertCallTypeId { get; set; }
        public int AlertId { get; set; }
        public int OrganizationID { get; set; }
        public int SourceCodeID { get; set; }
        
        public AlertDASprocs SprocName { get; set; }
        public SearchParameter OrganizationSearchParameter { get; set; }
        private GeneralConstant grConstant;
        public AlertDA()
            : base(AlertDASprocs.AlertSelectDataSet.ToString())
        {
            OrganizationSearchParameter = SearchParameter.CreateInstance();
            grConstant = GeneralConstant.CreateInstance();
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("Alert", "AlertInsert", "AlertUpdate", "AlertDelete"));
            ListTableSave.Add(new TableSave("AlertOrganization", "AlertOrganizationInsert", "AlertOrganizationUpdate", "AlertOrganizationDelete"));
            ListTableSave.Add(new TableSave("AlertSourceCode", "AlertSourceCodeInsert", "AlertSourceCodeUpdate", "AlertSourceCodeDelete"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = AlertDASprocs.AlertSelectDataSet.ToString();
            SetTablesSelect(
                "Alert",
                "AlertOrganization",
                "AlertSourceCode"
                );
        }
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            switch ((AlertDASprocs)Enum.Parse(typeof(AlertDASprocs), SpSelect, true))
            {
                case AlertDASprocs.AlertSelectDataSet:
                    SetDefaultTableSelect();
                    commandWrapper.AddInParameterForSelect("AlertID", DbType.Int32, AlertId);
                    break;
                case AlertDASprocs.AlertSelect:
                    commandWrapper.AddInParameterForSelect("AlertID", DbType.Int32, AlertId);
                    break;
                case AlertDASprocs.AlertOrganizationSelect:
                    commandWrapper.AddInParameterForSelect("AlertID", DbType.Int32, AlertId);
                    #region SearchParameter
                    if (OrganizationSearchParameter.SourceCodeId > 0)
                        commandWrapper.AddInParameterForSelect("AlertId", DbType.Int32, OrganizationSearchParameter.SourceCodeId);
                    if (OrganizationSearchParameter.OrganizationName.Length > 0)
                        commandWrapper.AddInParameterForSelect("OrganizationName", DbType.String, OrganizationSearchParameter.OrganizationName);
                    if (OrganizationSearchParameter.OrganizationTypeId > 0)
                        commandWrapper.AddInParameterForSelect("OrganizationTypeId", DbType.Int32, OrganizationSearchParameter.OrganizationTypeId);
                    if (OrganizationSearchParameter.StateId > 0)
                        commandWrapper.AddInParameterForSelect("StateId", DbType.Int32, OrganizationSearchParameter.StateId);
                    commandWrapper.AddInParameterForSelect("ContractedStatlineClient", DbType.Boolean, OrganizationSearchParameter.ContractedStatlineClient);
                    if (OrganizationSearchParameter.AdministrationGroupFieldValue.Length > 0)
                        commandWrapper.AddInParameterForSelect("AdministrationGroupFieldValue", DbType.String, OrganizationSearchParameter.AdministrationGroupFieldValue);
                    #endregion
                    break;
                case AlertDASprocs.AlertSourceCodeSelect:
                    commandWrapper.AddInParameterForSelect("AlertID", DbType.Int32, AlertId);
                    break;
                case AlertDASprocs.AlertSearchSelect:
                    commandWrapper.AddInParameterForSelect("OrganizationID", DbType.Int32, OrganizationID);
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, SourceCodeID);

                    break;

                default:
                    break;
            }
        }
        #endregion


        public void SearchOrganization()
        {
            SpSelect = AlertDASprocs.AlertOrganizationSelect.ToString();
            SetTablesSelect("AlertOrganization");

        }
        public void SelectAlert(int alertID)
        {
            SpSelect = AlertDASprocs.AlertSelect.ToString();
            AlertId = alertID;
            SetTablesSelect("Alert");
        }

        public void SelectAlertSourceCode(int alertID)
        {
            SpSelect = AlertDASprocs.AlertSourceCodeSelect.ToString();
            AlertId = alertID;
            SetTablesSelect("AlertSourceCode");
        }
        public void SelectAlertOrganization(int alertID)
        {
            SpSelect = AlertDASprocs.AlertOrganizationSelect.ToString();
            AlertId = alertID;
            SetTablesSelect("AlertOrganization");
        }

        public void AddAlertOrganizationDefault()
        {
            SetDefaultTableSelect();
            SpSelect = AlertDASprocs.AlertSearchSelect.ToString();
            
        }
    }
}
