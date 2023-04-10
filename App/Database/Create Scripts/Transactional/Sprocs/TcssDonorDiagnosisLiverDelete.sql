IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisLiverDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisLiverDelete'
		DROP Procedure TcssDonorDiagnosisLiverDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisLiverDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisLiverDelete
(
	@TcssDonorDiagnosisLiverId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisLiverDelete
**	Desc: Delete Data from table TcssDonorDiagnosisLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisLiver
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisLiverId = @TcssDonorDiagnosisLiverId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisLiver
WHERE TcssDonorDiagnosisLiverId = @TcssDonorDiagnosisLiverId
GO

GRANT EXEC ON TcssDonorDiagnosisLiverDelete TO PUBLIC
GO
