IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorCompleteBloodCountDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorCompleteBloodCountDelete'
		DROP Procedure TcssDonorCompleteBloodCountDelete
	END
GO

PRINT 'Creating Procedure TcssDonorCompleteBloodCountDelete'
GO

CREATE PROCEDURE dbo.TcssDonorCompleteBloodCountDelete
(
	@TcssDonorCompleteBloodCountId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorCompleteBloodCountDelete
**	Desc: Delete Data from table TcssDonorCompleteBloodCount
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorCompleteBloodCount
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorCompleteBloodCountId = @TcssDonorCompleteBloodCountId

-- Delete The Record
DELETE FROM dbo.TcssDonorCompleteBloodCount
WHERE TcssDonorCompleteBloodCountId = @TcssDonorCompleteBloodCountId
GO

GRANT EXEC ON TcssDonorCompleteBloodCountDelete TO PUBLIC
GO
