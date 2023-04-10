using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.Constant;
using Statline.Stattrac.BusinessRules.ScreenConfig;
using Statline.Stattrac.Data.Types.ScreenConfig;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.ScreenConfig
{
    public partial class FamilyServicesNavigation : Statline.Stattrac.Windows.UI.BaseEditControl
    {
        private FSNextofKinControl fSNextofKinControl;
        private FSCoronerMEAutopsyControl fSCoronerMEAutopsyControl;
        private FSHPControl fSHPControl;
        private FSBodyCareControl fSBodyCareControl;
        private FSCaseManagementControl fSCaseManagementControl;
        public FamilyServicesNavigation()
        {
            InitializeComponent();
            BusinessRule = new ScreenConfigBR();
            cbDisplayFS.BindData("DisplayScreenListSelect");
            fSNextofKinControl = new FSNextofKinControl();
            //fSNextofKinControl.InitializeBR(BusinessRule);

            fSCoronerMEAutopsyControl = new FSCoronerMEAutopsyControl();

            fSHPControl = new FSHPControl();

            fSBodyCareControl = new FSBodyCareControl();
            //fSBodyCareControl.InitializeBR(BusinessRule);

            fSCaseManagementControl = new FSCaseManagementControl();

            tabControl.AddTabItem(AppScreenType.FSNextofKin, "Next of Kin", fSNextofKinControl);
            tabControl.AddTabItem(AppScreenType.FSCoronerMEAutopsy, "Coroner/ME/Autopsy", fSCoronerMEAutopsyControl);
            tabControl.AddTabItem(AppScreenType.FSHP, "H/P", fSHPControl);
            tabControl.AddTabItem(AppScreenType.FSBodyCare, "Body Care", fSBodyCareControl);
            tabControl.AddTabItem(AppScreenType.FSCaseManagement, "Case Management", fSCaseManagementControl);
        }

        public override void LoadDataFromUI()
        {
            fSNextofKinControl.LoadDataFromUI();
            fSBodyCareControl.LoadDataFromUI();
        }
        
    }
}
