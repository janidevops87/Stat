IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisOtherDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisOtherDelete'
		DROP Procedure TcssDonorDiagnosisOtherDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisOtherDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisOtherDelete
(
	@TcssDonorDiagnosisOtherId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisOtherDelete
**	Desc: Delete Data from table TcssDonorDiagnosisOther
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisOther
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisOtherId = @TcssDonorDiagnosisOtherId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisOther
WHERE TcssDonorDiagnosisOtherId = @TcssDonorDiagnosisOtherId
GO

GRANT EXEC ON TcssDonorDiagnosisOtherDelete TO PUBLIC
GO
