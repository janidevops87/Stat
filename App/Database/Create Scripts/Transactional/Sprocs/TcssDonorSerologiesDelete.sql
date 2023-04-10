IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorSerologiesDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorSerologiesDelete'
		DROP Procedure TcssDonorSerologiesDelete
	END
GO

PRINT 'Creating Procedure TcssDonorSerologiesDelete'
GO

CREATE PROCEDURE dbo.TcssDonorSerologiesDelete
(
	@TcssDonorSerologiesId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorSerologiesDelete
**	Desc: Delete Data from table TcssDonorSerologies
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorSerologies
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorSerologiesId = @TcssDonorSerologiesId

-- Delete The Record
DELETE FROM dbo.TcssDonorSerologies
WHERE TcssDonorSerologiesId = @TcssDonorSerologiesId
GO

GRANT EXEC ON TcssDonorSerologiesDelete TO PUBLIC
GO
