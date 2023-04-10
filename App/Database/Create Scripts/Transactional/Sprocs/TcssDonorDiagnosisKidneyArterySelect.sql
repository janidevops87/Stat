IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyArterySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyArterySelect'
		DROP Procedure TcssDonorDiagnosisKidneyArterySelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyArterySelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyArterySelect
(
	@TcssDonorId int,
	@TcssListKidneyId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyArterySelect
**	Desc: Update Data in table TcssDonorDiagnosisKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddka.TcssDonorDiagnosisKidneyArteryId,
	tddka.LastUpdateStatEmployeeId,
	tddka.LastUpdateDate,
	tddka.TcssDonorId,
	tddka.TcssListKidneyId,
	tddka.TcssListKidneyArteryId,
	tddka.Length,
	tddka.Diameter,
	tddka.Distance,
	tddka.ArteriesOnCommonCuff
FROM dbo.TcssDonorDiagnosisKidneyArtery tddka
WHERE
	tddka.TcssDonorId = @TcssDonorId
	AND tddka.TcssListKidneyId = @TcssListKidneyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyArterySelect TO PUBLIC
GO
