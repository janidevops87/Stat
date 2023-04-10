IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisPancreasUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisPancreasUpdate'
		DROP Procedure TcssDonorDiagnosisPancreasUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisPancreasUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisPancreasUpdate
(
	@TcssDonorDiagnosisPancreasId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisPancreasUpdate
**	Desc: Update Data in table TcssDonorDiagnosisPancreas
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorDiagnosisPancreas
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	Comment = @Comment
WHERE
	TcssDonorDiagnosisPancreasId = @TcssDonorDiagnosisPancreasId
GO

GRANT EXEC ON TcssDonorDiagnosisPancreasUpdate TO PUBLIC
GO
