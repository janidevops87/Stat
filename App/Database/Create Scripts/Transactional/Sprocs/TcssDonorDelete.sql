IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDelete'
		DROP Procedure TcssDonorDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDelete
(
	@TcssDonorId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDelete
**	Desc: Delete Data from table TcssDonor
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonor
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorId = @TcssDonorId

-- Delete The Record
DELETE FROM dbo.TcssDonor
WHERE TcssDonorId = @TcssDonorId
GO

GRANT EXEC ON TcssDonorDelete TO PUBLIC
GO
