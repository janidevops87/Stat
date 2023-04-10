using System;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;
using Statline.Stattrac.Data.Types.TcssListString;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.Windows.UI.Controls.NewCall.Tcss
{
	public partial class DonorRecipientHlaDetailsControl : BaseEditControl
	{
		public DonorRecipientHlaDetailsControl()
		{
			InitializeComponent();
		}

		public override void BindDataToUI()
		{
			cbDonorGender.BindData("TcssListGenderSelect");
			cbDonorAbo.BindData("TcssListAboSelect");
			cbDonorAgeUnit.BindData("TcssListAgeUnitSelect");
			cbCauseOfDeath.BindData("TcssListCauseOfDeathSelect");
			cbEthnicity.BindData("TcssListEthnicitySelect");
			cbRace.BindData("TcssListRaceSelect");
			cbCircumstancesOfDeath.BindData("TcssListCircumstancesOfDeathSelect");
			cbMechanismOfDeath.BindData("TcssListMechanismOfDeathSelect");
			cbMeetsEcdCriteriaId.BindData("TcssListDonorMeetsEcdCriteriaSelect");
			cbMeetsDcdCriteriaId.BindData("TcssListDonorMeetsDcdCriteriaSelect");
			cbCardiacArrestDowntime.BindData("TcssListCardiacArrestDownTimeSelect");
			cbCprAdministered.BindData("TcssListCprAdministeredSelect");


			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			string tableName = dataSet.TcssDonorHla.TableName;
			cbDonorAbo.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListAboIdColumn.ColumnName);
			dtDateOfBirth.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.DateOfBirthColumn.ColumnName);
			txtDonorAge.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.AgeColumn.ColumnName);
			cbDonorAgeUnit.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListAgeUnitIdColumn.ColumnName);
			cbDonorGender.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListGenderIdColumn.ColumnName);
			txtDonorHeightFeet.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.HeightFeetColumn.ColumnName);
			txtDonorHeightInches.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.HeightInchesColumn.ColumnName);
			txtDonorWeight.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.WeightColumn.ColumnName);
			txtBmi.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.BmiColumn.ColumnName);
			cbEthnicity.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListEthnicityIdColumn.ColumnName);
			cbRace.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListRaceIdColumn.ColumnName);
			cbCauseOfDeath.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListCauseOfDeathIdColumn.ColumnName);
			cbCircumstancesOfDeath.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListCircumstancesOfDeathIdColumn.ColumnName);
			cbMechanismOfDeath.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListMechanismOfDeathIdColumn.ColumnName);
			dtAdmitDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.AdmitDateTimeColumn.ColumnName);
			dtPronouncedDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.PronouncedDateTimeColumn.ColumnName);

			dtCrossClampDateTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.CrossClampDateTimeColumn.ColumnName);

			if (!dataSet.TcssDonorHla[0].IsColdSchemeticTimeNull())
			{
                //int hour = dataSet.TcssDonorHla[0].ColdSchemeticTime / 60;
                //int min = dataSet.TcssDonorHla[0].ColdSchemeticTime % 60;

                //string txtHour = "";
                //if (hour < 10)
                //    txtHour = "0" + hour;
                //else
                //    txtHour = "" + hour;

                //string txtMin = "";
                //if (min < 10)
                //    txtMin = "0" + min;
                //else
                //    txtMin = "" + min;

                //txtColdIschemicTime.Text = txtHour + ":" + txtMin;
			}
            txtColdIschemicTime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.ColdSchemeticTimeColumn.ColumnName);
			cbMeetsEcdCriteriaId.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListDonorMeetsEcdCriteriaIdColumn.ColumnName);
			cbMeetsDcdCriteriaId.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListDonorMeetsDcdCriteriaIdColumn.ColumnName);
			cbCardiacArrestDowntime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListCardiacArrestDownTimeIdColumn.ColumnName);
			txtEstimatedDowntime.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.EstimattedDownTimeColumn.ColumnName);
			cbCprAdministered.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.TcssListCprAdministeredIdColumn.ColumnName);
			txtDuration.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.DurationColumn.ColumnName);
			txtDonorHighlights.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.DonorHighlightsColumn.ColumnName);
			txtAdmissionCourseComments.BindDataSet(dataSet, tableName, dataSet.TcssDonorHla.AdmissionCourseCommentsColumn.ColumnName);
		}

		public override void LoadDataFromUI()
		{
			// Since this is a int with mask we neeed to manually bind the data
			TcssDS dataSet = (TcssDS)BusinessRule.AssociatedDataSet;
			if (string.IsNullOrEmpty(txtColdIschemicTime.Text) || txtColdIschemicTime.Text.Trim() == ":")
			{
				dataSet.TcssDonorHla[0].SetColdSchemeticTimeNull();
			}
			else
			{
                //DateTime dtColdIschemic = DateTime.Parse(txtColdIschemicTime.Text);
                //dataSet.TcssDonorHla[0].ColdSchemeticTime = (short)((dtColdIschemic.Hour * 60) + dtColdIschemic.Minute);
			}
		}

		/// <summary>
		/// Requirement 3065
		/// 1.8.1 The race field is populated based on the values in ethinicity. The ethnicity and race values must match
		/// the ethnicity and race values that UNOS accepts. The following are the ethnicity values with the specific race values below
		/// each ethincity value.
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		private void cbEthnicity_SelectedIndexChanged(object sender, EventArgs e)
		{
			cbRace.DataSource = null;
			ListControlDS listControlDS = new ListControlDS();
			listControlDS.ListControl.AddListControlRow(0, "Select A Value");
			TcssListEthnicity tcssListEthnicity = (TcssListEthnicity)cbEthnicity.SelectedIndex;
			switch (tcssListEthnicity)
			{
				case TcssListEthnicity.AmericanIndianorAlaskaNative:
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AmericanIndian, TcssListRaceString.AmericanIndian);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Eskimo, TcssListRaceString.Eskimo);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Aleutian, TcssListRaceString.Aleutian);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AlaskaIndian, TcssListRaceString.AlaskaIndian);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AmericanIndianorAlaskaNativeOther, TcssListRaceString.AmericanIndianorAlaskaNativeOther);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AmericanIndianorAlaskaNativeNotSpecifiedUnknown, TcssListRaceString.AmericanIndianorAlaskaNativeNotSpecifiedUnknown);
					break;
				case TcssListEthnicity.Asian:
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AsianIndianIndianSubContinent, TcssListRaceString.AsianIndianIndianSubContinent);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Chinese, TcssListRaceString.Chinese);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Filipino, TcssListRaceString.Filipino);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Japanese, TcssListRaceString.Japanese);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Korean, TcssListRaceString.Korean);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Vietnamese, TcssListRaceString.Vietnamese);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AsianOther, TcssListRaceString.AsianOther);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AsianNotSpecifiedUnknown, TcssListRaceString.AsianNotSpecifiedUnknown);
					break;
				case TcssListEthnicity.BlackorAfricanAmerican:
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AfricanAmerican, TcssListRaceString.AfricanAmerican);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AfricanContinental, TcssListRaceString.AfricanContinental);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.WestIndian, TcssListRaceString.WestIndian);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Haitian, TcssListRaceString.Haitian);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.BlackorAfricanAmericanOther, TcssListRaceString.BlackorAfricanAmericanOther);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.BlackorAfricanAmericanNotSpecifiedUnknown, TcssListRaceString.BlackorAfricanAmericanNotSpecifiedUnknown);
					break;
				case TcssListEthnicity.HispanicLatino:
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Mexican, TcssListRaceString.Mexican);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.PuertoRicanMainland, TcssListRaceString.PuertoRicanMainland);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.PuertoRicanIsland, TcssListRaceString.PuertoRicanIsland);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Cuban, TcssListRaceString.Cuban);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.HispanicLatinoOther, TcssListRaceString.HispanicLatinoOther);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.HispanicLatinoNotSpecifiedUnknown, TcssListRaceString.HispanicLatinoNotSpecifiedUnknown);
					break;
				case TcssListEthnicity.NativeHawaiianorOtherPacificIslander:
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.NativeHawaiian, TcssListRaceString.NativeHawaiian);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.GuamanianorChamorro, TcssListRaceString.GuamanianorChamorro);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.Samoan, TcssListRaceString.Samoan);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.NativeHawaiianorOtherPacificIslanderOther, TcssListRaceString.NativeHawaiianorOtherPacificIslanderOther);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.NativeHawaiianorOtherPacificIslanderNotSpecifiedUnknown, TcssListRaceString.NativeHawaiianorOtherPacificIslanderNotSpecifiedUnknown);
					break;
				case TcssListEthnicity.White:
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.EuropeanDescent, TcssListRaceString.EuropeanDescent);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.AraborMiddleEastern, TcssListRaceString.AraborMiddleEastern);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.NorthAfricannonBlack, TcssListRaceString.NorthAfricannonBlack);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.WhiteOther, TcssListRaceString.WhiteOther);
					listControlDS.ListControl.AddListControlRow((int)TcssListRace.WhiteNotSpecifiedUnknown, TcssListRaceString.WhiteNotSpecifiedUnknown);
					break;
				default:
					break;
			}

			cbRace.DataSource = listControlDS.ListControl;
			cbRace.DisplayMember = "FieldValue";
			cbRace.ValueMember = "ListId";
		}

		private void btnColdIschemicTime_Click(object sender, EventArgs e)
		{
			txtColdIschemicTime.Mask = null;
			txtColdIschemicTime.Text = "Cross-clamp data not available";
		}

		private void txtColdIschemicTime_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
		{
			if (e.KeyValue == 67)
			{
				txtColdIschemicTime.Mask = null;
				txtColdIschemicTime.Text = "Cross-clamp data not available";
				e.SuppressKeyPress = true; // Since we set the text value we ignore the key
			}
			else
			{
				txtColdIschemicTime.Mask = "00:00";
			}
		}
	}
}
