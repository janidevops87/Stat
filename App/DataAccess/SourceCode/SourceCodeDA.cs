using System;
using System.Data;
using Statline.Stattrac.Common.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.DataAccess.SourceCode
{
    public enum SourceCodeDASprocs
    {
        SourceCodeSelectDataSet,
        SourceCodeSelect,
        SourceCodeListSelect,
        SourceCodeOrganizationSelect,
        AspSourceCodeMapSelect,
        DonorTracURLSelect,
        DonorTracIdentifierSelect,
        SourceCodeTransplantCenterSelect,
        SourceCodeASPSelect,
        SourceCodeSearchSelect,
        GetSourceCodeCount,
        GetSourceCodeDefaultCount,

    }
    public class SourceCodeDA : BaseDA
    {
        public int SourceCodeCallTypeId { get; set; }
        public string SourceCodeName { get; set; }
        public int CheckForSourceCodeDuplicatesResults { get; set; }
        public int CheckForExistingDefaultSourceCodeResults { get; set; }


        public int SourceCodeID {get; set;}
        public int GetSelected { get; set; }
        public int OrganizationID { get; set; }
        public SourceCodeDASprocs SprocName { get; set; }
        public SearchParameter OrganizationSearchParameter { get; set; }
        private GeneralConstant grConstant;
        public SourceCodeDA()
            : base(SourceCodeDASprocs.SourceCodeSelectDataSet.ToString())
        {
            OrganizationSearchParameter = SearchParameter.CreateInstance();
            grConstant = GeneralConstant.CreateInstance();
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("SourceCode", "SourceCodeInsert", "SourceCodeUpdate", "SourceCodeDelete"));
            ListTableSave.Add(new TableSave("SourceCodeOrganization", "SourceCodeOrganizationMerge", "SourceCodeOrganizationMerge", "SourceCodeOrganizationMerge"));
            ListTableSave.Add(new TableSave("AspSourceCodeMap", "AspSourceCodeMapMerge", "AspSourceCodeMapMerge", "AspSourceCodeMapMerge"));
            ListTableSave.Add(new TableSave("DonorTracURL", "DonorTracURLInsert", "DonorTracURLUpdate", "DonorTracURLDelete"));
            ListTableSave.Add(new TableSave("DonorTracIdentifier", "DonorTracIdentifierInsert", "DonorTracIdentifierUpdate", "DonorTracIdentifierDelete"));
            ListTableSave.Add(new TableSave("SourceCodeTransplantCenter", "SourceCodeTransplantCenterInsert", "SourceCodeTransplantCenterUpdate", "SourceCodeTransplantCenterDelete"));
            ListTableSave.Add(new TableSave("SourceCodeASP", "SourceCodeASPInsert", "SourceCodeASPUpdate", "SourceCodeASPDelete"));
        }
        public void SetDefaultTableSelect()
        {
            
            SpSelect = SourceCodeDASprocs.SourceCodeSelectDataSet.ToString();
            SetTablesSelect(
                "SourceCode",
                //"SourceCodeOrganization",
                "AspSourceCodeMap",
                "DonorTracURL",
                "DonorTracIdentifier",
                "SourceCodeTransplantCenter",
                "SourceCodeASP"
                );
        }
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {
            switch ((SourceCodeDASprocs)Enum.Parse(typeof(SourceCodeDASprocs), SpSelect, true))
            { 
                case SourceCodeDASprocs.SourceCodeSelectDataSet:
                    SetDefaultTableSelect();
                    commandWrapper.AddInParameterForSelect("StatEmployeeID", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, grConstant.SourceCodeId);
                    break;
                case SourceCodeDASprocs.SourceCodeSelect:
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, grConstant.SourceCodeId);
                    break;
                case SourceCodeDASprocs.SourceCodeListSelect:
                    commandWrapper.AddInParameterForSelect("StatEmployeeUserId", DbType.Int32, StattracIdentity.Identity.UserId);
                    break;
                case SourceCodeDASprocs.SourceCodeOrganizationSelect:
                    #region SearchParameter

                    commandWrapper.AddInParameterForSelect("SourceCodeId", DbType.Int32, grConstant.SourceCodeId);
                    commandWrapper.AddInParameterForSelect("GetSelected", DbType.Boolean, grConstant.SourceCodeOrganizationGetSelected);
                    if (OrganizationSearchParameter.SourceCodeId > 0)
                        commandWrapper.AddInParameterForSelect("SearchSourceCodeId", DbType.Int32, OrganizationSearchParameter.SourceCodeId);
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
                case SourceCodeDASprocs.AspSourceCodeMapSelect:
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, grConstant.SourceCodeId);
                    break;
                case SourceCodeDASprocs.DonorTracURLSelect:
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, grConstant.SourceCodeId);
                    break;
                case SourceCodeDASprocs.DonorTracIdentifierSelect:
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, grConstant.SourceCodeId);
                    break;
                case SourceCodeDASprocs.SourceCodeTransplantCenterSelect:
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, grConstant.SourceCodeId);
                    break;
                case SourceCodeDASprocs.SourceCodeASPSelect:
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, grConstant.SourceCodeId);
                    break;
                case SourceCodeDASprocs.GetSourceCodeCount:
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, SourceCodeID);
                    commandWrapper.AddInParameterForSelect("SourceCodeName", DbType.String, SourceCodeName);
                    commandWrapper.AddInParameterForSelect("SourceCodeCallTypeID", DbType.Int32, SourceCodeCallTypeId);
                    commandWrapper.AddInParameterForSelect("Count", DbType.Int32, CheckForSourceCodeDuplicatesResults);
                    commandWrapper.SetParameterToOutput("Count");
                    break;
                case SourceCodeDASprocs.GetSourceCodeDefaultCount:
                    commandWrapper.AddInParameterForSelect("SourceCodeID", DbType.Int32, SourceCodeID);
                    commandWrapper.AddInParameterForSelect("SourceCodeName", DbType.String, SourceCodeName);
                    commandWrapper.AddInParameterForSelect("Count", DbType.Int32, CheckForSourceCodeDuplicatesResults);
                    commandWrapper.SetParameterToOutput("Count");
                    break;

                default:
                    break;
            }

        }
        protected override void GetParameterValuesPostExecuteNonQuery(System.Data.Common.DbParameterCollection dbParameters)
        {
            switch ((SourceCodeDASprocs)Enum.Parse(typeof(SourceCodeDASprocs), SpSelect, true))
            {
                case SourceCodeDASprocs.GetSourceCodeCount:
                    CheckForSourceCodeDuplicatesResults = Convert.ToInt32(dbParameters["@Count"].Value);
                    break;
                case SourceCodeDASprocs.GetSourceCodeDefaultCount:
                    CheckForExistingDefaultSourceCodeResults = Convert.ToInt32(dbParameters["@Count"].Value);
                    break;
            }

        }
        #endregion

        public void CheckForSourceCodeDuplicates()
        {
            //reset value to 0;
            CheckForSourceCodeDuplicatesResults = 0;
            SpSelect = SourceCodeDASprocs.GetSourceCodeCount.ToString();

        }

        public void CheckForExistingDefaultSourceCode()
        {
            //reset value to 0;
            CheckForExistingDefaultSourceCodeResults = 0;
            SpSelect = SourceCodeDASprocs.GetSourceCodeDefaultCount.ToString();

        }

        public void SearchOrganization()
        {
            SpSelect = SourceCodeDASprocs.SourceCodeOrganizationSelect.ToString();
            SetTablesSelect("SourceCodeOrganization");

        }
        public void SelectSourceCode(int sourceCodeID)
        {
            SpSelect = SourceCodeDASprocs.SourceCodeSelect.ToString();
            SourceCodeID = sourceCodeID;
            SetTablesSelect("SourceCode");
        }

        public void SelectASPSourceCodeMap(int sourceCodeID)
        {
            SpSelect = SourceCodeDASprocs.AspSourceCodeMapSelect.ToString();
            SourceCodeID = sourceCodeID;
            SetTablesSelect("ASPSourceCodeMap");
        }
        public void SelectDonorTracURL(int sourceCodeID)
        {
            SpSelect = SourceCodeDASprocs.DonorTracURLSelect.ToString();
            SourceCodeID = sourceCodeID;
            SetTablesSelect("DonorTracURL");
        }
        public void SelectDonorTracIdentifier(int sourceCodeID)
        {
            SpSelect = SourceCodeDASprocs.DonorTracIdentifierSelect.ToString();
            SourceCodeID = sourceCodeID;
            SetTablesSelect("DonorTracIdentifier");
        }
        public void SelectSourceCodeTransplantCenter(int sourceCodeID)
        {
            SpSelect = SourceCodeDASprocs.SourceCodeTransplantCenterSelect.ToString();
            SourceCodeID = sourceCodeID;
            SetTablesSelect("SourceCodeTransplantCenter");
        }
        public void SelectSourceCodeASP(int sourceCodeID)
        {
            SpSelect = SourceCodeDASprocs.SourceCodeASPSelect.ToString();
            SourceCodeID = sourceCodeID;
            SetTablesSelect("SourceCodeASP");
        }
        public void SelectSourceCodeOrganization(int sourceCodeID)
        {
            SpSelect = SourceCodeDASprocs.SourceCodeOrganizationSelect.ToString();
            SourceCodeID = sourceCodeID;
            SetTablesSelect("SourceCodeOrganization");
        }

        public void AddSourceCodeOrganizationDefault()
        {
            SpSelect = SourceCodeDASprocs.SourceCodeSearchSelect.ToString();
            SetTablesSelect("SourceCode", "SourceCodeOrganization");
        }
    }
}
