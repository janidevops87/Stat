IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisIntestineDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisIntestineDelete'
		DROP Procedure TcssDonorDiagnosisIntestineDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisIntestineDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisIntestineDelete
(
	@TcssDonorDiagnosisIntestineId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisIntestineDelete
**	Desc: Delete Data from table TcssDonorDiagnosisIntestine
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisIntestine
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisIntestineId = @TcssDonorDiagnosisIntestineId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisIntestine
WHERE TcssDonorDiagnosisIntestineId = @TcssDonorDiagnosisIntestineId
GO

GRANT EXEC ON TcssDonorDiagnosisIntestineDelete TO PUBLIC
GO
