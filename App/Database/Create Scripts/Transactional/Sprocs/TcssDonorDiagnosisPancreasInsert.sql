IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorDiagnosisPancreasInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorDiagnosisPancreasInsert'
		DROP Procedure TcssDonorDiagnosisPancreasInsert
	END
GO

PRINT 'Creating Procedure TcssDonorDiagnosisPancreasInsert'
GO

CREATE PROCEDURE dbo.TcssDonorDiagnosisPancreasInsert
(
	@TcssDonorDiagnosisPancreasId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@Comment varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorDiagnosisPancreasInsert
**	Desc: Insert Data into table TcssDonorDiagnosisPancreas
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorDiagnosisPancreas
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	Comment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@Comment
)

-- Return the new identity value
SET @TcssDonorDiagnosisPancreasId = @@Identity

GO

GRANT EXEC ON TcssDonorDiagnosisPancreasInsert TO PUBLIC
GO
