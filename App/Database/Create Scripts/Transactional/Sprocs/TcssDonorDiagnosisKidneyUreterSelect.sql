IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyUreterSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyUreterSelect'
		DROP Procedure TcssDonorDiagnosisKidneyUreterSelect
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyUreterSelect'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyUreterSelect
(
	@TcssDonorId int,
	@TcssListKidneyId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyUreterSelect
**	Desc: Update Data in table TcssDonorDiagnosisKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/27/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tddku.TcssDonorDiagnosisKidneyUreterId,
	tddku.LastUpdateStatEmployeeId,
	tddku.LastUpdateDate,
	tddku.TcssDonorId,
	tddku.TcssListKidneyId,
	tddku.TcssListKidneyUreterId,
	tddku.Length,
	tddku.TcssListKidneyUreterTissueQualityId
FROM dbo.TcssDonorDiagnosisKidneyUreter tddku
WHERE
	tddku.TcssDonorId = @TcssDonorId
	AND tddku.TcssListKidneyId = @TcssListKidneyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyUreterSelect TO PUBLIC
GO
