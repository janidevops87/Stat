using System;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class DonorRecipientHlaSummaryControl : BaseEditControl
	{
		public DonorRecipientHlaSummaryControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			cbRefusedByOtherCenters.BindData("TcssListRefusedByOtherCenterSelect");
			cbDonorAbo.BindData("TcssListAboSelect");
			cbDonorGender.BindData("TcssListGenderSelect");
			cbCrossmatch.BindData("TcssListPreliminaryCrossmatchSelect");
			cbCauseOfDeath.BindData("TcssListCauseOfDeathSelect");
			cbDonorAgeUnit.BindData("TcssListAgeUnitSelect");

			ddlBreathingOverVent.BindData("TcssListBreathingOverVentSelect");
			ddlHemodynamicallyStable.BindData("TcssListHemodynamicallyStableSelect");

			cbDq2.BindData("TcssListHlaDq2Select");
			cbDr2.BindData("TcssListHlaDr2Select");
			cbDq1.BindData("TcssListHlaDq1Select");
			cbDr53.BindData("TcssListHlaDr53Select");
			cbDr51.BindData("TcssListHlaDr51Select");
			cbDr1.BindData("TcssListHlaDr1Select");
			cbDr52.BindData("TcssListHlaDr52Select");
			cbC2.BindData("TcssListHlaC2Select");
			cbB2.BindData("TcssListHlaB2Select");
			cbA2.BindData("TcssListHlaA2Select");
			cbC1.BindData("TcssListHlaC1Select");
			cbBw6.BindData("TcssListHlaBw6Select");
			cbBw4.BindData("TcssListHlaBw4Select");
			cbB1.BindData("TcssListHlaB1Select");
			cbA1.BindData("TcssListHlaA1Select");

			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			ugCandidateDetail.DataSource = dataSet;
			ugCandidateDetail.DataMember = dataSet.TcssRecipientCandidateDetail.TableName;
			ugCandidateDetail.BindValueList("TcssListOfferStatusSelect", "TcssListOfferStatusId");
			ugCandidateDetail.BindValueList("TcssListRefusalReasonSelect", "PrimaryTcssListRefusalReasonId");
			ugCandidateDetail.BindValueList("TcssListRefusalReasonSelect", "SecondaryTcssListRefusalReasonId");

			string tableName = dataSet.TcssRecipientCandidate.TableName;
			cbRefusedByOtherCenters.BindDataSet(dataSet, tableName, dataSet.TcssRecipientCandidate.TcssListRefusedByOtherCenterIdColumn.ColumnName);
			txtWhy.BindDataSet(dataSet, tableName, dataSet.TcssRecipientCandidate.WhyColumn.ColumnName);
			
			tableName = dataSet.TcssDonorHla.TableName;
			cbDonorAbo.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListAboIdColumn.ColumnName);
			txtDonorAge.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.AgeColumn.ColumnName);
			cbDonorAgeUnit.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListAgeUnitIdColumn.ColumnName);
			cbDonorGender.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListGenderIdColumn.ColumnName);
			txtDonorHeightFeet.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.HeightFeetColumn.ColumnName);
			txtDonorHeightInches.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.HeightInchesColumn.ColumnName);
			txtDonorWeight.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.WeightColumn.ColumnName);

			if (!dataSet.TcssDonorHla[0].IsTcssListDonorDefinitionIdNull())
			{
				TcssListDonorDefinition tcssListDonorDefinition = (TcssListDonorDefinition)dataSet.TcssDonorHla[0].TcssListDonorDefinitionId;
				switch (tcssListDonorDefinition)
				{
					case TcssListDonorDefinition.DBDBrainDeath:
						rbDbd.Checked = true;
						break;
					case TcssListDonorDefinition.DCD:
						rbDCD.Checked = true;
						break;
					case TcssListDonorDefinition.Unknown:
						rbUnknown.Checked = true;
						break;
					default:
						break;
				}
			}

			if (!dataSet.TcssDonorHla[0].IsTcssListDonorDbdSubDefinitionIdNull())
			{
				TcssListDonorDbdSubDefinition tcssListDonorDbdSubDefinition = (TcssListDonorDbdSubDefinition)dataSet.TcssDonorHla[0].TcssListDonorDbdSubDefinitionId;
				switch (tcssListDonorDbdSubDefinition)
				{
					case TcssListDonorDbdSubDefinition.SCD:
						rbScd.Checked = true;
						break;
					case TcssListDonorDbdSubDefinition.ECD:
						rbEcd.Checked = true;
						break;
					case TcssListDonorDbdSubDefinition.Unknown:
						rbDbdUnknown.Checked = true;
						break;
					default:
						break;
				}
			}

			if (!dataSet.TcssDonorHla[0].IsTcssListDonorDcdSubDefinitionIdNull())
			{
				TcssListDonorDcdSubDefinition tcssListDonorDcdSubDefinition = (TcssListDonorDcdSubDefinition)dataSet.TcssDonorHla[0].TcssListDonorDcdSubDefinitionId;
				switch (tcssListDonorDcdSubDefinition)
				{
					case TcssListDonorDcdSubDefinition.Yes:
						cbEcd.Checked = true;
						break;
					default:
						cbEcd.Checked = false;
						break;
				}
			}

			ddlBreathingOverVent.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.WeightColumn.ColumnName);
			txtUwScore.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.UwScoreColumn.ColumnName);
			ddlHemodynamicallyStable.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListHemodynamicallyStableIdColumn.ColumnName);

			dtAdmitDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.AdmitDateTimeColumn.ColumnName);
			txtEstimatedDowntime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.EstimattedDownTimeColumn.ColumnName);
			dtPronouncedDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.PronouncedDateTimeColumn.ColumnName);
			dtCardiacArrestDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.CardiacArrestDateTimeColumn.ColumnName);
			cbCauseOfDeath.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListCauseOfDeathIdColumn.ColumnName);
			txtPreAdmission.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.AdmissionCourseCommentsColumn.ColumnName);

			tableName = dataSet.TcssDonorHlaLiver.TableName;
			cbCrossmatch.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListPreliminaryCrossmatchIdColumn.ColumnName);
			cbA1.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaA1IdColumn.ColumnName);
			cbA2.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaA2IdColumn.ColumnName);
			cbB1.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaB1IdColumn.ColumnName);
			cbB2.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaB2IdColumn.ColumnName);
			cbBw4.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaBw4IdColumn.ColumnName);
			cbBw6.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaBw6IdColumn.ColumnName);
			cbC1.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaC1IdColumn.ColumnName);
			cbC2.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaC2IdColumn.ColumnName);
			cbDr1.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaDr1IdColumn.ColumnName);
			cbDr2.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaDr2IdColumn.ColumnName);
			cbDr51.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaDr51IdColumn.ColumnName);
			cbDr52.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaDr52IdColumn.ColumnName);
			cbDr53.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaDr53IdColumn.ColumnName);
			cbDq1.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaDq1IdColumn.ColumnName);
			cbDq2.BindDataSet(dataSet, tableName, dataSet.TcssDonorHlaLiver.TcssListHlaDq2IdColumn.ColumnName);
		}

		public override void LoadDataFromUI()
		{
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			if (rbDbd.Checked)
			{
				dataSet.TcssDonorHla[0].TcssListDonorDefinitionId = (int)TcssListDonorDefinition.DBDBrainDeath;
			}
			else if (rbDCD.Checked)
			{
				dataSet.TcssDonorHla[0].TcssListDonorDefinitionId = (int)TcssListDonorDefinition.DCD;
			}
			else if (rbUnknown.Checked)
			{
				dataSet.TcssDonorHla[0].TcssListDonorDefinitionId = (int)TcssListDonorDefinition.Unknown;
			}
			else
			{
				dataSet.TcssDonorHla[0].SetTcssListDonorDefinitionIdNull();
			}

			if (rbScd.Checked)
			{
				dataSet.TcssDonorHla[0].TcssListDonorDbdSubDefinitionId = (int)TcssListDonorDbdSubDefinition.SCD;
			}
			else if (rbEcd.Checked)
			{
				dataSet.TcssDonorHla[0].TcssListDonorDbdSubDefinitionId = (int)TcssListDonorDbdSubDefinition.ECD;
			}
			else if (rbDbdUnknown.Checked)
			{
				dataSet.TcssDonorHla[0].TcssListDonorDbdSubDefinitionId = (int)TcssListDonorDbdSubDefinition.Unknown;
			}
			else
			{
				dataSet.TcssDonorHla[0].SetTcssListDonorDbdSubDefinitionIdNull();
			}

			if (cbEcd.CheckState == System.Windows.Forms.CheckState.Checked )
			{
				dataSet.TcssDonorHla[0].TcssListDonorDcdSubDefinitionId = (int)TcssListDonorDcdSubDefinition.Yes;
			}
			else
			{
				dataSet.TcssDonorHla[0].TcssListDonorDcdSubDefinitionId = (int)TcssListDonorDcdSubDefinition.No;
			}
		}

		private void rbDbd_CheckedChanged(object sender, EventArgs e)
		{
			if (rbDbd.Checked)
			{
				 gbBrainDeathDbdSubType.Visible = true;
			}
			else
			{
				gbBrainDeathDbdSubType.Visible = false;
				rbScd.Checked = false;
				rbEcd.Checked = false;
				rbDbdUnknown.Checked = false;
			}
		}

		private void rbDCD_CheckedChanged(object sender, EventArgs e)
		{
			if (rbDCD.Checked)
			{
				cbEcd.Visible = true;
			}
			else
			{
				cbEcd.Visible = false;
				cbEcd.Checked = false;
			}
		}
	}
}
