IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneySelect'
		DROP Procedure TcssDonorDiagnosisKidneySelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneySelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneySelect
(
	@TcssDonorId int,
	@TcssListKidneyId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneySelect
**	Desc: Update Data in table TcssDonorDiagnosisKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddk.TcssDonorDiagnosisKidneyId,
	tddk.LastUpdateStatEmployeeId,
	tddk.LastUpdateDate,
	tddk.TcssDonorId,
	tddk.TcssListKidneyId,
	tddk.TcssListKidneyAorticCuffId,
	tddk.TcssListKidneyFullVenaId,
	tddk.Length,
	tddk.Width,
	tddk.TcssListKidneyAorticPlaqueId,
	tddk.TcssListKidneyArterialPlaqueId,
	tddk.TcssListKidneyInfarctedAreaId,
	tddk.TcssListKidneyCapsularTearId,
	tddk.TcssListKidneySubcapsularId,
	tddk.TcssListKidneyHematomaId,
	tddk.TcssListKidneyFatCleanedId,
	tddk.TcssListKidneyCystsDiscolorationId,
	tddk.TcssListKidneyHorseshoeShapeId,
	tddk.GlomeruliObserved,
	tddk.GlomeruliSclerosed,
	tddk.SclerosedPercent,
	tddk.TcssListKidneyBiopsyId,
	tddk.Comment,
	tddk.TcssListKidneyPumpDeviceId,
	tddk.TcssListKidneyPumpSolutionId,
	tddk.BiopsyType
FROM dbo.TcssDonorDiagnosisKidney tddk
WHERE
	tddk.TcssDonorId = @TcssDonorId
	AND tddk.TcssListKidneyId = @TcssListKidneyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneySelect TO PUBLIC
GO
