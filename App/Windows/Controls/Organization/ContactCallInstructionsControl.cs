using System.Collections;
using System.Data;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Security;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.Organization;
using System;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class ContactCallInstructionsControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private SecurityHelper securityHelper;
        public ContactCallInstructionsControl()
        {
            InitializeComponent();
            InitializeSecurityHelper();
            if (securityHelper.Authorized(SecurityRule.Schedule_Changes.ToString()))
            {
                txtPersonNote.ReadOnly = false;
                txtPesonTempNote.ReadOnly = false;
                chkPersonTempNoteActive.Enabled = true;
                chkPersonBusy.Enabled = true;

            }
            else
            {
                txtPersonNote.ReadOnly = true;
                txtPesonTempNote.ReadOnly = true;
                chkPersonTempNoteActive.Enabled = false;
                chkPersonBusy.Enabled = false;
            
            }
        }

        public int PersonId { get; set; }
        private CurrencyManager _currencyManagerPerson;
        private OrganizationDS _organizationDs;

        public override void BindDataToUI()
        {
            _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;
            if (_organizationDs == null)
                return;
            
            lblContactFirstName.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonFirstColumn.ColumnName);
            lblContactLastName.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonLastColumn.ColumnName);

            chkPersonBusy.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonBusyColumn.ColumnName);
            chkPersonTempNoteActive.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonTempNoteActiveColumn.ColumnName);
            
            ultraDtPersonBusyUntil.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonBusyUntilColumn.ColumnName);
            ultraDtPersonTempNoteExpires.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonTempNoteExpiresColumn.ColumnName);


            txtPersonNote.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonNotesColumn.ColumnName);
            txtPesonTempNote.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonTempNoteColumn.ColumnName); 

            _currencyManagerPerson = (CurrencyManager)BindingContext[_organizationDs, _organizationDs.Person.TableName];

            ultraDtPersonBusyUntilSet();
            ultraDtPersonTempNoteExpiresSet();

            if(PersonId > 0)
                SetCurrentRow(PersonId);
        }
        public override void LoadDataFromUI()
        {

        }
        public void SetCurrentRow(int personId)
        {
            PersonId = personId;
            if (_organizationDs == null)
                return;

            _organizationDs.ContactCallInstruction.PersonIDColumn.DefaultValue = PersonId;
            ((OrganizationBR)BusinessRule).ContactExpirations(personId);

        }

        private void chkPersonBusy_CheckedChanged(object sender, System.EventArgs e)
        {
            ultraDtPersonBusyUntilSet();
        }

        private void ultraDtPersonBusyUntilSet()
        {
            if (chkPersonBusy.CheckState == CheckState.Checked && chkPersonBusy.Enabled)
            {
                ultraDtPersonBusyUntil.Enabled = true;
            }
            else
            {
                ultraDtPersonBusyUntil.Enabled = false;
                ultraDtPersonBusyUntil.Value = "";
                
            }
        }

        private void chkPersonTempNoteActive_CheckedChanged(object sender, System.EventArgs e)
        {
            ultraDtPersonTempNoteExpiresSet();
        }

        private void ultraDtPersonTempNoteExpiresSet()
        {
            if (chkPersonTempNoteActive.CheckState == CheckState.Checked && chkPersonTempNoteActive.Enabled)
            {
                //enable the datetime field
                ultraDtPersonTempNoteExpires.Enabled = true;
                if (txtPesonTempNote.Text.Length == 0)
                {
                    OrganizationDS.PersonRow currentRow = (OrganizationDS.PersonRow)((DataRowView)_currencyManagerPerson.Current).Row;

                    if (currentRow != null)

                        txtPesonTempNote.Text = currentRow.PersonNotes;
                }

            }
            else
            {
                ultraDtPersonTempNoteExpires.Enabled = false;
                ultraDtPersonTempNoteExpires.Value = "";
                
            }
        }

        private void InitializeSecurityHelper()
        {
            if (securityHelper == null)
            {
                securityHelper = SecurityHelper.GetInstance();
            }
        }

        private void ContactCallInstructionsControl_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            // Set default value.
            // If Validation fails, Cancel is set to true
            bool cancel = false;

            // Validate each control
            if (ultraDtPersonTempNoteExpires_Validate())
                cancel = true;

            if (ultraDtPersonBusyUntil_Validate())
                cancel = true;

            e.Cancel = cancel;
            
        }

        private bool ultraDtPersonTempNoteExpires_Validate()
        {
            bool cancel = false;
            //if check box is required date is required
            if (chkPersonTempNoteActive.CheckState == CheckState.Checked)
            {
                Boolean valid = true;
                _currencyManagerPerson.EndCurrentEdit();
                OrganizationDS.PersonRow currentRow = (OrganizationDS.PersonRow)((DataRowView)_currencyManagerPerson.Current).Row;
                
                if (currentRow != null)
                   valid = ((OrganizationBR)BusinessRule).PersonTempNoteExpiresValidate(currentRow, valid);
                if (!valid)
                    cancel = true;
            }
            if (cancel == true)
            {
                ultraDtPersonTempNoteExpires.Appearance.BackColor = System.Drawing.Color.Yellow;
            }
            else
            {
                ultraDtPersonTempNoteExpires.Appearance.BackColor = System.Drawing.Color.White;
            }
            return cancel;
        }

        private bool ultraDtPersonBusyUntil_Validate()
        {
            bool cancel = false;
            //if check box is required date is required
            if (chkPersonBusy.CheckState == CheckState.Checked)
            {
                Boolean valid = true;
                _currencyManagerPerson.EndCurrentEdit();
                OrganizationDS.PersonRow currentRow = (OrganizationDS.PersonRow)((DataRowView)_currencyManagerPerson.Current).Row;
                
                if (currentRow != null)
                    valid = ((OrganizationBR)BusinessRule).PersonBusyUntilValidate(currentRow, valid);
                
                if (!valid)
                    cancel = true;
            }
            if (cancel == true)
            {                
                ultraDtPersonBusyUntil.Appearance.BackColor = System.Drawing.Color.Yellow;
            }
            else
            {                
                ultraDtPersonBusyUntil.Appearance.BackColor = System.Drawing.Color.White;
            }

            return cancel;
        }

        private void ultraDtPersonBusyUntil_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            e.Cancel = ultraDtPersonBusyUntil_Validate();
        }

        private void ultraDtPersonTempNoteExpires_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            e.Cancel = ultraDtPersonTempNoteExpires_Validate();
        }


    }
}
