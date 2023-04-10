using System;
using System.Data;
using System.Drawing;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Windows.UI;
using Statline.Stattrac.Framework.Security;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class ContactPermissionMainControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        #region private fields
        private ContactRoleControl contactRoleControl;
        private ContactPermissionControl contactPermissionControl;
        private OrganizationDS _organizationDs;
        private CurrencyManager _currencyManager;
        private DataView _dataViewWebPerson;
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();
        #endregion

        #region public Properties
        public int PersonId { get; set; }
        private string PersonIdFilter
        {
            get
            {
                return String.Format("PersonId = {0}", PersonId);
            }
        }
        #endregion

        #region contstructor
        public ContactPermissionMainControl()
        {
            InitializeComponent();

            contactRoleControl = new ContactRoleControl();
            contactPermissionControl = new ContactPermissionControl();

            tabControl.AddTabItem(AppScreenType.OrganizationContactRoleControl, "Contact Roles", contactRoleControl);
            tabControl.AddTabItem(AppScreenType.OrganizationContactPermissionControl, "Contact Permissions", contactPermissionControl);

        }
        #endregion

        #region overriden Methods
        public override void BindDataToUI()
        {
            _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;
            if (_organizationDs == null)
                return;

            if (_dataViewWebPerson == null)
                _dataViewWebPerson = new DataView(_organizationDs.WebPerson);
            if (generalConstant.ContactId > 0)
            {
                PersonId = generalConstant.ContactId;
                _dataViewWebPerson.RowFilter = PersonIdFilter;
            }
            contactRoleControl.InitializeBR(BusinessRule);
            contactPermissionControl.InitializeBR(BusinessRule);

            lblContactFirstName.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonFirstColumn.ColumnName);
            lblContactLastName.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonLastColumn.ColumnName);

            txtBoxUserName.BindDataSet(_dataViewWebPerson, _organizationDs.WebPerson.WebPersonUserNameColumn.ColumnName);

            contactRoleControl.BindDataToUI();
            contactPermissionControl.BindDataToUI();

            _currencyManager = (CurrencyManager)BindingContext[_organizationDs, _organizationDs.Person.TableName];
        }
        public override void LoadDataFromUI()
        {
            EndEditDataViewWebPerson();
            contactRoleControl.LoadDataFromUI();
            contactPermissionControl.LoadDataFromUI();

        }
        #endregion

        #region public methods
        public void SetCurrentRow(int personId)
        {

            if (generalConstant.ContactId == 0)
            {
                PersonId = personId;
            }
            else
            {
                if (generalConstant.ContactId != personId)
                {
                    PersonId = personId;
                }
                else
                {
                    PersonId = generalConstant.ContactId;
                    personId = generalConstant.ContactId;
                }
            }

            //load contact roles
            ((OrganizationBR)BusinessRule).ContactRoleSelect(personId);

            //always set the chkBoxStatTracLogin to UNchecked 
            chkBoxStatTracLogin.Checked = false;
            chkBoxStatTracLogin.Enabled = false;

            if (_organizationDs != null)
            {
                EndEditDataViewWebPerson();

                // set the defaut PersonID for WebPerson, supporitn current person phone number creation
                _organizationDs.WebPerson.PersonIDColumn.DefaultValue = PersonId;
                _organizationDs.StatEmployee.PersonIDColumn.DefaultValue = PersonId;

                _dataViewWebPerson.RowFilter = PersonIdFilter;


                //check the statemployee table. set the chkBoxStatTracLogin to checked if a record exists
                if (((OrganizationBR)BusinessRule).StatEmployeeRecordExists(PersonIdFilter))
                    chkBoxStatTracLogin.Checked = true;

                if (txtBoxUserName.Text.Length > 0)
                    chkBoxStatTracLogin.Enabled = true;

                //if(_dataViewWebPerson.Table.i .Columns[_organizationDs.WebPerson.WebPersonPasswordColumn.ColumnName]. )
            }

            contactRoleControl.SetCurrentRow(personId);
            contactPermissionControl.SetCurrentRow(personId);

        }
        #endregion

        #region private methods

        private void EndEditDataViewWebPerson()
        {
            if (_dataViewWebPerson.Count == 0)
                return;
            _dataViewWebPerson[0].EndEdit();

        }

        private int GetWebPersonID()
        {
            int webPersonID = 0;
            if (BusinessRule == null)
                return webPersonID;
            if (_dataViewWebPerson == null)
                return webPersonID;

            if (_dataViewWebPerson.Count == 0)
            {

                webPersonID = ((OrganizationBR)BusinessRule).WebPersonRow(PersonId, txtBoxUserName.Text);

            }
            else
            {
                webPersonID = Convert.ToInt32(_dataViewWebPerson[GRConstant.FirstRow][_organizationDs.WebPerson.WebPersonIDColumn.ColumnName]);

            }
            return webPersonID;
        }

        private Boolean ValidatetxtBoxUserName()
        {
            Boolean valid = true;
            txtBoxUserName.BackColor = Color.White;
            if (!txtBoxUserName.Visible)
                return valid;
            if (BusinessRule == null)
                return valid;
            if (txtBoxUserName.Text.Length == 0 && _dataViewWebPerson.Count == 0)
                return valid;
            valid = false;
            int webPersonID = GetWebPersonID();


            //Checks the database to confirm userName is unique.
            if (((OrganizationBR)BusinessRule).CheckForUserNameDuplicates(txtBoxUserName.Text, webPersonID, PersonId) > 0)
            {
                // add code to handle if username exists
                BaseMessageBox.Show(GRConstant.DuplicateUserName);
                Invalidate();
                txtBoxUserName.Invalidate();
                chkBoxStatTracLogin.Enabled = false;
                txtBoxUserName.BackColor = Color.Yellow;
            }
            else
            {
                valid = true;
                Validate();
            }
            return valid;
        }

        private Boolean ValidatePassword()
        {
            bool valid = true;
            if (!txtBoxWebPassword.Visible)
                return valid;
            if (txtBoxWebPassword.Text.Length == 0 && txtBoxPasswordConfirm.Text.Length == 0)
                return valid;
            if (txtBoxWebPassword.Text != txtBoxPasswordConfirm.Text)
                valid = false;
            if (txtBoxWebPassword.Text.Length < 8 || txtBoxWebPassword.Text.Length > 20)
                valid = false;
            if (valid)
            {
                txtBoxPasswordConfirm.BackColor = Color.White;
                txtBoxWebPassword.BackColor = Color.White;
                panelPasswordInvalid.Visible = false;
                var saltValue = PasswordEncryptor.GenerateSaltValue(txtBoxWebPassword.Text);

                if (_dataViewWebPerson == null || _dataViewWebPerson.Count == 0)
                    _dataViewWebPerson = new DataView(_organizationDs.WebPerson);

                _dataViewWebPerson[GRConstant.FirstRow][_organizationDs.WebPerson.SaltValueColumn.ColumnName] = saltValue;
                _dataViewWebPerson[GRConstant.FirstRow][_organizationDs.WebPerson.HashedPasswordColumn.ColumnName] = PasswordEncryptor.CreatePasswordHash(txtBoxWebPassword.Text, saltValue);

                // Identify the logged in user's PersonID (needed if the user selected a statline contact)
                var loggedInPersonID = -1; 
                // Look to see if the user selected a statline contact
                if (_organizationDs.StatEmployee.Count > 0)
                {
                    // Look to see if the logged in user is found in the list of Statline employees
                    var loggedInPersonFilter = "StatEmployeeId = " + ((StattracIdentity)StattracIdentity.CurrentIdentity).UserId;
                    var matchingStatEmployeeRows = _organizationDs.StatEmployee.Select(loggedInPersonFilter);
                    if (matchingStatEmployeeRows.Length == 1)
                    {
                        loggedInPersonID = Convert.ToInt32(matchingStatEmployeeRows[0][_organizationDs.StatEmployee.PersonIDColumn]);
                    }
                }

                // Check to see if the logged in user is changing someone else's password
                if (PersonId != loggedInPersonID)
                {
                    // Set the PasswordExpiration to expired
                    _dataViewWebPerson[GRConstant.FirstRow][_organizationDs.WebPerson.PasswordExpirationColumn.ColumnName] = DateTime.Now.AddDays(-1);
                }

            }
            else
            {
                panelPasswordInvalid.Visible = true;
                txtBoxPasswordConfirm.BackColor = Color.Yellow;
                txtBoxWebPassword.BackColor = Color.Yellow;

                // Don't set the PasswordExpiration to expired (since new password is invalid
                _dataViewWebPerson[GRConstant.FirstRow][_organizationDs.WebPerson.PasswordExpirationColumn.ColumnName] = DBNull.Value;

            }
            return valid;
        }

        #endregion

        #region events

        /// <summary>
        /// if user clicks the check box, 
        /// check if a user record exists 
        /// create a record if one does not exist 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void chkBoxStatTracLogin_CheckedChanged(object sender, EventArgs e)
        {
            if ((!((OrganizationBR)BusinessRule).StatEmployeeRecordExists(PersonIdFilter)) && ((Boolean)chkBoxStatTracLogin.Checked))
            {
                OrganizationDS.StatEmployeeRow statEmployeeRow = _organizationDs.StatEmployee.NewStatEmployeeRow();
                ((OrganizationBR)BusinessRule).UpdateStatEmployeeRecord(PersonId, ref statEmployeeRow);

                _organizationDs.StatEmployee.AddStatEmployeeRow(statEmployeeRow);
            }
        }
        /// <summary>
        /// Controls logic aroun creating a new UserName
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void txtBoxUserName_Leave(object sender, EventArgs e)
        {
            int webPersonID = 0;


            //check only if username exists
            if (txtBoxUserName.Text.Length > 0)
            {
                //if the user name exists enable the statEmployee check box
                chkBoxStatTracLogin.Enabled = true;



                webPersonID = GetWebPersonID();

                //checks to see if user has contactRoles and Adds them if it does not.
                ((OrganizationBR)BusinessRule).SelectContactRoles(webPersonID, PersonId);
                Boolean recordAdded = ((OrganizationBR)BusinessRule).SelectContactPermission(PersonId);
                contactPermissionControl.CalculateContactPermissions(recordAdded);
                //confirm the column exists before settign filter
                contactPermissionControl.availableSelectedRole.RowFilter(0, _organizationDs.ContactPermission.PersonIDColumn.ColumnName, PersonId, FilterComparisionOperator.Equals);

                // set the defaut PersonID for PersonPhone, supporitn current person phone number creation
                _organizationDs.ContactPermission.PermissionIDColumn.DefaultValue = PersonId;
                ////ValidatetxtBoxUserName();

            }
        }

        private void txtBoxUserName_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            e.Cancel = !ValidatetxtBoxUserName();

        }

        #endregion

        private void WebPassword_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            e.Cancel = !ValidatePassword();
        }

        private void WebPassword_TextChanged(object sender, EventArgs e)
        {
            ValidatePassword();
        }


    }
}
