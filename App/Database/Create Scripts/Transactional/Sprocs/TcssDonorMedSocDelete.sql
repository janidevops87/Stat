IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorMedSocDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorMedSocDelete'
		DROP Procedure TcssDonorMedSocDelete
	END
GO

PRINT 'Creating Procedure TcssDonorMedSocDelete'
GO

CREATE PROCEDURE dbo.TcssDonorMedSocDelete
(
	@TcssDonorMedSocId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorMedSocDelete
**	Desc: Delete Data from table TcssDonorMedSoc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorMedSoc
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorMedSocId = @TcssDonorMedSocId

-- Delete The Record
DELETE FROM dbo.TcssDonorMedSoc
WHERE TcssDonorMedSocId = @TcssDonorMedSocId
GO

GRANT EXEC ON TcssDonorMedSocDelete TO PUBLIC
GO
