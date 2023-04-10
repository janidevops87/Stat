using System;
using System.Data;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.Criteria
{
    public enum CriteriaDASprocs
    { 
        CriteriaSelectDataSet,
        CriteriaSelect,
        CriteriaSearchSelect,
        CriteriaSourceCodeSelect,
        CriteriaAgeUnitSelect,
        CriteriaWeightUnitSelect,
        CriteriaOrganizationSelect,
        CriteriaIndicationSelect,
        CriteriaProcessorSelect
    }
    
    public class CriteriaDA : BaseDA
    {
        public int CriteriaID { get; set; }
        public int CriteriaStatus { get; set; }
        public int OrganizationID { get; set; }
        public int OrganizationTypeID {get; set;}
        public int StateID { get; set; }
        public int SourceCodeID { get; set; }
        public int DonorCategoryID { get; set; }
        public CriteriaDASprocs SprocName { get; set; }
        public SearchParameter OrganizationSearchParameter { get; set; }
        public SearchParameter ProcessorSearchParameter { get; set; }
        public SearchParameter IndicationSearchParameter { get; set; }
        private GeneralConstant grConstant;

        public CriteriaDA()
            : base(CriteriaDASprocs.CriteriaSelectDataSet.ToString())
        {
            OrganizationSearchParameter = SearchParameter.CreateInstance();
            ProcessorSearchParameter = SearchParameter.CreateInstance();
            IndicationSearchParameter = SearchParameter.CreateInstance();

            grConstant = GeneralConstant.CreateInstance();
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("Criteria", "CriteriaInsert", "CriteriaUpdate", "CriteriaDelete"));
            ListTableSave.Add(new TableSave("CriteriaSourceCode", "CriteriaSourceCodeInsert", "CriteriaSourceCodeUpdate", "CriteriaSourceCodeDelete"));
            ListTableSave.Add(new TableSave("CriteriaAgeUnit", "CriteriaAgeUnitInsert", "CriteriaAgeUnitUpdate", "CriteriaAgeUnitDelete"));
            ListTableSave.Add(new TableSave("CriteriaWeightUnit", "CriteriaWeightUnitInsert", "CriteriaWeightUnitUpdate", "CriteriaWeightUnitDelete"));
            ListTableSave.Add(new TableSave("CriteriaOrganization", "CriteriaOrganizationMerge", "CriteriaOrganizationMerge", "CriteriaOrganizationMerge"));
            ListTableSave.Add(new TableSave("CriteriaIndication", "CriteriaIndicationMerge", "CriteriaIndicationMerge", "CriteriaIndicationMerge"));
            ListTableSave.Add(new TableSave("CriteriaProcessor", "CriteriaProcessorMerge", "CriteriaProcessorMerge", "CriteriaProcessorMerge"));
        }
        public void SetDefaultTableSelect()
        {

            SpSelect = CriteriaDASprocs.CriteriaSelectDataSet.ToString();
            SetTablesSelect(
                "Criteria",
                "CriteriaSourceCode",
                "CriteriaAgeUnit",
                "CriteriaWeightUnit",
                "CriteriaOrganization",
                "CriteriaIndication",
                "CriteriaProcessor"
                );
        }

        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((CriteriaDASprocs)Enum.Parse(typeof(CriteriaDASprocs), SpSelect, true))
            {
                case CriteriaDASprocs.CriteriaSelectDataSet:
                    SetDefaultTableSelect();
                    //commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("CriteriaID", DbType.Int32, CriteriaID);
                    commandWrapper.AddInParameterForSelect("DonorCategoryID", DbType.Int32, DonorCategoryID);
                    break;
                case CriteriaDASprocs.CriteriaSelect:
                    commandWrapper.AddInParameterForSelect("CriteriaID", DbType.Int32, CriteriaID);
                    commandWrapper.AddInParameterForSelect("DonorCategoryID", DbType.Int32, DonorCategoryID);
                    break;
                case CriteriaDASprocs.CriteriaSourceCodeSelect:
                    commandWrapper.AddInParameterForSelect("CriteriaID", DbType.Int32, CriteriaID);
                    break;
                case CriteriaDASprocs.CriteriaOrganizationSelect:
                    commandWrapper.AddInParameterForSelect("CriteriaID", DbType.Int32, grConstant.CriteriaId);
                    #region SearchParameter
                    if (OrganizationSearchParameter.CriteriaId > 0)
                        commandWrapper.AddInParameterForSelect("CriteriaId", DbType.Int32, OrganizationSearchParameter.CriteriaId);
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
                case CriteriaDASprocs.CriteriaIndicationSelect:
                    commandWrapper.AddInParameterForSelect("CriteriaID", DbType.Int32, grConstant.CriteriaId);
                    #region SearchParameter
                    if (IndicationSearchParameter.CriteriaId > 0)
                        commandWrapper.AddInParameterForSelect("CriteriaId", DbType.Int32, IndicationSearchParameter.CriteriaId);
                    #endregion
                    break;
                case CriteriaDASprocs.CriteriaProcessorSelect:
                    commandWrapper.AddInParameterForSelect("CriteriaID", DbType.Int32, grConstant.CriteriaId);
                    commandWrapper.AddInParameterForSelect("OrganizationTypeId", DbType.Int32, grConstant.CriteriaProcessorTypeId);
                    commandWrapper.AddInParameterForSelect("StateId", DbType.Int32, grConstant.CriteriaProcessorStateId);
                    break;
                case CriteriaDASprocs.CriteriaSearchSelect:
                    commandWrapper.AddInParameterForSelect("OrganizationID", DbType.Int32, OrganizationID);
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, SourceCodeID);
                    commandWrapper.AddInParameterForSelect("DonorCategoryID", DbType.Int32, DonorCategoryID);
                    commandWrapper.AddInParameterForSelect("CriteriaStatus", DbType.Int32, CriteriaStatus);
                    break;

                default:
                    break;
            }
        }

        public void SelectCriteria(int criteriaID)
        {
            SpSelect = CriteriaDASprocs.CriteriaSelect.ToString();
            CriteriaID = criteriaID;
            SetTablesSelect("Criteria");
        }
        public void SelectCriteriaSourceCode(int criteriaID)
        {
            SpSelect = CriteriaDASprocs.CriteriaSourceCodeSelect.ToString();
            CriteriaID = criteriaID;
            SetTablesSelect("CriteriaSourceCode");
        }

        public void SelectCriteriaAgeUnit()
        {
            SpSelect = CriteriaDASprocs.CriteriaAgeUnitSelect.ToString();
            SetTablesSelect("CriteriaAgeUnit");
        }

        public void SelectCriteriaWeightUnit()
        {
            SpSelect = CriteriaDASprocs.CriteriaWeightUnitSelect.ToString();
            SetTablesSelect("CriteriaWeightUnit");
        }

        public void SearchOrganization()
        {
            SpSelect = CriteriaDASprocs.CriteriaOrganizationSelect.ToString();
            SetTablesSelect("CriteriaOrganization");

        }
        public void SearchIndication(int criteriaID)
        {
            SpSelect = CriteriaDASprocs.CriteriaIndicationSelect.ToString();
            CriteriaID = criteriaID;
            SetTablesSelect("CriteriaIndication");

        }
        public void SearchProcessor(int criteriaID, int organizationTypeID, int stateID)
        {
            SpSelect = CriteriaDASprocs.CriteriaProcessorSelect.ToString();
            CriteriaID = criteriaID;
            OrganizationTypeID = organizationTypeID;
            StateID = stateID;
            SetTablesSelect("CriteriaProcessor");

        }

        public void AddCriteriaOrganizationDefault()
        {
            SetTablesSelect("CriteriaSearch");
            SpSelect = CriteriaDASprocs.CriteriaSearchSelect.ToString();

        }


    }
}
