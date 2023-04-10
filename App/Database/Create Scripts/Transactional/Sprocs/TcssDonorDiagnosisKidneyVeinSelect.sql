IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyVeinSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyVeinSelect'
		DROP Procedure TcssDonorDiagnosisKidneyVeinSelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyVeinSelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyVeinSelect
(
	@TcssDonorId int,
	@TcssListKidneyId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyVeinSelect
**	Desc: Update Data in table TcssDonorDiagnosisKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddkv.TcssDonorDiagnosisKidneyVeinId,
	tddkv.LastUpdateStatEmployeeId,
	tddkv.LastUpdateDate,
	tddkv.TcssDonorId,
	tddkv.TcssListKidneyId,
	tddkv.TcssListKidneyVeinId,
	tddkv.Length,
	tddkv.Diameter,
	tddkv.Distance,
	tddkv.VeinsOnVenaCava
FROM dbo.TcssDonorDiagnosisKidneyVein tddkv
WHERE
	tddkv.TcssDonorId = @TcssDonorId
	AND tddkv.TcssListKidneyId = @TcssListKidneyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyVeinSelect TO PUBLIC
GO
