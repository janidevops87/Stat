IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileDetailDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileDetailDelete'
		DROP Procedure TcssDonorLabProfileDetailDelete
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileDetailDelete'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileDetailDelete
(
	@TcssDonorLabProfileDetailId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileDetailDelete
**	Desc: Delete Data from table TcssDonorLabProfileDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorLabProfileDetail
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorLabProfileDetailId = @TcssDonorLabProfileDetailId

-- Delete The Record
DELETE FROM dbo.TcssDonorLabProfileDetail
WHERE TcssDonorLabProfileDetailId = @TcssDonorLabProfileDetailId
GO

GRANT EXEC ON TcssDonorLabProfileDetailDelete TO PUBLIC
GO
