using System;
using System.Linq;
using Infragistics.Win.UltraWinGrid;
using Infragistics.Win.UltraWinTabControl;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Windows.UI;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class OrganizationContactsControl : BaseEditControl
    {
        private ContactPropertiesControl contactPropertiesControl;
        private ContactNumbersControl contactNumbersControl;
        private ContactCallInstructionsControl contactCallInstructionsControl;
        private ContactPermissionMainControl contactPermissionMainControl;
        //private OrganizationDS _organizationDs;
        private SecurityHelper securityHelper;
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        public OrganizationContactsControl()
        {
            InitializeComponent();

            contactPropertiesControl = new ContactPropertiesControl();
            contactNumbersControl = new ContactNumbersControl();
            contactCallInstructionsControl = new ContactCallInstructionsControl();
            contactPermissionMainControl = new ContactPermissionMainControl();
            securityHelper = SecurityHelper.GetInstance();

            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationContactsContactProperties, "Contact Properties", contactPropertiesControl);
            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationContactsContactNumbers, "Contact Numbers", contactNumbersControl);
            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationContactsContactCallInstructions, "Call Instructions", contactCallInstructionsControl);
            tabControl.AddTabItem(AppScreenType.OrganizationsOrganizationContactsContactPermission, "Permissions", contactPermissionMainControl);

            //always hide permissions tab
            HidePermissionsTab();
            //check to see if user has access to permissions tab
            ShowPermissionsTab();


        }
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        public override void BindDataToUI()
        {
            _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;

            contactPropertiesControl.InitializeBR(BusinessRule);
            contactNumbersControl.InitializeBR(BusinessRule);
            contactCallInstructionsControl.InitializeBR(BusinessRule);
            contactPermissionMainControl.InitializeBR(BusinessRule);

            lblOrganizationName.Text = _organizationDs.Organization[GeneralConstant.CreateInstance().FirstRow].OrganizationName;
            //string tableName = "Person";
            ugContacts.DisplayLayout.Bands[0].ColumnFilters.ClearAllFilters();
            ugContacts.UltraGridType = UltraGridType.AddEditSearch;
            ugContacts.DataMember = _organizationDs.Person.TableName;
            ugContacts.DataSource = _organizationDs;
            ugContacts.BindValueList("GenderListSelect", _organizationDs.Person.GenderIDColumn.ColumnName, _organizationDs.Person, _organizationDs.Person.GenderColumn.ColumnName);
            ugContacts.BindValueList("PersonTypeListSelect", _organizationDs.Person.PersonTypeIDColumn.ColumnName, _organizationDs.Person, _organizationDs.Person.PersonTypeColumn.ColumnName);
            ugContacts.BindValueList("TrainedRequestorListSelect", _organizationDs.Person.TrainedRequestorIDColumn.ColumnName, _organizationDs.Person, _organizationDs.Person.TrainedRequestorColumn.ColumnName);
            ugContacts.BindValueList("RaceListSelect", _organizationDs.Person.RaceIDColumn.ColumnName, _organizationDs.Person, _organizationDs.Person.RaceColumn.ColumnName);
                                   
            contactPropertiesControl.BindDataToUI();
            contactNumbersControl.BindDataToUI();
            contactCallInstructionsControl.BindDataToUI();
            contactPermissionMainControl.BindDataToUI();
            
            chkDisplayAllContacts.CheckState = CheckState.Unchecked;
            chkDisplayAllContacts.Enabled = true;
            
            SetCurrentContactRow();
       }

        public override void LoadDataFromUI()
        {
            
            contactPropertiesControl.LoadDataFromUI();
            contactPermissionMainControl.LoadDataFromUI();
            contactNumbersControl.LoadDataFromUI();

            _organizationDs.Person.ToList().ForEach(personRow => personRow.EndEdit() );
            
            //reset the selected row to an active person
            SetCurrentContactRow();
            
            
        }
        private void ugContacts_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            if (_organizationDs  == null) 
                return;

            const int band = 0;
            ugContacts.ColumnDisplay(band, typeof(Person), _organizationDs.Person);
            ugContacts.DisplayLayout.Bands[band].Override.AllowDelete = Infragistics.Win.DefaultableBoolean.False;

            //hide gender and race
            switch (GRConstant.OpenOrganization)
            {
                case AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup:
                case AppScreenType.OrganizationsOrganizationEditPopup:
                case AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup:
                    ugContacts.DisplayLayout.Bands[band].Columns[_organizationDs.Person.RaceIDColumn.ColumnName.ToString()].Hidden = true;
                    ugContacts.DisplayLayout.Bands[band].Columns[_organizationDs.Person.GenderIDColumn.ColumnName.ToString()].Hidden = true;
                    break;
            }            
        }
        /// <summary>
        /// 
        /// </summary>
        private void SetCurrentContactRow()
        {
            if (_organizationDs == null)
                return;
            if (_organizationDs.Person.Rows.Count == 0)
                return;
                        
            ugContacts.Selected.Rows.Clear();
            bool newContactPropertiesEditPopUp = false;
            UltraGridRow ultraGridRow = null;
            try
            {
                ultraGridRow = ugContacts.Rows.FirstOrDefault(ultraRow => (int)ultraRow.Cells[_organizationDs.Person.PersonIDColumn.ColumnName].Value == GRConstant.ContactId);

                if (ultraGridRow == null)
                    switch (GRConstant.OpenOrganization)
                    {
                        case AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup:
                            ultraGridRow = ugContacts.Rows.TemplateAddRow;
                            newContactPropertiesEditPopUp = true;
                            break;
                        case AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup:
                        default:
                            ultraGridRow = ugContacts.Rows.FirstOrDefault(ultraRow => (Boolean)ultraRow.Cells[_organizationDs.Person.InactiveColumn.ColumnName].Value == false);
                            break;
                    }
            }
            catch (Exception ex)
            {                 
                BaseLogger.LogFormUnhandledException(ex, this);
            }

            if (ultraGridRow != null)
            {
                ultraGridRow.Activate();
                GRConstant.ContactId = Int32.Parse(ultraGridRow.Cells[_organizationDs.Person.PersonIDColumn.ColumnName].Value.ToString());
                if (GRConstant.ContactId == 0 && newContactPropertiesEditPopUp)
                { 
                    //Set focus for adding new Contact record from Edit Popup 
                    contactPropertiesControl.SetFocusPersonFirst();
               }
            
            }
        }

        private void FilterContactsGrid(UltraGridRow ultraGridRow)
        {
            if(ultraGridRow.Cells[Person.PersonFirst.ToString()].Value == null || ultraGridRow.Cells[Person.PersonLast.ToString()].Value == null)
                return;                   
            const int band = 0;

            //always clear the filters on this column
            ugContacts.DisplayLayout.Bands[band].ColumnFilters[Person.PersonFirst.ToString()].FilterConditions.Clear();
            ugContacts.DisplayLayout.Bands[band].ColumnFilters[Person.PersonLast.ToString()].FilterConditions.Clear();
                                    
            if(!String.IsNullOrEmpty(ultraGridRow.Cells[Person.PersonFirst.ToString()].Value.ToString()) &&  
                !String.IsNullOrEmpty(ultraGridRow.Cells[Person.PersonLast.ToString()].Value.ToString()))
            {   
                //add inactive users
                if (!BusinessRule.AssociatedDataSet.organizationDs().Person.Any(personRow => personRow.Inactive == true))
                    chkDisplayAllContacts.Checked = true;
                
                //create filter conditions for both first and last name
                PhoneticFilterCondition personFirstNameFilter = new PhoneticFilterCondition(ugContacts.DisplayLayout.Bands[band].Columns[Person.PersonFirst.ToString()], FilterComparisionOperator.Custom, ultraGridRow.Cells[Person.PersonFirst.ToString()].Value );
                PhoneticFilterCondition personLastNameFilter = new PhoneticFilterCondition(ugContacts.DisplayLayout.Bands[band].Columns[Person.PersonLast.ToString()], FilterComparisionOperator.Custom, ultraGridRow.Cells[Person.PersonLast.ToString()].Value) ;

                // set the filter for all columns to a Logical Or   
                ugContacts.DisplayLayout.Bands[band].ColumnFilters.LogicalOperator =
                    FilterLogicalOperator.And;

                //enable the custom filters.                
                ugContacts.DisplayLayout.Bands[band].ColumnFilters[Person.PersonFirst.ToString()].FilterConditions.Add(
                    personFirstNameFilter);
                ugContacts.DisplayLayout.Bands[band].ColumnFilters[Person.PersonLast.ToString()].FilterConditions.Add(
                    personLastNameFilter);
                               
            }
        }

        private void chkDisplayAllContacts_CheckedChanged(object sender, EventArgs e)
        {
            chkDisplayAllContacts.Enabled = false;
            ((OrganizationBR)BusinessRule).PersonSelect();

        }
        /// <summary>
        /// This called both when the SetCurrentRow is called and when a user clicks on a row.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ugContacts_AfterRowActivate(object sender, EventArgs e)
        {
            //check for an active row and exit if none
            if(ugContacts.ActiveRow == null)
                return;

            //assign the ActiveRow to a local param
            UltraGridRow ugRow = ugContacts.ActiveRow;

            //exit if the row is null
            if (ugRow == null)
                return;
            
            if (ugRow.Cells[_organizationDs.Person.PersonIDColumn.ColumnName].Value == System.DBNull.Value)
                return;
            int personId = (int)ugRow.Cells[_organizationDs.Person.PersonIDColumn.ColumnName].Value;

            contactCallInstructionsControl.SetCurrentRow(personId);
            contactNumbersControl.SetCurrentRow(personId);
            contactPermissionMainControl.SetCurrentRow(personId);
            GRConstant.ContactId = personId;

        }

        private void ugContacts_AfterCellUpdate(object sender, CellEventArgs e)
        {
            //check if the row is a new row. Exit if not.
           if (!e.Cell.Row.IsAddRow)
                return;

            //get a reference to the Currency Manager
            CurrencyManager cManager = (CurrencyManager)BindingContext[_organizationDs, _organizationDs.Person.TableName];
            cManager.EndCurrentEdit();
           
            ////check if the column.key exists in the enum
            if (Enum.IsDefined(typeof(Person), e.Cell.Column.Key))
            {
                //Filter for user if one of these fields
                switch ((int)Enum.Parse(typeof(Person), e.Cell.Column.Key))
                {
                    case (int)Person.PersonFirst:
                    case (int)Person.PersonLast:
                        FilterContactsGrid(e.Cell.Row);
                        break;
                }
            }
        }
        private void HidePermissionsTab()
        {
            UltraTab tabBaseConfig = tabControl.Tabs[((int)AppScreenType.OrganizationsOrganizationContactsContactPermission).ToString()];

            if (tabBaseConfig == null)
                return;

            tabBaseConfig.Visible = false;
        }
        private void ShowPermissionsTab()
        {
            if (securityHelper == null)
                return;
            if(!securityHelper.Authorized(SecurityRule.Contact_Permissions.ToString()))
                return;
            
            UltraTab tabBaseConfig = tabControl.Tabs[((int)AppScreenType.OrganizationsOrganizationContactsContactPermission).ToString()];

            if (tabBaseConfig == null)
                return;

            tabBaseConfig.Visible = true;
        }

        private void OrganizationContactsControl_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (_organizationDs == null)
                return;
            Boolean cancel = false;
            //check person table for invalid rows. 
            if (_organizationDs.Person.Rows.Count > 0)
            {
                //find the first added or changed rows that is not valid 
                OrganizationDS.PersonRow invalidRow = _organizationDs.Person.Where(personRow =>
                    {   //return true if the row is added or modified
                        return (personRow.RowState == System.Data.DataRowState.Added || personRow.RowState == System.Data.DataRowState.Modified);
                    }).ToList().FirstOrDefault(evaluateRow =>
                        {   //return true if the row is not valid
                            return (!((OrganizationBR)BusinessRule).PersonRowValid(evaluateRow));
                        });
                if (invalidRow != null)
                {
                    //invalid rows exist
                    //1. set cancel to true to cancel save 
                    //2. set curent contact row ID
                    //3. Set current row in grid                    
                    cancel = true;
                    GRConstant.ContactId = invalidRow.PersonID;
                    SetCurrentContactRow();
                }

            }            
            
            if (cancel == false && _organizationDs.PersonPhone.Rows.Count > 0)
            {
            
                //find the first added or changed rows that is not valid 
                OrganizationDS.PersonPhoneRow invalidRow = _organizationDs.PersonPhone.Where(row =>
                {   //return true if the row is added or modified
                    return (row.RowState == System.Data.DataRowState.Added || row.RowState == System.Data.DataRowState.Modified);
                }).ToList().FirstOrDefault(evaluateRow =>
                {   //return true if the row is not valid
                    // - method returns true if valid use ! to invert
                    return (!((OrganizationBR)BusinessRule).PersonPhoneValid(evaluateRow));
                });
                if (invalidRow != null)
                {
                    //invalid rows exist
                    //1. set cancel to true to cancel save 
                    //2. set curent contact row ID
                    //3. Set current row in grid                    
                    cancel = true;
                    GRConstant.ContactId = invalidRow.PersonID;
                    GRConstant.ContactPhoneId = invalidRow.PersonPhoneID;
                    SetCurrentContactRow();
                }                 
            }
            e.Cancel = cancel;            
        }


        private void OrganizationContactsControl_Load(object sender, EventArgs e)
        {
            SetActiveTab();
        }

        private void SetActiveTab()
        {
            UltraTab activeTab;
            string key = "";
            //make Contacts the active tab
            switch (GRConstant.OpenOrganization)
            {
                case AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup:
                    key = ((int)AppScreenType.OrganizationsOrganizationContactsContactNumbers).ToString(GRConstant.StattracCulture);
                    break;
                default:
                    key = ((int)AppScreenType.OrganizationsOrganizationContactsContactProperties).ToString(GRConstant.StattracCulture);
                    break;
            }


            if (key.Length == 0)
                return;
            activeTab = tabControl.Tabs[key];

            activeTab.Active = true;
            activeTab.Selected = true;
        }
       
    }
}
