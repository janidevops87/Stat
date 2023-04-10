using System;
using System.Data;
using System.Linq;
using System.Windows.Forms;
using Statline.Stattrac.BusinessRules.Framework;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;
using Statline.Stattrac.Data.Types.TcssList;
using Statline.Stattrac.DataAccess.Dashboard;
using Statline.Stattrac.Framework;
using Statline.Stattrac.Data.Types.Framework;

namespace Statline.Stattrac.BusinessRules.NewCall
{
	public class TcssBR : BaseBR
	{
		#region Private Fields
		private GeneralConstant GRConstant;
		private const string KidneyArteryNumber = "Artery #";
		private const string KidneyLength = "Length (cm)";
		private const string KidneyDiameter = "Diameter (cm)";
		private const string KidneyDistance = "Distance apart (cm)";
		private const string KidneyArteries = "Arteries on common cuff";
		private const string KidneyVeinNumber = "Vein #";
		private const string KidneyVeins = "Veins on vena cava";
		private const string KidneyUreter = "Ureter Tissue Quality";
		#endregion

		#region Constructor
		public TcssBR()
		{
			GRConstant = GeneralConstant.CreateInstance();
			AssociatedDataSet = new TcssDS();
			AssociatedDA = new TcssDA();
		}
		#endregion

		#region Public Properties
		public int CallId
		{
			get { return ((TcssDA)AssociatedDA).CallId; }
			set { ((TcssDA)AssociatedDA).CallId = value; }
		}

		public int RecipientId
		{
			get { return ((TcssDA)AssociatedDA).RecipientId; }
			set { ((TcssDA)AssociatedDA).RecipientId = value; }
		}

		public int DonorId
		{
			get { return ((TcssDA)AssociatedDA).DonorId; }
			set { ((TcssDA)AssociatedDA).DonorId = value; }
		}

		public string UiVitalSign
		{
			get { return "UiVitalSign"; }
		}

		public string UiLabProfile
		{
			get { return "UiLabProfile"; }
		}

		public string UiVitalSignSummaryLiver
		{
			get { return "UiVitalSignSummaryLiver"; }
		}

		public string UiLabProfileSummaryLiver
		{
			get { return "UiLabProfileSummaryLiver"; }
		}

		public string UiVitalSignSummaryKidney
		{
			get { return "UiVitalSignSummaryKidney"; }
		}

		public string UiLabProfileSummaryKidney
		{
			get { return "UiLabProfileSummaryKidney"; }
		}

		public string UiVitalSignSummaryLung
		{
			get { return "UiVitalSignSummaryLung"; }
		}

		public string UiLabProfileSummaryLung
		{
			get { return "UiLabProfileSummaryLung"; }
		}

		public string UiVitalSignSummaryHeart
		{
			get { return "UiVitalSignSummaryHeart"; }
		}

		public string UiLabProfileSummaryHeart
		{
			get { return "UiLabProfileSummaryHeart"; }
		}

		public string UiVitalSignSummaryIntestine
		{
			get { return "UiVitalSignSummaryIntestine"; }
		}

		public string UiLabProfileSummaryIntestine
		{
			get { return "UiLabProfileSummaryIntestine"; }
		}

		public string UiVitalSignSummaryPancreas
		{
			get { return "UiVitalSignSummaryPancreas"; }
		}

		public string UiLabProfileSummaryPancreas
		{
			get { return "UiLabProfileSummaryPancreas"; }
		}

		public string UiVitalSignSummaryHeartLung
		{
			get { return "UiVitalSignSummaryHeartLung"; }
		}

		public string UiLabProfileSummaryHeartLung
		{
			get { return "UiLabProfileSummaryHeartLung"; }
		}

		public string UiVitalSignSummaryKidneyPancreas
		{
			get { return "UiVitalSignSummaryKidneyPancreas"; }
		}

		public string UiLabProfileSummaryKidneyPancreas
		{
			get { return "UiLabProfileSummaryKidneyPancreas"; }
		}

		public string UiVitalSignSummaryMultiOrgan
		{
			get { return "UiVitalSignSummaryMultiOrgan"; }
		}

		public string UiLabProfileSummaryMultiOrgan
		{
			get { return "UiLabProfileSummaryMultiOrgan"; }
		}
		#endregion

		#region Overridden Methods
		/// <summary>
		/// Business Rules After Select
		/// </summary>
		protected override void BusinessRulesAfterSelect()
		{
			AddEmptyRow();
			CreateTableVitalSign();
			CreateTableLabProfile();
			// CreateTableVitalSignSummary and CreateTableLabProfileSummary must be called after CreateTableVitalSign and CreateTableLabProfile

			TcssDS tcssDS = (TcssDS)AssociatedDataSet;
			if (tcssDS.TcssRecipientOfferInformation.Count == 1 && !tcssDS.TcssRecipientOfferInformation[0].IsTcssListOrganTypeIdNull())
			{
				switch ((TcssListOrganType)tcssDS.TcssRecipientOfferInformation[0].TcssListOrganTypeId)
				{
					case TcssListOrganType.Liver:
						CreateTableVitalSignSummary(UiVitalSignSummaryLiver, "IsLiver");
						CreateTableLabProfileSummary(UiLabProfileSummaryLiver, "IsLiver");
						break;
					case TcssListOrganType.Kidney:
						CreateTableVitalSignSummary(UiVitalSignSummaryKidney, "IsKidney");
						CreateTableLabProfileSummary(UiLabProfileSummaryKidney, "IsKidney");
						break;
					case TcssListOrganType.Heart:
						CreateTableVitalSignSummary(UiVitalSignSummaryHeart, "IsHeart");
						CreateTableLabProfileSummary(UiLabProfileSummaryHeart, "IsHeart");
						break;
					case TcssListOrganType.Lung:
						CreateTableVitalSignSummary(UiVitalSignSummaryLung, "IsLung");
						CreateTableLabProfileSummary(UiLabProfileSummaryLung, "IsLung");
						break;
					case TcssListOrganType.Intestine:
						CreateTableVitalSignSummary(UiVitalSignSummaryIntestine, "IsIntestine");
						CreateTableLabProfileSummary(UiLabProfileSummaryIntestine, "IsIntestine");
						break;
					case TcssListOrganType.Pancreas:
						CreateTableVitalSignSummary(UiVitalSignSummaryPancreas, "IsPancreas");
						CreateTableLabProfileSummary(UiLabProfileSummaryPancreas, "IsPancreas");
						break;
					case TcssListOrganType.HeartLung:
						CreateTableVitalSignSummary(UiVitalSignSummaryHeartLung, "IsHeartLung");
						CreateTableLabProfileSummary(UiLabProfileSummaryHeartLung, "IsHeartLung");
						break;
					case TcssListOrganType.KidneyPancreas:
						CreateTableVitalSignSummary(UiVitalSignSummaryKidneyPancreas, "IsKidneyPancreas");
						CreateTableLabProfileSummary(UiLabProfileSummaryKidneyPancreas, "IsKidneyPancreas");
						break;
					case TcssListOrganType.MultiOrgan:
						CreateTableVitalSignSummary(UiVitalSignSummaryMultiOrgan, "IsMultiOrgan");
						CreateTableLabProfileSummary(UiLabProfileSummaryMultiOrgan, "IsMultiOrgan");
						break;
					default:
						break;
				}
			}
			CreateTableSerologies();
			CreateTableDiagnosticsKidneyArteryLeft();
			CreateTableDiagnosticsKidneyVeinLeft();
			CreateTableDiagnosticsKidneyUreterLeft();
			CreateTableDiagnosticsKidneyArteryRight();
			CreateTableDiagnosticsKidneyVeinRight();
			CreateTableDiagnosticsKidneyUreterRight();
		}

		protected override void BusinessRulesBeforeSave()
		{
            //AssociatedDataSet.ds().WriteXml(@"d:\temp\tcssDataset.xml",XmlWriteMode.WriteSchema);
           
			LoadDataFromVitalSign();
			LoadDataFromLabProfile();
			AgeUnitIsRequiredWithAge();
            //check tables for any FKs with a value of 0 and set it to dbnull
            AssociatedDataSet.tcssDs().TcssDonorContactInformation.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(tcssDonorContactInformationRow =>
                    {

                        if (!tcssDonorContactInformationRow.IsTcssListTimeZoneIdNull())
                            if (tcssDonorContactInformationRow.TcssListTimeZoneId == 0)
                            {
                                tcssDonorContactInformationRow.SetTcssListTimeZoneIdNull();
                            }
                        if (!tcssDonorContactInformationRow.IsTcssListDaylightSavingsObservedIdNull())
                            if (tcssDonorContactInformationRow.TcssListDaylightSavingsObservedId == 0)
                            {
                                tcssDonorContactInformationRow.SetTcssListDaylightSavingsObservedIdNull();
                            }
                        if (!tcssDonorContactInformationRow.IsTransplantSurgeonContactIdNull())
                            if (tcssDonorContactInformationRow.TransplantSurgeonContactId == 0)
                            {
                                tcssDonorContactInformationRow.SetTransplantSurgeonContactIdNull();
                            }
                        if (!tcssDonorContactInformationRow.IsClinicalCoordinatorIdNull())
                            if (tcssDonorContactInformationRow.ClinicalCoordinatorId == 0)
                            {
                                tcssDonorContactInformationRow.SetClinicalCoordinatorIdNull();
                            }
                    });

            AssociatedDataSet
                .tcssDs().TcssRecipientOfferInformation.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(tcssRecipientOfferInformationRow =>
                    {
                        if (!tcssRecipientOfferInformationRow.IsStatEmployeeIdNull())
                            if (tcssRecipientOfferInformationRow.StatEmployeeId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetStatEmployeeIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsTcssListCallTypeIdNull())
                            if (tcssRecipientOfferInformationRow.TcssListCallTypeId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetTcssListCallTypeIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsClientIdNull())
                            if (tcssRecipientOfferInformationRow.ClientId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetClientIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsTcssListOrganTypeIdNull())
                            if (tcssRecipientOfferInformationRow.TcssListOrganTypeId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetTcssListOrganTypeIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsTcssListKidneyTypeIdNull())
                            if (tcssRecipientOfferInformationRow.TcssListKidneyTypeId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetTcssListKidneyTypeIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsTcssListLiverTypeIdNull())
                            if (tcssRecipientOfferInformationRow.TcssListLiverTypeId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetTcssListLiverTypeIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsTcssListLungTypeIdNull())
                            if (tcssRecipientOfferInformationRow.TcssListLungTypeId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetTcssListLungTypeIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsTcssListStatusOfImportDataIdNull())
                            if (tcssRecipientOfferInformationRow.TcssListStatusOfImportDataId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetTcssListStatusOfImportDataIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsStatusSetByStatEmployeeIdNull())
                            if (tcssRecipientOfferInformationRow.StatusSetByStatEmployeeId == 0)
                            {
                                tcssRecipientOfferInformationRow.SetStatusSetByStatEmployeeIdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsTcssListCloseReason1IdNull())
                            if (tcssRecipientOfferInformationRow.TcssListCloseReason1Id == 0)
                            {
                                tcssRecipientOfferInformationRow.SetTcssListCloseReason1IdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsCloseByStatEmployee1IdNull())
                            if (tcssRecipientOfferInformationRow.CloseByStatEmployee1Id == 0)
                            {
                                tcssRecipientOfferInformationRow.SetCloseByStatEmployee1IdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsTcssListCloseReason2IdNull())
                            if (tcssRecipientOfferInformationRow.TcssListCloseReason2Id == 0)
                            {
                                tcssRecipientOfferInformationRow.SetTcssListCloseReason2IdNull();
                            }
                        if (!tcssRecipientOfferInformationRow.IsCloseByStatEmployee2IdNull())
                            if (tcssRecipientOfferInformationRow.CloseByStatEmployee2Id == 0)
                            {
                                tcssRecipientOfferInformationRow.SetCloseByStatEmployee2IdNull();
                            }
                    });

                    AssociatedDataSet
                   .tcssDs().Call.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                   .ToList().ForEach(currentRow =>
                   {
                       if (!currentRow.IsCallTypeIDNull())
                           if (currentRow.CallTypeID == 0)
                           {
                               currentRow.SetCallTypeIDNull();
                           }
                       if (!currentRow.IsStatEmployeeIDNull())
                           if (currentRow.StatEmployeeID == 0)
                           {
                               currentRow.SetStatEmployeeIDNull();
                           }
                       if (!currentRow.IsSourceCodeIDNull())
                           if (currentRow.SourceCodeID == 0)
                           {
                               currentRow.SetSourceCodeIDNull();
                           }
                       if (!currentRow.IsCallOpenByIDNull())
                           if (currentRow.CallOpenByID == 0)
                           {
                               currentRow.SetCallOpenByIDNull();
                           }
                       if (!currentRow.IsCallTempSavedByIDNull())
                           if (currentRow.CallTempSavedByID == 0)
                           {
                               currentRow.SetCallTempSavedByIDNull();
                           }
                       if (!currentRow.IsCallOpenByWebPersonIdNull())
                           if (currentRow.CallOpenByWebPersonId == 0)
                           {
                               currentRow.SetCallOpenByWebPersonIdNull();
                           }
                       if (!currentRow.IsCallSaveLastByIDNull())
                           if (currentRow.CallSaveLastByID == 0)
                           {
                               currentRow.SetCallSaveLastByIDNull();
                           }
                    });



				AssociatedDataSet
                .tcssDs().TcssRecipientOfferStatusInformation.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
                        if (!currentRow.IsCoordinatorIdNull())
				            if (currentRow.CoordinatorId == 0)
				            {
					            currentRow.SetCoordinatorIdNull();
				            }


                        if (!currentRow.IsTcssListStatusIdNull())
                            if (currentRow.TcssListStatusId == 0)
				            {
					            currentRow.SetTcssListStatusIdNull();
				            }



				});


				AssociatedDataSet
                .tcssDs().TcssRecipientCandidate.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
                        if (!currentRow.IsTcssListRefusedByOtherCenterIdNull())
						    if (currentRow.TcssListRefusedByOtherCenterId == 0)
						    {
							    currentRow.SetTcssListRefusedByOtherCenterIdNull();
						    }

				});
				AssociatedDataSet
                .tcssDs().TcssRecipientCandidateDetail.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                       if (!currentRow.IsPrimaryTcssListRefusalReasonIdNull())
						if (currentRow.PrimaryTcssListRefusalReasonId == 0)
						{
							currentRow.SetPrimaryTcssListRefusalReasonIdNull();
						}

                       if (!currentRow.IsSecondaryTcssListRefusalReasonIdNull())
                           if (currentRow.SecondaryTcssListRefusalReasonId == 0)
						    {
    							currentRow.SetSecondaryTcssListRefusalReasonIdNull();
	    					}

                       if (!currentRow.IsTcssListOfferStatusIdNull())
                           if (currentRow.TcssListOfferStatusId == 0)
		    				{
			    				currentRow.SetTcssListOfferStatusIdNull();
				    		}


				});
				AssociatedDataSet
                .tcssDs().TcssDonorHlaLiver.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                        if (!currentRow.IsTcssListHlaDr53IdNull())
                            if (currentRow.TcssListHlaDr53Id == 0)
						    {
							    currentRow.SetTcssListHlaDr53IdNull();
						    }

                        if (!currentRow.IsTcssListHlaDr52IdNull())
                            if (currentRow.TcssListHlaDr52Id == 0)
						    {
							    currentRow.SetTcssListHlaDr52IdNull();
						    }

                        if (!currentRow.IsTcssListHlaDr51IdNull())
                            if (currentRow.TcssListHlaDr51Id == 0)
						    {
							    currentRow.SetTcssListHlaDr51IdNull();
						    }

                        if (!currentRow.IsTcssListHlaDr2IdNull())
                            if (currentRow.TcssListHlaDr2Id == 0)
						    {
							    currentRow.SetTcssListHlaDr2IdNull();
						    }

                        if (!currentRow.IsTcssListHlaDr1IdNull())
                            if (currentRow.TcssListHlaDr1Id == 0)
						    {
							    currentRow.SetTcssListHlaDr1IdNull();
						    }

                        if (!currentRow.IsTcssListHlaDq2IdNull())
                            if (currentRow.TcssListHlaDq2Id == 0)
						    {
							    currentRow.SetTcssListHlaDq2IdNull();
						    }

                        if (!currentRow.IsTcssListHlaDq1IdNull())
                            if (currentRow.TcssListHlaDq1Id == 0)
						    {
							    currentRow.SetTcssListHlaDq1IdNull();
						    }

                        if (!currentRow.IsTcssListHlaC2IdNull())
                            if (currentRow.TcssListHlaC2Id == 0)
						    {
							    currentRow.SetTcssListHlaC2IdNull();
						    }

                        if (!currentRow.IsTcssListHlaC1IdNull())
                            if (currentRow.TcssListHlaC1Id == 0)
						    {
							    currentRow.SetTcssListHlaC1IdNull();
						    }

                        if (!currentRow.IsTcssListHlaBw6IdNull())
                            if (currentRow.TcssListHlaBw6Id == 0)
						    {
							    currentRow.SetTcssListHlaBw6IdNull();
						    }

                        if (!currentRow.IsTcssListHlaBw4IdNull())
                            if (currentRow.TcssListHlaBw4Id == 0)
						    {
							    currentRow.SetTcssListHlaBw4IdNull();
						    }

                        if (!currentRow.IsTcssListHlaB2IdNull())
                            if (currentRow.TcssListHlaB2Id == 0)
						    {
							    currentRow.SetTcssListHlaB2IdNull();
						    }

                        if (!currentRow.IsTcssListHlaB1IdNull())
                            if (currentRow.TcssListHlaB1Id == 0)
						    {
							    currentRow.SetTcssListHlaB1IdNull();
						    }

                        if (!currentRow.IsTcssListHlaA2IdNull())
                            if (currentRow.TcssListHlaA2Id == 0)
						    {
							    currentRow.SetTcssListHlaA2IdNull();
						    }

                        if (!currentRow.IsTcssListHlaA1IdNull())
                            if (currentRow.TcssListHlaA1Id == 0)
						    {
							    currentRow.SetTcssListHlaA1IdNull();
						    }

                        if (!currentRow.IsTcssListPreliminaryCrossmatchIdNull())
                            if (currentRow.TcssListPreliminaryCrossmatchId == 0)
						    {
							    currentRow.SetTcssListPreliminaryCrossmatchIdNull();
						    }

				});
				AssociatedDataSet
                .tcssDs().TcssDonorHla.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
					    if (!currentRow.IsTcssListHemodynamicallyStableIdNull())
						    if (currentRow.TcssListHemodynamicallyStableId == 0)
						    {
							    currentRow.SetTcssListHemodynamicallyStableIdNull();
						    }
					    if (!currentRow.IsTcssListGenderIdNull())
						    if (currentRow.TcssListGenderId == 0)
						    {
							    currentRow.SetTcssListGenderIdNull();
						    }
					    if (!currentRow.IsTcssListEthnicityIdNull())
						    if (currentRow.TcssListEthnicityId == 0)
						    {
							    currentRow.SetTcssListEthnicityIdNull();
						    }
					    if (!currentRow.IsTcssListDonorDcdSubDefinitionIdNull())
						    if (currentRow.TcssListDonorDcdSubDefinitionId == 0)
						    {
							    currentRow.SetTcssListDonorDcdSubDefinitionIdNull();
						    }
					    if (!currentRow.IsTcssListDonorDbdSubDefinitionIdNull())
						    if (currentRow.TcssListDonorDbdSubDefinitionId == 0)
						    {
							    currentRow.SetTcssListDonorDbdSubDefinitionIdNull();
						    }
					    if (!currentRow.IsTcssListDonorMeetsEcdCriteriaIdNull())
						    if (currentRow.TcssListDonorMeetsEcdCriteriaId == 0)
						    {
							    currentRow.SetTcssListDonorMeetsEcdCriteriaIdNull();
						    }
					    if (!currentRow.IsTcssListDonorMeetsDcdCriteriaIdNull())
						    if (currentRow.TcssListDonorMeetsDcdCriteriaId == 0)
						    {
							    currentRow.SetTcssListDonorMeetsDcdCriteriaIdNull();
						    }
					    if (!currentRow.IsTcssListDonorDefinitionIdNull())
						    if (currentRow.TcssListDonorDefinitionId == 0)
						    {
							    currentRow.SetTcssListDonorDefinitionIdNull();
						    }
					    if (!currentRow.IsTcssListCprAdministeredIdNull())
						    if (currentRow.TcssListCprAdministeredId == 0)
						    {
							    currentRow.SetTcssListCprAdministeredIdNull();
						    }
					    if (!currentRow.IsTcssListCircumstancesOfDeathIdNull())
						    if (currentRow.TcssListCircumstancesOfDeathId == 0)
						    {
							    currentRow.SetTcssListCircumstancesOfDeathIdNull();
						    }
					    if (!currentRow.IsTcssListCauseOfDeathIdNull())
						    if (currentRow.TcssListCauseOfDeathId == 0)
						    {
							    currentRow.SetTcssListCauseOfDeathIdNull();
						    }
					    if (!currentRow.IsTcssListCardiacArrestDownTimeIdNull())
						    if (currentRow.TcssListCardiacArrestDownTimeId == 0)
						    {
							    currentRow.SetTcssListCardiacArrestDownTimeIdNull();
						    }
					    if (!currentRow.IsTcssListAgeUnitIdNull())
						    if (currentRow.TcssListAgeUnitId == 0)
						    {
							    currentRow.SetTcssListAgeUnitIdNull();
						    }
					    if (!currentRow.IsTcssListBreathingOverVentIdNull())
						    if (currentRow.TcssListBreathingOverVentId == 0)
						    {
							    currentRow.SetTcssListBreathingOverVentIdNull();
						    }
					    if (!currentRow.IsTcssListAboIdNull())
						    if (currentRow.TcssListAboId == 0)
						    {
							    currentRow.SetTcssListAboIdNull();
						    }
					    if (!currentRow.IsTcssListRaceIdNull())
						    if (currentRow.TcssListRaceId == 0)
						    {
							    currentRow.SetTcssListRaceIdNull();
						    }
					    if (!currentRow.IsTcssListMechanismOfDeathIdNull())
						    if (currentRow.TcssListMechanismOfDeathId == 0)
						    {
							    currentRow.SetTcssListMechanismOfDeathIdNull();
						    }

				});
				AssociatedDataSet
                .tcssDs().TcssDonorMedSoc.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
						if (!currentRow.IsTcssListHypertensionHistoryIdNull())
							if (currentRow.TcssListHypertensionHistoryId == 0)
							{
								currentRow.SetTcssListHypertensionHistoryIdNull();
							}
						if (!currentRow.IsTcssListOtherDrugUseIdNull())
							if (currentRow.TcssListOtherDrugUseId == 0)
							{
								currentRow.SetTcssListOtherDrugUseIdNull();
							}
						if (!currentRow.IsTcssListCigaretteUseContinuedIdNull())
							if (currentRow.TcssListCigaretteUseContinuedId == 0)
							{
								currentRow.SetTcssListCigaretteUseContinuedIdNull();
							}
						if (!currentRow.IsTcssListCigaretteUseIdNull())
							if (currentRow.TcssListCigaretteUseId == 0)
							{
								currentRow.SetTcssListCigaretteUseIdNull();
							}
						if (!currentRow.IsTcssListChestTraumaIdNull())
							if (currentRow.TcssListChestTraumaId == 0)
							{
								currentRow.SetTcssListChestTraumaIdNull();
							}
						if (!currentRow.IsTcssListCompliantWithTreatmentIdNull())
							if (currentRow.TcssListCompliantWithTreatmentId == 0)
							{
								currentRow.SetTcssListCompliantWithTreatmentIdNull();
							}
						if (!currentRow.IsTcssListHistoryOfGastrointestinalDiseaseIdNull())
							if (currentRow.TcssListHistoryOfGastrointestinalDiseaseId == 0)
							{
								currentRow.SetTcssListHistoryOfGastrointestinalDiseaseIdNull();
							}
						if (!currentRow.IsTcssListDonorMeetCdcGuidelinesIdNull())
							if (currentRow.TcssListDonorMeetCdcGuidelinesId == 0)
							{
								currentRow.SetTcssListDonorMeetCdcGuidelinesIdNull();
							}
						if (!currentRow.IsTcssListHeavyAlcoholUseIdNull())
							if (currentRow.TcssListHeavyAlcoholUseId == 0)
							{
								currentRow.SetTcssListHeavyAlcoholUseIdNull();
							}
						if (!currentRow.IsTcssListHistoryOfCancerIdNull())
							if (currentRow.TcssListHistoryOfCancerId == 0)
							{
								currentRow.SetTcssListHistoryOfCancerIdNull();
							}
						if (!currentRow.IsTcssListHistoryOfDiabetesIdNull())
							if (currentRow.TcssListHistoryOfDiabetesId == 0)
							{
								currentRow.SetTcssListHistoryOfDiabetesIdNull();
							}
						if (!currentRow.IsTcssListHistoryOfCoronaryArteryDiseaseIdNull())
							if (currentRow.TcssListHistoryOfCoronaryArteryDiseaseId == 0)
							{
								currentRow.SetTcssListHistoryOfCoronaryArteryDiseaseIdNull();
							}

				});

				AssociatedDataSet
                .tcssDs().TcssDonorVitalSignDetail.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                {
						if (!currentRow.IsTcssDonorVitalSignIdNull())
							if (currentRow.TcssDonorVitalSignId == 0)
							{
								currentRow.SetTcssDonorVitalSignIdNull();
							}
						if (!currentRow.IsTcssListVitalSignIdNull())
							if (currentRow.TcssListVitalSignId == 0)
							{
								currentRow.SetTcssListVitalSignIdNull();
							}

				});
				AssociatedDataSet
                .tcssDs().TcssDonorMedication.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
						if (!currentRow.IsTcssListMedicationDoseUnitIdNull())
							if (currentRow.TcssListMedicationDoseUnitId == 0)
							{
								currentRow.SetTcssListMedicationDoseUnitIdNull();
							}
						if (!currentRow.IsTcssListMedicationIdNull())
							if (currentRow.TcssListMedicationId == 0)
							{
								currentRow.SetTcssListMedicationIdNull();
							}

				});
				AssociatedDataSet
                .tcssDs().TcssDonorFluidBlood.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
						if (!currentRow.IsTcssListNumberOfTransfusionIdNull())
							if (currentRow.TcssListNumberOfTransfusionId == 0)
							{
								currentRow.SetTcssListNumberOfTransfusionIdNull();
							}
						if (!currentRow.IsTcssListInsulinIdNull())
							if (currentRow.TcssListInsulinId == 0)
							{
								currentRow.SetTcssListInsulinIdNull();
							}
						if (!currentRow.IsTcssListVasodilatorIdNull())
							if (currentRow.TcssListVasodilatorId == 0)
							{
								currentRow.SetTcssListVasodilatorIdNull();
							}
						if (!currentRow.IsTcssListOtherBloodProductIdNull())
							if (currentRow.TcssListOtherBloodProductId == 0)
							{
								currentRow.SetTcssListOtherBloodProductIdNull();
							}
						if (!currentRow.IsTcssListT4IdNull())
							if (currentRow.TcssListT4Id == 0)
							{
								currentRow.SetTcssListT4IdNull();
							}
						if (!currentRow.IsTcssListT3IdNull())
							if (currentRow.TcssListT3Id == 0)
							{
								currentRow.SetTcssListT3IdNull();
							}
						if (!currentRow.IsTcssListSteroidIdNull())
							if (currentRow.TcssListSteroidId == 0)
							{
								currentRow.SetTcssListSteroidIdNull();
							}
						if (!currentRow.IsTcssListArginineVasopressinIdNull())
							if (currentRow.TcssListArginineVasopressinId == 0)
							{
								currentRow.SetTcssListArginineVasopressinIdNull();
							}
						if (!currentRow.IsTcssListAntihypertensiveIdNull())
							if (currentRow.TcssListAntihypertensiveId == 0)
							{
								currentRow.SetTcssListAntihypertensiveIdNull();
							}
						if (!currentRow.IsTcssListDextroseInIvFluidsIdNull())
							if (currentRow.TcssListDextroseInIvFluidsId == 0)
							{
								currentRow.SetTcssListDextroseInIvFluidsIdNull();
							}
						if (!currentRow.IsTcssListDdavpIdNull())
							if (currentRow.TcssListDdavpId == 0)
							{
								currentRow.SetTcssListDdavpIdNull();
							}
						if (!currentRow.IsTcssListDiureticIdNull())
							if (currentRow.TcssListDiureticId == 0)
							{
								currentRow.SetTcssListDiureticIdNull();
							}
						if (!currentRow.IsTcssListHeparinIdNull())
							if (currentRow.TcssListHeparinId == 0)
							{
								currentRow.SetTcssListHeparinIdNull();
							}

				});     
				AssociatedDataSet
                .tcssDs().TcssDonorLabProfileDetail.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
						if (!currentRow.IsTcssDonorLabProfileIdNull())
							if (currentRow.TcssDonorLabProfileId == 0)
							{
								currentRow.SetTcssDonorLabProfileIdNull();
							}
						if (!currentRow.IsTcssListLabIdNull())
							if (currentRow.TcssListLabId == 0)
							{
								currentRow.SetTcssListLabIdNull();
							}

				});


				AssociatedDataSet
                .tcssDs().TcssDonorLab.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
                    
						if (!currentRow.IsTcssListToxicologyScreenIdNull())
							if (currentRow.TcssListToxicologyScreenId == 0)
							{
								currentRow.SetTcssListToxicologyScreenIdNull();
							}

				});
            			
				AssociatedDataSet
                .tcssDs().TcssDonorTest.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
						if (!currentRow.IsTcssListTestTypeIdNull())
							if (currentRow.TcssListTestTypeId == 0)
							{
								currentRow.SetTcssListTestTypeIdNull();
							}

				});				
                

				AssociatedDataSet
                .tcssDs().TcssDonorSerologies.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
						if (!currentRow.IsTcssListSerologyAnswerIdNull())
							if (currentRow.TcssListSerologyAnswerId == 0)
							{
								currentRow.SetTcssListSerologyAnswerIdNull();
							}
						if (!currentRow.IsTcssListSerologyQuestionIdNull())
							if (currentRow.TcssListSerologyQuestionId == 0)
							{
								currentRow.SetTcssListSerologyQuestionIdNull();
							}

				});

                AssociatedDataSet
                .tcssDs().TcssDonorDiagnosisLiver.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                        if (!currentRow.IsTcssListLiverBiopsyIdNull())
                            if (currentRow.TcssListLiverBiopsyId == 0)
						    {
							    currentRow.SetTcssListLiverBiopsyIdNull();
						    }

				});

				AssociatedDataSet
                .tcssDs().TcssDonorDiagnosisOther.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                        if (!currentRow.IsTcssListOtherOrganIdNull())
                            if (currentRow.TcssListOtherOrganId == 0)
						    {
    							currentRow.SetTcssListOtherOrganIdNull();
	    					}

				});

				AssociatedDataSet
                .tcssDs().TcssDonorDiagnosisHeart.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                        if (!currentRow.IsTcssListDiagnosisHeartMethodIdNull())
                            if (currentRow.TcssListDiagnosisHeartMethodId == 0)
						    {
    							currentRow.SetTcssListDiagnosisHeartMethodIdNull();
	    					}

				});
				AssociatedDataSet
                .tcssDs().TcssDonorDiagnosisLung.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                        if (!currentRow.IsTcssListDiagnosisLungChestXrayIdNull())
                            if (currentRow.TcssListDiagnosisLungChestXrayId == 0)
						    {
							    currentRow.SetTcssListDiagnosisLungChestXrayIdNull();
						    }

				});
				
				AssociatedDataSet
                .tcssDs().TcssDonorUrinalysis.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {
						if (!currentRow.IsTcssListUrinalysisWbcIdNull())
							if (currentRow.TcssListUrinalysisWbcId == 0)
							{
								currentRow.SetTcssListUrinalysisWbcIdNull();
							}
						if (!currentRow.IsTcssListUrinalysisRbcIdNull())
							if (currentRow.TcssListUrinalysisRbcId == 0)
							{
								currentRow.SetTcssListUrinalysisRbcIdNull();
							}
						if (!currentRow.IsTcssListUrinalysisBacteriaIdNull())
							if (currentRow.TcssListUrinalysisBacteriaId == 0)
							{
								currentRow.SetTcssListUrinalysisBacteriaIdNull();
							}
						if (!currentRow.IsTcssListUrinalysisCastIdNull())
							if (currentRow.TcssListUrinalysisCastId == 0)
							{
								currentRow.SetTcssListUrinalysisCastIdNull();
							}
						if (!currentRow.IsTcssListUrinalysisBloodIdNull())
							if (currentRow.TcssListUrinalysisBloodId == 0)
							{
								currentRow.SetTcssListUrinalysisBloodIdNull();
							}
						if (!currentRow.IsTcssListUrinalysisProteinIdNull())
							if (currentRow.TcssListUrinalysisProteinId == 0)
							{
								currentRow.SetTcssListUrinalysisProteinIdNull();
							}
						if (!currentRow.IsTcssListUrinalysisLeukocyteIdNull())
							if (currentRow.TcssListUrinalysisLeukocyteId == 0)
							{
								currentRow.SetTcssListUrinalysisLeukocyteIdNull();
							}
						if (!currentRow.IsTcssListUrinalysisGlucoseIdNull())
							if (currentRow.TcssListUrinalysisGlucoseId == 0)
							{
								currentRow.SetTcssListUrinalysisGlucoseIdNull();
							}
						if (!currentRow.IsTcssListUrinalysisEpithIdNull())
							if (currentRow.TcssListUrinalysisEpithId == 0)
							{
								currentRow.SetTcssListUrinalysisEpithIdNull();
							}

				});
				AssociatedDataSet
                .tcssDs().TcssDonorCulture.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                        if (!currentRow.IsTcssListCultureTypeIdNull())
                            if (currentRow.TcssListCultureTypeId == 0)
						    {
							    currentRow.SetTcssListCultureTypeIdNull();
						    }

                        if (!currentRow.IsTcssListCultureResultIdNull())
                            if (currentRow.TcssListCultureResultId == 0)
						    {
							    currentRow.SetTcssListCultureResultIdNull();
						    }
				});
                AssociatedDataSet
                .tcssDs().TcssDonorDiagnosisKidneyLeft.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                        if (!currentRow.IsTcssListKidneyBiopsyIdNull())
                            if (currentRow.TcssListKidneyBiopsyId == 0)
						    {
							    currentRow.SetTcssListKidneyBiopsyIdNull();
						    }
                        if (!currentRow.IsTcssListKidneyAorticCuffIdNull())
                            if (currentRow.TcssListKidneyAorticCuffId == 0)
                            {
                                currentRow.SetTcssListKidneyAorticCuffIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyFullVenaIdNull())
                            if (currentRow.TcssListKidneyFullVenaId == 0)
                            {
                                currentRow.SetTcssListKidneyFullVenaIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyAorticPlaqueIdNull())
                            if (currentRow.TcssListKidneyAorticPlaqueId == 0)
                            {
                                currentRow.SetTcssListKidneyAorticPlaqueIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyArterialPlaqueIdNull())
                            if (currentRow.TcssListKidneyArterialPlaqueId == 0)
                            {
                                currentRow.SetTcssListKidneyArterialPlaqueIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyInfarctedAreaIdNull())
                            if (currentRow.TcssListKidneyInfarctedAreaId == 0)
                            {
                                currentRow.SetTcssListKidneyInfarctedAreaIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyCapsularTearIdNull())
                            if (currentRow.TcssListKidneyCapsularTearId == 0)
                            {
                                currentRow.SetTcssListKidneyCapsularTearIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyFullVenaIdNull())
                            if (currentRow.TcssListKidneyFullVenaId == 0)
                            {
                                currentRow.SetTcssListKidneyFullVenaIdNull();
                            }
                        if (!currentRow.IsTcssListKidneySubcapsularIdNull())
                            if (currentRow.TcssListKidneySubcapsularId == 0)
                            {
                                currentRow.SetTcssListKidneySubcapsularIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyHematomaIdNull())
                            if (currentRow.TcssListKidneyHematomaId == 0)
                            {
                                currentRow.SetTcssListKidneyHematomaIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyFatCleanedIdNull())
                            if (currentRow.TcssListKidneyFatCleanedId == 0)
                            {
                                currentRow.SetTcssListKidneyFatCleanedIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyCystsDiscolorationIdNull())
                            if (currentRow.TcssListKidneyCystsDiscolorationId == 0)
                            {
                                currentRow.SetTcssListKidneyCystsDiscolorationIdNull();
                            }
                        if (!currentRow.IsTcssListKidneyHorseshoeShapeIdNull())
                            if (currentRow.TcssListKidneyHorseshoeShapeId == 0)
                            {
                                currentRow.SetTcssListKidneyHorseshoeShapeIdNull();
                            }
                    });
                AssociatedDataSet
                .tcssDs().TcssDonorDiagnosisKidneyRight.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                {

                    if (!currentRow.IsTcssListKidneyBiopsyIdNull())
                        if (currentRow.TcssListKidneyBiopsyId == 0)
                        {
                            currentRow.SetTcssListKidneyBiopsyIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyAorticCuffIdNull())
                        if (currentRow.TcssListKidneyAorticCuffId == 0)
                        {
                            currentRow.SetTcssListKidneyAorticCuffIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyFullVenaIdNull())
                        if (currentRow.TcssListKidneyFullVenaId == 0)
                        {
                            currentRow.SetTcssListKidneyFullVenaIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyAorticPlaqueIdNull())
                        if (currentRow.TcssListKidneyAorticPlaqueId == 0)
                        {
                            currentRow.SetTcssListKidneyAorticPlaqueIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyArterialPlaqueIdNull())
                        if (currentRow.TcssListKidneyArterialPlaqueId == 0)
                        {
                            currentRow.SetTcssListKidneyArterialPlaqueIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyInfarctedAreaIdNull())
                        if (currentRow.TcssListKidneyInfarctedAreaId == 0)
                        {
                            currentRow.SetTcssListKidneyInfarctedAreaIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyCapsularTearIdNull())
                        if (currentRow.TcssListKidneyCapsularTearId == 0)
                        {
                            currentRow.SetTcssListKidneyCapsularTearIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyFullVenaIdNull())
                        if (currentRow.TcssListKidneyFullVenaId == 0)
                        {
                            currentRow.SetTcssListKidneyFullVenaIdNull();
                        }
                    if (!currentRow.IsTcssListKidneySubcapsularIdNull())
                        if (currentRow.TcssListKidneySubcapsularId == 0)
                        {
                            currentRow.SetTcssListKidneySubcapsularIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyHematomaIdNull())
                        if (currentRow.TcssListKidneyHematomaId == 0)
                        {
                            currentRow.SetTcssListKidneyHematomaIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyFatCleanedIdNull())
                        if (currentRow.TcssListKidneyFatCleanedId == 0)
                        {
                            currentRow.SetTcssListKidneyFatCleanedIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyCystsDiscolorationIdNull())
                        if (currentRow.TcssListKidneyCystsDiscolorationId == 0)
                        {
                            currentRow.SetTcssListKidneyCystsDiscolorationIdNull();
                        }
                    if (!currentRow.IsTcssListKidneyHorseshoeShapeIdNull())
                        if (currentRow.TcssListKidneyHorseshoeShapeId == 0)
                        {
                            currentRow.SetTcssListKidneyHorseshoeShapeIdNull();
                        }
                });
				AssociatedDataSet
                .tcssDs().TcssDonorAbg.Where(row => row.RowState == DataRowState.Modified || row.RowState == DataRowState.Added)
                .ToList().ForEach(currentRow =>
                    {

                        if (!currentRow.IsTcssListVentSettingModeIdNull())
                            if (currentRow.TcssListVentSettingModeId == 0)
						    {
							    currentRow.SetTcssListVentSettingModeIdNull();
						    }

				});
                        	


		}

        protected override void BusinessRulesAfterSave()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            //capture CallID
            CallId = tcssDS.Call[0].CallID;
        }

        private void AgeUnitIsRequiredWithAge()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.TcssDonorHla.Count == 1 &&
                !tcssDS.TcssDonorHla[0].IsAgeNull() &&
                tcssDS.TcssDonorHla[0].IsTcssListAgeUnitIdNull())
            {
                throw new BaseException("Age Unit must be selected when age is enetered for Donor", true);
            }
        }
        #endregion

        #region Public Methods
        public void DeleteDataBeforeImport()
        {
            LoadDataFromUnos loadDataFromUnos = new LoadDataFromUnos(null, (TcssDS)AssociatedDataSet);
            loadDataFromUnos.DeleteDataBeforeImport();
        }

        public void LoadMatchResultsFromUnos(HtmlDocument document)
        {
            LoadDataFromUnos loadDataFromUnos = new LoadDataFromUnos(document, (TcssDS)AssociatedDataSet);
            loadDataFromUnos.LoadMatchResultsFromUnos();
        }

        public void LoadDonorSummaryFromUnos(HtmlDocument document)
        {
            LoadDataFromUnos loadDataFromUnos = new LoadDataFromUnos(document, (TcssDS)AssociatedDataSet);
            loadDataFromUnos.LoadDonorSummaryFromUnos();

            // We need to rebind the data to the custom tables
            CreateTableVitalSign();
            CreateTableLabProfile();
            CreateTableSerologies();
            CreateTableDiagnosticsKidneyArteryLeft();
            CreateTableDiagnosticsKidneyVeinLeft();
            CreateTableDiagnosticsKidneyUreterLeft();
            CreateTableDiagnosticsKidneyArteryRight();
            CreateTableDiagnosticsKidneyVeinRight();
            CreateTableDiagnosticsKidneyUreterRight();
        }
        #endregion

        #region Private Methods
        /// <summary>
        /// Set the default values on the tables
        /// </summary>
        private void SetDefaultValue()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;

            // Set the default values for the tables
            SetDefaultValue(tcssDS.TcssDonorToRecipient);
            SetDefaultValue(tcssDS.TcssRecipientOfferInformation);
            SetDefaultValue(tcssDS.TcssRecipientOfferStatusInformation);
            SetDefaultValue(tcssDS.TcssDonorContactInformation);
            SetDefaultValue(tcssDS.TcssRecipientCandidate);
            SetDefaultValue(tcssDS.TcssRecipientCandidateDetail);

            SetDefaultValue(tcssDS.TcssDonorHlaLiver);
            SetDefaultValue(tcssDS.TcssDonorHla);
            SetDefaultValue(tcssDS.TcssDonorMedSoc);
            SetDefaultValue(tcssDS.TcssDonorVitalSignSummary);
            SetDefaultValue(tcssDS.TcssDonorVitalSign);
            SetDefaultValue(tcssDS.TcssDonorVitalSignDetail);

            SetDefaultValue(tcssDS.TcssDonorMedication);
            SetDefaultValue(tcssDS.TcssDonorFluidBlood);
            SetDefaultValue(tcssDS.TcssDonorLabProfileSummary);
            SetDefaultValue(tcssDS.TcssDonorLabProfile);
            SetDefaultValue(tcssDS.TcssDonorLabProfileDetail);

            SetDefaultValue(tcssDS.TcssDonorLabValues);
            SetDefaultValue(tcssDS.TcssDonorLab);
            SetDefaultValue(tcssDS.TcssDonorCompleteBloodCount);
            SetDefaultValue(tcssDS.TcssDonorTest);

            SetDefaultValue(tcssDS.TcssDonorSerologies);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyLeft);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyArteryLeft);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyVeinLeft);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyUreterLeft);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyBiopsyLeft);
            tcssDS.TcssDonorDiagnosisKidneyBiopsyLeft.TcssListKidneyIdColumn.DefaultValue = (int)TcssListKidney.Left;

            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyRight);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyArteryRight);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyVeinRight);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyUreterRight);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisKidneyBiopsyRight);
            tcssDS.TcssDonorDiagnosisKidneyBiopsyRight.TcssListKidneyIdColumn.DefaultValue = (int)TcssListKidney.Right;

            SetDefaultValue(tcssDS.TcssDonorDiagnosisLiver);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisOther);

            SetDefaultValue(tcssDS.TcssDonorDiagnosisHeart);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisLung);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisLungSputum);
            SetDefaultValue(tcssDS.TcssDonorDiagnosisPancreas);

            SetDefaultValue(tcssDS.TcssDonorDiagnosisIntestine);
            SetDefaultValue(tcssDS.TcssDonorUrinalysis);
            SetDefaultValue(tcssDS.TcssDonorCulture);
            SetDefaultValue(tcssDS.TcssDonorAbg);
            SetDefaultValue(tcssDS.TcssDonorAbgSummary);
        }

        /// <summary>
        /// Add an empty row if the case is new
        /// </summary>
        private void AddEmptyRow()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;

            // We need to set teh default value for the Donor and Receipent table before we add an empty row
            SetDefaultValue(tcssDS.TcssDonor);
            SetDefaultValue(tcssDS.TcssRecipient);
            AddEmptyRow(tcssDS.Call);
            AddEmptyRow(tcssDS.TcssDonor);
            AddEmptyRow(tcssDS.TcssRecipient);

            // Update the gloval vlaues so that other places can use them
            GRConstant.ReferralId = tcssDS.Call[0].CallID;
            GRConstant.TcssDonorId = tcssDS.TcssDonor[0].TcssDonorId;
            GRConstant.TcssRecipientId = tcssDS.TcssRecipient[0].TcssRecipientId;

            // Set the defualt values for all rest table after we update the GRConstant
            SetDefaultValue();

            // We need to add the defulat value for TcssDonorToRecipient
            tcssDS.TcssRecipientOfferInformation.CallIdColumn.DefaultValue = GRConstant.ReferralId;

            AddEmptyRow(tcssDS.TcssDonorToRecipient);
            AddEmptyRow(tcssDS.TcssRecipientOfferInformation);
            AddEmptyRow(tcssDS.TcssRecipientOfferStatusInformation);
            AddEmptyRow(tcssDS.TcssDonorContactInformation);
            AddEmptyRow(tcssDS.TcssRecipientCandidate);
            AddEmptyRow(tcssDS.TcssDonorHlaLiver);
            AddEmptyRow(tcssDS.TcssDonorHla);
            AddEmptyRow(tcssDS.TcssDonorMedSoc);
            AddEmptyRow(tcssDS.TcssDonorVitalSignSummary);
            AddEmptyRow(tcssDS.TcssDonorFluidBlood);
            AddEmptyRow(tcssDS.TcssDonorLab);
            AddEmptyRow(tcssDS.TcssDonorLabProfileSummary);
            AddEmptyRow(tcssDS.TcssDonorDiagnosisKidneyLeft);
            AddEmptyRow(tcssDS.TcssDonorDiagnosisKidneyRight);
            AddEmptyRow(tcssDS.TcssDonorDiagnosisLiver);
            AddEmptyRow(tcssDS.TcssDonorDiagnosisHeart);
            AddEmptyRow(tcssDS.TcssDonorDiagnosisLung);
            AddEmptyRow(tcssDS.TcssDonorDiagnosisPancreas);
            AddEmptyRow(tcssDS.TcssDonorDiagnosisIntestine);
            AddEmptyRow(tcssDS.TcssDonorAbgSummary);


            // Add specific data to the Call Table
            TcssDS.CallRow callRow = tcssDS.Call[0];
            callRow.AuditLogTypeID = 1;
            callRow.CallActive = 1;
            callRow.CallDateTime = DateTime.Now;
            //callRow.SourceCodeID = GRConstant.
            callRow.StatEmployeeID = Convert.ToInt16(StattracIdentity.Identity.UserId);
            callRow.LastModified = DateTime.Now;
            callRow.CallTypeID = 6; //Oasis Calltype


            // Set Call ID and the Source Code Id from the Call Table
            //TcssDS.TcssRecipientOfferInformationRow tcssRecipientOfferInformationRow = tcssDS.TcssRecipientOfferInformation[0];
            //tcssRecipientOfferInformationRow.CallId = tcssDS.Call[0].CallID;

            // Add the default row with the status set to pending
            if (tcssDS.TcssRecipientOfferStatusInformation.Rows.Count == 1)
            {
                tcssDS.TcssRecipientOfferStatusInformation[0].TcssListStatusId = 1;
            }


            // Set the left and right side of the kidney tables
            TcssDS.TcssDonorDiagnosisKidneyLeftRow leftKidneyRow = tcssDS.TcssDonorDiagnosisKidneyLeft[0];
            leftKidneyRow.TcssListKidneyId = (int)TcssListKidney.Left;
            TcssDS.TcssDonorDiagnosisKidneyRightRow rightKidneyRow = tcssDS.TcssDonorDiagnosisKidneyRight[0];
            rightKidneyRow.TcssListKidneyId = (int)TcssListKidney.Right;
        }

        /// <summary>
        /// Set the default value in the table
        /// </summary>
        /// <param name="dataTable"></param>
        private void SetDefaultValue(DataTable dataTable)
        {
            if (dataTable.Columns.Contains("TcssDonorId") && !dataTable.Columns["TcssDonorId"].AutoIncrement)
            {
                dataTable.Columns["TcssDonorId"].DefaultValue = GRConstant.TcssDonorId;
            }
            if (dataTable.Columns.Contains("TcssRecipientId") && !dataTable.Columns["TcssRecipientId"].AutoIncrement)
            {
                dataTable.Columns["TcssRecipientId"].DefaultValue = GRConstant.TcssRecipientId;
            }
            dataTable.Columns["LastUpdateStatEmployeeId"].DefaultValue = StattracIdentity.Identity.UserId;
            dataTable.Columns["LastUpdateDate"].DefaultValue = GRConstant.CurrentDateTime;
        }

        /// <summary>
        /// Add an empty row to the table
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        private void AddEmptyRow(DataTable dataTable)
        {
            if (dataTable.Rows.Count == 0)
            {
                dataTable.Rows.Add(dataTable.NewRow());
                //DataRow dataRow = dataTable.NewRow();
                //dataTable.Rows.Add(dataRow);
            }
        }

        /// <summary>
        /// Create a table that can be bound to the ui
        /// </summary>
        private void CreateTableVitalSign()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            DataTable uiVitalSign;
            // Create the new table
            if (!tcssDS.Tables.Contains(UiVitalSign))
            {
                tcssDS.Tables.Add(UiVitalSign);
                uiVitalSign = tcssDS.Tables[UiVitalSign];

                DataColumn dataColumn = uiVitalSign.Columns.Add("TcssDonorVitalSignId", typeof(System.Int32));
                dataColumn.AutoIncrement = true;
                dataColumn.ReadOnly = true;

                // Set it as the primary keky
                DataColumn[] keys = new DataColumn[1];
                keys[0] = dataColumn;
                uiVitalSign.PrimaryKey = keys;

                dataColumn = uiVitalSign.Columns.Add("From Date/Time", typeof(System.DateTime));
                dataColumn.AllowDBNull = false;

                dataColumn = uiVitalSign.Columns.Add("To Date/Time", typeof(System.DateTime));

                ListControlBR listControlBR = new ListControlBR("TcssListVitalSignSelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                for (int index = 0; index < listControlDS.TcssListVitalSign.Rows.Count; index++)
                {
                    DataColumn column = uiVitalSign.Columns.Add();
                    column.ColumnName = listControlDS.TcssListVitalSign[index].ListId.ToString();
                    column.Caption = listControlDS.TcssListVitalSign[index].FieldValue.ToString();
                    column.DataType = typeof(System.String);
                }
            }

            // Load the data into the new table
            uiVitalSign = tcssDS.Tables[UiVitalSign];
            uiVitalSign.Clear(); // clear the rows so that we can re-populate it
            for (int mainIndex = 0; mainIndex < tcssDS.TcssDonorVitalSign.Count; mainIndex++)
            {
                if (tcssDS.TcssDonorVitalSign[mainIndex].RowState == DataRowState.Deleted)
                {
                    continue;
                }

                DataRow dataRow = uiVitalSign.NewRow();
                dataRow["TcssDonorVitalSignId"] = tcssDS.TcssDonorVitalSign[mainIndex].TcssDonorVitalSignId;
                if (!tcssDS.TcssDonorVitalSign[mainIndex].IsFromDateTimeNull())
                {
                    dataRow["From Date/Time"] = tcssDS.TcssDonorVitalSign[mainIndex].FromDateTime;
                }
                if (!tcssDS.TcssDonorVitalSign[mainIndex].IsToDateTimeNull())
                {
                    dataRow["To Date/Time"] = tcssDS.TcssDonorVitalSign[mainIndex].ToDateTime;
                }

                TcssDS.TcssDonorVitalSignDetailRow[] detailRow = tcssDS.TcssDonorVitalSign[mainIndex].GetTcssDonorVitalSignDetailRows();
                for (int detailIndex = 0; detailIndex < detailRow.Length; detailIndex++)
                {
                    string columnName = detailRow[detailIndex].TcssListVitalSignId.ToString();
                    if (!detailRow[detailIndex].IsAnswerNull())
                    {
                        dataRow[columnName] = detailRow[detailIndex].Answer;
                    }
                }
                uiVitalSign.Rows.Add(dataRow);
            }
            // WE want to accept all the changes so that datagrid will  know what has chnaged. Since everything is add right now
            uiVitalSign.AcceptChanges();
        }

        /// <summary>
        /// Create the Table for the Vital Sign Summary
        /// </summary>
        private void CreateTableVitalSignSummary(string tableName, string organColumn)
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            DataTable uiVitalSignSummary;

            // Create the table if it does not already exists
            if (!tcssDS.Tables.Contains(tableName))
            {
                ListControlBR listControlBR = new ListControlBR("TcssListVitalSignSelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();

                // Create the table schema
                tcssDS.Tables.Add(tableName);
                uiVitalSignSummary = tcssDS.Tables[tableName];
                uiVitalSignSummary.Columns.Add(" ", typeof(System.String));
                for (int index = 0; index < listControlDS.TcssListVitalSign.Rows.Count; index++)
                {
                    if ((bool)listControlDS.TcssListVitalSign[index][organColumn])
                    {
                        DataColumn column = uiVitalSignSummary.Columns.Add();
                        column.ColumnName = listControlDS.TcssListVitalSign[index].ListId.ToString();
                        //column.ColumnName = listControlDS.TcssListVitalSign[index].FieldValue;
                        column.Caption = listControlDS.TcssListVitalSign[index].FieldValue;
                        column.DataType = typeof(System.String);

                        // Add a column to stor the from date 
                        column = uiVitalSignSummary.Columns.Add();
                        column.ColumnName = listControlDS.TcssListVitalSign[index].ListId.ToString() + "FromDate";
                        column.Caption = " ";
                        column.DataType = typeof(System.String);

                        // Add a column to stor the to date 
                        column = uiVitalSignSummary.Columns.Add();
                        column.ColumnName = listControlDS.TcssListVitalSign[index].ListId.ToString() + "ToDate";
                        column.Caption = " ";
                        column.DataType = typeof(System.String);
                    }
                }
            }

            // Clear the table and add the default rows
            uiVitalSignSummary = tcssDS.Tables[tableName];
            uiVitalSignSummary.Clear();

            // Create the 3 rows of data
            DataRow initalRow = uiVitalSignSummary.NewRow();
            initalRow[0] = "Initial";
            uiVitalSignSummary.Rows.Add(initalRow);

            DataRow peakRow = uiVitalSignSummary.NewRow();
            peakRow[0] = "Peak";
            uiVitalSignSummary.Rows.Add(peakRow);

            DataRow currentRow = uiVitalSignSummary.NewRow();
            currentRow[0] = "Current";
            uiVitalSignSummary.Rows.Add(currentRow);

            // Load the Data
            DataTable uiVitalSignDataTable = tcssDS.Tables[UiVitalSign];

            // For each column in the table dtVitalSign
            for (int columnIndex = 1; columnIndex < uiVitalSignSummary.Columns.Count; columnIndex = columnIndex + 3)
            {
                string columnName = uiVitalSignSummary.Columns[columnIndex].ColumnName;
                // Get the 1st non null value from the table uiVitalSignDataTable
                for (int rowIndex = 0; rowIndex < uiVitalSignDataTable.Rows.Count; rowIndex++)
                {
                    // We need to comaapre the decimal but dispay the string version
                    string newStringValue = string.Empty;
                    decimal newDecimalValue = decimal.MinValue;
                    newStringValue = uiVitalSignDataTable.Rows[rowIndex][columnName].ToString();
                    //newDecimalValue = ParseAndIgnoreNonDigit(newStringValue);
                    //newDecimalValue = Convert.ToDecimal(newStringValue);
                    if (uiVitalSignSummary.Columns[columnIndex].ColumnName != "20" && uiVitalSignSummary.Columns[columnIndex].ColumnName != "22")
                    {
                        newDecimalValue = ParseAndIgnoreNonDigit(newStringValue);
                    }
                    // Set the initial value
                    if (uiVitalSignSummary.Rows[0][columnIndex] == DBNull.Value && newStringValue.Trim() != string.Empty)
                    {
                        uiVitalSignSummary.Rows[0][columnIndex] = newStringValue;
                        if (string.IsNullOrEmpty(uiVitalSignDataTable.Rows[rowIndex]["From Date/Time"].ToString()))
                        {
                            uiVitalSignSummary.Rows[0][columnIndex + 1] = "";
                        }
                        else
                        {
                            uiVitalSignSummary.Rows[0][columnIndex + 1] = ((DateTime)uiVitalSignDataTable.Rows[rowIndex]["From Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat) + " - ";
                        }
                        if (string.IsNullOrEmpty(uiVitalSignDataTable.Rows[rowIndex]["To Date/Time"].ToString()))
                        {
                            uiVitalSignSummary.Rows[0][columnIndex + 2] = "";
                        }
                        else
                        {
                            uiVitalSignSummary.Rows[0][columnIndex + 2] = ((DateTime)uiVitalSignDataTable.Rows[rowIndex]["To Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat);
                        }
                    }

                    // itereate through all the values to get the Peak Value
                    //decimal oldPreviousValue = Convert.ToDecimal(uiVitalSignSummary.Rows[1][columnIndex].ToString());
                    decimal oldPreviousValue = ParseAndIgnoreNonDigit(uiVitalSignSummary.Rows[1][columnIndex].ToString());
                    if (uiVitalSignSummary.Rows[1][columnIndex] == DBNull.Value || oldPreviousValue <= newDecimalValue)
                    {
                        if (newStringValue.Trim() != string.Empty)
                        {//don't put average bp in the summary, its handled special down below
                            if (uiVitalSignSummary.Columns[columnIndex].ColumnName != "20" && uiVitalSignSummary.Columns[columnIndex].ColumnName != "22")
                                uiVitalSignSummary.Rows[1][columnIndex] = newStringValue;
                            //special handling of average bp in the summary table, if Average BP (systolic) then use average bp
                            if (uiVitalSignSummary.Columns[columnIndex].ColumnName == "1")
                            {
                                uiVitalSignSummary.Rows[1][4] = uiVitalSignDataTable.Rows[rowIndex][4].ToString();
                            }
                            //special handling of average bp in the summary table, if Average BP (diastolic)
                            if (uiVitalSignSummary.Columns[columnIndex].ColumnName == "2")
                            {
                                uiVitalSignSummary.Rows[1][10] = uiVitalSignDataTable.Rows[rowIndex][6].ToString();
                            }
                            if (string.IsNullOrEmpty(uiVitalSignDataTable.Rows[rowIndex]["From Date/Time"].ToString()))
                            {
                                uiVitalSignSummary.Rows[1][columnIndex + 1] = "";
                            }
                            else
                            {
                                uiVitalSignSummary.Rows[1][columnIndex + 1] = ((DateTime)uiVitalSignDataTable.Rows[rowIndex]["From Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat) + " - ";
                            }

                            if (string.IsNullOrEmpty(uiVitalSignDataTable.Rows[rowIndex]["To Date/Time"].ToString()))
                            {
                                uiVitalSignSummary.Rows[1][columnIndex + 2] = "";
                            }
                            else
                            {
                                uiVitalSignSummary.Rows[1][columnIndex + 2] = ((DateTime)uiVitalSignDataTable.Rows[rowIndex]["To Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat);
                            }
                        }
                    }

                    // set the Current Value
                    //fixed this to do either way...the else was coded to handle ranges which were min values
                    if (newDecimalValue != decimal.MinValue && newStringValue.Trim() != string.Empty)
                    {
                        uiVitalSignSummary.Rows[2][columnIndex] = newStringValue;
                        if (string.IsNullOrEmpty(uiVitalSignDataTable.Rows[rowIndex]["From Date/Time"].ToString()))
                        {
                            uiVitalSignSummary.Rows[2][columnIndex + 1] = "";
                        }
                        else
                        {
                            uiVitalSignSummary.Rows[2][columnIndex + 1] = ((DateTime)uiVitalSignDataTable.Rows[rowIndex]["From Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat) + " - ";
                        }
                        if (string.IsNullOrEmpty(uiVitalSignDataTable.Rows[rowIndex]["To Date/Time"].ToString()))
                        {
                            uiVitalSignSummary.Rows[2][columnIndex + 2] = "";
                        }
                        else
                        {
                            uiVitalSignSummary.Rows[2][columnIndex + 2] = ((DateTime)uiVitalSignDataTable.Rows[rowIndex]["To Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat);
                        }
                    }
                    else
                        if (uiVitalSignSummary.Rows[2][uiVitalSignSummary.Columns.Count - 1] == DBNull.Value && newStringValue.Trim() != string.Empty)
                        {
                            uiVitalSignSummary.Rows[2][columnIndex] = newStringValue;
                            if (string.IsNullOrEmpty(uiVitalSignDataTable.Rows[rowIndex]["From Date/Time"].ToString()))
                            {
                                uiVitalSignSummary.Rows[2][columnIndex + 1] = "";
                            }
                            else
                            {
                                uiVitalSignSummary.Rows[2][columnIndex + 1] = ((DateTime)uiVitalSignDataTable.Rows[rowIndex]["From Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat) + " - ";
                            }
                            if (string.IsNullOrEmpty(uiVitalSignDataTable.Rows[rowIndex]["To Date/Time"].ToString()))
                            {
                                uiVitalSignSummary.Rows[2][columnIndex + 2] = "";
                            }
                            else
                            {
                                uiVitalSignSummary.Rows[2][columnIndex + 2] = ((DateTime)uiVitalSignDataTable.Rows[rowIndex]["To Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat);
                            }
                        }
                }
            }
        }

        /// <summary>
        /// Ignore the non digits when converting to decimal
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        private decimal ParseAndIgnoreNonDigit(string s)
        {
            decimal returnValue = decimal.MinValue;
            try
            {
                string str = "";
                foreach (char c in s)
                {
                    //if (char.IsDigit(c)) this didn't work jth
                    //added method below and filter of the degree sign which is char 176 jth
                    if (!char.IsLetter(c) && c != 176)
                    {
                        str += c.ToString();
                    }
                }
                returnValue = decimal.Parse(str);
            }
            catch (Exception ex)
            {
                string str = "";
            }

            return returnValue;
        }

        /// <summary>
        /// Load the data from the temp table into the main table to save data
        /// </summary>
        private void LoadDataFromVitalSign()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.Tables[UiVitalSign] == null)
                return;
            DataTable uiVitalSign = tcssDS.Tables[UiVitalSign].GetChanges();
            if (uiVitalSign != null)
            {
                for (int mainIndex = 0; mainIndex < uiVitalSign.Rows.Count; mainIndex++)
                {
                    // We cannot access the deleted rows
                    if (uiVitalSign.Rows[mainIndex].RowState == DataRowState.Deleted)
                    {
                        int tcssDonorVitalSignId = (int)uiVitalSign.Rows[mainIndex]["TcssDonorVitalSignId", DataRowVersion.Original];
                        TcssDS.TcssDonorVitalSignRow tcssDonorVitalSignRow = tcssDS.TcssDonorVitalSign.FindByTcssDonorVitalSignId(tcssDonorVitalSignId);
                        tcssDonorVitalSignRow.Delete();
                    }
                    else
                    {
                        int tcssDonorVitalSignId = (int)uiVitalSign.Rows[mainIndex]["TcssDonorVitalSignId"];
                        TcssDS.TcssDonorVitalSignRow tcssDonorVitalSignRow = tcssDS.TcssDonorVitalSign.FindByTcssDonorVitalSignId(tcssDonorVitalSignId);
                        // Add the Vital sign
                        if (tcssDonorVitalSignRow == null)
                        {
                            tcssDonorVitalSignRow = tcssDS.TcssDonorVitalSign.NewTcssDonorVitalSignRow();
                            if (uiVitalSign.Rows[mainIndex]["From Date/Time"] != DBNull.Value)
                            {
                                tcssDonorVitalSignRow.FromDateTime = (DateTime)uiVitalSign.Rows[mainIndex]["From Date/Time"];
                            }
                            if (uiVitalSign.Rows[mainIndex]["To Date/Time"] != DBNull.Value)
                            {
                                tcssDonorVitalSignRow.ToDateTime = (DateTime)uiVitalSign.Rows[mainIndex]["To Date/Time"];
                            }
                            tcssDS.TcssDonorVitalSign.AddTcssDonorVitalSignRow(tcssDonorVitalSignRow);
                        }
                        // Updte teh Vital sign
                        else
                        {
                            if (uiVitalSign.Rows[mainIndex]["From Date/Time"] != DBNull.Value)
                            {
                                tcssDonorVitalSignRow.FromDateTime = (DateTime)uiVitalSign.Rows[mainIndex]["From Date/Time"];
                            }
                            if (uiVitalSign.Rows[mainIndex]["To Date/Time"] != DBNull.Value)
                            {
                                tcssDonorVitalSignRow.ToDateTime = (DateTime)uiVitalSign.Rows[mainIndex]["To Date/Time"];
                            }
                        }

                        // test to see if this is a new item or an old item
                        int existingDetailRowCount = tcssDS.TcssDonorVitalSignDetail.Select("TcssDonorId=" + tcssDonorVitalSignRow.TcssDonorId +
                            "AND TcssDonorVitalSignId=" + tcssDonorVitalSignRow.TcssDonorVitalSignId).Length;

                        // add the item
                        if (existingDetailRowCount > 0)
                        {
                            // We ignore the first 3 columns since they are for the main table
                            for (int detailIndex = 3; detailIndex < uiVitalSign.Columns.Count; detailIndex++)
                            {
                                int tcssListVitalSignId = int.Parse(uiVitalSign.Columns[detailIndex].ColumnName);

                                TcssDS.TcssDonorVitalSignDetailRow[] existingDetailRow = (TcssDS.TcssDonorVitalSignDetailRow[])
                                    tcssDS.TcssDonorVitalSignDetail.Select("TcssDonorId=" + tcssDonorVitalSignRow.TcssDonorId +
                                    "AND TcssDonorVitalSignId=" + tcssDonorVitalSignRow.TcssDonorVitalSignId +
                                    "AND TcssListVitalSignId=" + tcssListVitalSignId);

                                TcssDS.TcssDonorVitalSignDetailRow detailRow = existingDetailRow[0];
                                detailRow.TcssDonorVitalSignId = tcssDonorVitalSignRow.TcssDonorVitalSignId;
                                detailRow.TcssListVitalSignId = tcssListVitalSignId;
                                detailRow.Answer = uiVitalSign.Rows[mainIndex][detailIndex].ToString();
                            }
                        }
                        // update the item
                        else
                        {
                            // We ignore the first 3 columns since they are for the main table
                            for (int detailIndex = 3; detailIndex < uiVitalSign.Columns.Count; detailIndex++)
                            {
                                TcssDS.TcssDonorVitalSignDetailRow detailRow = tcssDS.TcssDonorVitalSignDetail.NewTcssDonorVitalSignDetailRow();
                                detailRow.TcssDonorVitalSignId = tcssDonorVitalSignRow.TcssDonorVitalSignId;
                                detailRow.TcssListVitalSignId = int.Parse(uiVitalSign.Columns[detailIndex].ColumnName);
                                detailRow.Answer = uiVitalSign.Rows[mainIndex][detailIndex].ToString();
                                tcssDS.TcssDonorVitalSignDetail.AddTcssDonorVitalSignDetailRow(detailRow);
                            }
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Create a table that can be bound to the ui
        /// </summary>
        private void CreateTableLabProfile()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            DataTable uiLabProfile;
            // Create the new table
            if (!tcssDS.Tables.Contains(UiLabProfile))
            {
                tcssDS.Tables.Add(UiLabProfile);
                uiLabProfile = tcssDS.Tables[UiLabProfile];

                DataColumn dataColumn = uiLabProfile.Columns.Add("TcssDonorLabProfileId", typeof(System.Int32));
                dataColumn.AutoIncrement = true;
                dataColumn.ReadOnly = true;
                dataColumn = uiLabProfile.Columns.Add("Sample Date/Time", typeof(System.DateTime));
                dataColumn.AllowDBNull = false;

                ListControlBR listControlBR = new ListControlBR("TcssListLabSelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                for (int index = 0; index < listControlDS.TcssListLab.Rows.Count; index++)
                {
                    DataColumn column = uiLabProfile.Columns.Add();
                    column.ColumnName = listControlDS.TcssListLab.Rows[index]["ListId"].ToString();
                    column.Caption = listControlDS.TcssListLab.Rows[index]["FieldValue"].ToString();
                    column.DataType = typeof(System.String);
                }
            }

            // Load the data into the new table
            uiLabProfile = tcssDS.Tables[UiLabProfile];
            uiLabProfile.Clear(); // clear the table so that we can re-ppulate it
            for (int mainIndex = 0; mainIndex < tcssDS.TcssDonorLabProfile.Count; mainIndex++)
            {
                // Only look at non-deleted data
                if (tcssDS.TcssDonorLabProfile[mainIndex].RowState == DataRowState.Deleted)
                {
                    continue;
                }

                DataRow dataRow = uiLabProfile.NewRow();
                dataRow["TcssDonorLabProfileId"] = tcssDS.TcssDonorLabProfile[mainIndex].TcssDonorLabProfileId;
                dataRow["Sample Date/Time"] = tcssDS.TcssDonorLabProfile[mainIndex].SampleDateTime;

                TcssDS.TcssDonorLabProfileDetailRow[] detailRow = tcssDS.TcssDonorLabProfile[mainIndex].GetTcssDonorLabProfileDetailRows();
                for (int detailIndex = 0; detailIndex < detailRow.Length; detailIndex++)
                {
                    if (!detailRow[detailIndex].IsAnswerNull())
                    {
                        string columnName = detailRow[detailIndex].TcssListLabId.ToString();
                        dataRow[columnName] = detailRow[detailIndex].Answer;
                    }
                }
                uiLabProfile.Rows.Add(dataRow);
            }
            // WE want to accept all the changes so that datagrid will  know what has chnaged. Since everything is add right now
            uiLabProfile.AcceptChanges();
        }

        /// <summary>
        /// Load the data from the temp table into the main table to save data
        /// </summary>
        private void LoadDataFromLabProfile()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.Tables[UiLabProfile] == null)
                return;

            DataTable uiLabProfile = tcssDS.Tables[UiLabProfile];
            for (int mainIndex = 0; mainIndex < uiLabProfile.Rows.Count; mainIndex++)
            {
                // We cannot access the deleted rows
                if (uiLabProfile.Rows[mainIndex].RowState == DataRowState.Deleted)
                {
                    int tcssDonorLabProfileId = (int)uiLabProfile.Rows[mainIndex]["TcssDonorLabProfileId", DataRowVersion.Original];
                    TcssDS.TcssDonorLabProfileRow tcssDonorLabProfileRow = tcssDS.TcssDonorLabProfile.FindByTcssDonorLabProfileId(tcssDonorLabProfileId);
                    tcssDonorLabProfileRow.Delete();
                }
                else if (uiLabProfile.Rows[mainIndex].RowState == DataRowState.Added ||
                    uiLabProfile.Rows[mainIndex].RowState == DataRowState.Modified)
                {
                    int tcssDonorLabProfileId = (int)uiLabProfile.Rows[mainIndex]["TcssDonorLabProfileId"];
                    TcssDS.TcssDonorLabProfileRow tcssDonorLabProfileRow = tcssDS.TcssDonorLabProfile.FindByTcssDonorLabProfileId(tcssDonorLabProfileId);
                    // Add the Vital sign
                    if (tcssDonorLabProfileRow == null)
                    {
                        tcssDonorLabProfileRow = tcssDS.TcssDonorLabProfile.NewTcssDonorLabProfileRow();
                        tcssDonorLabProfileRow.SampleDateTime = (DateTime)uiLabProfile.Rows[mainIndex]["Sample Date/Time"];
                        tcssDS.TcssDonorLabProfile.AddTcssDonorLabProfileRow(tcssDonorLabProfileRow);
                    }
                    // Updte teh Vital sign
                    else
                    {
                        tcssDonorLabProfileRow.SampleDateTime = (DateTime)uiLabProfile.Rows[mainIndex]["Sample Date/Time"];
                    }

                    // test to see if this is a new item or an old item
                    int existingDetailRowCount = tcssDS.TcssDonorLabProfileDetail.Select("TcssDonorId=" + tcssDonorLabProfileRow.TcssDonorId +
                        "AND TcssDonorLabProfileId=" + tcssDonorLabProfileRow.TcssDonorLabProfileId).Length;

                    // add the item
                    if (existingDetailRowCount > 0)
                    {
                        // We ignore the first 2 columns since they are for the main table
                        for (int detailIndex = 2; detailIndex < uiLabProfile.Columns.Count; detailIndex++)
                        {
                            int tcssListId = int.Parse(uiLabProfile.Columns[detailIndex].ColumnName);

                            TcssDS.TcssDonorLabProfileDetailRow[] existingDetailRow = (TcssDS.TcssDonorLabProfileDetailRow[])
                                tcssDS.TcssDonorLabProfileDetail.Select("TcssDonorId=" + tcssDonorLabProfileRow.TcssDonorId +
                                "AND TcssDonorLabProfileId=" + tcssDonorLabProfileRow.TcssDonorLabProfileId +
                                "AND TcssListLabId=" + tcssListId);

                            TcssDS.TcssDonorLabProfileDetailRow detailRow = existingDetailRow[0];
                            detailRow.TcssDonorLabProfileId = tcssDonorLabProfileRow.TcssDonorLabProfileId;
                            detailRow.TcssListLabId = tcssListId;
                            detailRow.Answer = uiLabProfile.Rows[mainIndex][detailIndex].ToString();
                        }
                    }
                    // update the item
                    else
                    {
                        // We ignore the first 2 columns since they are for the main table
                        for (int detailIndex = 2; detailIndex < uiLabProfile.Columns.Count; detailIndex++)
                        {
                            TcssDS.TcssDonorLabProfileDetailRow detailRow = tcssDS.TcssDonorLabProfileDetail.NewTcssDonorLabProfileDetailRow();
                            detailRow.TcssDonorLabProfileId = tcssDonorLabProfileRow.TcssDonorLabProfileId;
                            detailRow.TcssListLabId = int.Parse(uiLabProfile.Columns[detailIndex].ColumnName);
                            detailRow.Answer = uiLabProfile.Rows[mainIndex][detailIndex].ToString();
                            tcssDS.TcssDonorLabProfileDetail.AddTcssDonorLabProfileDetailRow(detailRow);
                        }
                    }
                }


            }
        }

        /// <summary>
        /// Create the Table for the Vital Sign Summary
        /// </summary>
        private void CreateTableLabProfileSummary(string tableName, string organColumn)
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            DataTable uiLabProfileSummary;

            // Create the table if it does not already exists
            if (!tcssDS.Tables.Contains(tableName))
            {
                ListControlBR listControlBR = new ListControlBR("TcssListLabSelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();

                // Create the table schema
                tcssDS.Tables.Add(tableName);
                uiLabProfileSummary = tcssDS.Tables[tableName];
                uiLabProfileSummary.Columns.Add(" ", typeof(System.String));
                for (int index = 0; index < listControlDS.TcssListLab.Rows.Count; index++)
                {
                    if ((bool)listControlDS.TcssListLab[index][organColumn])
                    {
                        DataColumn column = uiLabProfileSummary.Columns.Add();
                        column.ColumnName = listControlDS.TcssListLab[index].ListId.ToString();
                        column.Caption = listControlDS.TcssListLab[index].FieldValue;
                        column.DataType = typeof(System.String);

                        // Add a column to stor the from-to date 
                        column = uiLabProfileSummary.Columns.Add();
                        column.ColumnName = listControlDS.TcssListLab[index].ListId.ToString() + "Date";
                        column.Caption = " ";
                        column.DataType = typeof(System.String);
                    }
                }
            }

            // Clear the table and add the default rows
            uiLabProfileSummary = tcssDS.Tables[tableName];
            uiLabProfileSummary.Clear();

            // Create the 3 rows of data
            DataRow initalRow = uiLabProfileSummary.NewRow();
            initalRow[0] = "Initial";
            uiLabProfileSummary.Rows.Add(initalRow);

            DataRow peakRow = uiLabProfileSummary.NewRow();
            peakRow[0] = "Peak";
            uiLabProfileSummary.Rows.Add(peakRow);

            DataRow currentRow = uiLabProfileSummary.NewRow();
            currentRow[0] = "Current";
            uiLabProfileSummary.Rows.Add(currentRow);

            // Load the DAta
            DataTable uiLabProfileDataTable = tcssDS.Tables[UiLabProfile];

            // For each column in the table dtLabProfile
            for (int columnIndex = 1; columnIndex < uiLabProfileSummary.Columns.Count; columnIndex = columnIndex + 2)
            {
                string columnName = uiLabProfileSummary.Columns[columnIndex].ColumnName;
                // Get the 1st non null value from the table uiLabProfileDataTable
                for (int rowIndex = 0; rowIndex < uiLabProfileDataTable.Rows.Count; rowIndex++)
                {
                    try
                    {
                        decimal newValue = decimal.MinValue;
                        newValue = decimal.Parse(uiLabProfileDataTable.Rows[rowIndex][columnName].ToString());

                        // Set the initial value
                        if (uiLabProfileSummary.Rows[0][columnIndex] == DBNull.Value)
                        {
                            uiLabProfileSummary.Rows[0][columnIndex] = newValue;
                            uiLabProfileSummary.Rows[0][columnIndex + 1] = ((DateTime)uiLabProfileDataTable.Rows[rowIndex]["Sample Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat);
                        }

                        // Set the Peak Value
                        if (uiLabProfileSummary.Rows[1][columnIndex] == DBNull.Value || decimal.Parse(uiLabProfileSummary.Rows[1][columnIndex].ToString()) <= newValue)
                        {
                            uiLabProfileSummary.Rows[1][columnIndex] = newValue;
                            uiLabProfileSummary.Rows[1][columnIndex + 1] = ((DateTime)uiLabProfileDataTable.Rows[rowIndex]["Sample Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat);
                        }

                        // set the Current Value
                        if (newValue != decimal.MinValue)
                        {
                            uiLabProfileSummary.Rows[2][columnIndex] = newValue;
                            uiLabProfileSummary.Rows[2][columnIndex + 1] = ((DateTime)uiLabProfileDataTable.Rows[rowIndex]["Sample Date/Time"]).ToString(WindowsConstant.CreateInstance().DateTimeFormat);
                        }
                    }
                    catch (Exception) { }
                }
            }
        }

        private void CreateTableSerologies()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.TcssDonor.Count == 1 && tcssDS.TcssDonorSerologies.Count == 0)
            {
                ListControlBR serologyQuestionBR = new ListControlBR("TcssListSerologyQuestionSelect");
                ListControlDS serologyQuestionDS = (ListControlDS)serologyQuestionBR.SelectDataSet();
                for (int index = 0; index < serologyQuestionDS.ListControl.Count; index++)
                {
                    TcssDS.TcssDonorSerologiesRow row = tcssDS.TcssDonorSerologies.NewTcssDonorSerologiesRow();
                    row.TcssListSerologyQuestionId = serologyQuestionDS.ListControl[index].ListId;
                    tcssDS.TcssDonorSerologies.AddTcssDonorSerologiesRow(row);
                }
            }
        }

        private void CreateTableDiagnosticsKidneyArteryLeft()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.TcssDonor.Count == 1 && tcssDS.TcssDonorDiagnosisKidneyArteryLeft.Count == 0)
            {
                ListControlBR listControlBR = new ListControlBR("TcssListKidneyArterySelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                for (int index = 0; index < listControlDS.ListControl.Count; index++)
                {
                    TcssDS.TcssDonorDiagnosisKidneyArteryLeftRow row = tcssDS.TcssDonorDiagnosisKidneyArteryLeft.NewTcssDonorDiagnosisKidneyArteryLeftRow();
                    row.TcssListKidneyId = (int)TcssListKidney.Left;
                    row.TcssListKidneyArteryId = listControlDS.ListControl[index].ListId;
                    tcssDS.TcssDonorDiagnosisKidneyArteryLeft.AddTcssDonorDiagnosisKidneyArteryLeftRow(row);
                }
            }
        }

        private void CreateTableDiagnosticsKidneyVeinLeft()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.TcssDonor.Count == 1 && tcssDS.TcssDonorDiagnosisKidneyVeinLeft.Count == 0)
            {
                ListControlBR listControlBR = new ListControlBR("TcssListKidneyVeinSelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                for (int index = 0; index < listControlDS.ListControl.Count; index++)
                {
                    TcssDS.TcssDonorDiagnosisKidneyVeinLeftRow row = tcssDS.TcssDonorDiagnosisKidneyVeinLeft.NewTcssDonorDiagnosisKidneyVeinLeftRow();
                    row.TcssListKidneyId = (int)TcssListKidney.Left;
                    row.TcssListKidneyVeinId = listControlDS.ListControl[index].ListId;
                    tcssDS.TcssDonorDiagnosisKidneyVeinLeft.AddTcssDonorDiagnosisKidneyVeinLeftRow(row);
                }
            }
        }

        private void CreateTableDiagnosticsKidneyUreterLeft()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.TcssDonor.Count == 1 && tcssDS.TcssDonorDiagnosisKidneyUreterLeft.Count == 0)
            {
                ListControlBR listControlBR = new ListControlBR("TcssListKidneyUreterSelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                for (int index = 0; index < listControlDS.ListControl.Count; index++)
                {
                    TcssDS.TcssDonorDiagnosisKidneyUreterLeftRow row = tcssDS.TcssDonorDiagnosisKidneyUreterLeft.NewTcssDonorDiagnosisKidneyUreterLeftRow();
                    row.TcssListKidneyId = (int)TcssListKidney.Left;
                    row.TcssListKidneyUreterId = listControlDS.ListControl[index].ListId;
                    tcssDS.TcssDonorDiagnosisKidneyUreterLeft.AddTcssDonorDiagnosisKidneyUreterLeftRow(row);
                }
            }
        }

        private void CreateTableDiagnosticsKidneyArteryRight()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.TcssDonor.Count == 1 && tcssDS.TcssDonorDiagnosisKidneyArteryRight.Count == 0)
            {
                ListControlBR listControlBR = new ListControlBR("TcssListKidneyArterySelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                for (int index = 0; index < listControlDS.ListControl.Count; index++)
                {
                    TcssDS.TcssDonorDiagnosisKidneyArteryRightRow row = tcssDS.TcssDonorDiagnosisKidneyArteryRight.NewTcssDonorDiagnosisKidneyArteryRightRow();
                    row.TcssListKidneyId = (int)TcssListKidney.Right;
                    row.TcssListKidneyArteryId = listControlDS.ListControl[index].ListId;
                    tcssDS.TcssDonorDiagnosisKidneyArteryRight.AddTcssDonorDiagnosisKidneyArteryRightRow(row);
                }
            }
        }

        private void CreateTableDiagnosticsKidneyVeinRight()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.TcssDonor.Count == 1 && tcssDS.TcssDonorDiagnosisKidneyVeinRight.Count == 0)
            {
                ListControlBR listControlBR = new ListControlBR("TcssListKidneyVeinSelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                for (int index = 0; index < listControlDS.ListControl.Count; index++)
                {
                    TcssDS.TcssDonorDiagnosisKidneyVeinRightRow row = tcssDS.TcssDonorDiagnosisKidneyVeinRight.NewTcssDonorDiagnosisKidneyVeinRightRow();
                    row.TcssListKidneyId = (int)TcssListKidney.Right;
                    row.TcssListKidneyVeinId = listControlDS.ListControl[index].ListId;
                    tcssDS.TcssDonorDiagnosisKidneyVeinRight.AddTcssDonorDiagnosisKidneyVeinRightRow(row);
                }
            }
        }

        private void CreateTableDiagnosticsKidneyUreterRight()
        {
            TcssDS tcssDS = (TcssDS)AssociatedDataSet;
            if (tcssDS.TcssDonor.Count == 1 && tcssDS.TcssDonorDiagnosisKidneyUreterRight.Count == 0)
            {
                ListControlBR listControlBR = new ListControlBR("TcssListKidneyUreterSelect");
                ListControlDS listControlDS = (ListControlDS)listControlBR.SelectDataSet();
                for (int index = 0; index < listControlDS.ListControl.Count; index++)
                {
                    TcssDS.TcssDonorDiagnosisKidneyUreterRightRow row = tcssDS.TcssDonorDiagnosisKidneyUreterRight.NewTcssDonorDiagnosisKidneyUreterRightRow();
                    row.TcssListKidneyId = (int)TcssListKidney.Right;
                    row.TcssListKidneyUreterId = listControlDS.ListControl[index].ListId;
                    tcssDS.TcssDonorDiagnosisKidneyUreterRight.AddTcssDonorDiagnosisKidneyUreterRightRow(row);
                }
            }
        }
        #endregion

        internal void ReassignField(int fieldID, DataColumn fieldName,  DataColumn reassignColumn, object orginalValue, Object newValue)
        {
            //check table for record 
            DataRow[] row;
            string query = string.Format("{0} = {1}", fieldName.ColumnName, fieldID);
            row = AssociatedDataSet.tcssDs().Tables[fieldName.Table.TableName].Select(query);
            if (row.Count() == 0)
                //load the record
                switch (fieldName.Table.TableName)
                {
                    case "TcssRecipientOfferInformation":
                        SelectTcss(fieldID);
                        break;
                }
            //table has the record
            row = AssociatedDataSet.tcssDs().Tables[reassignColumn.Table.TableName].Select(query);
            if (row.Count() == 0)
                return;

            if (row[GeneralConstant.CreateInstance().FirstRow][reassignColumn.ColumnName].Equals(orginalValue))
                row[GeneralConstant.CreateInstance().FirstRow][reassignColumn.ColumnName] = newValue;
        }

        private void SelectTcss(int callID)
        {
            CallId  = callID;            
            Select();

        }
    }
    public static class DataSetConversion
    {
        public static TcssDS tcssDs(this DataSet tcssDs)
        {
            return (TcssDS)tcssDs;
        }
    }
}

