using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Dashboard;
using Statline.Stattrac.Data.Types.Dashboard;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.BusinessRules.NewCall;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Infragistics.Win;
using System.Globalization;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.FamilyServices
{
	public partial class CaseStatusControl : BaseEditControl
	{
		#region Constructor
		public CaseStatusControl()
		{
			InitializeComponent();
		} 
		#endregion

		#region Protected Overridden Methods
		/// <summary>
		/// Bind the data to the UI
		/// </summary>
		public override void BindDataToUI()
		{
			FamilyServicesDS ds = (FamilyServicesDS)BusinessRule.AssociatedDataSet;

			ugFsbCaseStatus.DataSource = ds;
			ugFsbCaseStatus.DataMember = ds.FsbCaseStatus.TableName;
            //ugFsbCaseStatus.Enabled = false;

			ugFsbCaseStatus.BeforeRowUpdate += new Infragistics.Win.UltraWinGrid.CancelableRowEventHandler(ugFsbCaseStatus_BeforeRowUpdate);
			ugFsbCaseStatus.RowUpdateCancelAction = Infragistics.Win.UltraWinGrid.RowUpdateCancelAction.RetainDataAndActivation;
			ugFsbCaseStatus.BeforeCellUpdate += new Infragistics.Win.UltraWinGrid.BeforeCellUpdateEventHandler(ugFsbCaseStatus_BeforeCellUpdate);

			ugFsbCaseStatus.DisplayLayout.Bands[0].Columns["LastModified"].DefaultCellValue = GRConstant.CurrentDateTime;
			ugFsbCaseStatus.DisplayLayout.Bands[0].Columns["LastStatEmployeeId"].DefaultCellValue = StattracIdentity.Identity.UserId;

			if (ds.FsbCase.Count == 1)
			{
				txtCreatedBy.Text = ds.FsbCase[0].CreatedUser;
                //txtDateCreated.Text = ds.FsbCase[0].CreatedDate.ToString("g", System.Globalization.DateTimeFormatInfo.InvariantInfo);
                txtDateCreated.Text = ds.FsbCase[0].LastModified.ToString("g", System.Globalization.DateTimeFormatInfo.InvariantInfo);
				txtReferralNum.Text = ds.FsbCase[0].CallId.ToString(GRConstant.StattracCulture);
				txtClient.Text = ds.FsbCase[0].SourceCodeName;
				txtPatientFirstName.Text = ds.FsbCase[0].PatientFirst;
				txtPatientLastName.Text = ds.FsbCase[0].PatientLast;
                //ugFsbCaseStatus.Enabled = true;
				ugFsbCaseStatus.DisplayLayout.Bands[0].Columns["CallId"].DefaultCellValue = ds.FsbCase[0].CallId;
			}
			else
			{
				txtCreatedBy.Text = string.Empty;
				txtDateCreated.Text = string.Empty;
				txtReferralNum.Text = string.Empty;
				txtClient.Text = string.Empty;
				txtPatientFirstName.Text = string.Empty;
				txtPatientLastName.Text = string.Empty;
			}

			BindValueList();
		}

		private void ugFsbCaseStatus_BeforeCellUpdate(object sender, Infragistics.Win.UltraWinGrid.BeforeCellUpdateEventArgs e)
		{
			if (e.Cell.Column.Key == "ListFsbStatusId" && string.IsNullOrEmpty(e.NewValue.ToString()))
			{
				BaseMessageBox.Show("Status is required");
				e.Cancel = true;
			}
		}

		private void ugFsbCaseStatus_BeforeRowUpdate(object sender, Infragistics.Win.UltraWinGrid.CancelableRowEventArgs e)
		{
            if (string.IsNullOrEmpty(e.Row.Cells["CallId"].Value.ToString()))
            {
                BaseMessageBox.Show("A Family Service Referral Number Must be Entered First");
                ugFsbCaseStatus.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.PrevCell, false, false);
                e.Cancel = true;
            }
			e.Row.Cells["LastModified"].Value = GRConstant.CurrentDateTime;
			if (string.IsNullOrEmpty(e.Row.Cells["ListFsbStatusId"].Value.ToString()))
			{
				BaseMessageBox.Show("Status is required");
				ugFsbCaseStatus.PerformAction(Infragistics.Win.UltraWinGrid.UltraGridAction.PrevCell, false, false);
				e.Cancel = true;
			}
		}

		private void BindValueList()
		{
			// Bind the value list for LastStatEmployeeId
			ListControlBR listControlBR = new ListControlBR("LookupListStatEmployee");
			ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
			ValueList valueList = new ValueList();
			// Add the items form the list
			foreach (ListControlDS.ListControlRow listControlRow in listControlDS.ListControl)
			{
				valueList.ValueListItems.Add(listControlRow.ListId, listControlRow.FieldValue);
			}
			// add the items that are not in the valulist
			FamilyServicesDS ds = (FamilyServicesDS)BusinessRule.AssociatedDataSet;
			for (int rowIndex = 0; rowIndex < ds.FsbCaseStatus.Rows.Count; rowIndex++)
			{
				FamilyServicesDS.FsbCaseStatusRow row = (FamilyServicesDS.FsbCaseStatusRow)ds.FsbCaseStatus.Rows[rowIndex];
				if (!row.IsLastStatEmployeeNameNull())
				{
					valueList.ValueListItems.Add(row.LastStatEmployeeId, row.LastStatEmployeeName);
				}
			}
			ugFsbCaseStatus.DisplayLayout.Bands[0].Columns["LastStatEmployeeId"].ValueList = valueList;


			// Bind the value list for FamilyServicesCoordinatorId
			listControlBR = new ListControlBR("LookupListPerson");
			listControlDS = (ListControlDS)listControlBR.SelectDataSet();
			valueList = new ValueList();
			foreach (ListControlDS.ListControlRow listControlRow in listControlDS.ListControl)
			{
				valueList.ValueListItems.Add(listControlRow.ListId, listControlRow.FieldValue);
			}
			for (int rowIndex = 0; rowIndex < ds.FsbCaseStatus.Rows.Count; rowIndex++)
			{
				FamilyServicesDS.FsbCaseStatusRow row = (FamilyServicesDS.FsbCaseStatusRow)ds.FsbCaseStatus.Rows[rowIndex];
				if (!row.IsFamilyServicesCoordinatorIdNull() && !row.IsFamilyServicesCoordinatorNameNull())
				{
					valueList.ValueListItems.Add(row.FamilyServicesCoordinatorId, row.FamilyServicesCoordinatorName);
				}
			}
			ugFsbCaseStatus.DisplayLayout.Bands[0].Columns["FamilyServicesCoordinatorId"].ValueList = valueList;


			// Bind the value list for ListFsbStatusId 
			listControlBR = new ListControlBR("ListFsbStatusSelect");
			listControlDS = (ListControlDS)listControlBR.SelectDataSet();
			valueList = new ValueList();
			foreach (ListControlDS.ListControlRow listControlRow in listControlDS.ListControl)
			{
				valueList.ValueListItems.Add(listControlRow.ListId, listControlRow.FieldValue);
			}
			ugFsbCaseStatus.DisplayLayout.Bands[0].Columns["ListFsbStatusId"].ValueList = valueList;
		}

		/// <summary>
		/// Load the data from the UI
		/// </summary>
		public override void LoadDataFromUI()
		{
            if (txtReferralNum.Text != "")
            {
			((FamilyServicesBR)BusinessRule).CallId = int.Parse(txtReferralNum.Text, GRConstant.StattracCulture);
            }
		} 
		#endregion

		#region Private Events
		/// <summary>
		/// Get the latest data when the user modifies the referral number
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void txtReferralNum_Leave(object sender, EventArgs e)
		{
            if (String.IsNullOrEmpty(txtReferralNum.Text))
            {
                BaseMessageBox.Show("Please enter a valid Family Service Referral Number");
                return;
            }
			LoadDataFromUI();
			FamilyServicesDS ds = (FamilyServicesDS)BusinessRule.SelectDataSet();
			if (ds.FsbCase.Count == 0)
			{
				BaseMessageBox.Show(txtReferralNum.Text + " is not a valid Family Service Referral Number");
			}
			else
			{
				BindDataToUI();
			}
		} 
		#endregion


        private void ugFsbCaseStatus_InitializeLayout(object sender, Infragistics.Win.UltraWinGrid.InitializeLayoutEventArgs e)
        {
            e.Layout.Override.AllowAddNew = Infragistics.Win.UltraWinGrid.AllowAddNew.FixedAddRowOnTop;
            this.ugFsbCaseStatus.DisplayLayout.Override.TemplateAddRowAppearance.BackColor = Color.Yellow;
            this.ugFsbCaseStatus.DisplayLayout.Override.AddRowAppearance.BackColor = Color.Yellow;
        }

        private void ugFsbCaseStatus_AfterRowActivate(object sender, EventArgs e)
        {
            if (ugFsbCaseStatus.ActiveRow != null && !ugFsbCaseStatus.ActiveRow.IsAddRow)
                ugFsbCaseStatus.ActiveRow.Activation = Infragistics.Win.UltraWinGrid.Activation.NoEdit;
        }
	}
}
