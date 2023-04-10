using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Constant.GridColumns;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class OrganizationAliasesControl : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        public OrganizationAliasesControl()
        {
            InitializeComponent();
        }
        public override void BindDataToUI()
        {
            OrganizationDS organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;
            ugAssociatedAliases.DataMember = organizationDS.OrganizationAlias.TableName;
            ugAssociatedAliases.DataSource = organizationDS;

            lblOrganizationName.Text = organizationDS.Organization[GeneralConstant.CreateInstance().FirstRow].OrganizationName;

        }

        private void ugAssociatedAliases_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            OrganizationDS organizationDS = (OrganizationDS)BusinessRule.AssociatedDataSet;

            const int band = 0;
            ugAssociatedAliases.ColumnDisplay(band, typeof(OrganizationAlias), organizationDS.OrganizationAlias);            
            
        }
    }
}
