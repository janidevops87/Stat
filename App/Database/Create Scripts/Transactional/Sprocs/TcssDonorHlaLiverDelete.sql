IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorHlaLiverDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorHlaLiverDelete'
		DROP Procedure TcssDonorHlaLiverDelete
	END
GO

PRINT 'Creating Procedure TcssDonorHlaLiverDelete'
GO

CREATE PROCEDURE dbo.TcssDonorHlaLiverDelete
(
	@TcssDonorHlaLiverId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorHlaLiverDelete
**	Desc: Delete Data from table TcssDonorHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorHlaLiver
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorHlaLiverId = @TcssDonorHlaLiverId

-- Delete The Record
DELETE FROM dbo.TcssDonorHlaLiver
WHERE TcssDonorHlaLiverId = @TcssDonorHlaLiverId
GO

GRANT EXEC ON TcssDonorHlaLiverDelete TO PUBLIC
GO
