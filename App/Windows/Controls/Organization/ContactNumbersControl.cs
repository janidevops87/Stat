using System;
using System.Linq;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Windows.Forms;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class ContactNumbersControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public ContactNumbersControl()
        {
            InitializeComponent();
        }
        public int PersonId { get; set; }
        private CurrencyManager _currencyManager;
        OrganizationDS _organizationDs;
     
        public override void BindDataToUI()
        {
           
            if (_organizationDs == null)
                _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;

            lblContactFirstName.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonFirstColumn.ColumnName);
            lblContactLastName.BindDataSet(_organizationDs, _organizationDs.Person.TableName, _organizationDs.Person.PersonLastColumn.ColumnName);
            
            _currencyManager = (CurrencyManager)BindingContext[_organizationDs, _organizationDs.Person.TableName];
            
            ugPersonPhone.UltraGridType = UltraGridType.AddEdit;
            ugPersonPhone.DataMember = _organizationDs.PersonPhone.TableName;
            ugPersonPhone.DataSource = _organizationDs;

            ugPersonPhone.BindValueList("PhoneTypeListSelect", _organizationDs.PersonPhone.PhoneTypeIDColumn.ColumnName);
            ugPersonPhone.BindValueList("PagerTypeListSelect", _organizationDs.PersonPhone.PagerTypeIDColumn.ColumnName);
            ugPersonPhone.BindValueList("EmailTypeListSelect", _organizationDs.PersonPhone.EmailTypeIDColumn.ColumnName);


            if(PersonId > 0)
                SetCurrentRow(PersonId);
            
        }
        public override void LoadDataFromUI()
        {
            if (_organizationDs == null)
                return;

            _organizationDs.PersonPhone.ToList().ForEach(personPhoneRow => personPhoneRow.EndEdit());

        }
        private void ugPersonPhone_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            OrganizationDS organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;
            if (organizationDs == null)
                return;

            const int band = 0;
            ugPersonPhone.ColumnDisplay(band, typeof(PersonPhone), organizationDs.PersonPhone);

            //set the field mask for a column with a non default mask
            ugPersonPhone.ColumnMaskSet(UltraGridColumnMask.Phone, ugPersonPhone.DisplayLayout.Bands[0].Columns[organizationDs.PersonPhone.PhoneColumn.ColumnName]);
            

            
        }
        public void SetCurrentRow(int personId)
        {
            PersonId = personId;
            _organizationDs = (OrganizationDS)BusinessRule.AssociatedDataSet;

            if (_organizationDs.Organization.Rows.Count == 0)
                return;
            try
            {

                if (_organizationDs == null)
                    return;

                //confirm the column exists before settign filter
                if (ugPersonPhone.DisplayLayout.Bands[0].Columns.Exists(_organizationDs.PersonPhone.PersonIDColumn.ColumnName))
                {
                    //the following filters out the PersonID fields
                    ugPersonPhone.DisplayLayout.Bands[0].ColumnFilters[_organizationDs.PersonPhone.PersonIDColumn.ColumnName].FilterConditions.Clear();
                    ugPersonPhone.DisplayLayout.Bands[0].ColumnFilters[_organizationDs.PersonPhone.PersonIDColumn.ColumnName].FilterConditions.Add(FilterComparisionOperator.Equals, PersonId);
                }
                // set the defaut PersonID for PersonPhone, supporitn current person phone number creation
                _organizationDs.PersonPhone.PersonIDColumn.DefaultValue = personId;
            }
            catch (Exception exception)
            {
                BaseLogger.LogFormUnhandledException(exception);
            }

        }

        private void ugPersonPhone_AfterRowUpdate(object sender, RowEventArgs e)
        {
            Int32 PhoneLength = e.Row.Cells[_organizationDs.PersonPhone.PhoneColumn.ColumnName].Value.ToString().Length;
            Int32 EmailLength = e.Row.Cells[_organizationDs.PersonPhone.PhoneAlphaPagerEmailColumn.ColumnName].Value.ToString().Length;
            Int32 PhoneType = 0;
            if (e.Row.Cells[_organizationDs.PersonPhone.PhoneTypeIDColumn.ColumnName].Value.ToString().Length > 0)
                PhoneType = Int32.Parse(e.Row.Cells[_organizationDs.PersonPhone.PhoneTypeIDColumn.ColumnName].Value.ToString());

            if (PhoneType < 1)
            {
                e.Row.Cells[_organizationDs.PersonPhone.PhoneTypeIDColumn.ColumnName].Appearance.BackColor = System.Drawing.Color.Yellow;
            }
            else
                e.Row.Cells[_organizationDs.PersonPhone.PhoneTypeIDColumn.ColumnName].Appearance.BackColor = System.Drawing.Color.White;

            //the validation steps made it here set the Cancel value to to false.
            if (PhoneLength + EmailLength < 1)
            {
                e.Row.Cells[_organizationDs.PersonPhone.PhoneColumn.ColumnName].Appearance.BackColor = System.Drawing.Color.Yellow;
            }
            else
                e.Row.Cells[_organizationDs.PersonPhone.PhoneColumn.ColumnName].Appearance.BackColor = System.Drawing.Color.White;

        }

    }
}
