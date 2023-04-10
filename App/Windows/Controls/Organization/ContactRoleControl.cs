using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Constant.GridColumns;
using Infragistics.Win.UltraWinGrid;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class ContactRoleControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {

        private OrganizationDS _organizationDs;
        private CurrencyManager _currencyManager;
        
        public int PersonId { get; set; }
        
        public ContactRoleControl()
        {
            InitializeComponent();
        }
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        public override void BindDataToUI()
        {
            _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;

            availableSelectedRoleControl.DataMember = _organizationDs.ContactRole.TableName.ToString();
            availableSelectedRoleControl.ColumnList = typeof(ContactRole);
            availableSelectedRoleControl.DataSource = _organizationDs;            

            _currencyManager = (CurrencyManager)BindingContext[_organizationDs, _organizationDs.Person.TableName];

            if (PersonId > 0)
                SetCurrentRow(PersonId);

        }
        public override void LoadDataFromUI()
        {
            if (_organizationDs == null)
                return;

            _organizationDs.ContactRole.ToList().ForEach(contactRoleRow => contactRoleRow.EndEdit());
            
        }
        public void SetCurrentRow(int personId)
        {
            PersonId = personId;
            if (_organizationDs == null)
                return;

            //confirm the column exists before settign filter
            availableSelectedRoleControl.RowFilter(0, _organizationDs.ContactRole.PersonIDColumn.ColumnName, PersonId, FilterComparisionOperator.Equals);
            
             // set the defaut PersonID for PersonPhone, supporitn current person phone number creation
            _organizationDs.ContactRole.PersonIDColumn.DefaultValue = PersonId;

            //List<OrganizationDS.ContactRoleRow> contactList =  _organizationDs.ContactRole.Where(contact => contact.PersonID == personId);



        }
    }
}
