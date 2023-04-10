IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorFluidBloodDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorFluidBloodDelete'
		DROP Procedure TcssDonorFluidBloodDelete
	END
GO

PRINT 'Creating Procedure TcssDonorFluidBloodDelete'
GO

CREATE PROCEDURE dbo.TcssDonorFluidBloodDelete
(
	@TcssDonorFluidBloodId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorFluidBloodDelete
**	Desc: Delete Data from table TcssDonorFluidBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorFluidBlood
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorFluidBloodId = @TcssDonorFluidBloodId

-- Delete The Record
DELETE FROM dbo.TcssDonorFluidBlood
WHERE TcssDonorFluidBloodId = @TcssDonorFluidBloodId
GO

GRANT EXEC ON TcssDonorFluidBloodDelete TO PUBLIC
GO
