IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyUpdate'
		DROP Procedure TcssDonorDiagnosisKidneyUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyUpdate
(
	@TcssDonorDiagnosisKidneyId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListKidneyId int = null,
	@TcssListKidneyAorticCuffId int = null,
	@TcssListKidneyFullVenaId int = null,
	@Length float = null,
	@Width float = null,
	@TcssListKidneyAorticPlaqueId int = null,
	@TcssListKidneyArterialPlaqueId int = null,
	@TcssListKidneyInfarctedAreaId int = null,
	@TcssListKidneyCapsularTearId int = null,
	@TcssListKidneySubcapsularId int = null,
	@TcssListKidneyHematomaId int = null,
	@TcssListKidneyFatCleanedId int = null,
	@TcssListKidneyCystsDiscolorationId int = null,
	@TcssListKidneyHorseshoeShapeId int = null,
	@GlomeruliObserved varchar(50) = null,
	@GlomeruliSclerosed varchar(50) = null,
	@SclerosedPercent decimal = null,
	@TcssListKidneyBiopsyId int = null,
	@Comment varchar(5000) = null,
	@TcssListKidneyPumpDeviceId int = null,
	@TcssListKidneyPumpSolutionId int = null,
	@BiopsyType varchar(20) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyUpdate
**	Desc: Update Data in table TcssDonorDiagnosisKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisKidney
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListKidneyId = @TcssListKidneyId,
	TcssListKidneyAorticCuffId = @TcssListKidneyAorticCuffId,
	TcssListKidneyFullVenaId = @TcssListKidneyFullVenaId,
	Length = @Length,
	Width = @Width,
	TcssListKidneyAorticPlaqueId = @TcssListKidneyAorticPlaqueId,
	TcssListKidneyArterialPlaqueId = @TcssListKidneyArterialPlaqueId,
	TcssListKidneyInfarctedAreaId = @TcssListKidneyInfarctedAreaId,
	TcssListKidneyCapsularTearId = @TcssListKidneyCapsularTearId,
	TcssListKidneySubcapsularId = @TcssListKidneySubcapsularId,
	TcssListKidneyHematomaId = @TcssListKidneyHematomaId,
	TcssListKidneyFatCleanedId = @TcssListKidneyFatCleanedId,
	TcssListKidneyCystsDiscolorationId = @TcssListKidneyCystsDiscolorationId,
	TcssListKidneyHorseshoeShapeId = @TcssListKidneyHorseshoeShapeId,
	GlomeruliObserved = @GlomeruliObserved,
	GlomeruliSclerosed = @GlomeruliSclerosed,
	SclerosedPercent = @SclerosedPercent,
	TcssListKidneyBiopsyId = @TcssListKidneyBiopsyId,
	Comment = @Comment,
	TcssListKidneyPumpDeviceId = @TcssListKidneyPumpDeviceId,
	TcssListKidneyPumpSolutionId = @TcssListKidneyPumpSolutionId,
	BiopsyType = @BiopsyType
WHERE
	TcssDonorDiagnosisKidneyId = @TcssDonorDiagnosisKidneyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyUpdate TO PUBLIC
GO
