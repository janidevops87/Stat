using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Constant;
using System.Data;
using Statline.Stattrac.Data.Types.Organization;
using System.Threading;

namespace Statline.Stattrac.DataAccess.Organization
{
    public enum OrganizationDASprocs
    {
        OrganizationSelectDataSet,
        ReferralByPhoneIdSelect,
        DuplicateSearchRuleDefaultSelect,
        DashBoardTimerDefaultSelect,        
        OrganizationSearchSelect,
        GetUserNameCount,
        GetAllRoles,
        SecurityRuleSelect,
        TimeZoneSelect,
        OrganizationPhoneSelect,
        OrganizationDelete,
        BillToDelete,
        OrganizationAliasDelete,
        OrganizationASPSettingDelete, 
        OrganizationCaseReviewDelete,
        SecurityRuleDelete,
        StatEmployeeDelete,
        ContactRoleDelete,
        ContactRoleSelect,
        WebPersonDelete,
        PersonPhoneDelete,
        ContactCallInstructionDelete,
        PersonDelete,
        OrganizationDashBoardTimerDelete,
        OrganizationPhoneDelete,
        OrganizationFsSourceCodeDelete,
        OrganizationDuplicateSearchRuleDelete,
        OrganizationDisplaySettingDelete,
        OrganizationSelect,
        CountySelect,
        PersonSelectDataSet,
        PersonSelect

    }
    public class OrganizationDA : BaseDA 
    {
        public int CheckForUserNameDuplicatesResults { get; set; }

        public int CountyId { get; set; }
        public OrganizationDASprocs SprocName { get; set; }        
        public int OrganizationId { get; set; }
        public int ContactId { get; set; }
        public string OrganizationName { get; set; }
        public int PersonId { get; set; }
        public Boolean PersonInactive { get; set; }
        public string Phone { get; set; }        
        public int PhoneId { get; set; }        
        public int StateId { get; set; }
        public string WebPersonUserName { get; set; }
        public int WebPersonId { get; set; }
        
        private StattracIdentity stattracIdentity;        

        public OrganizationDA()
			: base(OrganizationDASprocs.OrganizationSelectDataSet.ToString())
		{
            SetDefaultTableSelect();
            ListTableSave.Add(new TableSave("Organization", "OrganizationInsert", "OrganizationUpdate", "OrganizationDelete"));
            ListTableSave.Add(new TableSave("BillTo", "BillToInsert", "BillToUpdate", "BillToDelete"));
            ListTableSave.Add(new TableSave("OrganizationAlias", "OrganizationAliasInsert", "OrganizationAliasUpdate", "OrganizationAliasDelete"));
            ListTableSave.Add(new TableSave("OrganizationASPSetting", "OrganizationASPSettingInsert", "OrganizationASPSettingUpdate", "OrganizationASPSettingDelete"));
            ListTableSave.Add(new TableSave("OrganizationCaseReview", "OrganizationCaseReviewInsert", "OrganizationCaseReviewUpdate", "OrganizationCaseReviewDelete"));
            ListTableSave.Add(new TableSave("OrganizationDisplaySetting", "OrganizationDisplaySettingMerge", "OrganizationDisplaySettingMerge", "OrganizationDisplaySettingDelete"));
            ListTableSave.Add(new TableSave("OrganizationDuplicateSearchRule", "OrganizationDuplicateSearchRuleInsert", "OrganizationDuplicateSearchRuleUpdate", "OrganizationDuplicateSearchRuleDelete"));
            ListTableSave.Add(new TableSave("OrganizationFsSourceCode", "OrganizationFsSourceCodeInsert", "OrganizationFsSourceCodeUpdate", "OrganizationFsSourceCodeDelete"));
            ListTableSave.Add(new TableSave("OrganizationPhone", "OrganizationPhoneInsert", "OrganizationPhoneUpdate", "OrganizationPhoneDelete"));
            ListTableSave.Add(new TableSave("OrganizationDashBoardTimer", "OrganizationDashBoardTimerInsert", "OrganizationDashBoardTimerUpdate", "OrganizationDashBoardTimerDelete"));
            ListTableSave.Add(new TableSave("Person", "PersonInsert", "PersonUpdate", "PersonDelete"));
            ListTableSave.Add(new TableSave("ContactCallInstruction", "ContactCallInstructionInsert", "ContactCallInstructionUpdate", "ContactCallInstructionDelete"));
            ListTableSave.Add(new TableSave("PersonPhone", "PersonPhoneInsert", "PersonPhoneUpdate", "PersonPhoneDelete"));
            ListTableSave.Add(new TableSave("WebPerson", "WebPersonInsert", "WebPersonUpdate", "WebPersonDelete"));
            ListTableSave.Add(new TableSave("ContactRole", "ContactRoleMerge", "ContactRoleMerge", "ContactRoleDelete"));
            ListTableSave.Add(new TableSave("StatEmployee", "StatEmployeeInsert", "StatEmployeeUpdate", "StatEmployeeDelete"));
            ListTableSave.Add(new TableSave("SecurityRule", "SecurityRuleInsert", "SecurityRuleUpdate", "SecurityRuleDelete"));
            stattracIdentity = (StattracIdentity)Thread.CurrentPrincipal.Identity;
            PersonInactive = false;
        }

        public void SetDefaultTableSelect()
        {

            SpSelect = OrganizationDASprocs.OrganizationSelectDataSet.ToString();
            SetTablesSelect(
                "Organization",
                "BillTo",
                "OrganizationAlias",
                "OrganizationASPSetting",
                "OrganizationCaseReview",
                "OrganizationDashBoardTimer",
                "OrganizationDisplaySetting",
                "OrganizationDuplicateSearchRule",
                "OrganizationFsSourceCode",
                "OrganizationSourceCode",
                "OrganizationPhone",
                "Person",
                
                "PersonPhone",
                "WebPerson",
                "StatEmployee"
                                
                
                );
        }
        #region ovrriden methods
        protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
        {

            switch ((OrganizationDASprocs)Enum.Parse(typeof(OrganizationDASprocs), SpSelect, true))
            {
                case OrganizationDASprocs.ReferralByPhoneIdSelect:
                    
                    commandWrapper.AddInParameterForSelect("PhoneId", DbType.Int32, PhoneId);
                    break;
                case OrganizationDASprocs.OrganizationSelectDataSet:                    
                    SetDefaultTableSelect();
                    //reset PersonInactive
                    PersonInactive = false;
                    commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("OrganizationId", DbType.Int32, OrganizationId);
                    commandWrapper.AddInParameterForSelect("ContactId", DbType.Int32, ContactId);
                    
                    commandWrapper.AddInParameterForSelect("AllPermissions", DbType.Boolean, Constant.GeneralConstant.CreateInstance().AllPermissions);
                    commandWrapper.AddInParameterForSelect("Inactive", DbType.Boolean, PersonInactive);

                    break;
                case OrganizationDASprocs.OrganizationSearchSelect:
                    commandWrapper.AddInParameterForSelect("OrganizationName", DbType.String, OrganizationName);
                    commandWrapper.AddInParameterForSelect("userOrganizationID", DbType.Int32, stattracIdentity.UserOrganizationId);
                    if(CountyId > 0)
                        commandWrapper.AddInParameterForSelect("CountyID", DbType.Int32, CountyId);
                    if(StateId > 0)
                        commandWrapper.AddInParameterForSelect("StateID", DbType.Int32, StateId);
                    // always display all Organizatin
                    commandWrapper.AddInParameterForSelect("DisplayAllOrganizations", DbType.Boolean, true);
                    commandWrapper.AddInParameterForSelect("organizationAliasName", DbType.String, OrganizationName);
                    break;
                case OrganizationDASprocs.GetUserNameCount:
                    commandWrapper.AddInParameterForSelect("WebPersonUserName", DbType.String, WebPersonUserName);
                    commandWrapper.AddInParameterForSelect("Inactive", DbType.Boolean, PersonInactive);
                    commandWrapper.AddInParameterForSelect("WebPersonID", DbType.Int32, WebPersonId);
                    commandWrapper.AddInParameterForSelect("Count", DbType.Int32, CheckForUserNameDuplicatesResults);
                    commandWrapper.SetParameterToOutput("Count");
                    
                    break;
                case OrganizationDASprocs.OrganizationPhoneSelect:
                    commandWrapper.AddInParameterForSelect("ExcludeOrganizationId", DbType.Int32, OrganizationId);
                    commandWrapper.AddInParameterForSelect("Phone", DbType.String, Phone);
                    break;
                case OrganizationDASprocs.OrganizationSelect:
                    commandWrapper.AddInParameterForSelect("OrganizationId", DbType.Int32, OrganizationId);
                    break;
                case OrganizationDASprocs.CountySelect:
                    commandWrapper.AddInParameterForSelect("StateId", DbType.Int32, StateId);
                    break;
                case OrganizationDASprocs.ContactRoleSelect:
                    commandWrapper.AddInParameterForSelect("StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
                    commandWrapper.AddInParameterForSelect("OrganizationId", DbType.Int32, OrganizationId);
                    commandWrapper.AddInParameterForSelect("AllPermissions", DbType.Boolean, Constant.GeneralConstant.CreateInstance().AllPermissions);
                    commandWrapper.AddInParameterForSelect("ContactId", DbType.Int32, ContactId);
                                    
                    break;        
        	    case OrganizationDASprocs.PersonSelectDataSet:
                    commandWrapper.AddInParameterForSelect("OrganizationId", DbType.Int32, OrganizationId);
                    commandWrapper.AddInParameterForSelect("Inactive", DbType.Boolean, PersonInactive);
                    break;
                case OrganizationDASprocs.PersonSelect:
                    commandWrapper.AddInParameterForSelect("PersonId", DbType.Int32, PersonId);
                    break;


                default:
                    break;
            } 
        }
        protected override void GetParameterValuesPostExecuteNonQuery(System.Data.Common.DbParameterCollection dbParameters)
        {
            switch ((OrganizationDASprocs)Enum.Parse(typeof(OrganizationDASprocs), SpSelect, true))
            {
                case OrganizationDASprocs.GetUserNameCount:
                    CheckForUserNameDuplicatesResults = Convert.ToInt32(dbParameters["@Count"].Value);
                    break;
            }

            
        }
        #endregion
        public void CheckForUserNameDuplicates()
        {
            //reset value to 0;
            CheckForUserNameDuplicatesResults = 0;
            SpSelect = OrganizationDASprocs.GetUserNameCount.ToString();

        }
        public void SelectDuplicateSearchRuleDefault()
        {
            SpSelect = OrganizationDASprocs.DuplicateSearchRuleDefaultSelect.ToString();
            
            SetTablesSelect("DuplicateSearchRuleDefault");
            
        }
        public void SelectDashBoardTimerDefault()
        {
            SpSelect = OrganizationDASprocs.DashBoardTimerDefaultSelect.ToString();

            SetTablesSelect("DashBoardTimerDefault");

        }

        public void SelectAssociatedReferrals(int phoneID)
        {
            SpSelect = OrganizationDASprocs.ReferralByPhoneIdSelect.ToString();
            PhoneId = phoneID;            
            SetTablesSelect("AssociatedReferral");
            
        }

        public void SelectOrganizationDupes(string organizationName, int stateId, int countyId)
        {
            SpSelect = OrganizationDASprocs.OrganizationSearchSelect.ToString();
            OrganizationName = organizationName;
            StateId = stateId;
            CountyId = countyId;
            SetTablesSelect("OrganizationSearch");

        }

        public void SelectContactRoles()
        {
            SpSelect = OrganizationDASprocs.GetAllRoles.ToString();
            SetTablesSelect("Role");

        }
        public void SelectSecurityRule()
        {
            SpSelect = OrganizationDASprocs.SecurityRuleSelect.ToString();
            SetTablesSelect("SecurityRule");

        }
        public void SelectTimeZone()
        {
            SpSelect = OrganizationDASprocs.TimeZoneSelect.ToString();
            SetTablesSelect("TimeZone");
        
        }
        /// <summary>
        /// Searches existing numbers where phone exists
        /// </summary>
        public void SelectOrganizationPhoneSearch()
        {
            SpSelect = OrganizationDASprocs.OrganizationPhoneSelect.ToString();
            SetTablesSelect("OrganizationPhoneSearch");

        }


        public void SelectOranization()
        {
            SpSelect = OrganizationDASprocs.OrganizationSelect.ToString();
            SetTablesSelect("Organization");
        }

        public void CountySelect()
        {            
            SpSelect = OrganizationDASprocs.CountySelect.ToString();
             
            SetTablesSelect("County");
        }

        public void ContactRoleSelect()
        { 
            SpSelect = OrganizationDASprocs.ContactRoleSelect.ToString();             
            SetTablesSelect("ContactRole");	
        }

        public void PersonSelect(int personId)
        {
            PersonId = personId;
            SpSelect = OrganizationDASprocs.PersonSelect.ToString();
            SetTablesSelect(
                "Person");
        }
        public void PersonSelect()
        {
            SpSelect = OrganizationDASprocs.PersonSelectDataSet.ToString();
            SetTablesSelect(
                "Person",
                "PersonPhone",
                "WebPerson",
                "StatEmployee",
                "ContactRole");	
        }
    }
}
