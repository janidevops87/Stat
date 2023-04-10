IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorMedSocUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorMedSocUpdate'
		DROP Procedure TcssDonorMedSocUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorMedSocUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorMedSocUpdate
(
	@TcssDonorMedSocId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListHistoryOfDiabetesId int = null,
	@TcssListHistoryOfCancerId int = null,
	@TcssListHypertensionHistoryId int = null,
	@TcssListCompliantWithTreatmentId int = null,
	@TcssListHistoryOfCoronaryArteryDiseaseId int = null,
	@TcssListHistoryOfGastrointestinalDiseaseId int = null,
	@TcssListChestTraumaId int = null,
	@TcssListCigaretteUseId int = null,
	@TcssListCigaretteUseContinuedId int = null,
	@TcssListOtherDrugUseId int = null,
	@TcssListHeavyAlcoholUseId int = null,
	@TcssListDonorMeetCdcGuidelinesId int = null,
	@Comments varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorMedSocUpdate
**	Desc: Update Data in table TcssDonorMedSoc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorMedSoc
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListHistoryOfDiabetesId = @TcssListHistoryOfDiabetesId,
	TcssListHistoryOfCancerId = @TcssListHistoryOfCancerId,
	TcssListHypertensionHistoryId = @TcssListHypertensionHistoryId,
	TcssListCompliantWithTreatmentId = @TcssListCompliantWithTreatmentId,
	TcssListHistoryOfCoronaryArteryDiseaseId = @TcssListHistoryOfCoronaryArteryDiseaseId,
	TcssListHistoryOfGastrointestinalDiseaseId = @TcssListHistoryOfGastrointestinalDiseaseId,
	TcssListChestTraumaId = @TcssListChestTraumaId,
	TcssListCigaretteUseId = @TcssListCigaretteUseId,
	TcssListCigaretteUseContinuedId = @TcssListCigaretteUseContinuedId,
	TcssListOtherDrugUseId = @TcssListOtherDrugUseId,
	TcssListHeavyAlcoholUseId = @TcssListHeavyAlcoholUseId,
	TcssListDonorMeetCdcGuidelinesId = @TcssListDonorMeetCdcGuidelinesId,
	Comments = @Comments
WHERE
	TcssDonorMedSocId = @TcssDonorMedSocId
GO

GRANT EXEC ON TcssDonorMedSocUpdate TO PUBLIC
GO
