using System;
using System.Data;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Administration
{
    public enum ServiceLevel30OrganizationDASprocs
    {
        ServiceLevel30OrganizationSelectDataSet,
        ServiceLevel30OrganizationSelect,
        ServiceLevel30OrganizationSearchSelect

    }
    public class ServiceLevel30OrganizationDA : BaseDA
    {
        public int ServiceLevelOrganizationId { get; set; }
        public int OrganizationID { get; set; }
        public int CriteriaStatus { get; set; }
        public int SourceCodeID { get; set; }


        public ServiceLevel30OrganizationDASprocs SprocName { get; set; }
        private GeneralConstant grConstant;
        public ServiceLevel30OrganizationDA()
            : base(ServiceLevel30OrganizationDASprocs.ServiceLevel30OrganizationSelectDataSet.ToString())
        {
            grConstant = GeneralConstant.CreateInstance();
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("ServiceLevel30Organization", "ServiceLevel30OrganizationInsert", "ServiceLevel30OrganizationUpdate", "ServiceLevel30OrganizationDelete"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = ServiceLevel30OrganizationDASprocs.ServiceLevel30OrganizationSelectDataSet.ToString();
            SetTablesSelect(
                "ServiceLevel30Organization"
                );
        }
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            switch ((ServiceLevel30OrganizationDASprocs)Enum.Parse(typeof(ServiceLevel30OrganizationDASprocs), SpSelect, true))
            {
                case ServiceLevel30OrganizationDASprocs.ServiceLevel30OrganizationSelectDataSet:
                    SetDefaultTableSelect();
                    commandWrapper.AddInParameterForSelect("ServiceLevel30OrganizationID", DbType.Int32, ServiceLevelOrganizationId);
                    break;
                case ServiceLevel30OrganizationDASprocs.ServiceLevel30OrganizationSelect:
                    commandWrapper.AddInParameterForSelect("ServiceLevel30OrganizationID", DbType.Int32, ServiceLevelOrganizationId);
                    break;
                case ServiceLevel30OrganizationDASprocs.ServiceLevel30OrganizationSearchSelect:
                    commandWrapper.AddInParameterForSelect("OrganizationID", DbType.Int32, OrganizationID);
                    commandWrapper.AddInParameterForSelect("CriteriaStatus", DbType.Int32, CriteriaStatus);
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, SourceCodeID);
                    break;

                default:
                    break;
            }
        }
        #endregion


        public void SelectServiceLevel30Organization(int webReportGroupOrgID)
        {
            SpSelect = ServiceLevel30OrganizationDASprocs.ServiceLevel30OrganizationSelect.ToString();
            ServiceLevelOrganizationId = webReportGroupOrgID;
            SetTablesSelect("ServiceLevel30Organization");
        }

        public void AddServiceLevel30OrganizationDefault()
        {
            SetDefaultTableSelect();
            SpSelect = ServiceLevel30OrganizationDASprocs.ServiceLevel30OrganizationSearchSelect.ToString();

        }
    }
}
