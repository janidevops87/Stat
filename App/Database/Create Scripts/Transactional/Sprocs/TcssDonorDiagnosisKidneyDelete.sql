IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisKidneyDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisKidneyDelete'
		DROP Procedure TcssDonorDiagnosisKidneyDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisKidneyDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisKidneyDelete
(
	@TcssDonorDiagnosisKidneyId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyDelete
**	Desc: Delete Data from table TcssDonorDiagnosisKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisKidney
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisKidneyId = @TcssDonorDiagnosisKidneyId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisKidney
WHERE TcssDonorDiagnosisKidneyId = @TcssDonorDiagnosisKidneyId
GO

GRANT EXEC ON TcssDonorDiagnosisKidneyDelete TO PUBLIC
GO
