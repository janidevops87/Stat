IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisHeartSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisHeartSelect'
		DROP Procedure TcssDonorDiagnosisHeartSelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisHeartSelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisHeartSelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisHeartSelect
**	Desc: Update Data in table TcssDonorDiagnosisHeart
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddh.TcssDonorDiagnosisHeartId,
	tddh.LastUpdateStatEmployeeId,
	tddh.LastUpdateDate,
	tddh.TcssDonorId,
	tddh.LvEjectionFraction,
	tddh.TcssListDiagnosisHeartMethodId,
	tddh.ShorteningFraction,
	tddh.SeptalWallThickness,
	tddh.LvPosteriorWallThickness,
	tddh.Comment
FROM dbo.TcssDonorDiagnosisHeart tddh
WHERE
	tddh.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorDiagnosisHeartSelect TO PUBLIC
GO
