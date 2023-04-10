IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorMedSocInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorMedSocInsert'
		DROP Procedure TcssDonorMedSocInsert
	END
GO

PRINT 'Creating Procedure TcssDonorMedSocInsert'
GO

CREATE PROCEDURE dbo.TcssDonorMedSocInsert
(
	@TcssDonorMedSocId int output,
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
**	Name: TcssDonorMedSocInsert
**	Desc: Insert Data into table TcssDonorMedSoc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorMedSoc
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListHistoryOfDiabetesId,
	TcssListHistoryOfCancerId,
	TcssListHypertensionHistoryId,
	TcssListCompliantWithTreatmentId,
	TcssListHistoryOfCoronaryArteryDiseaseId,
	TcssListHistoryOfGastrointestinalDiseaseId,
	TcssListChestTraumaId,
	TcssListCigaretteUseId,
	TcssListCigaretteUseContinuedId,
	TcssListOtherDrugUseId,
	TcssListHeavyAlcoholUseId,
	TcssListDonorMeetCdcGuidelinesId,
	Comments
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListHistoryOfDiabetesId,
	@TcssListHistoryOfCancerId,
	@TcssListHypertensionHistoryId,
	@TcssListCompliantWithTreatmentId,
	@TcssListHistoryOfCoronaryArteryDiseaseId,
	@TcssListHistoryOfGastrointestinalDiseaseId,
	@TcssListChestTraumaId,
	@TcssListCigaretteUseId,
	@TcssListCigaretteUseContinuedId,
	@TcssListOtherDrugUseId,
	@TcssListHeavyAlcoholUseId,
	@TcssListDonorMeetCdcGuidelinesId,
	@Comments
)

-- Return the new identity value
SET @TcssDonorMedSocId = @@Identity

GO

GRANT EXEC ON TcssDonorMedSocInsert TO PUBLIC
GO
