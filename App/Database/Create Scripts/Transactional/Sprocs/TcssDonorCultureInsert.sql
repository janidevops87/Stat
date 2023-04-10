IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorCultureInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorCultureInsert'
		DROP Procedure TcssDonorCultureInsert
	END
GO

PRINT 'Creating Procedure TcssDonorCultureInsert'
GO

CREATE PROCEDURE dbo.TcssDonorCultureInsert
(
	@TcssDonorCultureId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@SampleDateTime smalldatetime = null,
	@TcssListCultureTypeId int = null,
	@TcssListCultureResultId int = null,
	@Comment varchar(2500) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorCultureInsert
**	Desc: Insert Data into table TcssDonorCulture
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorCulture
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	SampleDateTime,
	TcssListCultureTypeId,
	TcssListCultureResultId,
	Comment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@SampleDateTime,
	@TcssListCultureTypeId,
	@TcssListCultureResultId,
	@Comment
)

-- Return the new identity value
SET @TcssDonorCultureId = @@Identity

GO

GRANT EXEC ON TcssDonorCultureInsert TO PUBLIC
GO
