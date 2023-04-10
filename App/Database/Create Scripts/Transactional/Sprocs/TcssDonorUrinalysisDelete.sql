IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorUrinalysisDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorUrinalysisDelete'
		DROP Procedure TcssDonorUrinalysisDelete
	END
GO

PRINT 'Creating Procedure TcssDonorUrinalysisDelete'
GO

CREATE PROCEDURE dbo.TcssDonorUrinalysisDelete
(
	@TcssDonorUrinalysisId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorUrinalysisDelete
**	Desc: Delete Data from table TcssDonorUrinalysis
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorUrinalysis
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorUrinalysisId = @TcssDonorUrinalysisId

-- Delete The Record
DELETE FROM dbo.TcssDonorUrinalysis
WHERE TcssDonorUrinalysisId = @TcssDonorUrinalysisId
GO

GRANT EXEC ON TcssDonorUrinalysisDelete TO PUBLIC
GO
