IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssSelectDataSet')
	BEGIN
		PRINT 'Dropping Procedure TcssSelectDataSet'
		DROP Procedure TcssSelectDataSet
	END
GO

PRINT 'Creating Procedure TcssSelectDataSet'
GO

CREATE PROCEDURE dbo.TcssSelectDataSet
(
	@StatEmployeeId int,
	@CallId int = null,
	@TcssRecipientId int = null,
	@TcssDonorId int = null
)
AS
/***************************************************************************************************
**	Name: TcssSelectDataSet
**	Desc: Select Data for FamilyServices
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/01/2009	Tanvir Ather	Initial Sproc Creation 
**  6/06/2011   jth				if the donor and recipient aren't the same, then it is associcated with another donor...
**								for these, don't show candidates
***************************************************************************************************/

DECLARE @OrganizationId int
DECLARE @CandidateID int
SELECT @OrganizationId = dbo.GetOrganizationsByStatEmployeeId(@StatEmployeeId)
set @CandidateID = @TcssRecipientId
IF(@TcssRecipientId<>@TcssDonorId )
BEGIN
	set @CandidateID = 0
END

-- Get the CallId TcssDonorId and TcssRecipientId
SELECT @CallId = troi.CallId, @TcssDonorId = td.TcssDonorId, @TcssRecipientId = tr.TcssRecipientId
FROM dbo.TcssDonor td
	INNER JOIN TcssDonorToRecipient tdr ON td.TcssDonorId = tdr.TcssDonorId
	INNER JOIN TcssRecipient tr ON tr.TcssRecipientId = tdr.TcssRecipientId
	INNER JOIN TcssRecipientOfferInformation troi ON troi.TcssRecipientId = tr.TcssRecipientId
WHERE ((@CallId IS NULL AND tr.TcssRecipientId = @TcssRecipientId AND td.TcssDonorId= @TcssDonorId) OR (troi.CallId = @CallId))

IF @CallId IS NOT NULL
	AND(
			@OrganizationId = 194 -- If the User belongs to StatTrac, allow the user to edit this case
			OR EXISTS(SELECT * FROM dbo.GetCallIdByOrganizationId(@OrganizationId) WHERE CallId = @CallId)
		)
BEGIN
	EXEC dbo.CallSelect @callID = @CallId
	
	EXEC dbo.TcssDonorSelect @TcssDonorId = @TcssDonorId, @TcssRecipientId = @TcssRecipientId
	EXEC dbo.TcssRecipientSelect @TcssRecipientId = @TcssRecipientId
	EXEC dbo.TcssDonorToRecipientSelect @TcssDonorId = @TcssDonorId, @TcssRecipientId = @TcssRecipientId
	EXEC dbo.TcssRecipientOfferInformationSelect @TcssRecipientId = @TcssRecipientId
	EXEC dbo.TcssRecipientOfferStatusInformationSelect @TcssRecipientId = @TcssRecipientId
	EXEC dbo.TcssDonorContactInformationSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssRecipientCandidateSelect @CandidateID--@TcssRecipientId
	EXEC dbo.TcssRecipientCandidateDetailSelect @CandidateID--@TcssRecipientId

	EXEC dbo.TcssDonorHlaLiverSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorHlaSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorMedSocSelect @TcssDonorId = @TcssDonorId

	EXEC dbo.TcssDonorVitalSignSummarySelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorVitalSignSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorVitalSignDetailSelect @TcssDonorId = @TcssDonorId

	EXEC dbo.TcssDonorMedicationSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorFluidBloodSelect @TcssDonorId = @TcssDonorId	

	EXEC dbo.TcssDonorLabProfileSummarySelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorLabProfileSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorLabProfileDetailSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorLabValuesSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorLabSelect @TcssDonorId = @TcssDonorId

	EXEC dbo.TcssDonorCompleteBloodCountSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorTestSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorSerologiesSelect @TcssDonorId = @TcssDonorId

	-- Get the left kidney
	EXEC dbo.TcssDonorDiagnosisKidneySelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 1
	EXEC dbo.TcssDonorDiagnosisKidneyArterySelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 1
	EXEC dbo.TcssDonorDiagnosisKidneyVeinSelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 1
	EXEC dbo.TcssDonorDiagnosisKidneyUreterSelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 1
	EXEC dbo.TcssDonorDiagnosisKidneyBiopsySelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 1

	-- Get the right kidney
	EXEC dbo.TcssDonorDiagnosisKidneySelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 2
	EXEC dbo.TcssDonorDiagnosisKidneyArterySelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 2
	EXEC dbo.TcssDonorDiagnosisKidneyVeinSelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 2
	EXEC dbo.TcssDonorDiagnosisKidneyUreterSelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 2
	EXEC dbo.TcssDonorDiagnosisKidneyBiopsySelect @TcssDonorId = @TcssDonorId, @TcssListKidneyId = 2
	
	EXEC dbo.TcssDonorDiagnosisLiverSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorDiagnosisOtherSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorDiagnosisHeartSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorDiagnosisLungSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorCultureSelect @TcssDonorId = @TcssDonorId, @TcssListCultureTypeId = 3 -- Sputum Gram Stain
	EXEC dbo.TcssDonorDiagnosisPancreasSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorDiagnosisIntestineSelect @TcssDonorId = @TcssDonorId

	EXEC dbo.TcssDonorUrinalysisSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorCultureSelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorAbgSummarySelect @TcssDonorId = @TcssDonorId
	EXEC dbo.TcssDonorAbgSelect @TcssDonorId = @TcssDonorId
END
GO

GRANT EXEC ON TcssSelectDataSet TO PUBLIC
GO
