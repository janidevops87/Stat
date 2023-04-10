using System;
using System.Data;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.BusinessRules.NewCall
{
	internal class LoadDataFromUnos
	{
		#region Private Fields
		private HtmlDocument document;
		private TcssDS tcssDS;
		private int CallId;
		#endregion

		#region Internal Constructor
		internal LoadDataFromUnos(HtmlDocument document, TcssDS tcssDS)
		{
			this.document = document;
			this.tcssDS = tcssDS;
			CallId = tcssDS.TcssRecipientOfferInformation[0].CallId;
		} 
		#endregion

		#region Internal Mehods
		internal void LoadMatchResultsFromUnos()
		{
			LoadTcssRecipientCandidateDetail();
		}

		internal void LoadDonorSummaryFromUnos()
		{
			LoadProviderInformation();
			LoadDonorInformation();
			LoadMedicalSocialHistory();
			LoadVitalSigns();
			LoadCompleteBloodCount();
			LoadLabPanel();
			LoadUrinalysis();
			LoadAbg();
			LoadLabValues();
			LoadCultures();
			LoadMedication();
			LoadTransfusionBloodProducts();
			LoadSeroligies();
			LoadTestAndDiagnoses();
			LoadHlaCrossMatch();
			LoadKidney();
			LoadPancreas();
			LoadLiver();
			LoadIntestine();
		}

		/// <summary>
		/// Delete all the 
		/// </summary>
		internal void DeleteDataBeforeImport()
		{
			tcssDS.TcssRecipientOfferInformation[0].SetTcssListStatusOfImportDataIdNull();
			for (int index = 0; index < tcssDS.TcssDonorVitalSign.Count; index++)
			{
				tcssDS.TcssDonorVitalSign[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorVitalSignDetail.Count; index++)
			{
				tcssDS.TcssDonorVitalSignDetail[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorMedication.Count; index++)
			{
				tcssDS.TcssDonorMedication[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorLabProfile.Count; index++)
			{
				tcssDS.TcssDonorLabProfile[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorLabProfileDetail.Count; index++)
			{
				tcssDS.TcssDonorLabProfileDetail[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorLabValues.Count; index++)
			{
				tcssDS.TcssDonorLabValues[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorCompleteBloodCount.Count; index++)
			{
				tcssDS.TcssDonorCompleteBloodCount[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorTest.Count; index++)
			{
				tcssDS.TcssDonorTest[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorUrinalysis.Count; index++)
			{
				tcssDS.TcssDonorUrinalysis[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorCulture.Count; index++)
			{
				tcssDS.TcssDonorCulture[index].Delete();
			}
			for (int index = 0; index < tcssDS.TcssDonorAbg.Count; index++)
			{
				tcssDS.TcssDonorAbg[index].Delete();
			}
		}
		#endregion

		#region Private Methods LoadDataSubSection
		private void LoadTcssRecipientCandidateDetail()
		{
            // We only want to import the canididate information the first time, and not update it
            if (tcssDS.TcssRecipientCandidateDetail.Count > 0)
            {
                return;
            }

			HtmlElement element = null;
			string str = "";

			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "seqnum1" ||
					tableCollection[tableIndex].Id == "seqnum2" ||
					tableCollection[tableIndex].Id == "seqnum3" ||
                    tableCollection[tableIndex].Id == "seqnum5"
                    )
				{
					element = tableCollection[tableIndex];
					int numOfRows = element.Children[0].Children.Count;
					for (int rowIndex = 2; rowIndex < numOfRows; rowIndex = rowIndex + 1)
					{
						TcssDS.TcssRecipientCandidateDetailRow row = tcssDS.TcssRecipientCandidateDetail.NewTcssRecipientCandidateDetailRow();

						LoadInt(row, "SequenceNumber", element, rowIndex, 0);
						str = LoadString(element, rowIndex, 2); // Name

                        // Igonre the name if it starts with "*" 
                        if (str.Contains(","))
                        {
                            row.CandidateLastName = str.Substring(0, str.IndexOf(","));
                            row.CandidateFirstName = str.Substring(str.IndexOf(",") + 1).Trim();
                            tcssDS.TcssRecipientCandidateDetail.AddTcssRecipientCandidateDetailRow(row);
                        }
					}
				}
			}
		}

		private void LoadProviderInformation()
		{
			string str = "";
			// Provider Information
			tcssDS.TcssDonorContactInformation[0].Opo = LoadString("_ctl12_tdPI_OPO");
			string dh = LoadString("_ctl12_tdPI_DonorHospital");
			if (dh.Length > 40)
			{
				dh = dh.Substring(0, 40);
			}
			tcssDS.TcssDonorContactInformation[0].DonorHospital = dh;
			// Time ZOne
			str = document.GetElementById("_ctl12_trTimeZone").Children[1].InnerText;
			LoadList(tcssDS.TcssDonorContactInformation[0], tcssDS.TcssDonorContactInformation.TcssListTimeZoneIdColumn.ColumnName, str);
			// Is Daylight svings observed
			str = document.GetElementById("_ctl12_trTimeZone").Children[3].InnerText;
			LoadList(tcssDS.TcssDonorContactInformation[0], tcssDS.TcssDonorContactInformation.TcssListDaylightSavingsObservedIdColumn.ColumnName, str);
		}

		private void LoadDonorInformation()
		{
			string str = "";

			// Donor Information
			HtmlElement element = document.GetElementById("_ctl12_tblDI_Name");
			//LoadString(element, 0, 1); // Name
			LoadHeight(element);
			str = LoadString("_ctl12_lblBloodType"); // Blood Type
			LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListAboIdColumn.ColumnName, str);

			LoadDateTime(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.DateOfBirthColumn.ColumnName, element, 1, 1); // Date of Birth
			LoadWeight(element); // Weight
			LoadAge(element); // Age
			LoadBmi(element); // Bmi
			LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListGenderIdColumn.ColumnName, element, 3, 1); // Gender
			LoadEthnicityRace(element); // EthnicityRace

			element = document.GetElementById("_ctl12_tdDI_COD").Children[0];
			LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListCauseOfDeathIdColumn.ColumnName, element, 0, 1); // Cause of death
			LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListMechanismOfDeathIdColumn.ColumnName, element, 1, 1); // Mechanism of injury
			LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListCircumstancesOfDeathIdColumn.ColumnName, element, 2, 1); // Circumstance of death

			element = document.GetElementById("_ctl12_tdDI_BDPD").Children[0];
			LoadDateTime(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.AdmitDateTimeColumn.ColumnName, element, 0, 1); // Date of Birth
			LoadDateTime(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.PronouncedDateTimeColumn.ColumnName, element, 1, 1); // Pronouncement of death date
			LoadDateTime(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.CrossClampDateTimeColumn.ColumnName, element, 2, 1); // Cross-clamp date
            //LoadShort(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.ColdSchemeticTimeColumn.ColumnName, element, 3, 1); // Cold Ischemic Time
            tcssDS.TcssDonorHla[0].ColdSchemeticTime = LoadString(element, 3, 1);
			element = document.GetElementById("_ctl12_tblDI_ECD");

            for (int index = 0; index < element.Children[0].Children.Count; index++)
            {
                string unosText = element.Children[0].Children[index].Children[0].InnerText.Trim();
                switch (unosText)
                {
                    case "Donor meets ECD criteria:":
                        LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListDonorMeetsEcdCriteriaIdColumn.ColumnName, element, index, 1);
                        break;
                    case "Donor meets DCD criteria:":
                        LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListDonorMeetsDcdCriteriaIdColumn.ColumnName, element, index, 1);
                        break;
                    case "Cardiac arrest/downtime?:":
                        str = element.Children[0].Children[index].Children[1].Children[0].InnerText;
                        tcssDS.TcssDonorHla[0].TcssListCardiacArrestDownTimeId = LoadList(tcssDS.TcssDonorHla.TcssListCardiacArrestDownTimeIdColumn.ColumnName, str);
                        if (element.Children[0].Children[index].Children[1].Children.Count > 1)
                        {
                            str = element.Children[0].Children[index].Children[1].Children[1].InnerText;
                            LoadInt(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.EstimattedDownTimeColumn.ColumnName, str);
                        }
                        break;
                    case "CPR administered?:":
                        str = element.Children[0].Children[index].Children[1].Children[0].InnerText;
                        tcssDS.TcssDonorHla[0].TcssListCprAdministeredId = LoadList(tcssDS.TcssDonorHla.TcssListCprAdministeredIdColumn.ColumnName, str);
                        if (element.Children[0].Children[index].Children[1].Children.Count > 1)
                        {
                            str = element.Children[0].Children[index].Children[1].Children[1].InnerText;
                            LoadInt(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.DurationColumn.ColumnName, str);
                        }
                        break;
                    default:
                        break;
                }
            }

			element = document.GetElementById("_ctl12_tblDI_DonorHighlights");
			tcssDS.TcssDonorHla[0].DonorHighlights = LoadString(element, 1, 0); // Donor Highlights

			element = document.GetElementById("_ctl12_tblDI_AdmissionComments");
			tcssDS.TcssDonorHla[0].AdmissionCourseComments = Substring(LoadString(element, 1, 0), 0, 2000); // Admission course comments
		}

		private void LoadMedicalSocialHistory()
		{
			HtmlElement element = document.GetElementById("_ctl12_tblDI_MedicalHistory2");
			for (int index = 0; index < element.Children[0].Children.Count; index++)
			{
				string unosText = element.Children[0].Children[index].Children[0].InnerText.Trim();
				switch (unosText)
				{
					case "History of diabetes:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListHistoryOfDiabetesIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "History of cancer:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListHistoryOfCancerIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "History of hypertension:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListHypertensionHistoryIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "Compliant with treatment:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListCompliantWithTreatmentIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "History of coronary artery disease (CAD):":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListHistoryOfCoronaryArteryDiseaseIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "Previous gastrointestinal disease:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListHistoryOfGastrointestinalDiseaseIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "Chest trauma:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListChestTraumaIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "Cigarette use (>20 pack years) ever:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListCigaretteUseIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "And continued in last six months:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListCigaretteUseContinuedIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "Heavy alcohol use (2+ drinks/daily):":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListHeavyAlcoholUseIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "I.V. drug usage:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListOtherDrugUseIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					case "Does the donor meet CDC guidelines for \"high risk\" category:":
						LoadList(tcssDS.TcssDonorMedSoc[0], tcssDS.TcssDonorMedSoc.TcssListDonorMeetCdcGuidelinesIdColumn.ColumnName, element, index, 1); // History of diabetes
						break;
					default:
						break;
				}
			}

			element = document.GetElementById("_ctl12_tblDI_MedicalAndSocialHistoryComments");
			tcssDS.TcssDonorMedSoc[0].Comments = LoadString(element, 1, 0); // Medical & social history comments
		}

		private void LoadVitalSigns()
		{
			HtmlElement element = null;
			string str = "";
            int columnIndex = 1;
            int numOfRows = 0;
			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "_ctl12_tblVS_Indicators2")
				{
					element = tableCollection[tableIndex];
					numOfRows = element.Children[0].Children.Count;
					if (numOfRows > 0)
					{
						int numOfColumns = element.Children[0].Children[0].Children.Count;
						// We ignore the first column which is a header colimn
						for (columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
						{
							TcssDS.TcssDonorVitalSignRow vitalSignRow = (TcssDS.TcssDonorVitalSignRow)AddEmptyTcssDonorVitalSignRow(tcssDS.TcssDonorVitalSign);

							// Add the Begin and end date time
							LoadDateTime(vitalSignRow, tcssDS.TcssDonorVitalSign.FromDateTimeColumn.ColumnName, element, 0, columnIndex); // FromDateTime
							LoadDateTime(vitalSignRow, tcssDS.TcssDonorVitalSign.ToDateTimeColumn.ColumnName, element, 1, columnIndex); // ToDateTime

							// Get vital sign details
							LoadVitalSignDetail(vitalSignRow, element, numOfRows, columnIndex);
						}
					}
				}
			}
            
			element = element.Parent.NextSibling.NextSibling;
			str = LoadString(element, 0, 1); // Vital Signs comments
            TcssDS.TcssDonorVitalSignRow vitalSignRow1 = (TcssDS.TcssDonorVitalSignRow)AddEmptyTcssDonorVitalSignRow(tcssDS.TcssDonorVitalSign);
            // Add the Begin and end date time
            LoadDateTime(vitalSignRow1, tcssDS.TcssDonorVitalSign.FromDateTimeColumn.ColumnName,System.DateTime.Today.ToString()); // FromDateTime
            LoadDateTime(vitalSignRow1, tcssDS.TcssDonorVitalSign.ToDateTimeColumn.ColumnName, System.DateTime.Today.ToString()); // ToDateTime
            LoadVitalSignDetail(vitalSignRow1, element, 1, 1);
            
		}

		private void LoadVitalSignDetail(TcssDS.TcssDonorVitalSignRow vitalSignRow, HtmlElement element, int numOfRows, int columnIndex)
		{
			TcssDS.TcssDonorVitalSignDetailRow[] vitalSignDetailList = vitalSignRow.GetTcssDonorVitalSignDetailRows();
			string slash = "/";
			string unosValue = "";
			int vitalSignDetailIndex = int.MinValue;
			for (int rowIndex = 0; rowIndex < numOfRows; rowIndex++)
			{
				string str = LoadString(element, rowIndex, 0);
                str = str.Trim();
				switch (str)
				{
					case "Average/Actual BP":
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "Average BP (systolic)", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, 0, unosValue.IndexOf(slash));
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "Average BP (diastolic)", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, unosValue.IndexOf(slash) + 1);
                        unosValue = LoadVitalSignDetail(vitalSignDetailList, "Average/Actual BP", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
                        vitalSignDetailList[vitalSignDetailIndex].Answer = unosValue;
                        unosValue = LoadVitalSignDetail(vitalSignDetailList, "Average/Actual BP1", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
                        vitalSignDetailList[vitalSignDetailIndex].Answer = unosValue;
						break;
					case "High BP":
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "High BP (systolic)", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, 0, unosValue.IndexOf(slash));
						LoadVitalSignDetail(vitalSignDetailList, "High BP (diastolic)", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						unosValue = vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, unosValue.IndexOf(slash) + 1);
						break;
					case "Low BP":
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "Low BP (systolic)", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, 0, unosValue.IndexOf(slash));
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "Low BP (diastolic)", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, unosValue.IndexOf(slash) + 1);
						break;
					case "PA Pressure (Sys./Diastolic)":
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "PA (systolic)", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, 0, unosValue.IndexOf(slash));
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "PA (diastolic)", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, unosValue.IndexOf(slash) + 1);
						break;
					case "CO/CI (L/min / L/min/m2)":
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "CO", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, 0, unosValue.IndexOf(slash));
						unosValue = LoadVitalSignDetail(vitalSignDetailList, "CI", element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = Substring(unosValue, unosValue.IndexOf(slash) + 1);
						break;
					case "Average heart rate (bpm)":
					case "Duration at high (minutes)":
					case "Duration at low (minutes)":
					case "Core Body Temp.":
					case "Urine output (cc/hour)":
					case "CVP (mm/Hg)":
					case "PCWP (mm/Hg)":
					case "PAMP (mm/Hg)":
						unosValue = LoadVitalSignDetail(vitalSignDetailList, str, element, rowIndex, columnIndex, ref vitalSignDetailIndex);
						vitalSignDetailList[vitalSignDetailIndex].Answer = unosValue;
						break;
                    case "Vital Signs comments:":
                        unosValue = LoadVitalSignDetail(vitalSignDetailList, str, element, 0, columnIndex, ref vitalSignDetailIndex);
                        vitalSignDetailList[vitalSignDetailIndex].Answer = unosValue;
                        break;
					default:
						break;
				}
			}
		}

		private string LoadVitalSignDetail(TcssDS.TcssDonorVitalSignDetailRow[] vitalSignDetailList, string unosValue,
			HtmlElement element, int rowIndex, int columnIndex, ref int vitalSignDetailIndex)
		{
			//   // For the Unos value get the Tcss Id
			int tcssListVitalSignId = LoadListVitalSign(tcssDS.TcssDonorVitalSignDetail.TcssListVitalSignIdColumn.ColumnName, unosValue);

			// Find the row with this id int the DataTable and set the answer
			for (int index = 0; index < vitalSignDetailList.Length; index++)
			{
				if (vitalSignDetailList[index].TcssListVitalSignId == tcssListVitalSignId)
				{
					vitalSignDetailIndex = index;
					return LoadString(element, rowIndex, columnIndex); ;
				}
			}
			return string.Empty;
		}

		private void LoadCompleteBloodCount()
		{
			HtmlElement element = null;

			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "_ctl12_tblLV_CBC2")
				{
					element = tableCollection[tableIndex];
					int numOfRows = element.Children[0].Children.Count;
					if (numOfRows > 0)
					{
						int numOfColumns = element.Children[0].Children[0].Children.Count;
						// We ignore the first column which is a header colimn
						for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
						{
							string sampleDateTime = LoadString(element, 0, columnIndex) + " " + LoadString(element, 1, columnIndex);
							sampleDateTime = sampleDateTime.Trim();

							TcssDS.TcssDonorCompleteBloodCountRow bloodCountRow = (TcssDS.TcssDonorCompleteBloodCountRow)AddEmptyRow(tcssDS.TcssDonorCompleteBloodCount);

							// Add the Begin and end date time
							try
							{
								bloodCountRow.SampleDateTime = DateTime.Parse(sampleDateTime);
								bloodCountRow.Wbc = LoadString(element, 2, columnIndex); // Wbc
								bloodCountRow.Rbc = LoadString(element, 3, columnIndex); // Rbc
								bloodCountRow.Hgb = LoadString(element, 4, columnIndex); // Hgb
								bloodCountRow.Hct = LoadString(element, 5, columnIndex); // Hct
								bloodCountRow.Plt = LoadString(element, 6, columnIndex); // Plt
								LoadDecimal(bloodCountRow, tcssDS.TcssDonorCompleteBloodCount.BandsColumn.ColumnName, element, 7, columnIndex); // Bands
							}
							catch (Exception) { }
						}
					}
				}
			}
		}

		private void LoadLabPanel()
		{
			HtmlElement element = null;
			string str = "";

			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "_ctl12_tblLV_LabPanel2")
				{
					element = tableCollection[tableIndex];
					int numOfRows = element.Children[0].Children.Count;
					if (numOfRows > 0)
					{
						int numOfColumns = element.Children[0].Children[0].Children.Count;
						// We ignore the first column which is a header colimn
						for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
						{
							string sampleDateTime = LoadString(element, 0, columnIndex) + " " + 
								LoadString(element, 1, columnIndex);
							sampleDateTime = sampleDateTime.Trim();

							TcssDS.TcssDonorLabProfileRow labProfileRow = AddEmptyTcssDonorLabProfileRow(tcssDS.TcssDonorLabProfile);

							labProfileRow.SampleDateTime = DateTime.Parse(sampleDateTime);
							// Ignore the date and time row
							for (int rowIndex = 2; rowIndex < numOfRows; rowIndex++)
							{
								str = LoadString(element, rowIndex, 0);
								int tcssListLabId = LoadListLab(tcssDS.TcssDonorLabProfileDetail.TcssListLabIdColumn.ColumnName, str);
								str = LoadString(element, rowIndex, columnIndex);
								TcssDS.TcssDonorLabProfileDetailRow[] labProfileDetail = labProfileRow.GetTcssDonorLabProfileDetailRows();

								for (int index = 0; index < labProfileDetail.Length; index++)
								{
									if (labProfileDetail[index].TcssListLabId == tcssListLabId)
									{
										labProfileDetail[index].Answer = LoadString(element, rowIndex, columnIndex); ;
									}
								}
							}
						}
					}
				}
			}
		}

		private void LoadUrinalysis()
		{
			HtmlElement element = null;
			string str = "";

			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "_ctl12_tblLV_Urinalysis2")
				{
					element = tableCollection[tableIndex];
					int numOfRows = element.Children[0].Children.Count;
					if (numOfRows > 0)
					{
						int numOfColumns = element.Children[0].Children[0].Children.Count;
						// We ignore the first column which is a header colimn
						for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
						{
							string sampleDateTime = LoadString(element, 0, columnIndex) + " " + 
								LoadString(element, 1, columnIndex);
							sampleDateTime = sampleDateTime.Trim();
							TcssDS.TcssDonorUrinalysisRow urinalysisRow = (TcssDS.TcssDonorUrinalysisRow)AddEmptyRow(tcssDS.TcssDonorUrinalysis);

							// Add the Begin and end date time
							try
							{
								urinalysisRow.SampleDateTime = DateTime.Parse(sampleDateTime);
								
								urinalysisRow.Color = LoadString(element, 2, columnIndex); // Color
								urinalysisRow.AppearanceId = LoadString(element, 3, columnIndex); // Appearance
								LoadDecimal(urinalysisRow, tcssDS.TcssDonorUrinalysis.PhColumn.ColumnName, element, 4, columnIndex); // pH
								LoadDecimal(urinalysisRow, tcssDS.TcssDonorUrinalysis.SpecificGravityColumn.ColumnName, element, 5, columnIndex); // SpecificGravity

                                urinalysisRow.TcssUrinalysisProtein = LoadString(element, 6, columnIndex);
                                urinalysisRow.TcssUrinalysisGlucose = LoadString(element, 7, columnIndex);
                                urinalysisRow.TcssUrinalysisBlood = LoadString(element, 8, columnIndex);
                                urinalysisRow.TcssUrinalysisRbc = LoadString(element, 9, columnIndex); 
                                urinalysisRow.TcssUrinalysisWbc = LoadString(element, 10, columnIndex); 
                                urinalysisRow.TcssUrinalysisEpith = LoadString(element, 11, columnIndex); 
                                urinalysisRow.TcssUrinalysisCast = LoadString(element, 12, columnIndex); 
                                urinalysisRow.TcssUrinalysisBacteria = LoadString(element, 13, columnIndex); 
                                urinalysisRow.TcssUrinalysisLeukocyte = LoadString(element, 14, columnIndex); 
                                //don't do list, its strings now
                                //str = Substring(LoadString(element, 6, columnIndex), 0, "Positive".Length); // TcssListUrinalysisProteinId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisProteinIdColumn.ColumnName, str);
                                //str = Substring(LoadString(element, 7, columnIndex), 0, "Positive".Length); // TcssListUrinalysisGlucoseId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisGlucoseIdColumn.ColumnName, str);
                                //str = Substring(LoadString(element, 8, columnIndex), 0, "Positive".Length); // TcssListUrinalysisBloodId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisBloodIdColumn.ColumnName, str);
                                //str = Substring(LoadString(element, 9, columnIndex), 0, "Positive".Length); // TcssListUrinalysisRbcId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisRbcIdColumn.ColumnName, str);
                                //str = Substring(LoadString(element, 10, columnIndex), 0, "Positive".Length); // TcssListUrinalysisWbcId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisWbcIdColumn.ColumnName, str);
                                //str = Substring(LoadString(element, 11, columnIndex), 0, "Positive".Length); // TcssListUrinalysisEpithId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisEpithIdColumn.ColumnName, str);
                                //str = Substring(LoadString(element, 12, columnIndex), 0, "Positive".Length); // TcssListUrinalysisCastId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisCastIdColumn.ColumnName, str);
                                //str = Substring(LoadString(element, 13, columnIndex), 0, "Positive".Length); // TcssListUrinalysisBacteriaId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisBacteriaIdColumn.ColumnName, str);
                                //str = Substring(LoadString(element, 14, columnIndex), 0, "Positive".Length); // TcssListUrinalysisLeukocyteId
                                //LoadList(urinalysisRow, tcssDS.TcssDonorUrinalysis.TcssListUrinalysisLeukocyteIdColumn.ColumnName, str);
							}
							catch (Exception) { }
						}
					}
				}
			}
		}

		private void LoadAbg()
		{
			HtmlElement element = null;
			string str = "";

			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "_ctl12_tblLV_ABGs2")
				{
					element = tableCollection[tableIndex];
					int numOfRows = element.Children[0].Children.Count;
					if (numOfRows > 0)
					{
						int numOfColumns = element.Children[0].Children[0].Children.Count;
						// We ignore the first column which is a header colimn
						for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
						{
							string sampleDateTime = LoadString(element, 0, columnIndex) + " " + 
								LoadString(element, 1, columnIndex);
							sampleDateTime = sampleDateTime.Trim();
							TcssDS.TcssDonorAbgRow abgRow = (TcssDS.TcssDonorAbgRow)AddEmptyRow(tcssDS.TcssDonorAbg);

							// Add the Begin and end date time
							try
							{
								abgRow.SampleDateTime = DateTime.Parse(sampleDateTime);

								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.PhColumn.ColumnName, element, 2, columnIndex); // Ph
								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.Pco2Column.ColumnName, element, 3, columnIndex); // Pco2
								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.Po2Column.ColumnName, element, 4, columnIndex); // Po2
								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.Hco3Column.ColumnName, element, 5, columnIndex); // Hco3
								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.O2satColumn.ColumnName, element, 6, columnIndex); // O2sat
								str = LoadString(element, 7, columnIndex); // TcssListVentSettingModeId
								if (!str.Contains("Other"))
								{
									LoadList(abgRow, tcssDS.TcssDonorAbg.TcssListVentSettingModeIdColumn.ColumnName, str);
								}
								else
								{
									abgRow.ModeOther = str.Substring("Other: ".Length);
								}
								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.Fio2Column.ColumnName, element, 8, columnIndex); // 
								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.RateColumn.ColumnName, element, 9, columnIndex); // 
								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.VtColumn.ColumnName, element, 10, columnIndex); // 
								LoadDecimal(abgRow, tcssDS.TcssDonorAbg.PeepColumn.ColumnName, element, 11, columnIndex); // 
							}
							catch (Exception) { }
						}
					}
				}
			}
		}

		private void LoadLabValues()
		{
			HtmlElement element = null;

			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "_ctl12_tblLV_Lab_Values2")
				{
					element = tableCollection[tableIndex];
					int numOfRows = element.Children[0].Children.Count;
					if (numOfRows > 0)
					{
						int numOfColumns = element.Children[0].Children[0].Children.Count;
						// We ignore the first column which is a header colimn
						for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
						{
							string sampleDateTime = LoadString(element, 0, columnIndex) + " " + LoadString(element, 1, columnIndex);
							sampleDateTime = sampleDateTime.Trim();
							TcssDS.TcssDonorLabValuesRow labValuesRow = (TcssDS.TcssDonorLabValuesRow)AddEmptyRow(tcssDS.TcssDonorLabValues);

							// Add the Begin and end date time
							try
							{
								labValuesRow.SampleDateTime = DateTime.Parse(sampleDateTime);
								labValuesRow.Cpk = LoadString(element, 2, columnIndex); // Cpk
								labValuesRow.Ckmb = LoadString(element, 3, columnIndex); // Ckmb
								labValuesRow.TroponinL = LoadString(element, 4, columnIndex); // TroponinL
								labValuesRow.TroponinT = LoadString(element, 5, columnIndex); // TroponinT
							}
							catch (Exception) { }
						}
					}
				}
			}
            try
            {
                element = element.Parent.NextSibling.NextSibling;
                LoadList(tcssDS.TcssDonorLab[0], tcssDS.TcssDonorLab.TcssListToxicologyScreenIdColumn.ColumnName, element, 0, 1);
                string str = LoadString(element, 1, 0); //check for results
                if (str.Contains("Results"))
                {
                    tcssDS.TcssDonorLab[0].Results = LoadString(element, 1, 1); // Results
                    string HbA1c_string = LoadString(element, 2, 1);
                    HbA1c_string = HbA1c_string.Replace("%", "");
                    LoadDecimal(tcssDS.TcssDonorLab[0], tcssDS.TcssDonorLab.HbA1cColumn.ColumnName, HbA1c_string);
                    LoadDateTime(tcssDS.TcssDonorLab[0], tcssDS.TcssDonorLab.HbA1cDateTimeColumn.ColumnName, element, 3, 1);
                    element = element.NextSibling;
                    tcssDS.TcssDonorLab[0].OtherLabs = LoadString(element, 0, 1); // Other labs, specify
                }
                else
                {
                    string HbA1c_string = LoadString(element, 1, 1);
                    HbA1c_string = HbA1c_string.Replace("%", "");
                    LoadDecimal(tcssDS.TcssDonorLab[0], tcssDS.TcssDonorLab.HbA1cColumn.ColumnName, HbA1c_string);
                    LoadDateTime(tcssDS.TcssDonorLab[0], tcssDS.TcssDonorLab.HbA1cDateTimeColumn.ColumnName, element, 2, 1);
                    element = element.NextSibling;
                    tcssDS.TcssDonorLab[0].OtherLabs = LoadString(element, 3, 1); // Other labs, specify
                }

            }
            catch (Exception) { }
		}

		private void LoadCultures()
		{
			HtmlElement element = null;
			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "_ctl12_tblLV_Cultures2")
				{
					element = tableCollection[tableIndex];
					int numOfRows = element.Children[0].Children.Count;
					if (numOfRows > 0)
					{
						int numOfColumns = element.Children[0].Children[0].Children.Count;
						// We ignore the first column which is a header colimn
						for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
						{
							string sampleDateTime = LoadString(element, 0, columnIndex) + " " + LoadString(element, 1, columnIndex);
							sampleDateTime = sampleDateTime.Trim();
							TcssDS.TcssDonorCultureRow cultureRow = (TcssDS.TcssDonorCultureRow)AddEmptyRow(tcssDS.TcssDonorCulture);

							// Add the Begin and end date time
							try
							{
								cultureRow.SampleDateTime = DateTime.Parse(sampleDateTime);
								LoadList(cultureRow, tcssDS.TcssDonorCulture.TcssListCultureTypeIdColumn.ColumnName, element, 2, columnIndex);
								LoadList(cultureRow, tcssDS.TcssDonorCulture.TcssListCultureResultIdColumn.ColumnName, element, 3, columnIndex);
								cultureRow.Comment = LoadString(element, 4, columnIndex);
							}
							catch (Exception) { }
						}
					}
				}
			}
		}

		private void LoadMedication()
		{
			HtmlElement element = null;
			string str = "";

			HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
			for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
			{
				if (tableCollection[tableIndex].Id == "_ctl12_tblMF_MedsFluids2")
				{
					element = tableCollection[tableIndex];
					int numOfRows = element.Children[0].Children.Count;
					if (numOfRows > 0)
					{
						int numOfColumns = element.Children[0].Children[0].Children.Count;
						// We ignore the first column which is a header colimn
						for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
						{
							string medicationName = LoadString(element, 0, columnIndex).Trim();
							string fromDate = LoadString(element, 1, columnIndex).Trim();
							string toDate = LoadString(element, 2, columnIndex).Trim();
							TcssDS.TcssDonorMedicationRow medicationRow = (TcssDS.TcssDonorMedicationRow)AddEmptyRow(tcssDS.TcssDonorMedication);

							// Add the Begin and end date time
							try
							{
								LoadList(medicationRow, tcssDS.TcssDonorMedication.TcssListMedicationIdColumn.ColumnName, element, 0, columnIndex);
								medicationRow.StartDate = DateTime.Parse(fromDate);
								if (!string.IsNullOrEmpty(toDate))
								{
									medicationRow.StopDateTime = DateTime.Parse(toDate);
								}
                                LoadDecimal(medicationRow, tcssDS.TcssDonorMedication.DoseColumn.ColumnName, element, 3, columnIndex);
								LoadList(medicationRow, tcssDS.TcssDonorMedication.TcssListMedicationDoseUnitIdColumn.ColumnName, element, 4, columnIndex);
								str = LoadString(element, 5, columnIndex);
								if (!string.IsNullOrEmpty(str))
								{
                                    string[] str1 = str.Split(':');
                                    medicationRow.Duration = int.Parse(str1[0].Substring(0, str1[0].Length));
								}
							}
							catch (Exception) { }
						}
					}
				}
			}

			TcssDS.TcssDonorFluidBloodRow fluidBloodRow = tcssDS.TcssDonorFluidBlood[0];
			element = element.Parent.NextSibling.NextSibling;
			for (int index = 0; index < element.Children[0].Children.Count; index++)
			{
				string unosText = element.Children[0].Children[index].Children[0].InnerText.Trim();
				switch (unosText)
				{
					case "I.V. fluids:":
						fluidBloodRow.IvFluids = LoadString(element, index, 1);
						break;
					case "Is there dextrose in I.V. fluids?":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListDextroseInIvFluidsIdColumn.ColumnName, element, index, 1);
						break;
					case "Steroids:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListSteroidIdColumn.ColumnName, element, index, 1);
						tcssDS.TcssDonorFluidBlood[0].SteroidsDetail = LoadString(element, index + 1, 1);
						break;
					case "Diuretics:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListDiureticIdColumn.ColumnName, element, index, 1);
						tcssDS.TcssDonorFluidBlood[0].DiureticDetail = LoadString(element, index + 1, 1);
						break;
					case "T3:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListT3IdColumn.ColumnName, element, index, 1);
						break;
					case "T4:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListT4IdColumn.ColumnName, element, index, 1);
						break;
					case "Insulin:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListInsulinIdColumn.ColumnName, element, index, 1);
						break;
                    case "Insulin begin date/time":
                        LoadDateTime(fluidBloodRow, tcssDS.TcssDonorFluidBlood.InsulinBeginDateTimeColumn.ColumnName, element, index, 1);
                        break;
                    case "Insulin end date/time":
                        LoadDateTime(fluidBloodRow, tcssDS.TcssDonorFluidBlood.InsulinEndDateTimeColumn.ColumnName, element, index, 1);
                        break;
					case "Antihypertensives:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListAntihypertensiveIdColumn.ColumnName, element, index, 1);
						break;
					case "Vasodilators:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListVasodilatorIdColumn.ColumnName, element, index, 1);
						break;
					case "DDAVP:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListDdavpIdColumn.ColumnName, element, index, 1);
						break;
					case "Arginine vasopressin:":
						LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListArginineVasopressinIdColumn.ColumnName, element, index, 1);
						break;
					case "Arginine begin date/time":
						LoadDateTime(fluidBloodRow, tcssDS.TcssDonorFluidBlood.ArginlineBeginDateTimeColumn.ColumnName, element, index, 1);
						break;
					case "Arginine end date/time":
						LoadDateTime(fluidBloodRow, tcssDS.TcssDonorFluidBlood.ArginlineEndDateTimeColumn.ColumnName, element, index, 1);
						break;
					default:
						str = unosText;
						break;
				}
			}
			element = element.NextSibling;
			fluidBloodRow.TotalParenteralNutrition = LoadString(element, 0, 1);
            //changed TotalPareteralNutrition field...now a new field with id...still loading twice until for sure works
            LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListTotalParenteralNutritionIdColumn.ColumnName, element, 0, 1);
            LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListHeparinIdColumn.ColumnName, element, 1, 1);
            LoadDateTime(fluidBloodRow, tcssDS.TcssDonorFluidBlood.HeparinBeginDateColumn.ColumnName, element, 2, 1);
            LoadDateTime(fluidBloodRow, tcssDS.TcssDonorFluidBlood.HeparinEndDateColumn.ColumnName, element, 3, 1);
            fluidBloodRow.HeparinDosage = LoadString(element, 4, 1);
			element = element.NextSibling;
			fluidBloodRow.OtherSpecify1 = LoadString(element, 0, 1);
			fluidBloodRow.OtherSpecify2 = LoadString(element, 1, 1);
			fluidBloodRow.OtherSpecify3 = LoadString(element, 2, 1);
		}

		private void LoadTransfusionBloodProducts()
		{
			TcssDS.TcssDonorFluidBloodRow fluidBloodRow = tcssDS.TcssDonorFluidBlood[0];
			HtmlElement element = document.GetElementById("_ctl12_divMF_TransBlood").Children[0];
			LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListNumberOfTransfusionIdColumn.ColumnName, element, 0, 1);
			LoadList(fluidBloodRow, tcssDS.TcssDonorFluidBlood.TcssListOtherBloodProductIdColumn.ColumnName, element, 1, 1);
            fluidBloodRow.OtherBloodProductsDetails = LoadString(element, 2, 1);
		}

		private void LoadSeroligies()
		{
			HtmlElement element = document.GetElementById("_ctl12_divSR_Serologies").Children[0];
			LoadSeroligy(element, 0); // Anti-HBcAb
			LoadSeroligy(element, 1); // Anti-HCV
			LoadSeroligy(element, 2); // Anti-HIV I/II
			LoadSeroligy(element, 3); // Anti-HTLV I/II
			LoadSeroligy(element, 4); // HBsAg
			LoadSeroligy(element, 5); // Anti-CMV
			LoadSeroligy(element, 6); // RPR/VDRL
			LoadSeroligy(element, 7); // HBsAb
			LoadSeroligy(element, 8); // EBV (VCA) (lgG)
			LoadSeroligy(element, 9); // EBV (VCA) (lgM)
			LoadSeroligy(element, 10); // EBNA
		}

		private void LoadSeroligy(HtmlElement element, int row)
		{
			string str = LoadString(element, row, 0);
			str = str.Substring(0, str.IndexOf(":")).Trim();
			int questionId = LoadList("TcssListSerologyQuestionId", str);
			TcssDS.TcssDonorSerologiesRow serologiesRow = (TcssDS.TcssDonorSerologiesRow)
				tcssDS.TcssDonorSerologies.Select("TcssListSerologyQuestionId='" + questionId + "'")[0];
			LoadList(serologiesRow, tcssDS.TcssDonorSerologies.TcssListSerologyAnswerIdColumn.ColumnName, element, row, 1);

		}

		private void LoadTestAndDiagnoses()
		{
			HtmlElement element = document.GetElementById("_ctl12_tblTD_TestAndDiagnoses2");
			if (element == null)
			{
				return;				
			}

			int numOfRows = element.Children[0].Children.Count;
			// We ignore the first row which is a header colimn
			for (int rowIndex = 1; rowIndex < numOfRows; rowIndex++)
			{
				string testDateTime = LoadString(element, rowIndex, 2).Trim();
				TcssDS.TcssDonorTestRow labValuesRow = (TcssDS.TcssDonorTestRow)AddEmptyRow(tcssDS.TcssDonorTest);

				// Add the Begin and end date time
				try
				{
					// Check to see if tehr is any image
					string imgUrl = LoadHtml(element, rowIndex, 0);
					if (imgUrl.Contains("IMG"))
						imgUrl = "Image Found ";
					else
						imgUrl = "";


					LoadList(labValuesRow, tcssDS.TcssDonorTest.TcssListTestTypeIdColumn.ColumnName, element, rowIndex, 1);
					labValuesRow.TestDateTime = DateTime.Parse(testDateTime);
					rowIndex++;
					labValuesRow.Interpretation = imgUrl + LoadString(element, rowIndex, 0);
				}
				catch (Exception ex)
				{
					BaseLogger.LogLoadDataFromUnosException(ex, "LoadTestAndDiagnoses()");
				}
			}
		}

		private void LoadHlaCrossMatch()
		{
			TcssDS.TcssDonorHlaLiverRow hlaLiverRow = tcssDS.TcssDonorHlaLiver[0];
			HtmlElement element = document.GetElementById("Row_HLA").Children[0].Children[0];
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaA1IdColumn.ColumnName, element, 0, 2); // A1
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaA2IdColumn.ColumnName, element, 0, 4); // A2
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaB1IdColumn.ColumnName, element, 1, 1); // B1
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaB2IdColumn.ColumnName, element, 1, 3); // B2
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaBw4IdColumn.ColumnName, element, 2, 1); // BW41
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaBw6IdColumn.ColumnName, element, 2, 3); // BW42
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaC1IdColumn.ColumnName, element, 3, 1); // CW1
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaC2IdColumn.ColumnName, element, 3, 3); // CW2
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaDr1IdColumn.ColumnName, element, 4, 2); // DR1
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaDr2IdColumn.ColumnName, element, 4, 4); // DR2
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaDr51IdColumn.ColumnName, element, 5, 1); // DR51
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaDr52IdColumn.ColumnName, element, 5, 3); // DR52
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaDr53IdColumn.ColumnName, element, 5, 5); // DR53
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaDq1IdColumn.ColumnName, element, 6, 1); // DQ1
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListHlaDq2IdColumn.ColumnName, element, 6, 3); // DQ2

			element = document.GetElementById("_ctl12_tblCM_CrossMatch2").Children[0].Children[0].Children[0].Children[0];
			LoadList(hlaLiverRow, tcssDS.TcssDonorHlaLiver.TcssListPreliminaryCrossmatchIdColumn.ColumnName, element, 0, 1);
		}

		private void LoadKidney()
		{
			// Left
			TcssDS.TcssDonorDiagnosisKidneyLeftRow kidneyLeftRow = tcssDS.TcssDonorDiagnosisKidneyLeft[0];
			HtmlElement element = document.GetElementById("_ctl12_divOD_Left_Kidney").FirstChild;
			LoadList(kidneyLeftRow, tcssDS.TcssDonorDiagnosisKidneyLeft.TcssListKidneyBiopsyIdColumn.ColumnName, element, 0, 1);

            HtmlElementCollection tableCollection = document.GetElementsByTagName("table");
            for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
            {
                if (tableCollection[tableIndex].Id == "_ctl12_tblOD_Left_Kidney_PumpVals2")
                {
                    element = tableCollection[tableIndex];
                    int numOfRows = element.Children[0].Children.Count;
                    if (numOfRows > 0)
                    {
                        int numOfColumns = element.Children[0].Children[0].Children.Count;
                        // We ignore the first column which is a header column
                        for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
                        {
                            string sampleDateTime = LoadString(element, 0, columnIndex);// +" " + LoadString(element, 1, columnIndex);
                            sampleDateTime = sampleDateTime.Trim();
                            TcssDS.TcssDonorDiagnosisKidneyBiopsyLeftRow kidneyBiopsyLeftRow = (TcssDS.TcssDonorDiagnosisKidneyBiopsyLeftRow)AddEmptyRow(tcssDS.TcssDonorDiagnosisKidneyBiopsyLeft);
                            // Add the Begin and end date time
                            try
                            {
                                string BP = null;
                                kidneyBiopsyLeftRow.DateTime = DateTime.Parse(sampleDateTime);
                                kidneyBiopsyLeftRow.Flow = LoadString(element, 1, columnIndex); // Flow
                                BP = LoadString(element, 2, columnIndex); // Pressure
                                kidneyBiopsyLeftRow.PressureSystolic = Substring(BP, 0, BP.IndexOf("/"));
                                kidneyBiopsyLeftRow.PressureDiastolic = Substring(BP, BP.IndexOf("/") + 1);
                                kidneyBiopsyLeftRow.Resistance = LoadString(element, 3, columnIndex); // Resistance
                            }
                            catch (Exception) { }
                        }
                    }
                }
            }

            element = element.Parent.NextSibling.NextSibling;
			kidneyLeftRow.Comment = LoadString(element, 0, 1);
			LoadList(kidneyLeftRow, tcssDS.TcssDonorDiagnosisKidneyLeft.TcssListKidneyPumpDeviceIdColumn.ColumnName, element, 1, 1); // A1
			LoadList(kidneyLeftRow, tcssDS.TcssDonorDiagnosisKidneyLeft.TcssListKidneyPumpSolutionIdColumn.ColumnName, element, 2, 1); // A2

			// Right
			TcssDS.TcssDonorDiagnosisKidneyRightRow kidneyRighttRow = tcssDS.TcssDonorDiagnosisKidneyRight[0];
			element = document.GetElementById("_ctl12_divOD_Right_Kidney").FirstChild;
			LoadList(kidneyRighttRow, tcssDS.TcssDonorDiagnosisKidneyRight.TcssListKidneyBiopsyIdColumn.ColumnName, element, 0, 1);
            tableCollection = document.GetElementsByTagName("table");
            for (int tableIndex = 0; tableIndex < tableCollection.Count; tableIndex++)
            {
                if (tableCollection[tableIndex].Id == "_ctl12_tblOD_Right_Kidney_PumpVals2")
                {
                    element = tableCollection[tableIndex];
                    int numOfRows = element.Children[0].Children.Count;
                    if (numOfRows > 0)
                    {
                        int numOfColumns = element.Children[0].Children[0].Children.Count;
                        // We ignore the first column which is a header column
                        for (int columnIndex = 1; columnIndex < numOfColumns; columnIndex++)
                        {
                            string sampleDateTime = LoadString(element, 0, columnIndex);// +" " + LoadString(element, 1, columnIndex);
                            sampleDateTime = sampleDateTime.Trim();
                            TcssDS.TcssDonorDiagnosisKidneyBiopsyRightRow kidneyBiopsyRightRow = (TcssDS.TcssDonorDiagnosisKidneyBiopsyRightRow)AddEmptyRow(tcssDS.TcssDonorDiagnosisKidneyBiopsyRight);
                            // Add the Begin and end date time
                            try
                            {
                                string BP = null;
                                kidneyBiopsyRightRow.DateTime = DateTime.Parse(sampleDateTime);
                                kidneyBiopsyRightRow.Flow = LoadString(element, 1, columnIndex); // Flow
                                BP = LoadString(element, 2, columnIndex); // Pressure
                                kidneyBiopsyRightRow.PressureSystolic = Substring(BP, 0, BP.IndexOf("/"));
                                kidneyBiopsyRightRow.PressureDiastolic = Substring(BP, BP.IndexOf("/") + 1);
                                kidneyBiopsyRightRow.Resistance = LoadString(element, 3, columnIndex); // Resistance
                            }
                            catch (Exception) { }
                        }
                    }
                }
            }

            element = element.Parent.NextSibling.NextSibling;
			kidneyRighttRow.Comment = LoadString(element, 0, 1);
			LoadList(kidneyRighttRow, tcssDS.TcssDonorDiagnosisKidneyRight.TcssListKidneyPumpDeviceIdColumn.ColumnName, element, 1, 1); // A1
			LoadList(kidneyRighttRow, tcssDS.TcssDonorDiagnosisKidneyRight.TcssListKidneyPumpSolutionIdColumn.ColumnName, element, 2, 1); // A2
		}

		private void LoadPancreas()
		{
			TcssDS.TcssDonorDiagnosisPancreasRow pancreasRow = tcssDS.TcssDonorDiagnosisPancreas[0];
			HtmlElement element = document.GetElementById("_ctl12_divOD_Pancreas").FirstChild;
			pancreasRow.Comment = LoadString(element, 0, 1);
		}

		private void LoadLiver()
		{
			TcssDS.TcssDonorDiagnosisLiverRow liverRow = tcssDS.TcssDonorDiagnosisLiver[0];
			HtmlElement element = document.GetElementById("_ctl12_divOD_Liver").FirstChild;
			LoadList(liverRow, tcssDS.TcssDonorDiagnosisLiver.TcssListLiverBiopsyIdColumn.ColumnName, element, 0, 1);
			liverRow.Comment = LoadString(element, 1, 1);
		}

		private void LoadIntestine()
		{
			TcssDS.TcssDonorDiagnosisIntestineRow intestineRow = tcssDS.TcssDonorDiagnosisIntestine[0];
			HtmlElement element = document.GetElementById("_ctl12_divOD_Intestine").FirstChild;
			intestineRow.Comment = LoadString(element, 0, 1);
		}
		#endregion

		#region  Private Methods Get Data From HtmlDocument Methods
		private string LoadString(string controlId)
		{
			string returnValue = string.Empty;
			try
			{
				returnValue = document.GetElementById(controlId).InnerText;
			}
			catch (Exception ex)
            {//comment...no reason to log errors
                //BaseLogger.LogLoadDataFromUnosException(ex, controlId);
			}
			return returnValue;
		}

		private string LoadHtml(HtmlElement table, int row, int column)
		{
			string returnValue = string.Empty;
			try
			{
				// Make sure the columns exists before trying to import
				if (table.Children[0].Children.Count > row)
				{
					returnValue = table.Children[0].Children[row].Children[column].InnerHtml;
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, table.OuterHtml);
			}
			if (returnValue == null)
			{
				returnValue = string.Empty;
			}
			return returnValue;
		}

		private string LoadString(HtmlElement table, int row, int column)
		{
			string returnValue = string.Empty;
			try
			{
                // Make sure the columns exists before trying to import
                if (table.Children[0].Children.Count > row)
                {
                    returnValue = table.Children[0].Children[row].Children[column].InnerText;
                }
			}
			catch (Exception ex)
			{//comment...no reason to log errors
                //BaseLogger.LogLoadDataFromUnosException(ex, table.OuterHtml);
			}
			if (returnValue == null)
			{
				returnValue = string.Empty;
			}
			return returnValue;
		}

		private DateTime LoadDateTime(HtmlElement table, int row, int column)
		{
			DateTime dateTime = DateTime.MinValue;
			string str = LoadString(table, row, column).Trim();
			try
			{
				if (!string.IsNullOrEmpty(str))
				{
					dateTime = DateTime.Parse(str);
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, table.OuterHtml);
			}
			return dateTime;
		}

		private void LoadDateTime(DataRow dataRow, string columnName, HtmlElement table, int row, int column)
		{
			string str = LoadString(table, row, column).Trim();
			LoadDateTime(dataRow, columnName, str);
		}

		private void LoadDateTime(DataRow dataRow, string columnName, string str)
		{
			try
			{
				str = str.Trim();
				if (!string.IsNullOrEmpty(str))
				{
					dataRow[columnName] = DateTime.Parse(str);
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, dataRow.Table.TableName, columnName);
			}
		}

		private void LoadShort(DataRow dataRow, string columnName, HtmlElement table, int row, int column)
		{
			string str = LoadString(table, row, column).Trim();
			try
			{
				if (!string.IsNullOrEmpty(str))
				{
					dataRow[columnName] = short.Parse(str);
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, dataRow.Table.TableName, columnName);
			}
		}

		private void LoadInt(DataRow dataRow, string columnName, HtmlElement table, int row, int column)
		{
			string str = LoadString(table, row, column).Trim();
			LoadInt(dataRow, columnName, str);
		}

		private void LoadInt(DataRow dataRow, string columnName, string str)
		{
			try
			{
				str = str.Trim();
				if (!string.IsNullOrEmpty(str))
				{
					dataRow[columnName] = int.Parse(str);
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, dataRow.Table.TableName, columnName);
			}
		}

		private void LoadDecimal(DataRow dataRow, string columnName, HtmlElement table, int row, int column)
		{
			string str = LoadString(table, row, column).Trim();
			LoadDecimal(dataRow, columnName, str);
		}

		private void LoadDecimal(DataRow dataRow, string columnName, string str)
		{
			try
			{
				str = str.Trim();
				if (!string.IsNullOrEmpty(str))
				{
					dataRow[columnName] = decimal.Parse(str);
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, dataRow.Table.TableName, columnName);
			}
		}

		private int LoadList(string columnName, string unosValue)
		{
			int listId = int.MinValue;
			try
			{
				unosValue = unosValue.Trim();
				string sprocName = columnName.Substring(0, columnName.Length - 2) + "Select";
				ListControlBR br = new ListControlBR(sprocName, int.MinValue, null, unosValue);
				ListControlDS listControlDS = (ListControlDS)br.SelectDataSet();
				if (listControlDS.ListControl.Count == 1)
				{
					listId = listControlDS.ListControl[0].ListId;
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, columnName);
			}
			return listId;

		}

		private void LoadList(DataRow dataRow, string columnName, HtmlElement table, int row, int column)
		{
			string str = LoadString(table, row, column).Trim();
			LoadList(dataRow, columnName, str);
		}

		private void LoadList(DataRow dataRow, string columnName, string unosValue)
		{
			try
			{
				unosValue = unosValue.Trim();
				string sprocName = columnName.Substring(0, columnName.Length - 2) + "Select";
				ListControlBR br = new ListControlBR(sprocName, int.MinValue, null, unosValue);
				ListControlDS listControlDS = (ListControlDS)br.SelectDataSet();
				if (listControlDS.ListControl.Count == 1)
				{
					dataRow[columnName] = listControlDS.ListControl[0].ListId;
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, dataRow.Table.TableName, columnName);
			}
		}

		/// <summary>
		/// Load the value for the VitalSign
		/// </summary>
		/// <param name="columnName"></param>
		/// <param name="unosValue"></param>
		/// <returns></returns>
		private int LoadListVitalSign(string columnName, string unosValue)
		{
			int listId = int.MinValue;
			try
			{
				unosValue = unosValue.Trim();
				string sprocName = columnName.Substring(0, columnName.Length - 2) + "Select";
				ListControlBR br = new ListControlBR(sprocName, int.MinValue, null, unosValue);
				ListControlDS listControlDS = (ListControlDS)br.SelectDataSet();
				if (listControlDS.TcssListVitalSign.Count == 1)
				{
					listId = listControlDS.TcssListVitalSign[0].ListId;
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, columnName);
			}
			return listId;

		}

		/// <summary>
		/// Load the value for the VitalSign
		/// </summary>
		/// <param name="columnName"></param>
		/// <param name="unosValue"></param>
		/// <returns></returns>
		private int LoadListLab(string columnName, string unosValue)
		{
			int listId = int.MinValue;
			try
			{
                unosValue = unosValue.Replace("\r\n", " ");
				unosValue = unosValue.Trim();
				string sprocName = columnName.Substring(0, columnName.Length - 2) + "Select";
				ListControlBR br = new ListControlBR(sprocName, int.MinValue, null, unosValue);
				ListControlDS listControlDS = (ListControlDS)br.SelectDataSet();
				if (listControlDS.TcssListLab.Count == 1)
				{
					listId = listControlDS.TcssListLab[0].ListId;
				}
			}
			catch (Exception ex)
			{
				BaseLogger.LogLoadDataFromUnosException(ex, columnName);
			}
			return listId;

		}
		#endregion

		#region Private Methods Unique GetData Methods
		private void LoadHeight(HtmlElement element)
		{
			try
			{
				string str = LoadString(element, 0, 3); // Height
				int feet = str.IndexOf("ft");
				int inch = str.IndexOf("in");
				string strFeet = str.Substring(0, feet);
				string strInch = str.Substring(feet + 2, inch - feet - 2);
				tcssDS.TcssDonorHla[0].HeightFeet = int.Parse(strFeet);
				tcssDS.TcssDonorHla[0].HeightInches = int.Parse(strInch);
			}
			catch (Exception) { }
		}

		private void LoadWeight(HtmlElement element)
		{
			try
			{
				string str = LoadString(element, 1, 3); // Weight
				int beg = str.IndexOf("/") + 1;
				int end = str.IndexOf("kg");
				tcssDS.TcssDonorHla[0].Weight = decimal.Parse(str.Substring(beg, end - beg));
			}
			catch (Exception) { }
		}
		
		private void LoadAge(HtmlElement element)
		{
			try
			{
				string str = LoadString(element, 2, 1); // Age
				int beg = str.IndexOf(" ");
				tcssDS.TcssDonorHla[0].Age = int.Parse(str.Substring(0, beg));
				string ageUnit = str.Substring(beg + 1, str.Length - beg - 1).ToLower();
				switch (ageUnit)
				{
					case "years":
						tcssDS.TcssDonorHla[0].TcssListAgeUnitId = (int)TcssListAgeUnit.Years;
						break;
					case "months":
						tcssDS.TcssDonorHla[0].TcssListAgeUnitId = (int)TcssListAgeUnit.Months;
						break;
					default:
						break;
				}
			}
			catch (Exception) { }
		}
		
		private void LoadBmi(HtmlElement element)
		{
			try
			{
				string str = LoadString(element, 2, 3); // BMI
				int beg = str.IndexOf("kg");
				tcssDS.TcssDonorHla[0].Bmi = decimal.Parse(str.Substring(0, beg));
			}
			catch (Exception) { }
		}

		private void LoadEthnicityRace(HtmlElement element)
		{
			string strEthnicityRace = LoadString(element, 5, 1); // Ethinicity
			int indexSemicolon = strEthnicityRace.IndexOf(":");
			string strEthnicity = Substring(strEthnicityRace, 0, indexSemicolon);
			string strRace = strEthnicityRace.Substring(indexSemicolon + 1);

			LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListEthnicityIdColumn.ColumnName, strEthnicity); // Ethinicity
			LoadList(tcssDS.TcssDonorHla[0], tcssDS.TcssDonorHla.TcssListRaceIdColumn.ColumnName, strRace); // Race
		}
		#endregion

		#region  Private Methods Other
		/// <summary>
		/// Add an empty row to the table
		/// </summary>
		/// <param name="table"></param>
		/// <returns></returns>
		private DataRow AddEmptyRow(DataTable dataTable)
		{
			DataRow dataRow = dataTable.NewRow();
			dataTable.Rows.Add(dataRow);
			return dataRow;
		}

		/// <summary>
		/// Add an empty row to the table
		/// </summary>
		/// <param name="table"></param>
		/// <returns></returns>
		private TcssDS.TcssDonorVitalSignRow AddEmptyTcssDonorVitalSignRow(TcssDS.TcssDonorVitalSignDataTable vitalSignTable)
		{
			TcssDS.TcssDonorVitalSignRow vitalSignRow = vitalSignTable.NewTcssDonorVitalSignRow();
			vitalSignTable.Rows.Add(vitalSignRow);

			ListControlBR listControlBR = new ListControlBR("TcssListVitalSignSelect");
			ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
			for (int index = 0; index < listControlDS.TcssListVitalSign.Rows.Count; index++)
			{
				TcssDS.TcssDonorVitalSignDetailRow detailRow = tcssDS.TcssDonorVitalSignDetail.NewTcssDonorVitalSignDetailRow();
				detailRow.TcssDonorVitalSignId = vitalSignRow.TcssDonorVitalSignId;
				detailRow.TcssListVitalSignId = listControlDS.TcssListVitalSign[index].ListId;
				tcssDS.TcssDonorVitalSignDetail.AddTcssDonorVitalSignDetailRow(detailRow);
			}
			return vitalSignRow;
		}

		private TcssDS.TcssDonorLabProfileRow AddEmptyTcssDonorLabProfileRow(TcssDS.TcssDonorLabProfileDataTable labProfileTable)
		{
			TcssDS.TcssDonorLabProfileRow lLabProfileRow = labProfileTable.NewTcssDonorLabProfileRow();
			labProfileTable.Rows.Add(lLabProfileRow);

			ListControlBR listControlBR = new ListControlBR("TcssListLabSelect");
			ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
			for (int index = 0; index < listControlDS.TcssListLab.Rows.Count; index++)
			{
				TcssDS.TcssDonorLabProfileDetailRow detailRow = tcssDS.TcssDonorLabProfileDetail.NewTcssDonorLabProfileDetailRow();
				detailRow.TcssDonorLabProfileId = lLabProfileRow.TcssDonorLabProfileId;
				detailRow.TcssListLabId = listControlDS.TcssListLab[index].ListId;
				tcssDS.TcssDonorLabProfileDetail.AddTcssDonorLabProfileDetailRow(detailRow);
			}
			return lLabProfileRow;
		}

		/// <summary>
		/// Get the substring
		/// </summary>
		/// <param name="str"></param>
		/// <param name="startIndex"></param>
		/// <returns></returns>
		private string Substring(string str, int startIndex)
		{
			string returnValue = "";
			if (!string.IsNullOrEmpty(str.Trim()))
			{
				returnValue = str.Substring(startIndex);
			}
			return returnValue;
		}

		/// <summary>
		/// Get the substring
		/// </summary>
		/// <param name="str"></param>
		/// <param name="startIndex"></param>
		/// <param name="length"></param>
		/// <returns></returns>
		private string Substring(string str, int startIndex, int length)
		{
			string returnValue = "";
			if (!string.IsNullOrEmpty(str.Trim()))
			{
				if (str.Length < length)
				{
					length = str.Length;
				}
				returnValue = str.Substring(startIndex, length);
			}
			return returnValue;
		}
		#endregion
	}
}
