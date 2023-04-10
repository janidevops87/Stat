using System;
using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;
using Statline.Stattrac.Windows.UI.Header;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class TcssManager : BaseManagerControl
	{
		#region Private Fields
		private static TcssManager tcssManager;
		private TcssHeader tcssHeader;
		#endregion

		#region Private Constructor
		private TcssManager()
		{
			InitializeComponent();
			BusinessRule = new TcssBR();
			tcssHeader = new TcssHeader();
		}

		public static TcssManager CreateInstance()
		{
			//removed check for null and am recreating the object
			tcssManager = new TcssManager();
			return tcssManager;
		}
		#endregion

		#region Protected Methods
		/// <summary>
		/// Update the parameters when the control comes into view
		/// </summary>
		protected override void UpdateParameters()
		{
            ((TcssBR)BusinessRule).CallId  = GRConstant.ReferralId;
            ((TcssBR)BusinessRule).RecipientId = GRConstant.TcssRecipientId;
			((TcssBR)BusinessRule).DonorId = GRConstant.TcssDonorId;
		}
        
		/// <summary>
		/// Navigate Back To Parent Control
		/// </summary>
		protected override void NavigateBackToParent()
		{
			GRConstant.ReferralId = Int32.MinValue;
			GRConstant.TcssDonorId = Int32.MinValue;
			GRConstant.TcssRecipientId = Int32.MinValue;
            ((TcssBR)BusinessRule).AssociatedDataSet.Clear();            
            if(((BaseForm)FindForm()).Name == "InFormPrompt")
                ((BaseForm)FindForm()).Close();   
            else
			((BaseForm)FindForm()).LoadSubControl(AppScreenType.Dashboard, AppScreenType.DashboardTCSSActiveCases);
		}
        private void DeleteFromImport()
        {
            ((TcssBR)BusinessRule).DeleteDataBeforeImport();
        }
        private void BindDataToUIAsync()
        {
            importDonorCardControl.InitializeBR(BusinessRule);
            importDonorCardControl.BindDataToUI();

            TcssDS tcssDS = (TcssDS)BusinessRule.AssociatedDataSet;
            donorCardStatusAssocControl.InitializeBR(BusinessRule);
            donorCardStatusAssocControl.BindDataToUI();
            contactInformationControl.InitializeBR(BusinessRule);
            contactInformationControl.BindDataToUI();
            donorRecipientHlaSummaryControl.InitializeBR(BusinessRule);
            donorRecipientHlaSummaryControl.BindDataToUI();
            donorRecipientHlaDetailsControl.InitializeBR(BusinessRule);
            donorRecipientHlaDetailsControl.BindDataToUI();
            medicalSocialHistoryControl.InitializeBR(BusinessRule);
            medicalSocialHistoryControl.BindDataToUI();
            vitalSignsSummaryControl.InitializeBR(BusinessRule);
            vitalSignsSummaryControl.BindDataToUI();
            vitalSignsDetailsControl.InitializeBR(BusinessRule);
            vitalSignsDetailsControl.BindDataToUI();
            fluidsBloodControl.InitializeBR(BusinessRule);
            fluidsBloodControl.BindDataToUI();
            labProfileSummaryControl.InitializeBR(BusinessRule);
            labProfileSummaryControl.BindDataToUI();
            labProfileDetailsControl.InitializeBR(BusinessRule);
            labProfileDetailsControl.BindDataToUI();
            testDiagnosesControl.InitializeBR(BusinessRule);
            testDiagnosesControl.BindDataToUI();
            serologiesControl.InitializeBR(BusinessRule);
            serologiesControl.BindDataToUI();
            diagnosticsSummaryControl.InitializeBR(BusinessRule);
            diagnosticsSummaryControl.BindDataToUI();
            diagnosticsDetailsControl.InitializeBR(BusinessRule);
            diagnosticsDetailsControl.BindDataToUI();
            urinalysisCulturesControl.InitializeBR(BusinessRule);
            urinalysisCulturesControl.BindDataToUI();
            abgVentSettingsControl.InitializeBR(BusinessRule);
            abgVentSettingsControl.BindDataToUI();
        }
        //private delegate void BindDataToUIDelegate();
        //private void BindDataToUICompletedCallback(IAsyncResult ar)
        //{
        //    BindDataToUIDelegate worker = (BindDataToUIDelegate)((AsyncResult)ar).AsyncDelegate;
        //    worker.EndInvoke(ar);
        //}


		/// <summary>
		/// Bind the data to the UI
		/// </summary>
		protected override void BindDataToUI()
		{
			BaseForm baseForm = ((BaseForm)FindForm());
			if (baseForm != null)
				baseForm.LoadHeaderControl(tcssHeader);

			tcssHeader.InitializeBR(BusinessRule);
            tcssHeader.BindDataToUI();

			offerInformationControl.InitializeBR(BusinessRule);
			offerInformationControl.BindDataToUI();

            OrganSpecificLayout();

            BindDataToUIAsync();

            // Bug# 6032
            ultraTabPageControlOfferInformation.SelectNextControl(offerInformationControl, true, true, true, true);

            //BindDataToUIDelegate worker = new BindDataToUIDelegate(BindDataToUIAsync);
            //AsyncCallback completedCallback = new AsyncCallback(BindDataToUICompletedCallback);

            //AsyncOperation async = AsyncOperationManager.CreateOperation(null);
            //worker.BeginInvoke(BindDataToUICompletedCallback, async);
		}

		protected override void LoadDataFromUI()
		{
            offerInformationControl.LoadDataFromUI();
            donorCardStatusAssocControl.LoadDataFromUI();
            contactInformationControl.LoadDataFromUI();
            donorRecipientHlaSummaryControl.LoadDataFromUI();
            donorRecipientHlaDetailsControl.LoadDataFromUI();
            medicalSocialHistoryControl.LoadDataFromUI();
            vitalSignsSummaryControl.LoadDataFromUI();
            vitalSignsDetailsControl.LoadDataFromUI();
            fluidsBloodControl.LoadDataFromUI();
            labProfileSummaryControl.LoadDataFromUI();
            labProfileDetailsControl.LoadDataFromUI();
            testDiagnosesControl.LoadDataFromUI();
            serologiesControl.LoadDataFromUI();
		}
		#endregion

		#region Private Methods
        /// <summary>
        /// This are the changes that needs to be done for specific Organs
        /// </summary>
		private void OrganSpecificLayout()
		{
			if (GRConstant.TcssRecipientId != int.MinValue)
			{
				TcssDS tcssDS = (TcssDS)BusinessRule.AssociatedDataSet;
				if (!tcssDS.TcssRecipientOfferInformation[0].IsTcssListOrganTypeIdNull())
				{
                    ultraTabControlDiagnostics.Tabs["Diagnostics Summary"].Visible = false;
					TcssListOrganType tcssDonorOrganType = (TcssListOrganType)tcssDS.TcssRecipientOfferInformation[0].TcssListOrganTypeId;
					switch (tcssDonorOrganType)
					{
						case TcssListOrganType.Liver:
							BackColor = System.Drawing.Color.LightGreen;
							break;
						case TcssListOrganType.Kidney:
							BackColor = System.Drawing.Color.LightYellow;
                            ultraTabControlDiagnostics.Tabs["Diagnostics Summary"].Text = "Kidney Anatomy Summary";
                            ultraTabControlDiagnostics.Tabs["Diagnostics Summary"].Visible = true;
                            break;
						case TcssListOrganType.Heart:
							BackColor = System.Drawing.Color.LightPink;
							break;
						case TcssListOrganType.Lung:
							BackColor = System.Drawing.Color.LightBlue;
							break;
						case TcssListOrganType.Intestine:
							BackColor = System.Drawing.Color.SandyBrown;
							break;
						case TcssListOrganType.Pancreas:
							BackColor = System.Drawing.Color.MediumPurple;
							break;
						case TcssListOrganType.HeartLung:
                            BackColor = System.Drawing.Color.WhiteSmoke;
                            break;
                        case TcssListOrganType.KidneyPancreas:
                            BackColor = System.Drawing.Color.Empty;
                            ultraTabControlDiagnostics.Tabs["Diagnostics Summary"].Text = "Kidney Anatomy Summary";
                            ultraTabControlDiagnostics.Tabs["Diagnostics Summary"].Visible = true;
                            break;
                        case TcssListOrganType.MultiOrgan:
                            BackColor = System.Drawing.Color.Empty;
                            ultraTabControlDiagnostics.Tabs["Diagnostics Summary"].Text = "Kidney Anatomy Summary";
                            ultraTabControlDiagnostics.Tabs["Diagnostics Summary"].Visible = true;
                            break;
						default:
							BackColor = System.Drawing.Color.Empty;
							break;
					}
					ultraTabControlOasis.Tabs["Donor Card"].Visible = true;
					ultraTabControlOasis.Tabs["Donor Card"].Text = tcssDonorOrganType + " Donor Card";
				}
				else
				{
					ultraTabControlOasis.Tabs["Donor Card"].Visible = false;
				}
			}
			else
			{
				ultraTabControlOasis.Tabs["Donor Card"].Visible = false;
			}
		}
		#endregion

        #region Public Static Methods
        /// <summary>
        /// Rebind the data to the UI
        /// </summary>
        public static void ReBindDataToUI()
        {
            tcssManager.BindDataToUI();
        }
        public static void DeleteDataBeforeImport()
        {
            tcssManager.DeleteFromImport();
        }
        /// <summary>
        /// Enable Edit on the controls after importing data from UNOS
        /// </summary>
        /// <param name="isEnabled"></param>
        public static void ToggleEditForDataScrapeFromUnos(bool isEnabled)
        {
            tcssManager.contactInformationControl.Enabled = isEnabled;
            tcssManager.donorRecipientHlaSummaryControl.Enabled = isEnabled;
            tcssManager.donorRecipientHlaDetailsControl.Enabled = isEnabled;
            tcssManager.medicalSocialHistoryControl.Enabled = isEnabled;
            tcssManager.vitalSignsSummaryControl.Enabled = isEnabled;
            tcssManager.vitalSignsDetailsControl.Enabled = isEnabled;
            tcssManager.fluidsBloodControl.Enabled = isEnabled;
            tcssManager.labProfileSummaryControl.Enabled = isEnabled;
            tcssManager.labProfileDetailsControl.Enabled = isEnabled;
            tcssManager.testDiagnosesControl.Enabled = isEnabled;
            tcssManager.serologiesControl.Enabled = isEnabled;
            tcssManager.diagnosticsDetailsControl.Enabled = isEnabled;
            tcssManager.urinalysisCulturesControl.Enabled = isEnabled;
            tcssManager.abgVentSettingsControl.Enabled = isEnabled;
            tcssManager.EnableSaveButton(isEnabled);
        }

		public static void ReLoadDataFromDatabase()
        {
            tcssManager.ReLoadDataFromDatabase(tcssManager, null);
		}

        /// <summary>
        /// Save the data to the database
        /// </summary>
        public static void Save()
        {
            tcssManager.btnSave_Click(tcssManager, null);
        }

        public static void EnableSave()
        {
            if (tcssManager != null)
            {
                tcssManager.btnSave.Enabled = true;
                tcssManager.EnableSaveButton(true);
            }
        }

        public static void DisableSave()
        {
            if (tcssManager != null)
            {
                tcssManager.btnSave.Enabled = false;
                tcssManager.EnableSaveButton(false);
            }
        }
        #endregion
    }
}
