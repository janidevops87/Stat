IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisHeartDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisHeartDelete'
		DROP Procedure TcssDonorDiagnosisHeartDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisHeartDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisHeartDelete
(
	@TcssDonorDiagnosisHeartId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisHeartDelete
**	Desc: Delete Data from table TcssDonorDiagnosisHeart
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisHeart
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisHeartId = @TcssDonorDiagnosisHeartId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisHeart
WHERE TcssDonorDiagnosisHeartId = @TcssDonorDiagnosisHeartId
GO

GRANT EXEC ON TcssDonorDiagnosisHeartDelete TO PUBLIC
GO
