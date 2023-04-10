using System;
using System.Collections;
using System.Linq;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.Forms;
using System.Drawing;
using Statline.Stattrac.Windows.UI;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class OrganizationOrganizationNumbersControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private SecurityHelper _securityHelper;
        private OrganizationDS _organizationDs;
        public OrganizationOrganizationNumbersControl()
        {
            InitializeComponent();

            _securityHelper = SecurityHelper.GetInstance();
            //always disable groupBoxReassignNumbers
            organizationAssociatedCall.Enabled = false;
            if (_securityHelper != null)
            {
                if (_securityHelper.Authorized(SecurityRule.Reassign_Numbers.ToString()))
                    organizationAssociatedCall.Enabled = true;
            }
        }
        public override void BindDataToUI()
        {
            string tableName = "";
            if (_organizationDs == null)
                _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;

            if (_organizationDs.Organization[GRConstant.FirstRow] != null)
            {
                int countryID = 0;
                try
                {
                    countryID = _organizationDs.Organization[GRConstant.FirstRow].CountryID;
                }
                catch { }
                Hashtable paramList = new Hashtable();
                paramList.Add("countryID", countryID);
                cbCountryCode.BindData("CountryCodeListSelect", paramList);
                cbInternationalDirectDialing.BindData("IddListSelect", paramList);

                tableName = _organizationDs.Organization.TableName;
                cbInternationalDirectDialing.BindDataSet(_organizationDs, tableName, _organizationDs.Organization.IDdIDColumn.ColumnName);
                cbCountryCode.BindDataSet(_organizationDs, tableName, _organizationDs.Organization.CountryCodeIDColumn.ColumnName);

                if (cbCountryCode.Items.Count == 2)
                    cbCountryCode.SelectedIndex = 1;
                if (cbInternationalDirectDialing.Items.Count == 2)
                    cbInternationalDirectDialing.SelectedIndex = 1;


            }
            lblOrganizationName.Text = _organizationDs.Organization[GRConstant.FirstRow].OrganizationName;
            ugPhoneNumber.UltraGridType = UltraGridType.AddEdit;
            ugPhoneNumber.DataMember = _organizationDs.OrganizationPhone.TableName;
            ugPhoneNumber.DataSource = _organizationDs;
            ugPhoneNumber.BindValueList(
                "PhoneTypeListSelect",
                _organizationDs.OrganizationPhone.PhoneTypeIDColumn.ColumnName,
                _organizationDs.OrganizationPhone,
                _organizationDs.OrganizationPhone.PhoneTypeColumn.ColumnName
              );
            ugPhoneNumber.BindValueList(
                "SubLocationListSelect",
                _organizationDs.OrganizationPhone.SubLocationIDColumn.ColumnName,
                _organizationDs.OrganizationPhone,
                _organizationDs.OrganizationPhone.SubLocationColumn.ColumnName
                );
            FilterOrganizationPhoneInactive();

        }

        private void ugPhoneNumber_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            const int band = 0;
            ugPhoneNumber.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.OrganizationPhone), _organizationDs.OrganizationPhone);

            ugPhoneNumber.DisplayLayout.Bands[band].Columns[_organizationDs.OrganizationPhone.PhoneColumn.ColumnName].MaskDisplayMode = Infragistics.Win.UltraWinMaskedEdit.MaskMode.IncludeLiterals;
            ugPhoneNumber.DisplayLayout.Bands[band].Columns[_organizationDs.OrganizationPhone.PhoneColumn.ColumnName].MaskInput = "(###) ###-####";
            //disable deleting and turn it off for users with acccess
            ugPhoneNumber.DisplayLayout.Bands[band].Override.AllowDelete = Infragistics.Win.DefaultableBoolean.False;
            if (_securityHelper.Authorized(SecurityRule.Edit_Organizations.ToString()))
                ugPhoneNumber.DisplayLayout.Bands[band].Override.AllowDelete = Infragistics.Win.DefaultableBoolean.True;

        }


        private void chkDisplayAllNumbers_CheckedChanged(object sender, EventArgs e)
        {
            if (_organizationDs == null)
                return;


            FilterOrganizationPhoneInactive();

        }

        private void FilterOrganizationPhoneInactive()
        {
            ugPhoneNumber.DisplayLayout.Bands[0].ColumnFilters[_organizationDs.OrganizationPhone.InactiveColumn.ColumnName].FilterConditions.Clear();
            if (!(bool)chkDisplayAllNumbers.Checked)
            {
                FilterCondition newfilter = new FilterCondition(FilterComparisionOperator.Equals, false);
                ugPhoneNumber.DisplayLayout.Bands[0].ColumnFilters[_organizationDs.OrganizationPhone.InactiveColumn.ColumnName].
                    FilterConditions.Add(newfilter);
            }
        }



        private void ugPhoneNumber_AfterRowInsert(object sender, RowEventArgs e)
        {
            string conflictingMessage = ((OrganizationBR)BusinessRule).CheckForDuplicatePhoneNumbers();
            if (conflictingMessage.Length > 0)
            {
                BaseMessageBox.Show(conflictingMessage);
            }
        }

        private void ugPhoneNumber_AfterRowUpdate(object sender, RowEventArgs e)
        {
            string conflictingMessage = ((OrganizationBR)BusinessRule).CheckForDuplicatePhoneNumbers();
            if (conflictingMessage.Length > 0)
            {
                BaseMessageBox.Show(conflictingMessage);
            }
        }

        private void btnViewAssociatedReferrals_Click(object sender, EventArgs e)
        {
            if (ugPhoneNumber.Selected.Rows.Count < 1)
                return;
            if (_organizationDs.Organization.Rows.Count == 0)
                return;
            Cursor.Current = Cursors.WaitCursor;
            try
            {
                int organizationID = _organizationDs.Organization[GRConstant.FirstRow].OrganizationID; //obtain organizationID from OrganizationID in Organization table

                int phoneID = (int)ugPhoneNumber.Selected.Rows[GRConstant.FirstRow].Cells[_organizationDs.OrganizationPhone.PhoneIDColumn.ColumnName].Value;
                organizationAssociatedCall.SelectAssociatedCall(organizationID, phoneID);

            }
            catch (Exception exception)
            {
                BaseLogger.LogFormUnhandledException(exception);
            }
            Cursor.Current = Cursors.Default;


        }

        private void ugPhoneNumber_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            bool cancel = true;

            cancel = ugPhoneNumber_ValidateRow(ugPhoneNumber.ActiveRow, cancel);

            e.Cancel = cancel;

        }

        private void ugPhoneNumber_BeforeRowDeactivate(object sender, System.ComponentModel.CancelEventArgs e)
        {
            bool cancel = true;
            UltraGridRow row = ((Infragistics.Win.UltraWinGrid.UltraGrid)sender).ActiveRow;
            cancel = ugPhoneNumber_ValidateRow(row, cancel);

            e.Cancel = cancel;
        }

        private bool ugPhoneNumber_ValidateRow(object sender, bool cancel)
        {
            if (sender == null)
            {
                cancel = false;
                return cancel;
            }
            try
            {
                if (_organizationDs == null)
                    _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;
                UltraGridRow row = (UltraGridRow)sender;

                if (row.Cells[_organizationDs.OrganizationPhone.PhoneColumn.ColumnName].Value == DBNull.Value || row.Cells[_organizationDs.OrganizationPhone.PhoneTypeIDColumn.ColumnName].Value == DBNull.Value)
                {
                    //row.Cells[_organizationDs.OrganizationPhone.PhoneTypeIDColumn.ColumnName].Appearance.Reset();
                    row.Cells[_organizationDs.OrganizationPhone.PhoneTypeIDColumn.ColumnName].Appearance.BackColor = Color.Yellow;
                    cancel = true;
                }
                else
                {
                    row.Cells[_organizationDs.OrganizationPhone.PhoneTypeIDColumn.ColumnName].Appearance.ResetBackColor();
                    cancel = false;
                }


            }
            catch
            { }
            return cancel;
        }

        private void OrganizationOrganizationNumbersControl_Validating(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (_organizationDs.OrganizationPhone.Rows.Count > 0)
            {
                OrganizationDS.OrganizationPhoneRow invalidRow = _organizationDs.OrganizationPhone.Where(row =>
                {
                    return (row.RowState == System.Data.DataRowState.Added || row.RowState == System.Data.DataRowState.Modified);

                }).ToList().FirstOrDefault(organizationPhoneRow =>
                {
                    return (!((OrganizationBR)BusinessRule).OrganizationPhoneValid(organizationPhoneRow));
                });
                if (invalidRow != null)
                {
                    e.Cancel = true;
                    SetCurrentPhoneRow(invalidRow.OrganizationPhoneID);
                }



            }

        }

        private void SetCurrentPhoneRow(int organizationPhoneID)
        {
            UltraGridRow ugPhoneRow = ugPhoneNumber.Rows.FirstOrDefault(ugRow => Int32.Parse(ugRow.Cells[_organizationDs.OrganizationPhone.OrganizationPhoneIDColumn.ColumnName].Value.ToString()) == organizationPhoneID);

            if (ugPhoneRow == null)
                return;

            ugPhoneRow.Activate();

        }




    }
}
