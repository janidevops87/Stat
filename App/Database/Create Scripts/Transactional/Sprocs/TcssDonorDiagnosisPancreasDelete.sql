IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisPancreasDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisPancreasDelete'
		DROP Procedure TcssDonorDiagnosisPancreasDelete
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisPancreasDelete'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisPancreasDelete
(
	@TcssDonorDiagnosisPancreasId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisPancreasDelete
**	Desc: Delete Data from table TcssDonorDiagnosisPancreas
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorDiagnosisPancreas
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorDiagnosisPancreasId = @TcssDonorDiagnosisPancreasId

-- Delete The Record
DELETE FROM dbo.TcssDonorDiagnosisPancreas
WHERE TcssDonorDiagnosisPancreasId = @TcssDonorDiagnosisPancreasId
GO

GRANT EXEC ON TcssDonorDiagnosisPancreasDelete TO PUBLIC
GO
