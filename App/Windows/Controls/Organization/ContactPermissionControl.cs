using System;
using System.Data;
using System.Linq;
using System.Security.Principal;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Security;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class ContactPermissionControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        
        public int PersonId { get; set; }
        private OrganizationDS _organizationDs;
        private SecurityHelper _securityHelper;

        public ContactPermissionControl()
        {
            InitializeComponent();
        }

        public override void BindDataToUI()
        {
            _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;
            availableSelectedRole.DataMember = _organizationDs.ContactPermission.TableName.ToString();
            availableSelectedRole.ColumnList = typeof(ContactPermission);
            availableSelectedRole.DataSource = _organizationDs;            
                        


            if (PersonId > 0)
                SetCurrentRow(PersonId);

        }
        public override void LoadDataFromUI()
        {
            
            CalculateContactPermissionsForSave();
            _organizationDs.ContactPermission.ToList().ForEach(contactPermissionRow => contactPermissionRow.EndEdit());
            if (_securityHelper != null)
                _securityHelper.ResetRules();

        }
        public void SetCurrentRow(int personId)
        {
            PersonId = personId;
            
            if (_organizationDs == null)
                return;


            Boolean recordAdded = ((OrganizationBR)BusinessRule).SelectContactPermission(personId);
            CalculateContactPermissions(recordAdded);
            //confirm the column exists before settign filter
            availableSelectedRole.RowFilter(0, _organizationDs.ContactPermission.PersonIDColumn.ColumnName, PersonId, FilterComparisionOperator.Equals);
            
             // set the defaut PersonID for PersonPhone, supporitn current person phone number creation
            _organizationDs.ContactPermission.PermissionIDColumn.DefaultValue = PersonId;



        }
        /// <summary>
        /// This determines if a permissions is displayed in Available or Selected.
        /// </summary>
        /// <param name="recordAdded"></param>
        public void CalculateContactPermissions(Boolean recordAdded)
        {            

            //check for access to permissions
            //note: this cannot be done at BR Level. It would be preferable to complete this at the BR/DA level

              if(_securityHelper == null)
                  _securityHelper = SecurityHelper.GetInstance();
                //remove any securityRule the user does not have access to
                //this is the user of the application not the currently selected contact
                _organizationDs.SecurityRule.ToList().ForEach
                 (securityRuleRow =>
                     {
                        if(!_securityHelper.Authorized(securityRuleRow.SecurityRule.ToString()))
                        {
                            _organizationDs.SecurityRule.RemoveSecurityRuleRow(securityRuleRow);
                        }                   
                     }
                     );
                //remove any contact PermissionsRows the user does not have access to
                _organizationDs.ContactPermission.ToList().ForEach
                 (contactPermissionRow =>
                    {
                        if (!_securityHelper.Authorized(contactPermissionRow.PermissionName.ToString()))
                        {
                            _organizationDs.ContactPermission.RemoveContactPermissionRow(contactPermissionRow);
                        } 
                    }
                 );

            GenericIdentity genericIdentity;
            GenericPrincipal genericPrincipal;
            SecurityHelperForContactPermission securityHelperForContactPermission;
            String[] userRoles = new string[1];

            OrganizationDS.WebPersonRow webPersonRow;
            webPersonRow = ((OrganizationBR)BusinessRule).WebPersonRow(PersonId);

            if (webPersonRow == null)
                return;

            //create the Person Identity
            genericIdentity = new GenericIdentity(webPersonRow.WebPersonUserName);

            ////confirm ContactRoles are loaded
            //generate a list of roles based on the ContactRole table in DS
            var rolesQuery = from contactRoleRow in _organizationDs.ContactRole.ToList()
                        where contactRoleRow.PersonID == PersonId && contactRoleRow.HIDDEN == true
                        select contactRoleRow.RoleName;
            if (rolesQuery.Count() > 0)
            {
                userRoles = rolesQuery.ToArray();
            }
            genericPrincipal = new GenericPrincipal(genericIdentity, userRoles);

            securityHelperForContactPermission = SecurityHelperForContactPermission.GetInstance();
            securityHelperForContactPermission.ResetRules();

            _organizationDs.ContactPermission.Where(contactPermissionRow =>
                contactPermissionRow.PersonID == PersonId).ToList().ForEach
                (contactPermissionRow =>
                    {
                        Boolean hasPermission = false;
                        hasPermission = securityHelperForContactPermission.Authorized(contactPermissionRow.PermissionName, genericPrincipal);
                        if (hasPermission)
                            contactPermissionRow.HIDDEN = true;
                        else
                            contactPermissionRow.HIDDEN = false;
                        contactPermissionRow.AcceptChanges();
                    }
                );

        }
        /// <summary>
        /// This is called with saving data
        /// </summary>
        public void CalculateContactPermissionsForSave()
        {
            GenericIdentity genericIdentity;
            GenericPrincipal genericPrincipal;
            SecurityHelperForContactPermission securityHelperForContactPermission;
            String[] userRoles = new string[1];
            OrganizationDS.WebPersonRow webPersonRow;

            securityHelperForContactPermission = SecurityHelperForContactPermission.GetInstance();

            // loop through ContactPermissions
            // for every modified row determine if I:userName text should be added or removed from the expression
            _organizationDs.ContactPermission.Where(contactPermissionRow => contactPermissionRow.RowState == DataRowState.Modified)
                .ToList().ForEach(contactPermissionRow =>
                    {
                        Boolean hasPermission = false;
                        webPersonRow = ((OrganizationBR)BusinessRule).WebPersonRow(contactPermissionRow.PersonID);

                        if (webPersonRow == null)
                            return;

                        //create the Person Identity
                        genericIdentity = new GenericIdentity(webPersonRow.WebPersonUserName);
                        //generate a list of roles based on the ContactRole table in DS
                        var rolesQuery = from contactRoleRow in _organizationDs.ContactRole.ToList()
                                         where contactRoleRow.PersonID == PersonId && contactRoleRow.HIDDEN == true
                                         select contactRoleRow.RoleName;
                        if (rolesQuery.Count() > 0)
                        {
                            userRoles = rolesQuery.ToArray();
                        }
                        genericPrincipal = new GenericPrincipal(genericIdentity, userRoles);

                        
                        hasPermission = securityHelperForContactPermission.Authorized(contactPermissionRow.PermissionName, genericPrincipal);
                        
                        //if HIDDEN = true then the current user should have access
                        //if HIDDEN = false then the current user should not have access
                        if (contactPermissionRow.HIDDEN)
                        {
                            // row is hidden and the user should not have access
                            if (!hasPermission)
                            {
                                //add access
                                Boolean addPermission = true;
                                ((OrganizationBR)BusinessRule).ModifySecurityRuleTable(webPersonRow.WebPersonUserName, contactPermissionRow.PermissionName, addPermission);
                            }

                        }
                        else
                        {
                            //row is not hidden, the user should have access
                            if (hasPermission)
                            {
                                //remove permission
                                Boolean removePermission = false;
                                ((OrganizationBR)BusinessRule).ModifySecurityRuleTable(webPersonRow.WebPersonUserName, contactPermissionRow.PermissionName, removePermission);
                            }

                        }

                    });
        }

    }
}
