IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorTestDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorTestDelete'
		DROP Procedure TcssDonorTestDelete
	END
GO

PRINT 'Creating Procedure TcssDonorTestDelete'
GO

CREATE PROCEDURE dbo.TcssDonorTestDelete
(
	@TcssDonorTestId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorTestDelete
**	Desc: Delete Data from table TcssDonorTest
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorTest
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorTestId = @TcssDonorTestId

-- Delete The Record
DELETE FROM dbo.TcssDonorTest
WHERE TcssDonorTestId = @TcssDonorTestId
GO

GRANT EXEC ON TcssDonorTestDelete TO PUBLIC
GO
