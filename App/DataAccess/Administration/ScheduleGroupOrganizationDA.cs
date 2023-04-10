using System;
using System.Data;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Administration
{
    public enum ScheduleGroupOrganizationDASprocs
    {
        ScheduleGroupOrganizationSelectDataSet,
        ScheduleGroupOrganizationSelect,
        ScheduleGroupOrganizationSearchSelect

    }
    public class ScheduleGroupOrganizationDA : BaseDA
    {
        public int ScheduleGroupOrganizationId { get; set; }
        public int OrganizationID { get; set; }
        public int SourceCodeID { get; set; }

        public ScheduleGroupOrganizationDASprocs SprocName { get; set; }
        private GeneralConstant grConstant;
        public ScheduleGroupOrganizationDA()
            : base(ScheduleGroupOrganizationDASprocs.ScheduleGroupOrganizationSelectDataSet.ToString())
        {
            grConstant = GeneralConstant.CreateInstance();
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("ScheduleGroupOrganization", "ScheduleGroupOrganizationInsert", "ScheduleGroupOrganizationUpdate", "ScheduleGroupOrganizationDelete"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = ScheduleGroupOrganizationDASprocs.ScheduleGroupOrganizationSelectDataSet.ToString();
            SetTablesSelect(
                "ScheduleGroupOrganization"
                );
        }
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            switch ((ScheduleGroupOrganizationDASprocs)Enum.Parse(typeof(ScheduleGroupOrganizationDASprocs), SpSelect, true))
            {
                case ScheduleGroupOrganizationDASprocs.ScheduleGroupOrganizationSelectDataSet:
                    SetDefaultTableSelect();
                    commandWrapper.AddInParameterForSelect("ScheduleGroupOrganizationID", DbType.Int32, ScheduleGroupOrganizationId);
                    break;
                case ScheduleGroupOrganizationDASprocs.ScheduleGroupOrganizationSelect:
                    commandWrapper.AddInParameterForSelect("ScheduleGroupOrganizationID", DbType.Int32, ScheduleGroupOrganizationId);
                    break;
                case ScheduleGroupOrganizationDASprocs.ScheduleGroupOrganizationSearchSelect:
                    commandWrapper.AddInParameterForSelect("OrganizationID", DbType.Int32, OrganizationID);
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, SourceCodeID);
                    break;

                default:
                    break;
            }
        }
        #endregion


        public void SelectScheduleGroupOrganization(int webReportGroupOrgID)
        {
            SpSelect = ScheduleGroupOrganizationDASprocs.ScheduleGroupOrganizationSelect.ToString();
            ScheduleGroupOrganizationId = webReportGroupOrgID;
            SetTablesSelect("ScheduleGroupOrganization");
        }

        public void AddScheduleGroupOrganizationDefault()
        {
            SetTablesSelect(
                "ScheduleGroupOrganizationSearch"
                );
            
            SpSelect = ScheduleGroupOrganizationDASprocs.ScheduleGroupOrganizationSearchSelect.ToString();

        }
    }
}
