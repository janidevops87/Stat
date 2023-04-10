using System;
using System.Collections.Generic;
using Statline.Stattrac.Framework;
using System.Data;
using Statline.Stattrac.Constant;
using Statline.Stattrac.Data.Types.NewCall;

namespace Statline.Stattrac.DataAccess.Dashboard
{
	public class TcssDA : BaseDA
	{
		#region Private Fields
		private int callId;
		private int recipientId;
		private int donorId;

		/// <summary>
		/// Determine if this is the first time we are saving a brand new Donor
		/// </summary>
		private bool isNewRecipient;
		#endregion

		#region Constructor
		public TcssDA()
			: base("TcssSelectDataSet")
		{
			callId = int.MinValue;
			recipientId = int.MinValue;
			isNewRecipient = false;

			SetTablesSelect("Call",
				"TcssDonor", "TcssRecipient", "TcssDonorToRecipient", "TcssRecipientOfferInformation", "TcssRecipientOfferStatusInformation",
				"TcssDonorContactInformation", "TcssRecipientCandidate", "TcssRecipientCandidateDetail",
				"TcssDonorHlaLiver", "TcssDonorHla", "TcssDonorMedSoc", 
				"TcssDonorVitalSignSummary", "TcssDonorVitalSign", "TcssDonorVitalSignDetail",
				"TcssDonorMedication", "TcssDonorFluidBlood", 
				"TcssDonorLabProfileSummary", "TcssDonorLabProfile", "TcssDonorLabProfileDetail", "TcssDonorLabValues", "TcssDonorLab",
				"TcssDonorCompleteBloodCount", "TcssDonorTest", "TcssDonorSerologies", 
				"TcssDonorDiagnosisKidneyLeft", "TcssDonorDiagnosisKidneyArteryLeft", "TcssDonorDiagnosisKidneyVeinLeft",
				"TcssDonorDiagnosisKidneyUreterLeft", "TcssDonorDiagnosisKidneyBiopsyLeft", 
				"TcssDonorDiagnosisKidneyRight", "TcssDonorDiagnosisKidneyArteryRight", "TcssDonorDiagnosisKidneyVeinRight",
				"TcssDonorDiagnosisKidneyUreterRight", "TcssDonorDiagnosisKidneyBiopsyRight", 
				"TcssDonorDiagnosisLiver", "TcssDonorDiagnosisOther", "TcssDonorDiagnosisHeart",
				"TcssDonorDiagnosisLung", "TcssDonorDiagnosisLungSputum", "TcssDonorDiagnosisPancreas", "TcssDonorDiagnosisIntestine",
				"TcssDonorUrinalysis", "TcssDonorCulture", "TcssDonorAbgSummary", "TcssDonorAbg");

			ListTableSave.Add(new TableSave("Call", "CallInsert", "CallUpdate", "CallDelete"));
			ListTableSave.Add(new TableSave("TcssDonor", "TcssDonorInsert", "TcssDonorUpdate", "TcssDonorDelete"));
			ListTableSave.Add(new TableSave("TcssRecipient", "TcssRecipientInsert", "TcssRecipientUpdate", "TcssRecipientDelete"));
			ListTableSave.Add(new TableSave("TcssDonorToRecipient", "TcssDonorToRecipientInsertUpdate", "TcssDonorToRecipientInsertUpdate", "TcssDonorToRecipientDelete")); 
			ListTableSave.Add(new TableSave("TcssRecipientOfferInformation", "TcssRecipientOfferInformationInsert", "TcssRecipientOfferInformationUpdate", "TcssRecipientOfferInformationDelete"));
			ListTableSave.Add(new TableSave("TcssRecipientOfferStatusInformation", "TcssRecipientOfferStatusInformationInsert", "TcssRecipientOfferStatusInformationUpdate", "TcssRecipientOfferStatusInformationDelete"));
			ListTableSave.Add(new TableSave("TcssDonorContactInformation", "TcssDonorContactInformationInsert", "TcssDonorContactInformationUpdate", "TcssDonorContactInformationDelete"));
			ListTableSave.Add(new TableSave("TcssRecipientCandidate", "TcssRecipientCandidateInsert", "TcssRecipientCandidateUpdate", "TcssRecipientCandidateDelete"));
			ListTableSave.Add(new TableSave("TcssRecipientCandidateDetail", "TcssRecipientCandidateDetailInsert", "TcssRecipientCandidateDetailUpdate", "TcssRecipientCandidateDetailDelete"));
			ListTableSave.Add(new TableSave("TcssDonorHlaLiver", "TcssDonorHlaLiverInsert", "TcssDonorHlaLiverUpdate", "TcssDonorHlaLiverDelete"));
			ListTableSave.Add(new TableSave("TcssDonorHla", "TcssDonorHlaInsert", "TcssDonorHlaUpdate", "TcssDonorHlaDelete"));
			ListTableSave.Add(new TableSave("TcssDonorMedSoc", "TcssDonorMedSocInsert", "TcssDonorMedSocUpdate", "TcssDonorMedSocDelete"));
			ListTableSave.Add(new TableSave("TcssDonorVitalSignSummary", "TcssDonorVitalSignSummaryInsert", "TcssDonorVitalSignSummaryUpdate", "TcssDonorVitalSignSummaryDelete"));
			ListTableSave.Add(new TableSave("TcssDonorVitalSign", "TcssDonorVitalSignInsert", "TcssDonorVitalSignUpdate", "TcssDonorVitalSignDelete"));
			ListTableSave.Add(new TableSave("TcssDonorVitalSignDetail", "TcssDonorVitalSignDetailInsert", "TcssDonorVitalSignDetailUpdate", "TcssDonorVitalSignDetailDelete"));
			ListTableSave.Add(new TableSave("TcssDonorMedication", "TcssDonorMedicationInsert", "TcssDonorMedicationUpdate", "TcssDonorMedicationDelete"));
			ListTableSave.Add(new TableSave("TcssDonorFluidBlood", "TcssDonorFluidBloodInsert", "TcssDonorFluidBloodUpdate", "TcssDonorFluidBloodDelete"));
			ListTableSave.Add(new TableSave("TcssDonorLabProfileSummary", "TcssDonorLabProfileSummaryInsert", "TcssDonorLabProfileSummaryUpdate", "TcssDonorLabProfileSummaryDelete"));
			ListTableSave.Add(new TableSave("TcssDonorLabProfile", "TcssDonorLabProfileInsert", "TcssDonorLabProfileUpdate", "TcssDonorLabProfileDelete"));
			ListTableSave.Add(new TableSave("TcssDonorLabProfileDetail", "TcssDonorLabProfileDetailInsert", "TcssDonorLabProfileDetailUpdate", "TcssDonorLabProfileDetailDelete"));
			ListTableSave.Add(new TableSave("TcssDonorLabValues", "TcssDonorLabValuesInsert", "TcssDonorLabValuesUpdate", "TcssDonorLabValuesDelete"));
			ListTableSave.Add(new TableSave("TcssDonorLab", "TcssDonorLabInsert", "TcssDonorLabUpdate", "TcssDonorLabDelete"));
			ListTableSave.Add(new TableSave("TcssDonorCompleteBloodCount", "TcssDonorCompleteBloodCountInsert", "TcssDonorCompleteBloodCountUpdate", "TcssDonorCompleteBloodCountDelete"));
			ListTableSave.Add(new TableSave("TcssDonorTest", "TcssDonorTestInsert", "TcssDonorTestUpdate", "TcssDonorTestDelete"));
			ListTableSave.Add(new TableSave("TcssDonorSerologies", "TcssDonorSerologiesInsert", "TcssDonorSerologiesUpdate", "TcssDonorSerologiesDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyLeft", "TcssDonorDiagnosisKidneyInsert", "TcssDonorDiagnosisKidneyUpdate", "TcssDonorDiagnosisKidneyDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyArteryLeft", "TcssDonorDiagnosisKidneyArteryInsert", "TcssDonorDiagnosisKidneyArteryUpdate", "TcssDonorDiagnosisKidneyArteryDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyVeinLeft", "TcssDonorDiagnosisKidneyVeinInsert", "TcssDonorDiagnosisKidneyVeinUpdate", "TcssDonorDiagnosisKidneyVeinDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyUreterLeft", "TcssDonorDiagnosisKidneyUreterInsert", "TcssDonorDiagnosisKidneyUreterUpdate", "TcssDonorDiagnosisKidneyUreterDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyBiopsyLeft", "TcssDonorDiagnosisKidneyBiopsyInsert", "TcssDonorDiagnosisKidneyBiopsyUpdate", "TcssDonorDiagnosisKidneyBiopsyDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyRight", "TcssDonorDiagnosisKidneyInsert", "TcssDonorDiagnosisKidneyUpdate", "TcssDonorDiagnosisKidneyDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyArteryRight", "TcssDonorDiagnosisKidneyArteryInsert", "TcssDonorDiagnosisKidneyArteryUpdate", "TcssDonorDiagnosisKidneyArteryDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyVeinRight", "TcssDonorDiagnosisKidneyVeinInsert", "TcssDonorDiagnosisKidneyVeinUpdate", "TcssDonorDiagnosisKidneyVeinDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyUreterRight", "TcssDonorDiagnosisKidneyUreterInsert", "TcssDonorDiagnosisKidneyUreterUpdate", "TcssDonorDiagnosisKidneyUreterDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisKidneyBiopsyRight", "TcssDonorDiagnosisKidneyBiopsyInsert", "TcssDonorDiagnosisKidneyBiopsyUpdate", "TcssDonorDiagnosisKidneyBiopsyDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisLiver", "TcssDonorDiagnosisLiverInsert", "TcssDonorDiagnosisLiverUpdate", "TcssDonorDiagnosisLiverDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisOther", "TcssDonorDiagnosisOtherInsert", "TcssDonorDiagnosisOtherUpdate", "TcssDonorDiagnosisOtherDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisHeart", "TcssDonorDiagnosisHeartInsert", "TcssDonorDiagnosisHeartUpdate", "TcssDonorDiagnosisHeartDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisLung", "TcssDonorDiagnosisLungInsert", "TcssDonorDiagnosisLungUpdate", "TcssDonorDiagnosisLungDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisPancreas", "TcssDonorDiagnosisPancreasInsert", "TcssDonorDiagnosisPancreasUpdate", "TcssDonorDiagnosisPancreasDelete"));
			ListTableSave.Add(new TableSave("TcssDonorDiagnosisIntestine", "TcssDonorDiagnosisIntestineInsert", "TcssDonorDiagnosisIntestineUpdate", "TcssDonorDiagnosisIntestineDelete"));
			ListTableSave.Add(new TableSave("TcssDonorUrinalysis", "TcssDonorUrinalysisInsert", "TcssDonorUrinalysisUpdate", "TcssDonorUrinalysisDelete"));
			ListTableSave.Add(new TableSave("TcssDonorCulture", "TcssDonorCultureInsert", "TcssDonorCultureUpdate", "TcssDonorCultureDelete"));
            ListTableSave.Add(new TableSave("TcssDonorAbgSummary", "TcssDonorAbgSummaryInsert", "TcssDonorAbgSummaryUpdate", "TcssDonorAbgSummaryDelete"));
            ListTableSave.Add(new TableSave("TcssDonorAbg", "TcssDonorAbgInsert", "TcssDonorAbgUpdate", "TcssDonorAbgDelete"));
        }
		#endregion

		#region Public Properties
		public int CallId
		{
			get { return callId; }
			set { callId = value; }
		}

		public int RecipientId
		{
			get { return recipientId; }
			set { recipientId = value; }
		}

		public int DonorId
		{
			get { return donorId; }
			set { donorId = value; }
		}
		#endregion

		#region Overridden Methods
		protected override void AddParameterForSelectDataSet(BaseCommand commandWrapper)
		{
			commandWrapper.AddInParameterForSelect("@StatEmployeeId", DbType.Int32, StattracIdentity.Identity.UserId);
			if (callId != int.MinValue)
			{
				commandWrapper.AddInParameterForSelect("@CallId", DbType.Int32, callId);
			}
			if (recipientId != int.MinValue)
			{
				commandWrapper.AddInParameterForSelect("@TcssRecipientId", DbType.Int32, recipientId);
			}
			if (donorId != int.MinValue)
			{
				commandWrapper.AddInParameterForSelect("@TcssDonorId", DbType.Int32, donorId);
			}
		}

		/// <summary>
		/// Set the Id column of the table to be output
		/// </summary>
		/// <param name="table"></param>
		/// <param name="commandWrapper"></param>
		protected override void AddParameterForInsert(DataTable table, BaseCommand commandWrapper)
		{
			base.AddParameterForInsert(table, commandWrapper);
			TcssDS tcssDS = null;
			switch (table.TableName)
			{
				case "TcssDonorDiagnosisKidneyLeft":
				case "TcssDonorDiagnosisKidneyRight":
					commandWrapper.SetParameterToOutput("TcssDonorDiagnosisKidneyId");
					break;
				case "TcssDonorDiagnosisKidneyArteryLeft":
				case "TcssDonorDiagnosisKidneyArteryRight":
					commandWrapper.SetParameterToOutput("TcssDonorDiagnosisKidneyArteryId");
					break;
				case "TcssDonorDiagnosisKidneyVeinLeft":
				case "TcssDonorDiagnosisKidneyVeinRight":
					commandWrapper.SetParameterToOutput("TcssDonorDiagnosisKidneyVeinId");
					break;
				case "TcssDonorDiagnosisKidneyUreterLeft":
				case "TcssDonorDiagnosisKidneyUreterRight":
					commandWrapper.SetParameterToOutput("TcssDonorDiagnosisKidneyUreterId");
					break;
				case "TcssDonorDiagnosisKidneyBiopsyLeft":
				case "TcssDonorDiagnosisKidneyBiopsyRight":
					commandWrapper.SetParameterToOutput("TcssDonorDiagnosisKidneyBiopsyId");
					break;
				case "TcssRecipient":
					tcssDS = (TcssDS)table.DataSet;
					if (tcssDS.TcssRecipient.GetChanges(DataRowState.Added) != null)
					{
						isNewRecipient = true;
					}
					commandWrapper.SetParameterToOutput(table.TableName + "Id");
					break;
				case "TcssDonorToRecipient":
					// Since we cannot set a relation on this table we need to explicitly update the value
					if (isNewRecipient)
					{
						isNewRecipient = false;
						tcssDS = (TcssDS)table.DataSet;
						tcssDS.TcssDonorToRecipient[0].TcssRecipientId = tcssDS.TcssRecipient[0].TcssRecipientId;
					}
					commandWrapper.SetParameterToOutput(table.TableName + "Id");
					break;
				default:
					commandWrapper.SetParameterToOutput(table.TableName + "Id");
					break;
			}
		}

		protected override void HandleSaveException(TableSave tableSave, Exception ex)
		{
			if (ex.Message.Contains("is not a valid Oasis# in associated DonorCard"))
			{
				throw new BaseException(ex.Message, true);
			}
		}
		#endregion
	}
}

