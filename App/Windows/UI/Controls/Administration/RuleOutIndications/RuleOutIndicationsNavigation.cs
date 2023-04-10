using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.RuleOutIndications;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Windows.UI.Controls.Administration.RuleOutIndications
{
    public partial class RuleOutIndicationsNavigation : Statline.Stattrac.Windows.UI.BaseUserControl
    {
        public int IndicationsId { get; set; }
        public RuleOutIndicationsAddEditControl ruleOutIndicationsAddEditControl;
        public RuleOutIndicationsDetailControl ruleOutIndicationsDetailControl;

        public RuleOutIndicationsNavigation()
        {
            InitializeComponent();
            BusinessRule = new RuleOutIndicationsBR();

            ruleOutIndicationsAddEditControl = new RuleOutIndicationsAddEditControl();
            ruleOutIndicationsDetailControl = new RuleOutIndicationsDetailControl();

            tabControl.AddTabItem(AppScreenType.RuleOutIndications, "Rule Out Indications", ruleOutIndicationsAddEditControl);
            tabControl.AddTabItem(AppScreenType.RuleOutIndicationsDetail, "Rule Out Indication Details", ruleOutIndicationsDetailControl);
            tabControl.Tabs[((int)AppScreenType.RuleOutIndicationsDetail).ToString()].Visible = false;

            
            ruleOutIndicationsAddEditControl.RuleOutIndicationsNavigation = this;

        }
        private void ultraTabSharedControlsPage1_Paint(object sender, PaintEventArgs e)
        {

        }
        
        public void DisplayEditDetails()
        {
            tabControl.Tabs[((int)AppScreenType.RuleOutIndicationsDetail).ToString()].Visible = true;
            tabControl.Tabs[((int)AppScreenType.RuleOutIndicationsDetail).ToString()].Selected = true;

        }
    }
}
