IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorAbgDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorAbgDelete'
		DROP Procedure TcssDonorAbgDelete
	END
GO

PRINT 'Creating Procedure TcssDonorAbgDelete'
GO

CREATE PROCEDURE dbo.TcssDonorAbgDelete
(
	@TcssDonorAbgId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorAbgDelete
**	Desc: Delete Data from table TcssDonorAbg
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorAbg
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorAbgId = @TcssDonorAbgId

-- Delete The Record
DELETE FROM dbo.TcssDonorAbg
WHERE TcssDonorAbgId = @TcssDonorAbgId
GO

GRANT EXEC ON TcssDonorAbgDelete TO PUBLIC
GO
