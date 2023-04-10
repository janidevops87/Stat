IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabDelete'
		DROP Procedure TcssDonorLabDelete
	END
GO

PRINT 'Creating Procedure TcssDonorLabDelete'
GO

CREATE PROCEDURE dbo.TcssDonorLabDelete
(
	@TcssDonorLabId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabDelete
**	Desc: Delete Data from table TcssDonorLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorLab
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorLabId = @TcssDonorLabId

-- Delete The Record
DELETE FROM dbo.TcssDonorLab
WHERE TcssDonorLabId = @TcssDonorLabId
GO

GRANT EXEC ON TcssDonorLabDelete TO PUBLIC
GO
