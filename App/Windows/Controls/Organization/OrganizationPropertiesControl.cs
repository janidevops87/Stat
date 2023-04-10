using System;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Windows.UI;
using Statline.Stattrac.Framework;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class OrganizationPropertiesControl : BaseEditControl
    {
        private int stateID = 0;
        private SecurityHelper securityHelper;
        private OrganizationDS _organizationDS;
        private Boolean cbStateHasChanged = false;

        public OrganizationPropertiesControl()
        {
            InitializeComponent();
        }
        //do local permissions here and then this is called back from the manager
        public void SetLocalPermissions()
        {
            //always set the status field to disabled
            cbStatus.Enabled = false;
            if (securityHelper != null)
            {
                if (securityHelper.Authorized(SecurityRule.Verify_Organizations.ToString()))
                    cbStatus.Enabled = true;
            }
        }
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        public override void BindDataToUI()
        {       if(_organizationDS== null)
                    _organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;
                OrganizationDS organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;

                if(cbState.Items.Count == 0)
                    cbState.BindData("StateListSelect");
                if (cbStatus.Items.Count == 0)
                    cbStatus.BindData("OrganizationStatusListSelect");
                if (cbOrganizationType.Items.Count == 0)
                    cbOrganizationType.BindData("OrganizationTypeListSelect");
                if (cbTimeZone.Items.Count == 0)
                    cbTimeZone.BindData("TimeZoneListSelect");
                if (cbCountry.Items.Count == 0)
                    cbCountry.BindData("CountryListSelect");
            
            #region  todo add binddata to combobox and replace code cbcounty
                        
            //cbCounty uses a non standard Binding            
            cbCounty.ValueMember = organizationDS.County.CountyIDColumn.ColumnName;
            cbCounty.DisplayMember = organizationDS.County.CountyNameColumn.ColumnName;
            cbCounty.DataSource = organizationDS.County.DefaultView;

            #endregion
            
            string tableName = organizationDS.Organization.TableName;
            
            cbStatus.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationStatusIDColumn.ColumnName);
            txtOrganizationName.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationNameColumn.ColumnName);
            chkContractedStatlineClient.BindDataSet(organizationDS, tableName, organizationDS.Organization.ContractedStatlineClientColumn.ColumnName);
            chkStattracOrganization.BindDataSet(organizationDS, tableName, organizationDS.Organization.StatTracOrganizationColumn.ColumnName);
            txtAddress1.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationAddress1Column.ColumnName);
            txtAddress2.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationAddress2Column.ColumnName);
            txtCity.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationCityColumn.ColumnName);
            cbState.BindDataSet(organizationDS, tableName, organizationDS.Organization.StateIDColumn.ColumnName);
            txtPostalCode.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationZipCodeColumn.ColumnName);
            cbCountry.BindDataSet(organizationDS, tableName, organizationDS.Organization.CountryIDColumn.ColumnName);
            cbOrganizationType.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationTypeIDColumn.ColumnName);
            cbCounty.BindDataSet(organizationDS, tableName, organizationDS.Organization.CountyIDColumn.ColumnName);
            
            txtProviderNumber.BindDataSet(organizationDS, tableName, organizationDS.Organization.ProviderNumberColumn.ColumnName);
            txtUnosCode.BindDataSet(organizationDS, tableName, organizationDS.Organization.UnosCodeColumn.ColumnName);
            cbTimeZone.BindDataSet(organizationDS, tableName, organizationDS.Organization.TimeZoneIDColumn.ColumnName);
            chkObservesDaylightSavings.BindDataSet(organizationDS, tableName, organizationDS.Organization.ObservesDaylightSavingsColumn.ColumnName);
            txtSpecialNotes.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationNotesColumn.ColumnName);
            txtOrganizationConsentInterval.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationConsentIntervalColumn.ColumnName);
            txtOrganizationPageInterval.BindDataSet(organizationDS, tableName, organizationDS.Organization.OrganizationPageIntervalColumn.ColumnName);
            txtFacilityEreferralCode.BindDataSet(organizationDS, tableName, organizationDS.Organization.FacilityEreferralCodeColumn.ColumnName);

            ugBillingAddress.UltraGridType = UltraGridType.AddEdit;
            ugBillingAddress.DataMember = organizationDS.BillTo.TableName;
            ugBillingAddress.DataSource = organizationDS;
            ugBillingAddress.BindValueList("StatelistSelect", organizationDS.BillTo.StateIDColumn.ColumnName , organizationDS.BillTo, organizationDS.BillTo.StateColumn.ColumnName);
            ugBillingAddress.BindValueList("CountryListSelect", organizationDS.BillTo.CountryIDColumn.ColumnName, organizationDS.BillTo, organizationDS.BillTo.CountrynameColumn.ColumnName);
            if (organizationDS.BillTo.Count == 0)
            {
                ckCopytoBilling.Enabled = true;
                ckCopytoBilling.Checked = false;
            }

            ugSourceCodes.UltraGridType = UltraGridType.ReadOnly;
                ugSourceCodes.DataMember = organizationDS.OrganizationSourceCode.TableName;
            ugSourceCodes.DataSource = organizationDS;

            ugOrganizationInstances.UltraGridType = UltraGridType.ReadOnly;
            ugOrganizationInstances.DataMember = organizationDS.OrganizationSearch.TableName;
            ugOrganizationInstances.DataSource = organizationDS;
            //reset value after load
            cbStateHasChanged = false;
            //check county ID. If selected value does not match Organization.CountyID set the value.
            if(!organizationDS.Organization[GRConstant.FirstRow].IsCountyIDNull())
                if (cbCounty.SelectedValue.ToString() != organizationDS.Organization[GRConstant.FirstRow].CountyID.ToString())
                    cbCounty.SelectedValue = organizationDS.Organization[GRConstant.FirstRow].CountyID;
            LoadCounty();
            
        }
        
        private void ugSourceCodes_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            const int band = 0;
            ugSourceCodes.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.OrganizationAssociatedSourceCodes),
                                        _organizationDS.OrganizationSourceCode);
        }

        private void ugOrganizationInstances_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            const int band = 0;
            ugOrganizationInstances.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.OrganizationInstances),
                                                  _organizationDS.OrganizationSearch);
        }

        private void ugBillingAddress_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {            
            const int band = 0;
            ugBillingAddress.ColumnDisplay(band, typeof(Statline.Stattrac.Constant.GridColumns.OrganizationBillingAddress), _organizationDS.BillTo);



        }

        private void cbState_SelectedIndexChanged(object sender, EventArgs e)
        {
            cbStateHasChanged = true;

     
         }

        /// <summary>
        /// set permission settings in the Load
        /// </summary>
        /// <param name="sender"></param>
        /// 
        /// <param name="e"></param>
        private void OrganizationPropertiesControl_Load(object sender, EventArgs e)
        {
            // add security here
            if (securityHelper == null)
                securityHelper = SecurityHelper.GetInstance();
            if (securityHelper.Authorized(SecurityRule.Response_Interval.ToString()))
                groupBoxResponseIntervals.Enabled = true;
            else
                groupBoxResponseIntervals.Enabled = false;

            if (securityHelper.Authorized(SecurityRule.Verify_Organizations.ToString()))
                cbStatus.Enabled = true;
            else
                cbStatus.Enabled = false;

        }

        private void txtOrganizationName_Leave(object sender, EventArgs e)
        {
            ProcessOrganizationDuplicates();
        }

        private void cbCounty_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ProcessOrganizationDuplicates();
        }
        private void ProcessOrganizationDuplicates()
        {
            try
            {

                if (_organizationDS.Organization.Rows.Count == 0)
                    return;
                if (txtOrganizationName.Text.Length == 0)
                    return;
                if (_organizationDS.Organization[GRConstant.FirstRow].RowState == DataRowState.Unchanged)
                    return;

                int stateId = 0;
                int countyId = 0;
                if (cbState.SelectedIndex > 0)
                    stateId = (int)cbState.SelectedValue;
                if (cbCounty.SelectedIndex > 0)
                    countyId = (int)cbCounty.SelectedValue;

                ((OrganizationBR)BusinessRule).SelectOrganizationDupes(txtOrganizationName.Text, stateId, countyId);

                lblInstancesOfOrganizations.Text = ugOrganizationInstances.Rows.Count.ToString() + " Instances of " + txtOrganizationName.Text + " found.";

                if ((int)cbCounty.SelectedIndex > 0 && (int)cbState.SelectedIndex > 0 && _organizationDS.OrganizationSearch.Count > 0)
                    ugOrganizationInstances.Visible = true;

                else
                    ugOrganizationInstances.Visible = false;
            }
            catch (Exception exception)
            {
                BaseLogger.LogFormUnhandledException(exception);
            }

        }
        private void ckCopytoBilling_Click(object sender, EventArgs e)
        {
            Windows.Forms.CheckBox checkbox = sender as Windows.Forms.CheckBox;
            if ((bool)checkbox.Checked)
            {

                OrganizationDS.BillToRow row = _organizationDS.BillTo.NewBillToRow();
                row.Address1 = txtAddress1.Text;
                row.Address2 = txtAddress2.Text;
                row.City = txtCity.Text;
                row.Name = txtOrganizationName.Text;
                row.PostalCode = txtPostalCode.Text;
                ckCopytoBilling.Enabled = false;
                try//just in case they click cb and nothing selected
                {
                    row.StateID = (int)cbState.SelectedValue;
                    row.CountryID = (int)cbCountry.SelectedValue;
                }
                catch
                {
                }
                row.State = cbState.Text;
                row.Countryname = cbCountry.Text;
                _organizationDS.BillTo.Rows.Add(row);
                ugBillingAddress.DataMember = _organizationDS.BillTo.TableName;
                ugBillingAddress.DataSource = _organizationDS;
                base.BindDataToUI();
            }
        }

        /// <summary>
        /// WI 12380 added confirmNameChange Boolean so Organization Name rename will not over write the Billing Address Required validation.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void OrganizationPropertiesControl_Validating(object sender, CancelEventArgs e)
        {
            bool cancel = false;

            bool billToIsValid = false;
            bool confirmNameChange = false; // WI 12380 

            billToIsValid = ((OrganizationBR)BusinessRule).ValidField(OrganizationFields.BillTo);

            
            if (!billToIsValid)
            {
                groupBoxBillingAddress.BackColor = Color.Yellow;
            
            }
            else 
            {
                groupBoxBillingAddress.BackColor = Color.White;
            }   
            //Confirm name Change
            confirmNameChange = ConfirmNameChange(); // WI 12380 
            if (!confirmNameChange || !billToIsValid) // WI 12380 
                cancel = true;

            e.Cancel = cancel;
        }
        /// <summary>
        ///  WI 2963
        ///  When an existing Organization Name is changed, notification shall be given to the user that the organization name is being changed.  
        ///  The existing name of the organization shall be displayed along with the new name of the organization.  
        ///  The user must verify the change before the new organization name can be saved.  
        /// </summary>
        /// <returns> Returns True if Users clicks Yes or False if the user Click no</returns>
        private bool ConfirmNameChange()
        {
            bool confirm = true;
            //Are you sure want to change the Organization Name FROM TO 
            if(_organizationDS == null)
                return confirm;
            if(_organizationDS.Organization.Rows.Count == 0)
                return confirm;
            if(_organizationDS.Organization[GRConstant.FirstRow].RowState == DataRowState.Added)
                return confirm;
            String organizationName =  _organizationDS.Organization[GRConstant.FirstRow].OrganizationName;         
            String organizationNameOriginal = _organizationDS.Organization[GRConstant.FirstRow][_organizationDS.Organization.OrganizationNameColumn, DataRowVersion.Original].ToString();

            if (organizationName == organizationNameOriginal)
                return confirm;

            String question = string.Format("Are you sure want to change the Organization Name from {0} to {1}.", organizationNameOriginal, organizationName );
            String caption = "Please Confirm.";
            DialogResult questionResult = BaseMessageBox.ShowYesNo(question, caption);

            if (questionResult == DialogResult.No)
                confirm = false;
            return confirm;
        }

        private void cbTimeZone_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

            int selectedValue = -1;
            Boolean observesDayLightSavings = false;
            if (cbTimeZone.SelectedIndex < 1)
                return;
            selectedValue = (int)cbTimeZone.SelectedValue;
            observesDayLightSavings = ((OrganizationBR)BusinessRule).ObservesDayLightSavings(selectedValue);
            chkObservesDaylightSavings.Checked = observesDayLightSavings;
            //chkObservesDaylightSavings.Enabled = observesDayLightSavings;
           
            }
            catch (Exception exception)
            {
                BaseLogger.LogFormUnhandledException(exception);
            }

            
        }
        /// <summary>
        /// 6/2/2011 Bret
        /// - Created to prevent the Duplicates search from interupting state combo box.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void cbState_Leave(object sender, EventArgs e)
        {
            try
            {
                if (!cbStateHasChanged)
                    return;
                // if a state is not collected do not select
                if (cbState.SelectedItem == null)
                    return;

                if ((int)((DataRowView)cbState.SelectedItem).Row[0] == 0)
                    return;
                

                //set the stateId 
                LoadCounty();



                ProcessOrganizationDuplicates();
                cbCounty.SelectedIndex = 0;
                cbStateHasChanged = false;
            }
            catch (Exception exception)
            {
                BaseLogger.LogFormUnhandledException(exception);
            }

        }

        private void LoadCounty()
        {
            if (cbState.SelectedValue == null)
                return;
            stateID = (int)cbState.SelectedValue;
            ((OrganizationBR)BusinessRule).CountySelect(stateID);
        }

        private void cbCounty_Leave(object sender, EventArgs e)
        {
            ProcessOrganizationDuplicates();
        }


    }
}
