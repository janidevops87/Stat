IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyInsert'
		DROP Procedure TcssDonorDiagnosisKidneyInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyInsert
(
	@TcssDonorDiagnosisKidneyId int output,
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
**	Name: TcssDonorDiagnosisKidneyInsert
**	Desc: Insert Data into table TcssDonorDiagnosisKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisKidney
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListKidneyId,
	TcssListKidneyAorticCuffId,
	TcssListKidneyFullVenaId,
	Length,
	Width,
	TcssListKidneyAorticPlaqueId,
	TcssListKidneyArterialPlaqueId,
	TcssListKidneyInfarctedAreaId,
	TcssListKidneyCapsularTearId,
	TcssListKidneyHematomaId,
	TcssListKidneySubcapsularId,
	TcssListKidneyFatCleanedId,
	TcssListKidneyCystsDiscolorationId,
	TcssListKidneyHorseshoeShapeId,
	GlomeruliObserved,
	GlomeruliSclerosed,
	SclerosedPercent,
	TcssListKidneyBiopsyId,
	Comment,
	TcssListKidneyPumpDeviceId,
	TcssListKidneyPumpSolutionId,
	BiopsyType
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListKidneyId,
	@TcssListKidneyAorticCuffId,
	@TcssListKidneyFullVenaId,
	@Length,
	@Width,
	@TcssListKidneyAorticPlaqueId,
	@TcssListKidneyArterialPlaqueId,
	@TcssListKidneyInfarctedAreaId,
	@TcssListKidneyCapsularTearId,
	@TcssListKidneySubcapsularId,
	@TcssListKidneyHematomaId,
	@TcssListKidneyFatCleanedId,
	@TcssListKidneyCystsDiscolorationId,
	@TcssListKidneyHorseshoeShapeId,
	@GlomeruliObserved,
	@GlomeruliSclerosed,
	@SclerosedPercent,
	@TcssListKidneyBiopsyId,
	@Comment,
	@TcssListKidneyPumpDeviceId,
	@TcssListKidneyPumpSolutionId,
	@BiopsyType
)

-- Return the new identity value
SET @TcssDonorDiagnosisKidneyId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisKidneyInsert TO PUBLIC
GO
