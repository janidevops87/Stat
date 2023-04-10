IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileDelete'
		DROP Procedure TcssDonorLabProfileDelete
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileDelete'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileDelete
(
	@TcssDonorLabProfileId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileDelete
**	Desc: Delete Data from table TcssDonorLabProfile
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

---- We need to delete the child tables 
---- Flag the User and time the record is being delete
--UPDATE dbo.TcssDonorLabProfileDetail
--SET
--	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
--	LastUpdateDate = GetUtcDate()
--WHERE TcssDonorLabProfileId = @TcssDonorLabProfileId

---- Delete The Record
--DELETE FROM dbo.TcssDonorLabProfileDetail
--WHERE TcssDonorLabProfileId = @TcssDonorLabProfileId

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorLabProfile
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorLabProfileId = @TcssDonorLabProfileId

-- Delete The Record
DELETE FROM dbo.TcssDonorLabProfile
WHERE TcssDonorLabProfileId = @TcssDonorLabProfileId
GO

GRANT EXEC ON TcssDonorLabProfileDelete TO PUBLIC
GO
