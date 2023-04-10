using Statline.Stattrac.Data.Types.NewCall;
using System.Windows.Forms;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class ContactInformationControl : BaseEditControl
	{
		#region Private Fields
		private CurrencyManager tcssDonorContactInformationCurrenycyManager;
		#endregion

		#region Constructor
		public ContactInformationControl()
		{
			InitializeComponent();
		}
		#endregion

		#region Overriden Methods
		public override void BindDataToUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;

			// Use this to update the header
			tcssDonorContactInformationCurrenycyManager = (CurrencyManager)BindingContext[dataSet, dataSet.TcssDonorContactInformation.TableName];

			cbTimeZone.BindData("TcssListTimeZoneSelect");
			cbDaylightObserved.BindData("TcssListDaylightSavingsObservedSelect");

            if (!dataSet.Call[0].IsSourceCodeIDNull())
            {
                cbClinicalCoordinator.BindClinicalCoordinatorByReferralFacility(dataSet.Call[0].SourceCodeID);
                if (!dataSet.TcssRecipientOfferInformation[0].IsClientIdNull())
                {
                    cbTransplantSurgeonContact.BindTransplantSurgeonContactByOrganization(dataSet.Call[0].SourceCodeID,
                        dataSet.TcssRecipientOfferInformation[0].ClientId);
                }
            }

			string tableName = dataSet.TcssDonorContactInformation.TableName;
			txtDonorHospital.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.DonorHospitalColumn.ColumnName);
			cbDaylightObserved.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.TcssListDaylightSavingsObservedIdColumn.ColumnName);
			cbTimeZone.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.TcssListTimeZoneIdColumn.ColumnName);
			txtDonorHospitalPhone.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.DonorHospitalPhoneColumn.ColumnName);
			txtDonorHospitalContact.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.DonorHospitalContactColumn.ColumnName);
			txtOpo.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.OpoColumn.ColumnName);
			txtOpoContact.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.OpoContactColumn.ColumnName);
			cbTransplantSurgeonContact.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.TransplantSurgeonContactIdColumn.ColumnName);
			txtTransplantSurgeonContactOther.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.TransplantSurgeonContactOtherColumn.ColumnName);
			cbClinicalCoordinator.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.ClinicalCoordinatorIdColumn.ColumnName);
			txtClinicalCoordinatorOther.BindDataSet(dataSet, tableName, dataSet.TcssDonorContactInformation.ClinicalCoordinatorOtherColumn.ColumnName);
		}
		#endregion

		#region Private Events
		private void EndCurrentEdit(object sender, System.EventArgs e)
		{
			tcssDonorContactInformationCurrenycyManager.EndCurrentEdit();
		}
		#endregion
	}
}
