IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyBiopsyDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyBiopsyDelete'
		DROP Procedure TcssDonorDiagnosisKidneyBiopsyDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyBiopsyDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyBiopsyDelete
(
	@TcssDonorDiagnosisKidneyBiopsyId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyBiopsyDelete
**	Desc: Delete Data from table TcssDonorDiagnosisKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisKidneyBiopsy
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisKidneyBiopsyId = @TcssDonorDiagnosisKidneyBiopsyId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisKidneyBiopsy
WHERE TcssDonorDiagnosisKidneyBiopsyId = @TcssDonorDiagnosisKidneyBiopsyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyBiopsyDelete TO PUBLIC
GO
