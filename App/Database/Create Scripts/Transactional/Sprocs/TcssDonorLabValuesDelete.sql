IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabValuesDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabValuesDelete'
		DROP Procedure TcssDonorLabValuesDelete
	END
GO

PRINT 'Creating Procedure TcssDonorLabValuesDelete'
GO

CREATE PROCEDURE dbo.TcssDonorLabValuesDelete
(
	@TcssDonorLabValuesId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabValuesDelete
**	Desc: Delete Data from table TcssDonorLabValues
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorLabValues
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorLabValuesId = @TcssDonorLabValuesId

-- Delete The Record
DELETE FROM dbo.TcssDonorLabValues
WHERE TcssDonorLabValuesId = @TcssDonorLabValuesId
GO

GRANT EXEC ON TcssDonorLabValuesDelete TO PUBLIC
GO
