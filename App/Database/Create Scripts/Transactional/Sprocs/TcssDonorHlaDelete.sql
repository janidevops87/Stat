IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorHlaDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorHlaDelete'
		DROP Procedure TcssDonorHlaDelete
	END
GO

PRINT 'Creating Procedure TcssDonorHlaDelete'
GO

CREATE PROCEDURE dbo.TcssDonorHlaDelete
(
	@TcssDonorHlaId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorHlaDelete
**	Desc: Delete Data from table TcssDonorHla
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorHla
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorHlaId = @TcssDonorHlaId

-- Delete The Record
DELETE FROM dbo.TcssDonorHla
WHERE TcssDonorHlaId = @TcssDonorHlaId
GO

GRANT EXEC ON TcssDonorHlaDelete TO PUBLIC
GO
