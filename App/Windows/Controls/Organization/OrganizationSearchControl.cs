using System;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Security;
using Statline.Stattrac.Windows.Forms;
using Statline.Stattrac.Windows.UI;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class OrganizationSearchControl : BaseGridSearch
    {
        #region Private Members
        private SecurityHelper securityHelper;
        // create the Business rule object
        private OrganizationSearchBR _organizationSearchBR;
        private OrganizationSearchDS _organizationSearchDS;

        #endregion
        #region Construtor
        public OrganizationSearchControl()
        {
            _organizationSearchBR = new OrganizationSearchBR(); 
            InitializeBR(_organizationSearchBR  );
            _organizationSearchDS = (OrganizationSearchDS)_organizationSearchBR.AssociatedDataSet;
            
            ultraGrid.InitializeLayout += new InitializeLayoutEventHandler(ultraGrid_InitializeLayout);  
            InitializeComponent();
            securityHelper = SecurityHelper.GetInstance();

            //initialize control always hide add and delete buttons. if use has permission they will be show later
            btnAdd.Hide();
            btnDelete.Hide();
            
            //Clear Filter - not used for Organization Search 
            btnClearFilter.Hide();

            if (securityHelper != null )
            {
                //show add button if user has access
                if (securityHelper.Authorized(SecurityRule.Add_Organizations.ToString()))
                    btnAdd.Show();
                //show delete button if user has access
                if (securityHelper.Authorized(SecurityRule.Edit_Organizations.ToString()))
                    btnDelete.Show();
            }           
            
            //bret 07/12 adding RefreshPage because timer is not used.
            //RefreshPage();
        }
        #endregion
        #region Protected Methods

        /// <summary>
		/// Bind the data to the UI
		/// </summary>
        public override void BindDataToUI()
        {
            BindValueList();
        }
        protected override void NavigateToAddScreen() 
        {
            NavigateToEditScreen(int.MinValue);
        }
        protected void NavigateToEditScreen(int organizationId)
        {
            GeneralConstant generalConstant = GeneralConstant.CreateInstance();
            generalConstant.OrganizationId = organizationId;
            generalConstant.OpenOrganization = AppScreenType.OrganizationsOrganizationProperties;

            ((BaseForm)FindForm()).LoadSubControl(AppScreenType.Organizations, AppScreenType.OrganizationsOrganizationEdit);
        }

        /// <summary>
        /// Event fired when Delete Button is clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected override void NavigateToDeleteScreen()
        {
            
            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;

                //OrganizationSearchBR organizationBR = (OrganizationSearchBR)BusinessRule;
                //organizationBR.SelectOrganizationReferrals((int)cellsCollection[0].Value);
                
                //OrganizationDS organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;
                //if (organizationDS.OrganizationReferrals.Count == 0) return;

                
                NavigateToDeleteScreen((int)cellsCollection[0].Value,  (string)cellsCollection[1].Value);
            }
        }
        protected void NavigateToDeleteScreen(int organizationId,  string organizationName)
        {            
            GeneralConstant generalConstant = GeneralConstant.CreateInstance();
            generalConstant.OrganizationId = organizationId;
            generalConstant.OrganizationName = organizationName;
            ((BaseForm)FindForm()).LoadSubControl(AppScreenType.Organizations, AppScreenType.OrganizationsOrganizationDelete);

        }
        /// <summary>
        /// Event fired when Add Button is clicked
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        
        protected override void ReloadGrid() 
        {
            organizationSearchParameter.SetBrParams();

            _organizationSearchBR.DisplayAllOrganizations = (Boolean)(chkDisplayAllOrganizations.Checked);

            RefreshPage();
            //BusinessRule.SelectDataSet();
        }
        /// <summary>
        /// Event fired when a row is selected
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected override void UltraGridDoubleClick() 
        {

            if (ultraGrid.Selected.Rows.Count == 1 && ultraGrid.Selected.Rows[0].Cells != null)
            {
                CellsCollection cellsCollection = ultraGrid.Selected.Rows[0].Cells;
                NavigateToEditScreen((int)cellsCollection[0].Value);
            }

        }   
        
        #endregion
        #region Private Methods
        void ultraGrid_InitializeLayout(object sender, InitializeLayoutEventArgs e)
        {
            const int band = 0;
            ultraGrid.ColumnDisplay(band,
                                    typeof(Statline.Stattrac.Constant.GridColumns.OrganizationSearch),
                                     _organizationSearchDS.OrganizationSearch);
        }

        private void BindValueList()
        {
            

            ultraGrid.UltraGridType = UltraGridType.Search;
            ultraGrid.DataMember = _organizationSearchDS.OrganizationSearch.TableName;
            ultraGrid.DataSource = _organizationSearchDS;
            
            organizationSearchParameter.BRSearchParameter = _organizationSearchBR.OrganizationSearchParameter;
            organizationSearchParameter.RefreshPage();
            base.BindDataToUI();

        }
        #endregion

    }
}
