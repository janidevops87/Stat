using System;
using System.ComponentModel;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Organization;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class ContactPropertiesControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public int PersonId { get; set; }
        private CurrencyManager _currencyManager;
        public ContactPropertiesControl()
        {
            InitializeComponent();            
        }

      
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        public override void BindDataToUI()
        {

            OrganizationDS organizationDs = (OrganizationDS) BusinessRule.AssociatedDataSet;
            if(organizationDs == null)
                return;
            txtPersonFirst.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.PersonFirstColumn.ColumnName);
            txtPersonLast.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.PersonLastColumn.ColumnName);
            txtPersonMI.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.PersonMIColumn.ColumnName);
            txtCredential.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.CredentialColumn.ColumnName);    
            
            
            chkInactive.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.InactiveColumn.ColumnName);    

            cbPersonType.BindData("PersonTypeListSelect");
            cbPersonType.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.PersonTypeIDColumn.ColumnName);

            cbTrainedRequestor.BindData("TrainedRequestorListSelect");
            cbTrainedRequestor.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.TrainedRequestorIDColumn.ColumnName);

            cbRace.BindData("RaceListSelect");
            cbRace.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.RaceIDColumn.ColumnName);

            cbGender.BindData("GenderListSelect");
            cbGender.BindDataSet(organizationDs, organizationDs.Person.TableName, organizationDs.Person.GenderIDColumn.ColumnName);

            _currencyManager = (CurrencyManager)BindingContext[organizationDs, organizationDs.Person.TableName];
            //set the manager to the first row of person
            _currencyManager.Position = GRConstant.FirstRow;
            
            //hide gender and race
            switch (GRConstant.OpenOrganization)
            {
                case AppScreenType.OrganizationsOrganizationContactsContactPropertiesEditPopup:
                case AppScreenType.OrganizationsOrganizationEditPopup:
                case AppScreenType.OrganizationsOrganizationContactsPhoneEditPopup:
                    pnlRaceGender.Hide();    
                    break;
            }            

        }
        public override void LoadDataFromUI()
        {
            
        }
        /// <summary>
        /// Note: Ths Event is fired for the for;
        /// * First name
        /// * Last name
        /// * MI
        /// * and Credentials
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void controlEndCurrentEdit_Leave(object sender, EventArgs e)
        {
            if (_currencyManager == null)
                return;
            int test = BusinessRule.AssociatedDataSet.organizationDs().Person.Rows.Count;
            if (_currencyManager.Count == 0)// && BusinessRule.AssociatedDataSet.ds().Person.Rows.Count > 0)
            {
                string textBoxValue = "";
                if (sender is TextBox)
                {
                    textBoxValue = ((TextBox)sender).Text;
                    ((TextBox)sender).Text = textBoxValue;
                }
                if (textBoxValue.Length > 0)
                    _currencyManager.AddNew();
                if (sender is TextBox)
                {
                    ((TextBox)sender).Text = textBoxValue;
                }
            }
            else
            {
                string textBoxValue = "";
                if (sender is TextBox)
                {
                    textBoxValue = ((TextBox)sender).Text;
                    ((TextBox)sender).Text = textBoxValue;
                }
                if (sender is TextBox)
                {
                    ((TextBox)sender).Text = textBoxValue;
                }
            }
            _currencyManager.EndCurrentEdit();
        }

        private void ContactPropertiesControl_Validating(object sender, CancelEventArgs e)
        {
            if (BusinessRule == null)
                return;
            if (BusinessRule.AssociatedDataSet.organizationDs() == null)
                return;
            if (BusinessRule.AssociatedDataSet.organizationDs().Person.Rows.Count == 0)
            {
                RequiredFields(false);
            }
            else
            {
                RequiredFields(true);
            }

        }

        public void SetFocusPersonFirst()
        { 
            if (txtPersonFirst.Enabled)
                txtPersonFirst.Select();
        }

        private void RequiredFields(Boolean required)
        {
            if (txtPersonFirst.Required != required)
            {
                txtPersonFirst.Required = required;
            }

            if (txtPersonLast.Required != required)
            {
                txtPersonLast.Required = required;    
            }

            if (cbPersonType.Required != required)
            {
                cbPersonType.Required = required; 
            }
        }
    }
}
