IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyBiopsySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyBiopsySelect'
		DROP Procedure TcssDonorDiagnosisKidneyBiopsySelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyBiopsySelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyBiopsySelect
(
	@TcssDonorId int,
	@TcssListKidneyId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyBiopsySelect
**	Desc: Update Data in table TcssDonorDiagnosisKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/28/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddkb.TcssDonorDiagnosisKidneyBiopsyId,
	tddkb.LastUpdateStatEmployeeId,
	tddkb.LastUpdateDate,
	tddkb.TcssDonorId,
	tddkb.TcssListKidneyId,
	tddkb.DateTime,
	tddkb.Flow,
	tddkb.PressureSystolic,
	tddkb.PressureDiastolic,
	tddkb.Resistance
FROM dbo.TcssDonorDiagnosisKidneyBiopsy tddkb
WHERE
	tddkb.TcssDonorId = @TcssDonorId
	AND tddkb.TcssListKidneyId = @TcssListKidneyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyBiopsySelect TO PUBLIC
GO
