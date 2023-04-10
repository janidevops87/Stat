using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.DataAccess.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.BusinessRules.SourceCode;
using Statline.Stattrac.BusinessRules.Administration;
using Statline.Stattrac.BusinessRules.Criteria;
using Statline.Stattrac.BusinessRules.Schedule;
using System.Collections;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.Framework;



namespace Statline.Stattrac.BusinessRules.Organization
{
    public enum OrganizationFields
    {
        BillTo
    }
    public class OrganizationBR : BaseBR
    {
        public OrganizationBR()
        {
            grConstant = GeneralConstant.CreateInstance();
            AssociatedDataSet = new OrganizationDS();
            AssociatedDA = new OrganizationDA();
        }
        #region Overridden Methods

        protected override void BusinessRulesBeforeSelect()
        {


            //organizationDS.EnforceConstraints = false;
        }

        /// <summary>
        /// Business Rules After Select
        /// </summary>
        protected override void BusinessRulesAfterSelect()
        {

            switch ((OrganizationDASprocs)Enum.Parse(typeof(OrganizationDASprocs), AssociatedDA.SpSelect, true))
            {
                case OrganizationDASprocs.OrganizationSelectDataSet:

                    //check for row and add initial rows if not exist
                    AddEmptyRow();


                    //modify the OrganizationDisplaySetting to 
                    ((OrganizationDS)AssociatedDataSet).OrganizationDisplaySetting
                        .ToList().ForEach
                    (delegate(OrganizationDS.OrganizationDisplaySettingRow row)
                    {
                        row.AcceptChanges();
                    });

                    //load count base on Organization StateID
                    int stateID = 0;
                    try
                    {
                        stateID = ((OrganizationDS)AssociatedDataSet).Organization[grConstant.FirstRow].StateID;
                    }
                    catch { }
                    CountySelect(stateID);

                    break;
            }


        }
        /// <summary>
        /// This called by ContactCallInstructions when a person Row is selected
        /// </summary>
        public void ContactExpirations(int personID)
        {
            //get the current time to use for all contacts
            DateTime current = DateTime.Now;
            OrganizationDS.PersonRow personRow = PersonRow(personID);
            ContactCheckIsBusyUntil(personRow, current);
            ContactCheckTempCallInstruction(personRow, current);

        }
        /// <summary>
        /// Checks contact row IsBusyUntil and resets if expired
        /// Performance Note: This functionality is currently being ran after selecting.
        ///     This design might have to change to improve performance.
        /// </summary>
        private void ContactCheckIsBusyUntil(OrganizationDS.PersonRow personRow, DateTime current)
        {
            if (personRow == null)
                return;
            if (personRow.RowState == DataRowState.Added || personRow.RowState == DataRowState.Modified)
                return;

            DateTime checkDate = Convert.ToDateTime("1/1/1900 00:00");
            short personBusy = 0;

            //try to set date, protect against null            
            try
            {
                checkDate = personRow.PersonBusyUntil;
            }
            catch
            {
            }

            try
            {
                personBusy = personRow.PersonBusy;
            }
            catch
            {
            }

            if (personBusy == 0)
                return;

            if (checkDate < current)
            {
                personRow.PersonBusy = 0;
                personRow.SetPersonBusyUntilNull();

            }

        }

        /// <summary>
        /// Checks each of the contact temp call instructins and reset if expired
        /// Performance Note: This functionality is currently being ran after selecting.
        ///     This design might have to change to improve performance.
        /// </summary>
        private void ContactCheckTempCallInstruction(OrganizationDS.PersonRow personRow, DateTime current)
        {
            if (personRow == null)
                return;

            if (personRow.RowState == DataRowState.Added || personRow.RowState == DataRowState.Modified)
                return;

            DateTime checkDate = Convert.ToDateTime("1/1/1900 00:00");
            short personTempNoteActive = 0;

            try
            {
                checkDate = personRow.PersonTempNoteExpires;
            }
            catch
            {
            }
            try
            {
                personTempNoteActive = personRow.PersonTempNoteActive;
            }
            catch
            {
            }
            if (personTempNoteActive == 0)
            {
                if (personRow != null)
                    personRow.PersonTempNote = string.Empty;
                return;
            }

            //reset fields
            if (checkDate < current)
            {
                personRow.PersonTempNoteActive = 0;
                personRow.SetPersonTempNoteExpiresNull();
                personRow.PersonTempNote = string.Empty;

            }

        }
        protected override void BusinessRulesAfterSave()
        {
            SetOrganizationID();
            SetContactID();
            SetContactPhoneID();
            //call functionality to create Organization Administration associations for ServiceLevel, Criteria, SourceCode, Alerts, WebReportGroup and Schedules
            AddOrganizationAdministrationDefaults();
        }


        /// <summary>
        /// When a new organization is added to StatTrac through the referral screen, the organization shall be assigned to Administration groups automatically.
        ///
        /// </summary>
        private void AddOrganizationAdministrationDefaults()
        {
            if (!grConstant.IsNewCallOrganization)
                return;

            if (grConstant.SourceCodeId == 0)
                return;
            //SourceCodeOrganization
            SourceCodeBR sourceCodeBR = new SourceCodeBR();
            sourceCodeBR.AddOrganizationDefault(organizationId);

            Hashtable param = new Hashtable();
            param.Add("OrganizationId", organizationId);
            ListControlBR organizationList = new ListControlBR("AdministrationOrganizationSearchSelect", param);
            organizationList.SelectDataSet();
            // check to see an organization was found
            if (organizationList.AssociatedDataSet.ListControlDS().ListControl.Rows.Count == 0)
                return;

            Int32 similarOrganizationId = organizationList.AssociatedDataSet.ListControlDS().ListControl[grConstant.FirstRow].ListId;
            Int32 criteriaStatus = 0;
            //CriteriaOrganization 
            ListControlBR donorCategoryBR = new ListControlBR("DonorCategoryListSelect");
            donorCategoryBR.SelectDataSet();

            donorCategoryBR.AssociatedDataSet.ListControlDS().ListControl.ToList().ForEach(listrow =>
                {

                    CriteriaBR criteriaBR = new CriteriaBR();
                    criteriaBR.DonorCategoryID = listrow.ListId;
                    criteriaBR.OrganizationID = similarOrganizationId;
                    criteriaBR.SourceCodeID = grConstant.SourceCodeId;
                    criteriaBR.CriteriaStatus = criteriaStatus;
                    criteriaBR.AddOrganizationDefault(organizationId);

                });
            
            criteriaStatus = 1;
            donorCategoryBR.AssociatedDataSet.ListControlDS().ListControl.ToList().ForEach(listrow =>
            {

                CriteriaBR criteriaBR = new CriteriaBR();
                criteriaBR.DonorCategoryID = listrow.ListId;
                criteriaBR.OrganizationID = similarOrganizationId;
                criteriaBR.SourceCodeID = grConstant.SourceCodeId;
                criteriaBR.CriteriaStatus = criteriaStatus;
                criteriaBR.AddOrganizationDefault(organizationId);

            });

            //AlertOrganization
            AlertBR alertBR = new AlertBR();
            alertBR.AddOrganizationDefault(organizationId, similarOrganizationId, grConstant.SourceCodeId);

            //WebReportGroupOrg
            WebReportGroupOrgBR webReportGroupOrgBR = new WebReportGroupOrgBR();
            webReportGroupOrgBR.AddOrganizationDefault(organizationId, similarOrganizationId);

            //ServiceLevel30Organization
            ServiceLevel30OrganizationBR serviceLevel30OrganizationBR = new ServiceLevel30OrganizationBR();
            
            criteriaStatus = 0;
            serviceLevel30OrganizationBR.AddOrganizationDefault(organizationId, similarOrganizationId, grConstant.SourceCodeId, criteriaStatus);
            serviceLevel30OrganizationBR.AssociatedDataSet.Clear();
            criteriaStatus = 1;
            serviceLevel30OrganizationBR.AddOrganizationDefault(organizationId, similarOrganizationId, grConstant.SourceCodeId, criteriaStatus);
            

            //ScheduleGroupOrganization
            ScheduleGroupOrganizationBR scheduleGroupOrganizationBR = new ScheduleGroupOrganizationBR();
            scheduleGroupOrganizationBR.AddOrganizationDefault(organizationId, similarOrganizationId, grConstant.SourceCodeId);

        }
        protected override void BusinessRulesBeforeSave()
        {
            OrganizationDS organizationDs = (OrganizationDS)AssociatedDataSet;
            #region System Requirements; Code required to make things work
            //for each person row that has a rowstate of Added or Modified update the statEmployee table
            organizationDs.Person.Where(
                row => row.RowState == DataRowState.Added || row.RowState == DataRowState.Modified).ToList().ForEach(
                row => UpdateStatEmployeeRecord(row)
                );

            //Bret 5/20/2011 WI 12213
            // - set Default HasNewContactRecord 
            HasNewContactRecord = false;
            //- now set it to true if any records are new
            organizationDs.Person.Where(
                row => row.RowState == DataRowState.Added).ToList().FirstOrDefault(row => HasNewContactRecord = true);

            //for each webPerson row that has changed modify and update the statEmployee table
            organizationDs.WebPerson.Where(
                webPersonRow => webPersonRow.RowState == DataRowState.Added || webPersonRow.RowState == DataRowState.Modified).ToList().ForEach(
                alteredRow => UpdateStatEmployeeRecord(alteredRow));


            //check the state of each table if the data has changed update the lastmodified, logtype and LastStatEmployeeID
            for (int forLoop = 0; forLoop < organizationDs.Tables.Count; forLoop++)
            {
                SetDefaultModifiedValues(organizationDs.Tables[forLoop]);
            }

            ////the following statement loops through the OrganizationDisplaySetting and sets new records to Added

            ((OrganizationDS)AssociatedDataSet).OrganizationDisplaySetting.Where
                (row => row.RowState != DataRowState.Deleted).ToList().Where
                (row => row.OrganizationDisplaySettingID < 0 && row.Hidden == false).ToList().ForEach
                (row =>
                {
                    if (row.DashBoardDisplaySettingID < 1 && row.RowState == DataRowState.Unchanged)
                        row.SetAdded();
                });

            // check the organization table If a foreign key field = 0 set it to null 
            organizationDs.Organization.Where
                (row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added).ToList().ForEach
                (organizationRow =>
                     {
                         if (organizationRow.CountyID == 0)
                             organizationRow.SetCountyIDNull();
                         if (organizationRow.StateID == 0)
                             organizationRow.SetStateIDNull();
                         if (organizationRow.CountryID == 0)
                             organizationRow.SetCountryIDNull();
                     }
                );


            //broke code out to seperate method
            OrganizationChangeNotification(organizationDs);
            //WI 3367
            Boolean sendEmail = true;
            CheckConflictingOrganizationPhone(sendEmail);

            //WI 9376 OrganizationAddNotification
            OrganizationAddNotification(organizationDs);

            //WI 12421 if Organization is set to delete cancel any adds.
            if (organizationDs.Organization[grConstant.FirstRow].RowState == DataRowState.Deleted)
                organizationDs.Tables.OfType<DataTable>().ToList().ForEach(table =>
                    {
                        table.Rows.OfType<DataRow>().ToList().ForEach(row =>
                            {
                                if (row.RowState == DataRowState.Added)
                                    row.AcceptChanges();
                            });
                    });
            #endregion
        }
        /// <summary>
        /// WI 3367
        /// 1. look for new OranizationPhone records
        /// 2. Search for existing record
        /// 3. If any are found generates test message. 
        /// </summary>
        private string CheckConflictingOrganizationPhone(OrganizationDS organizationDs)
        {
            StringBuilder message = new StringBuilder();

            //1. look for new OranizationPhone records
            // clear OrganizationPHoneSearch before starting
            organizationDs.OrganizationPhone.Where(organizationPhoneRow => organizationPhoneRow.RowState == DataRowState.Added || organizationPhoneRow.RowState == DataRowState.Modified).ToList().ForEach
                (modifiedRow =>
                {
                    //2.Search for existing record
                    if (!modifiedRow.IsPhoneNull())
                        SelectOrganizationPhoneSearch(modifiedRow.Phone);

                });
            //3.If any are found in existing organizations Create a string of information.
            if (((OrganizationDS)AssociatedDataSet).OrganizationPhoneSearch.Count > 0)
            {
                OrganizationSearchBR organizationSearchBR = new OrganizationSearchBR();
                ((OrganizationDS)AssociatedDataSet).OrganizationPhoneSearch.ToList().ForEach
                    (organizationPhoneSearchRow =>
                        {
                            organizationSearchBR.OrganizationId = organizationPhoneSearchRow.OrganizationID;
                            organizationSearchBR.DisplayAllOrganizations = true;
                            organizationSearchBR.SelectDataSet();
                            string organizationName = "";
                            string organizationPhysicalAddress = "";
                            if (((OrganizationSearchDS)organizationSearchBR.AssociatedDataSet).OrganizationSearch.Count > 0)
                            {
                                organizationName = ((OrganizationSearchDS)organizationSearchBR.AssociatedDataSet).OrganizationSearch[grConstant.FirstRow].OrganizationName;
                                organizationPhysicalAddress = ((OrganizationSearchDS)organizationSearchBR.AssociatedDataSet).OrganizationSearch[grConstant.FirstRow].PhysicalAddress;
                            }

                            message.Append(string.Format("The Phone # {0} exists in \n\tOrganization {1}.\n\t{2}", organizationPhoneSearchRow.Phone, organizationName, organizationPhysicalAddress));

                        });

            }

            return message.ToString();
        }
        /// <summary>
        /// Checks for duplicate phone Numbers and sends an email.
        /// </summary>
        /// <param name="sendEmail"></param>
        /// <returns></returns>
        public string CheckConflictingOrganizationPhone(Boolean sendEmail)
        {
            if (((OrganizationDS)AssociatedDataSet).Organization.Rows.Count == 0)
                return "";
            //call method to check for duplicates and generate string.
            string message = CheckConflictingOrganizationPhone((OrganizationDS)AssociatedDataSet);

            if (sendEmail && message.Length > 0)
            {
                string organizationName = ((OrganizationDS)AssociatedDataSet).Organization[grConstant.FirstRow].OrganizationName;
                string emailMessage = string.Format("{0} has changed {1} and was notified of the following.\n{2}", StattracIdentity.Identity.UserName, organizationName, message);
                BaseLogger.EmailClientServices(emailMessage, LoggingCategories.ClientServicesNotification);
            }

            return message;

        }
        /// <summary>
        /// Searches existing numbers where phone exists
        /// </summary>
        private void SelectOrganizationPhoneSearch(string phone)
        {
            ((OrganizationDA)AssociatedDA).Phone = phone;
            ((OrganizationDA)AssociatedDA).SelectOrganizationPhoneSearch();
            Select();
        }

        /// <summary>
        /// WI 9376 If any user adds a new organization through a referral or through the organization screen, 
        /// notification shall be sent by email to the Service Consultants.  
        /// The email shall include the name of the organization, source code, who created the organization, 
        /// and the date/time it was created.
        /// </summary>
        /// <param name="organizationDs"></param>
        private void OrganizationAddNotification(OrganizationDS organizationDs)
        {

            bool organizationIsNew = false;
            organizationIsNew = organizationDs.Organization.Any(currentRow => currentRow.RowState == DataRowState.Added);
            if (organizationIsNew)
            {
                string organizationName = organizationDs.Organization[grConstant.FirstRow].OrganizationName;
                string sourceCodeName = grConstant.SourceCodeName;
                if (sourceCodeName == null)
                    sourceCodeName = "Unknown (added through Organization Screen)";
                string organizationChangeMessage = string.Format("{0} has created {1} in Source Code {2} on {3} ",
                    StattracIdentity.Identity.UserName,
                    organizationName,
                    sourceCodeName,
                    DateTime.Now.ToString("MM/dd/yyyy HH:mm")
                    );
                BaseLogger.EmailClientServices(organizationChangeMessage, LoggingCategories.ClientServicesNotification);
            }
        }
        /// <summary>
        /// WI 5439
        /// </summary>
        /// <param name="organizationDs"></param>
        private void OrganizationChangeNotification(OrganizationDS organizationDs)
        {
            // WI 5439 send an email if Organization information has changed
            // check the following tables
            //  Organization
            //  OrganizationNumbers
            //  OrganizationAlias
            bool organizationHasChanged = false;
            bool organizationPhoneHasChanged = false;
            bool organizationAliasHasChanged = false;
            organizationHasChanged = organizationDs.Organization.Any(currentRow => currentRow.RowState == DataRowState.Modified);
            organizationPhoneHasChanged = organizationDs.OrganizationPhone.Any(currentRow => currentRow.RowState == DataRowState.Modified);
            organizationAliasHasChanged = organizationDs.OrganizationAlias.Any(currentRow => currentRow.RowState == DataRowState.Modified);
            if (organizationHasChanged || organizationPhoneHasChanged || organizationAliasHasChanged)
            {
                string organizationName = organizationDs.Organization[grConstant.FirstRow].OrganizationName;

                string organizationChangeMessage = string.Format("{0} has changed {1}", StattracIdentity.Identity.UserName, organizationName);
                BaseLogger.EmailClientServices(organizationChangeMessage, LoggingCategories.ClientServicesNotification);
            }
        }

        #endregion

        #region Fields/Properties
        private GeneralConstant grConstant;
        private int organizationId;
        private int contactId;
        public Boolean HasNewContactRecord { get; set; }
        public int ContactId
        {
            get { return contactId; }
            set
            {
                contactId = value;
                ((OrganizationDA)AssociatedDA).ContactId = value;
            }
        }
        public int OrganizationId
        {
            get { return organizationId; }
            set
            {
                organizationId = value;
                ((OrganizationDA)AssociatedDA).OrganizationId = value;
            }
        }
        public int CheckForUserNameDuplicatesResults
        {
            get
            {
                return ((OrganizationDA)AssociatedDA).CheckForUserNameDuplicatesResults;
            }
            set
            {
                ((OrganizationDA)AssociatedDA).CheckForUserNameDuplicatesResults = value;
            }
        }
        public string WebPersonUserName
        {
            get
            {
                return ((OrganizationDA)AssociatedDA).WebPersonUserName;
            }
            set
            {
                ((OrganizationDA)AssociatedDA).WebPersonUserName = value;
            }
        }
        public int WebPersonId
        {
            get
            {
                return ((OrganizationDA)AssociatedDA).WebPersonId;
            }
            set
            {
                ((OrganizationDA)AssociatedDA).WebPersonId = value;
            }

        }
        public Boolean PersonInactive
        {
            get
            {
                return ((OrganizationDA)AssociatedDA).PersonInactive;
            }
            set
            {
                ((OrganizationDA)AssociatedDA).PersonInactive = value;
            }
        }

        #endregion

        #region private methods
        private void SetDefaultModifiedValues(DataTable table)
        {
            table.Select().ToList().ForEach(delegate(DataRow row)
            {
                if (row.RowState != DataRowState.Modified && row.RowState != DataRowState.Added)
                    return;

                if (row.Table.Columns.Contains("LastStatEmployeeID"))
                    row[row.Table.Columns["LastStatEmployeeID"].Ordinal] = StattracIdentity.Identity.UserId;
                if (row.Table.Columns.Contains("LastModified"))
                    row[row.Table.Columns["LastModified"].Ordinal] = grConstant.CurrentDateTime;
                if (row.Table.Columns.Contains("AuditLogTypeID"))
                    row[row.Table.Columns["AuditLogTypeID"].Ordinal] = GeneralConstant.AuditLogType.Modify;
                row.EndEdit();
            });

            // row => row.RowState == DataRowState.Modified)

        }
        /// <summary>
        /// Set the default values on the tables
        /// </summary>
        private void SetDefaultValue()
        {
            OrganizationDS organizationDs = (OrganizationDS)AssociatedDataSet;
            SetDefaultValue(organizationDs.BillTo);
            SetDefaultValue(organizationDs.OrganizationAlias);
            SetDefaultValue(organizationDs.OrganizationASPSetting);
            SetDefaultValue(organizationDs.OrganizationCaseReview);
            SetDefaultValue(organizationDs.OrganizationDashBoardTimer);
            SetDefaultValue(organizationDs.OrganizationDisplaySetting);
            SetDefaultValue(organizationDs.OrganizationDuplicateSearchRule);
            SetDefaultValue(organizationDs.OrganizationFsSourceCode);
            SetDefaultValue(organizationDs.OrganizationSourceCode);
            SetDefaultValue(organizationDs.OrganizationPhone);
            SetDefaultValue(organizationDs.Person);
            SetDefaultValue(organizationDs.PersonPhone);
            SetDefaultValue(organizationDs.ContactCallInstruction);
            SetDefaultValue(organizationDs.ContactRole);
            SetDefaultValue(organizationDs.ContactPermission);
            SetDefaultValue(organizationDs.WebPerson);
            SetDefaultValue(organizationDs.StatEmployee);




        }
        /// <summary>
        /// Add an empty row if the case is new
        /// </summary>
        private void AddEmptyRow()
        {
            OrganizationDS organizationDS = (OrganizationDS)AssociatedDataSet;
            SetDefaultValue(organizationDS.Organization);
            if (organizationDS.Organization.Count == 0)
                AddEmptyRow(organizationDS.Organization);
            SetOrganizationID();
            //Set Default Values here. at this point Organization exists if it
            SetDefaultValue();

            //run the next block of code only if the Organization is a StatTracOrganization
            if (organizationDS.Organization[grConstant.FirstRow].StatTracOrganization == false)
                return;
            if (organizationDS.OrganizationDuplicateSearchRule.Count == 0)
                AddDefaultData(organizationDS.OrganizationDuplicateSearchRule);
            if (organizationDS.OrganizationDashBoardTimer.Count == 0)
                AddDefaultData(organizationDS.OrganizationDashBoardTimer);
            if (organizationDS.OrganizationASPSetting.Count == 0)
                AddEmptyRow(organizationDS.OrganizationASPSetting);


        }
        /// <summary>
        /// determines the new OrganizationID
        /// </summary>
        private void SetOrganizationID()
        {
            OrganizationDS organizationDS = (OrganizationDS)AssociatedDataSet;
            if (organizationDS.Organization.Count == 0)
                return;
            OrganizationId = organizationDS.Organization[grConstant.FirstRow].OrganizationID;
            grConstant.OrganizationId = OrganizationId;
        }
        /// <summary>
        /// Determines the new ContactID
        /// </summary>
        private void SetContactID()
        {
            OrganizationDS organizationDS = (OrganizationDS)AssociatedDataSet;
            if (organizationDS.Person.Count == 0)
                return;
            //this assumes only one contact was added to the Organizations Contacts
            //Bret 5/20 WI 12213 on update ContactID if new record was added.
            // --- this assumes only one record was added and that a record was not added and then another one updated.
            // -- code will always reset contactID if a new person/contact record was created
            if (HasNewContactRecord)
                grConstant.ContactId = organizationDS.Person.Max(personRow => personRow.PersonID);

        }
        /// <summary>
        /// Determines the new ContactPhoneID
        /// </summary>
        private void SetContactPhoneID()
        {
            OrganizationDS organizationDS = (OrganizationDS)AssociatedDataSet;
            if (organizationDS.PersonPhone.Count == 0)
                return;
            //this assumes only one contact was added to the Organizations Contacts
            grConstant.ContactPhoneId = organizationDS.PersonPhone.Max(personPhoneRow => personPhoneRow.PersonPhoneID);

        }

        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            OrganizationDS organizationDS = (OrganizationDS)AssociatedDataSet;
            if (dataTable.Columns.Contains("OrganizationID") && !dataTable.Columns["OrganizationID"].AutoIncrement)
            {
                dataTable.Columns["OrganizationID"].DefaultValue = organizationDS.Organization[grConstant.FirstRow].OrganizationID;
            }
            if (dataTable.Columns.Contains("LastStatEmployeeID"))
                dataTable.Columns["LastStatEmployeeID"].DefaultValue = StattracIdentity.Identity.UserId;
            if (dataTable.Columns.Contains("LastModified"))
                dataTable.Columns["LastModified"].DefaultValue = grConstant.CurrentDateTime;
            if (dataTable.Columns.Contains("AuditLogTypeID"))
                dataTable.Columns["AuditLogTypeID"].DefaultValue = GeneralConstant.AuditLogType.Create;
        }
        /// <summary>
        /// Add an empty row to the table
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        private DataRow AddEmptyRow(DataTable table)
        {
            DataRow row = table.NewRow();
            table.Rows.Add(row);
            return row;
        }

        private void AddDefaultData(OrganizationDS.OrganizationDuplicateSearchRuleDataTable table)
        {
            OrganizationDS organizationDs = (OrganizationDS)AssociatedDataSet;
            SelectDuplicateSearchRuleDefault();

            if (organizationDs.DuplicateSearchRuleDefault.Count > 0)
            {
                organizationDs.DuplicateSearchRuleDefault.ToList().ForEach(delegate(OrganizationDS.DuplicateSearchRuleDefaultRow row)
                {

                    OrganizationDS.OrganizationDuplicateSearchRuleRow newRow = table.NewOrganizationDuplicateSearchRuleRow();
                    newRow.CallTypeID = row.CallTypeID;
                    newRow.CallType = row.CallType;
                    newRow.DuplicateSearchRuleID = row.DuplicateSearchRuleDefaultID;
                    newRow.DuplicateSearchRule = row.DuplicateSearchRule;
                    newRow.NumberOfDaysToSearch = row.NumberOfDaysToSearch;
                    organizationDs.OrganizationDuplicateSearchRule.AddOrganizationDuplicateSearchRuleRow(newRow);
                }
                    );
            }

        }
        private void AddDefaultData(OrganizationDS.OrganizationDashBoardTimerDataTable table)
        {
            OrganizationDS organizationDS = (OrganizationDS)AssociatedDataSet;
            SelectDashBoardTimerDefault();

            if (organizationDS.DashBoardTimerDefault.Count > 0)
            {
                organizationDS.DashBoardTimerDefault.ToList().ForEach(delegate(OrganizationDS.DashBoardTimerDefaultRow row)
                {

                    OrganizationDS.OrganizationDashBoardTimerRow newRow = table.NewOrganizationDashBoardTimerRow();
                    newRow.DashBoardWindowID = row.DashBoardWindowId;
                    newRow.DashBoardWindow = row.DashBoardWindow;
                    newRow.DashBoardTimerTypeID = row.DashBoardTimerTypeId;
                    newRow.DashBoardTimerType = row.DashBoardTimerType;
                    newRow.ExpirationMinutes = row.ExpirationMinutes;
                    organizationDS.OrganizationDashBoardTimer.AddOrganizationDashBoardTimerRow(newRow);
                }
                    );
            }

        }

        protected void Select()
        {
            base.Select();
            ((OrganizationDA)AssociatedDA).SetDefaultTableSelect();
        }

        protected void ExecuteNonQuery()
        {
            base.ExecuteNonQuery();
            ((OrganizationDA)AssociatedDA).SetDefaultTableSelect();
        }

        #endregion

        #region public methods
        /// <summary>
        /// 1 create an array of DataRows
        /// 2 find all rows based on filter
        /// 3 return true if a records exists.
        /// </summary>
        /// <param name="filter"></param>
        public Boolean StatEmployeeRecordExists(string filter)
        {
            //create a boolean parameter to return
            Boolean returnValue = false;

            // 1
            DataRow[] statEmployeeRow;
            // 2
            statEmployeeRow = ((OrganizationDS)AssociatedDataSet).StatEmployee.Select(filter);
            // 3
            if (statEmployeeRow != null)
                if (statEmployeeRow.Length > 0)
                    returnValue = true;

            return returnValue;

        }
        /// <summary>
        /// Update StatEmployee record based on PersonID
        /// </summary>
        /// <param name="personID"></param>
        /// <param name="statEmployeeRow"></param>
        public void UpdateStatEmployeeRecord(int personID, ref OrganizationDS.StatEmployeeRow statEmployeeRow)
        {
            OrganizationDS.PersonRow personRow;
            OrganizationDS.WebPersonRow webPersonRow;
            personRow = PersonRow(personID);
            webPersonRow = WebPersonRow(personID);

            if (personRow == null)
                return;

            UpdateStatEmployeeRecord(webPersonRow, personRow, ref statEmployeeRow);

        }
        /// <summary>
        /// update webPersonRow based on personrow
        /// </summary>
        /// <param name="personRow"></param>
        public void UpdateStatEmployeeRecord(OrganizationDS.PersonRow personRow)
        {
            OrganizationDS.WebPersonRow webPersonRow;
            OrganizationDS.StatEmployeeRow statEmployeeRow;

            webPersonRow = WebPersonRow(personRow.PersonID);
            statEmployeeRow = StatEmployeeRow(personRow.PersonID);
            if (webPersonRow == null || statEmployeeRow == null)
                return;
            UpdateStatEmployeeRecord(webPersonRow, personRow, ref statEmployeeRow);
        }
        public void UpdateStatEmployeeRecord(OrganizationDS.WebPersonRow webPersonRow)
        {
            OrganizationDS.PersonRow personRow;
            OrganizationDS.StatEmployeeRow statEmployeeRow;

            personRow = PersonRow(webPersonRow.PersonID);
            statEmployeeRow = StatEmployeeRow(webPersonRow.PersonID);
            if (personRow == null || statEmployeeRow == null)
                return;
            UpdateStatEmployeeRecord(webPersonRow, personRow, ref statEmployeeRow);


        }
        public void UpdateStatEmployeeRecord(OrganizationDS.WebPersonRow webPersonRow, OrganizationDS.PersonRow personRow, ref OrganizationDS.StatEmployeeRow statEmployeeRow)
        {

            //statEmployeeRow.PersonID = personID;
            statEmployeeRow.StatEmployeeFirstName = personRow.PersonFirst;
            statEmployeeRow.StatEmployeeLastName = personRow.PersonLast;
            statEmployeeRow.StatEmployeeUserID = webPersonRow.WebPersonUserName;

            try
            {
                if (webPersonRow.WebPersonEmail != null)
                    statEmployeeRow.StatEmployeeEmail = "pgrrspnse@statline.com";
            }
            catch
            {   //assume the current value is dbnull
                statEmployeeRow.StatEmployeeEmail = "pgrrspnse@statline.com";
            }
            statEmployeeRow.EndEdit();

        }


        private OrganizationDS.StatEmployeeRow StatEmployeeRow(int personID)
        {
            OrganizationDS.StatEmployeeRow statEmployeeRow = null;
            DataRow[] dataRow;
            string personIDFilter = string.Format("PersonID = {0}", personID);
            dataRow = ((OrganizationDS)AssociatedDataSet).StatEmployee.Select(personIDFilter);
            if (dataRow.Length > 0)
                statEmployeeRow = (OrganizationDS.StatEmployeeRow)dataRow[grConstant.FirstRow];

            return statEmployeeRow;

        }
        public OrganizationDS.WebPersonRow WebPersonRow(int personID)
        {
            OrganizationDS.WebPersonRow webPersonRow = null;
            DataRow[] dataRow;
            string personIDFilter = string.Format("PersonID = {0}", personID);
            dataRow = ((OrganizationDS)AssociatedDataSet).WebPerson.Select(personIDFilter);
            if (dataRow.Count() > 0)
                webPersonRow = (OrganizationDS.WebPersonRow)dataRow[grConstant.FirstRow];

            return webPersonRow;
        }

        public OrganizationDS.PersonRow PersonRow(int personID)
        {
            OrganizationDS.PersonRow personRow;
            personRow = ((OrganizationDS)AssociatedDataSet).Person.FindByPersonID(personID);
            return personRow;
        }
        public void PersonSelect(int personID)
        {
            OrganizationDS.PersonRow personRow = PersonRow(personID);
            if (personRow != null)
                return;
            ((OrganizationDA)AssociatedDA).PersonSelect(personID);
            Select();
            
        }
        ///// <summary>
        ///// Update WebPerson record based on PersonID
        ///// </summary>
        ///// <param name="personID"></param>
        ///// <param name="statEmployeeRow"></param>
        //public void UpdateStatEmployeeRecord(int personID, ref OrganizationDS.WebPersonRow webPersonRow )
        //{
        //    OrganizationDS.PersonRow personRow;


        //    personRow = ((OrganizationDS)AssociatedDataSet).Person.FindByPersonID(personID);

        //    if (personRow == null)
        //        return;

        //    webPersonRow.


        //    statEmployeeRow.StatEmployeeFirstName = personRow.PersonFirst;
        //    statEmployeeRow.StatEmployeeLastName = personRow.PersonLast;

        //    if (webPersonCollection == null)
        //        return;
        //    if (webPersonCollection.Count() == 0)
        //        return;
        //    webPersonRow = webPersonCollection.First();
        //    if (webPersonRow == null)
        //        return;
        //    statEmployeeRow.StatEmployeeUserID = webPersonRow.WebPersonUserName;

        //}
        public int CheckForUserNameDuplicates(string userName, int webPersonID, int personID)
        {
            Boolean personInactive = false;
            OrganizationDS.PersonRow personRow;

            personRow = PersonRow(personID);
            if (personRow != null)
                personInactive = personRow.Inactive;

            //set values in the BR used to CheckForUserName
            WebPersonUserName = userName;
            WebPersonId = webPersonID;
            PersonInactive = personInactive;

            //Setup DA for query
            ((OrganizationDA)AssociatedDA).CheckForUserNameDuplicates();
            ExecuteNonQuery();

            return CheckForUserNameDuplicatesResults;
        }

        public void SelectDuplicateSearchRuleDefault()
        {
            ((OrganizationDA)AssociatedDA).SelectDuplicateSearchRuleDefault();
            Select();
        }
        public void SelectDashBoardTimerDefault()
        {
            ((OrganizationDA)AssociatedDA).SelectDashBoardTimerDefault();
            Select();

        }
        public void SelectAssociatedReferral(int phoneId)
        {
            //production
            ((OrganizationDA)AssociatedDA).SelectAssociatedReferrals(phoneId);
            Select();

            //archive
            if (grConstant.CurrentDB == DatabaseInstance.Production.ToString())
            {
                grConstant.CurrentDB = DatabaseInstance.ProductionArchive.ToString();
                ((OrganizationDA)AssociatedDA).SelectAssociatedReferrals(phoneId);
                Select();
                grConstant.CurrentDB = DatabaseInstance.Production.ToString();
            }

        }
        public void SelectOrganizationDupes(string organizationName, int stateId, int countyId)
        {
            ((OrganizationDS)AssociatedDataSet).OrganizationSearch.Clear();
            ((OrganizationDA)AssociatedDA).SelectOrganizationDupes(organizationName, stateId, countyId);
            Select();

        }
        public void SelectContactRoles(int webPersonID, int personID)
        {

            string personIdFilter = string.Format("PersonId = {0}", personID);
            // check to see if ContactRole exists for user
            // if contact role exists exit method.
            if (((OrganizationDS)AssociatedDataSet).ContactRole.Select(personIdFilter).Count() > 0)
                return;

            //check to see if Role is empty and select Role if empty
            if (((OrganizationDS)AssociatedDataSet).Role.Rows.Count == 0)
            {
                ((OrganizationDA)AssociatedDA).SelectContactRoles();
                Select();
            }

            if (((OrganizationDS)AssociatedDataSet).Role.Rows.Count > 0)
            {
                OrganizationDS.PersonRow personRow = PersonRow(personID);
                OrganizationDS.WebPersonRow webPersonRow = WebPersonRow(personID);
                //for each role add it ContactRole table
                if (personRow != null)
                {
                    ((OrganizationDS)AssociatedDataSet).Role.ToList().ForEach(roleRow =>
                        {
                            OrganizationDS.ContactRoleRow contactRoleRow = ((OrganizationDS)AssociatedDataSet).ContactRole.NewContactRoleRow();
                            contactRoleRow.WebPersonID = webPersonRow.WebPersonID;
                            contactRoleRow.PersonID = personRow.PersonID;
                            contactRoleRow.RoleID = roleRow.RoleID;
                            contactRoleRow.RoleName = roleRow.RoleName;
                            contactRoleRow.LastModified = DateTime.Now;
                            contactRoleRow.LastStatEmployeeID = -1;
                            contactRoleRow.AuditLogTypeID = 1;
                            contactRoleRow.HIDDEN = false;

                            ((OrganizationDS)AssociatedDataSet).ContactRole.AddContactRoleRow(contactRoleRow);
                        }
                        );
                }
            }

        }
        /// <summary>
        /// Builds the new records for a ContactPermission
        /// Returns true of a records are added
        /// 1. Checks to See if records exist for user and exits if they do
        /// 2. Get the Webperson Row, exit if not found
        /// 3. Confirm the UserName is exists, exit if not
        /// 4. Fill the SecurityRule table
        /// </summary>
        /// <param name="personID"></param>
        /// <returns></returns>
        public Boolean SelectContactPermission(int personID)
        {
            Boolean recordAdded = false;
            string personIdFilter = string.Format("PersonId = {0}", personID);
            OrganizationDS.WebPersonRow webPersonRow;

            //check to see if ContactPermission exists for user
            // if contact role exists exit method.
            // 1
            if (((OrganizationDS)AssociatedDataSet).ContactPermission.Select(personIdFilter).Count() > 0)
                return recordAdded;

            //2
            webPersonRow = WebPersonRow(personID);
            if (webPersonRow == null)
                return recordAdded;

            //3
            if (webPersonRow.WebPersonUserName.Length == 0)
                return recordAdded;

            //4
            //ContactPermission does not exists for user so see if SecurityRule exists
            if (((OrganizationDS)AssociatedDataSet).SecurityRule.Rows.Count == 0)
            {
                ((OrganizationDA)AssociatedDA).SelectSecurityRule();
                Select();

            }

            //SecurityRule exists
            //Create a record for each permission
            if (((OrganizationDS)AssociatedDataSet).SecurityRule.Rows.Count > 0)
            {
                //for each SecurityRule row that exists in the SecurityRule enum add record to ControlPermission
                ////// Change this to for 
                ((OrganizationDS)AssociatedDataSet).SecurityRule.ToList().ForEach
                    //(delegate(OrganizationDS.SecurityRuleRow securityRuleRow) // note when multiple lines are used replace lambda with delegate
                    (securityRuleRow =>
                    {
                        if (!Enum.IsDefined(typeof(SecurityRule), securityRuleRow.SecurityRule))
                            return;
                        recordAdded = true;
                        Boolean hideRow = true;
                        ((OrganizationDS)AssociatedDataSet).ContactPermission.AddContactPermissionRow(webPersonRow.WebPersonID, personID, securityRuleRow.SecurityRuleID, securityRuleRow.SecurityRule, DateTime.Now, -1, 1, hideRow);
                    }
                    );

            }

            return recordAdded;

        }

        /// <summary>
        /// Update the SecurityRule table
        /// 
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="addPermission"></param>
        public void ModifySecurityRuleTable(string userName, string securityRuleName, Boolean addPermission)
        {
            OrganizationDS.SecurityRuleRow securityRuleRow;
            string expressionString = string.Format(" OR I:{0}", userName);
            //confirm SecurityRule Table is filled
            if (((OrganizationDS)AssociatedDataSet).SecurityRule.Rows.Count == 0)
            {
                ((OrganizationDA)AssociatedDA).SelectSecurityRule();

                Select();
            }

            //find the row containing the permission and either add or remove the permission
            securityRuleRow = ((OrganizationDS)AssociatedDataSet).SecurityRule.First(securityRuleRowFirst =>
               securityRuleRowFirst.SecurityRule == securityRuleName);

            if (securityRuleRow == null)
                return;

            if (addPermission)
            {
                //confirm the permission does not exists
                if (securityRuleRow.Expression.Contains(userName))
                    return;
                securityRuleRow.Expression = string.Format("{0} {1}", securityRuleRow.Expression, expressionString);

            }
            else
            {

                securityRuleRow.Expression = securityRuleRow.Expression.Replace(expressionString, string.Empty);
            }


        }
        /// <summary>
        /// Checks a specific field or table to confirm validation
        /// </summary>
        /// <param name="field"></param>
        /// <returns></returns>
        public Boolean ValidField(OrganizationFields field)
        {
            Boolean validField = false;
            switch (field)
            {   //WI 3327 Billing Address is required for ContractedStatlineClients
                case OrganizationFields.BillTo:
                    if (((OrganizationDS)AssociatedDataSet).Organization[grConstant.FirstRow].ContractedStatlineClient)
                    {
                        if (((OrganizationDS)AssociatedDataSet).BillTo.Count > 0)
                            validField = true;
                    }
                    else
                    {
                        validField = true;
                    }
                    break;
                default:
                    break;
            }
            return validField;

        }
        /// <summary>
        /// Looks up a TimeZone by TimeZoneId and returns Observation of Daylight Savings
        /// </summary>
        /// <returns></returns>
        public Boolean ObservesDayLightSavings(int timeZoneId)
        {

            Boolean observesDayLightSavings = false;
            try
            {
                SelectTimeZone();

                OrganizationDS.TimeZoneRow timeZoneRow;
                timeZoneRow = ((OrganizationDS)AssociatedDataSet).TimeZone.FindByTimeZoneID(timeZoneId);
                if (timeZoneId < 1)
                    return observesDayLightSavings;

                observesDayLightSavings = timeZoneRow.ObservesDaylightSavings;
            }
            catch (Exception exception)
            {
                BaseLogger.LogFormUnhandledException(exception);
            }

            return observesDayLightSavings;

        }
        /// <summary>
        /// 1 check if records exist and exit if they do
        /// 2 load the table
        /// </summary>
        public void SelectTimeZone()
        {
            //1
            if (((OrganizationDS)AssociatedDataSet).TimeZone.Count() > 0)
                return;

            //2
            ((OrganizationDA)AssociatedDA).SelectTimeZone();
            Select();

        }
        /// <summary>
        /// 1. check to see if a row exists for the current type
        /// 2. create the record if it does not exist
        /// </summary>
        /// <param name="phoneType"></param>
        /// <returns></returns>
        public List<OrganizationDS.OrganizationPhoneRow> SelectOrganizationPhone(string phoneType)
        {
            List<OrganizationDS.OrganizationPhoneRow> organizationPhoneRowList;
            DataRow[] listControlRow;
            string listControlFilter = string.Format("FieldValue = '{0}'", phoneType);
            int phoneTypeID = 0;

            // find the PhoneTypeID
            Hashtable param = new Hashtable();
            param.Add("SelectAll", 1);
            ListControlBR listControlBR = new ListControlBR("PhoneTypeListSelect", param);
            listControlBR.SelectDataSet();

            listControlRow = ((ListControlDS)listControlBR.AssociatedDataSet).ListControl.Select(listControlFilter);
            if (listControlRow.Count() > 0)
            {
                phoneTypeID = (int)listControlRow[grConstant.FirstRow]["ListID"];
                phoneType = (string)listControlRow[grConstant.FirstRow]["FieldValue"];
            }
            string organizationPhoneFilter = string.Format("PhoneTypeID = '{0}'", phoneTypeID);
            organizationPhoneRowList = ((OrganizationDS)AssociatedDataSet).OrganizationPhone.Select(organizationPhoneFilter).ToList().ConvertAll<OrganizationDS.OrganizationPhoneRow>(dataRow => (OrganizationDS.OrganizationPhoneRow)dataRow);

            if (phoneTypeID == 0)
                return organizationPhoneRowList;
            //create a record if there are no records
            if (organizationPhoneRowList.Count == 0)
            {
                OrganizationDS.OrganizationPhoneRow newPhoneRow;
                newPhoneRow = ((OrganizationDS)AssociatedDataSet).OrganizationPhone.NewOrganizationPhoneRow();
                newPhoneRow.AuditLogTypeID = 1;

                newPhoneRow.PhoneTypeID = phoneTypeID;
                newPhoneRow.PhoneType = phoneType;

                ((OrganizationDS)AssociatedDataSet).OrganizationPhone.AddOrganizationPhoneRow(newPhoneRow);

                organizationPhoneRowList = ((OrganizationDS)AssociatedDataSet).OrganizationPhone.Select(organizationPhoneFilter).ToList().ConvertAll<OrganizationDS.OrganizationPhoneRow>(dataRow => (OrganizationDS.OrganizationPhoneRow)dataRow);

            }
            return organizationPhoneRowList;
        }
        public Boolean DeleteOrganization(int organizationID)
        {
            Boolean deleted = false;

            OrganizationId = organizationID;
            SelectDataSet();

            if (((OrganizationDS)AssociatedDataSet).Organization.Count == 0)
                return deleted;
            if (((OrganizationDS)AssociatedDataSet).Organization[grConstant.FirstRow].OrganizationID != organizationId)
                return deleted;

            ((OrganizationDS)AssociatedDataSet).Organization[grConstant.FirstRow].Delete();
            try
            {
                SaveDataSet();
            }
            catch
            {
                deleted = false;
            }
            SelectDataSet();

            //set deleted to true
            if (((OrganizationDS)AssociatedDataSet).Organization.Count == 0)
                deleted = true;

            return deleted;
        }

        public void SelectOrganization()
        {
            ((OrganizationDA)AssociatedDA).SelectOranization();
            Select();
        }
        public void CountySelect(int stateID)
        {
            if (stateID == 0)
                return;
            //check County table for stateID and return if it exists
            if (((OrganizationDS)AssociatedDataSet).County.Any(countyRow => countyRow.StateID == stateID && countyRow.CountyID > 1))
                return;
            ((OrganizationDA)AssociatedDA).StateId = stateID;
            ((OrganizationDS)AssociatedDataSet).County.Clear();
            ((OrganizationDA)AssociatedDA).CountySelect();
            Select();
            CountyDefaultRow(stateID);

        }
        private void CountyDefaultRow(int stateID)
        {
            //each stateID group of Counties need a Select A Value Row.
            //create a new row
            //assign look for countID = 0 for the current state
            //create a new row if it does not exist.
            OrganizationDS.CountyRow countyRow;
            countyRow = ((OrganizationDS)AssociatedDataSet).County.FindByCountyID(0);
            if (countyRow == null)
            {
                countyRow = ((OrganizationDS)AssociatedDataSet).County.NewCountyRow();
                countyRow.CountyID = 0;
                countyRow.CountyName = "Select A Value";
                countyRow.StateID = stateID;
                ((OrganizationDS)AssociatedDataSet).County.Rows.InsertAt(countyRow, 0);
            }
        }
        public void ContactRoleSelect(int contactID)
        {
            //check County table for stateID and return if it exists
            if (((OrganizationDS)AssociatedDataSet).ContactRole.Any(contactRoleRow => contactRoleRow.PersonID == contactID))
                return;
            ((OrganizationDA)AssociatedDA).ContactId = contactID;
            ((OrganizationDA)AssociatedDA).ContactRoleSelect();
            Select();
        }
        //loads Inactive Organization Contacts (Person) table
        public void PersonSelect()
        {
            if (((OrganizationDS)AssociatedDataSet).Person.Any(personRow => personRow.Inactive == true))
                return;
            PersonInactive = true;
            ((OrganizationDA)AssociatedDA).PersonSelect();
            Select();
        }

        public int WebPersonRow(int personId, string userName)
        {
            OrganizationDS _organizationDs = ((OrganizationDS)AssociatedDataSet);
            OrganizationDS.PersonRow personRow = PersonRow(personId);

            if (personRow == null)
                return Int32.MinValue;

            _organizationDs.WebPerson.PersonIDColumn.DefaultValue = personId;
            OrganizationDS.WebPersonRow webPersonRow = _organizationDs.WebPerson.NewWebPersonRow();
            //webPersonRow.WebPersonID - This is automatically generated
            //webPersonRow.PersonID - This is the default value                    
            webPersonRow.WebPersonUserName = userName;
            webPersonRow.PersonRow = personRow;
            _organizationDs.WebPerson.AddWebPersonRow(webPersonRow);
            return webPersonRow.WebPersonID;


        }



        public void OrganizationPhoneCallBack(string callBack)
        {

            if (!Regex.IsMatch(callBack, grConstant.PhonePattern))
                return;

            List<OrganizationDS.OrganizationPhoneRow> organizationPhoneList;
            organizationPhoneList = SelectOrganizationPhone("Call Back");

            if (organizationPhoneList.Count == 1)
                organizationPhoneList[grConstant.FirstRow].Phone = callBack;

        }
        #endregion
        
        /// <summary>
        /// Called by Organization Contacts to validate each modified Person Row
        /// </summary>
        /// <param name="evaluateRow"></param>
        /// <returns></returns>
        public bool PersonRowValid(OrganizationDS.PersonRow evaluateRow)
        {
            Boolean valid = true;

            if (evaluateRow.PersonFirst.Length == 0)
                valid = false;
            if (evaluateRow.PersonLast.Length == 0)
                valid = false;
            if (evaluateRow.IsPersonTypeIDNull())
                valid = false;
            if (!evaluateRow.IsPersonTypeIDNull())
                if (evaluateRow.PersonTypeID < 1)
                    valid = false;
            valid = PersonBusyUntilValidate(evaluateRow, valid);
            valid = PersonTempNoteExpiresValidate(evaluateRow, valid);

            return valid;

        }

        public Boolean PersonTempNoteExpiresValidate(OrganizationDS.PersonRow evaluateRow, Boolean valid)
        {
            if (!evaluateRow.IsPersonTempNoteActiveNull())
            {
                if (evaluateRow.PersonTempNoteActive == 1)
                {
                    if (evaluateRow.PersonTempNoteActive == 1 && evaluateRow.IsPersonTempNoteExpiresNull())
                        valid = false;

                    DateTime validTime = DateTime.Now.AddHours(-1);
                    try
                    {
                        validTime = evaluateRow.PersonTempNoteExpires;
                    }
                    catch
                    {
                        //there was an error to the date is not correct.
                        valid = false;
                    }
                    if (validTime < DateTime.Now)
                        valid = false;
                }
            }
            return valid;
        }

        public Boolean PersonBusyUntilValidate(OrganizationDS.PersonRow evaluateRow, Boolean valid)
        {
            if (!evaluateRow.IsPersonBusyNull())
            {
                if (evaluateRow.PersonBusy == 1)
                {
                    if (evaluateRow.PersonBusy == 1 && evaluateRow.IsPersonBusyUntilNull())
                        valid = false;

                    DateTime validTime = DateTime.Now.AddHours(-1);
                    try
                    {
                        validTime = evaluateRow.PersonBusyUntil;
                    }
                    catch
                    {
                        //there was an error to the date is not correct.
                        valid = false;
                    }
                    if (validTime < DateTime.Now)
                        valid = false;
                }
            }
            return valid;
        }

        /// <summary>
        /// Called by Organization Contacts to validate each modified PersonPhone Row
        /// </summary>
        /// <param name="evaluateRow"></param>
        /// <returns></returns>
        public bool PersonPhoneValid(OrganizationDS.PersonPhoneRow evaluateRow)
        {
            //set the cancel value exit with a return if the row is not valid. 
            Boolean valid = true;

            Int32 phoneLength = 0;
            if (!evaluateRow.IsPhoneNull())
                phoneLength = evaluateRow.Phone.Length;
            Int32 emailLength = 0;
            if (!evaluateRow.IsPhoneAlphaPagerEmailNull())
                emailLength = evaluateRow.PhoneAlphaPagerEmail.Length;
            Int32 PhoneType = 0;
            if (!evaluateRow.IsPhoneTypeIDNull())
                if (evaluateRow.PhoneTypeID.ToString().Length > 0)
                    PhoneType = Int32.Parse(evaluateRow.PhoneTypeID.ToString());

            if (PhoneType < 1)
                valid = false;

            //the validation steps made it here set the Can value to to false.
            if (phoneLength + emailLength < 1)
                valid = false;

            return valid;
        }

        public bool OrganizationPhoneValid(OrganizationDS.OrganizationPhoneRow evaluateRow)
        {
            //assume valid
            Boolean valid = true;
            Int32 PhoneLength = 0;
            if (!evaluateRow.IsPhoneNull())
                PhoneLength = evaluateRow.Phone.Length;
            Int32 phoneTypeID = 0;

            if (!evaluateRow.IsPhoneTypeIDNull())
                if (evaluateRow.PhoneID.ToString().Length > 0)
                    phoneTypeID = Int32.Parse(evaluateRow.PhoneTypeID.ToString());

            if (phoneTypeID < 1)
                valid = false;

            if (PhoneLength < 1)
                valid = false;


            return valid;

        }
        /// <summary>
        /// break-out method to make sure a phone number is not duplicated.
        /// </summary>
        public string CheckForDuplicatePhoneNumbers()
        {
            return CheckConflictingOrganizationPhone(false);
        }
    }
        public static class DataSetConversion
        {
            public static OrganizationDS organizationDs(this DataSet dataset)
            {
                try
                {
                    return (OrganizationDS)dataset;
                }
                catch
                {
                    return null;
                }
            }
        }
    
}
