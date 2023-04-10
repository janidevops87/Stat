IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorSerologiesInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorSerologiesInsert'
		DROP Procedure TcssDonorSerologiesInsert
	END
GO

PRINT 'Creating Procedure TcssDonorSerologiesInsert'
GO

CREATE PROCEDURE dbo.TcssDonorSerologiesInsert
(
	@TcssDonorSerologiesId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListSerologyQuestionId int = null,
	@TcssListSerologyAnswerId int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorSerologiesInsert
**	Desc: Insert Data into table TcssDonorSerologies
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorSerologies
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListSerologyQuestionId,
	TcssListSerologyAnswerId
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListSerologyQuestionId,
	@TcssListSerologyAnswerId
)

-- Return the new identity value
SET @TcssDonorSerologiesId = @@Identity

GO

GRANT EXEC ON TcssDonorSerologiesInsert TO PUBLIC
GO
