using System;
using System.Collections;
using System.Windows.Forms;
using Infragistics.Win.UltraWinGrid;
using Statline.Stattrac.BusinessRules.Organization;
using Statline.Stattrac.Common;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.Organization;
using Statline.Stattrac.Windows.UI;

namespace Statline.Stattrac.Windows.Controls.Organization
{
    public partial class OrganizationDeleteControl : BaseUserControl
    {
        public OrganizationDeleteControl()
        {

            InitializeComponent();

            lblDefaultMessage.Text = String.Format("Searching for calls associated to Organization {0}.", GRConstant.OrganizationName);
            lblHeader.Text = GRConstant.OrganizationName;
            pnlDefaultNote.Visible = true;
            pnlDefaultNote.BringToFront();
            organizationAssociatedCall.Enabled = true;
            Refresh();
        }

        public override void BindDataToUI()
        {
            Refresh();
            int phoneID = 0;
            int rowCount = organizationAssociatedCall.SelectAssociatedCall(GRConstant.OrganizationId, phoneID);

            //hide the message after loading the dataset
            pnlDefaultNote.Visible = false;

            if (rowCount == 0)
            {
                OrganizationBR organizationBR = new OrganizationBR();
                organizationBR.OrganizationId = GRConstant.OrganizationId;

                organizationBR.SelectDataSet();

                DialogResult result = BaseMessageBox.ShowWarning("Are you sure you want to delete this organization? Press OK to continue");
                if (result == DialogResult.OK)
                {
                    ((OrganizationDS)organizationBR.AssociatedDataSet).EnforceConstraints = false;
                    ((OrganizationDS)organizationBR.AssociatedDataSet).Organization[GRConstant.FirstRow].Delete();
                    organizationBR.SaveDataSet();

                    //now reselect referrals 
                    organizationAssociatedCall.ClearControlGrid();
                    rowCount = organizationAssociatedCall.SelectAssociatedCall(GRConstant.OrganizationId, phoneID);

                }
                else 
                {
                    lblDefaultMessage.Text = "Returning to Organization Search Screen.";
                    pnlDefaultNote.Visible = true;
                    Refresh();
                }


            }

            if (rowCount == 0)
            {

                NavigateToParentScreen();
            }
            else
            {
                base.BindDataToUI();
                lblHeader.Text = String.Format("\n{0} cannot be deleted because it is associated to the following calls.\nDouble click the below calls to view each individually.\n", GRConstant.OrganizationName);

            }

        }

        protected override void OnLoad(EventArgs e)
        {
            BindDataToUI();   
        }


        protected void NavigateToParentScreen()
        {
            ((BaseForm)FindForm()).LoadSubControl(AppScreenType.Organizations, AppScreenType.OrganizationsOrganizationSearch);

        }
        
        
    }
}
