IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisLungDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisLungDelete'
		DROP Procedure TcssDonorDiagnosisLungDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisLungDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisLungDelete
(
	@TcssDonorDiagnosisLungId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisLungDelete
**	Desc: Delete Data from table TcssDonorDiagnosisLung
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisLung
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisLungId = @TcssDonorDiagnosisLungId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisLung
WHERE TcssDonorDiagnosisLungId = @TcssDonorDiagnosisLungId
GO

GRANT EXEC ON TcssDonorDiagnosisLungDelete TO PUBLIC
GO
