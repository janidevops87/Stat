using System;
using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Constant;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.FamilyServices
{
	public partial class FamilyServicesManager : BaseManagerControl
	{
		public FamilyServicesManager()
		{
			InitializeComponent();
			BusinessRule = new FamilyServicesBR();
			caseStatusControl.InitializeBR(BusinessRule);
		}

		/// <summary>
		/// Update the parameters when the control comes into view
		/// </summary>
		protected override void UpdateParameters() 
		{
			((FamilyServicesBR)BusinessRule).CallId = GRConstant.ReferralId;
		}

		/// <summary>
		/// Navigate Back To Parent Control
		/// </summary>
		protected override void NavigateBackToParent()
		{
			GRConstant.ReferralId = Int32.MinValue;            
			((BaseForm)FindForm()).LoadSubControl(AppScreenType.Dashboard, AppScreenType.DashboardFSActiveCases);
		}

		/// <summary>
		/// Bind the data to the UI
		/// </summary>
		protected override void BindDataToUI()
		{
			caseStatusControl.BindDataToUI();
		}

		/// <summary>
		/// Load the data from the UI
		/// </summary>
		protected override void LoadDataFromUI()
		{
			caseStatusControl.LoadDataFromUI();
		}
	}
}
