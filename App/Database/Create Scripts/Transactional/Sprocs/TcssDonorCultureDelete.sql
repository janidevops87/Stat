IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorCultureDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorCultureDelete'
		DROP Procedure TcssDonorCultureDelete
	END
GO

PRINT 'Creating Procedure TcssDonorCultureDelete'
GO

CREATE PROCEDURE dbo.TcssDonorCultureDelete
(
	@TcssDonorCultureId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorCultureDelete
**	Desc: Delete Data from table TcssDonorCulture
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorCulture
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorCultureId = @TcssDonorCultureId

-- Delete The Record
DELETE FROM dbo.TcssDonorCulture
WHERE TcssDonorCultureId = @TcssDonorCultureId
GO

GRANT EXEC ON TcssDonorCultureDelete TO PUBLIC
GO
