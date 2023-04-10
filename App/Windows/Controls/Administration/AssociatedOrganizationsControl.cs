using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Windows.Controls.Common;
using Statline.Stattrac.Windows.UI;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Common.Organization;

namespace Statline.Stattrac.Windows.Controls.Administration
{
    [Description("If any control uses AssociatedOrgaizationControl its BR will need to do the following. " +
                    "\n1. inherit from the IOrganizationSearch" +
                    "\n2. Implement the SearchParameter class."
                    )]
    public partial class AssociatedOrganizationsControl : UserControl 
    {
        #region Protected Fields
        /// <summary>
        /// Business Rules object
        /// </summary>
        private BaseBR baseBR;

        protected BaseBR BusinessRule
        {
            get { return baseBR; }
            set { baseBR = value; }
        }
        private GeneralConstant generalConstant = GeneralConstant.CreateInstance();

        protected GeneralConstant GRConstant
        {
            get { return generalConstant; }
        }
        #endregion
        #region Properties

        private string idColumn = "";
        
        [Description("This is used to pass the parameters for searching back to the BR/DA for")]
        public SearchParameter OrganizationSearchParameter
        {
            get { return organizationSearchParameter.BRSearchParameter; }
            set { organizationSearchParameter.BRSearchParameter = value; }
        }

        public string IdColumn
        {
            get { return idColumn; }
            set { idColumn = value; }
        }
        [Description("Name of DataTable to bind to. The table must have a Hidden field. Rows with a Hidden Field of False will display in the selected grid.")]
        public string DataMember
        {
            get { return availableSelectedControl.DataMember; }
            set
            {
                availableSelectedControl.DataMember = value;
                availableSelectedControl.DataMember = value;
            }
        }

        public object DataSource
        {
            get { return availableSelectedControl.DataSource; }
            set
            {
                availableSelectedControl.DataSource = value;
                availableSelectedControl.DataSource = value;

            }

        }
        public string TextAvailable
        {
            get { return availableSelectedControl.TextAvailable; }
            set
            {
                
                availableSelectedControl.TextAvailable = value;
            }
        }
        public string TextSelected
        {
            get { return availableSelectedControl.TextSelected; }
            set
            {
                
                availableSelectedControl.TextSelected = value;
            }
        }
        [Description("Used to set the Visible columns for a DataTable.\n" +
            "Set before setting DataMember.")]
        public Type ColumnList
        {
            get { return availableSelectedControl.ColumnList; }
            set { availableSelectedControl.ColumnList = value; }
        }

        #endregion  

        public AssociatedOrganizationsControl()
        {
            InitializeComponent();
        }
        #region Protected Virtual Methods
        /// <summary>
        /// Initilize Business Rules object
        /// </summary>
        /// <param name="baseBR"></param>
        public virtual void InitializeBR(BaseBR businessRule)
        {
            baseBR = businessRule;
        }
        #endregion
        #region Public Methods
        /// <summary>
        /// Bind the data to the UI
        /// </summary>
        public void BindDataToUI()
        {
            organizationSearchParameter.BindDataToUI();
        }
        public void RowFilter(int bands, string columnName, int fieldValue, FilterComparisionOperator filterComparisonOperator)
        {
            availableSelectedControl.RowFilter(bands, columnName, fieldValue, filterComparisonOperator);
        }

        #endregion
        private void btnSearch_Click(object sender, EventArgs e)
        {
            organizationSearchParameter.SetBrParams();
            //add code here to search datatable need to capture if anything has changed
            
            //Set Organization selection mode
            GRConstant.SourceCodeOrganizationGetSelected = false;
            ((IOrganizationSearch)BusinessRule).SearchOrganization();
            
            //add code here to reset the set values.


        }

       
    }
}
