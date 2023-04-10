IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorTestInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorTestInsert'
		DROP Procedure TcssDonorTestInsert
	END
GO

PRINT 'Creating Procedure TcssDonorTestInsert'
GO

CREATE PROCEDURE dbo.TcssDonorTestInsert
(
	@TcssDonorTestId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListTestTypeId int = null,
	@TestDateTime smalldatetime = null,
	@Interpretation varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorTestInsert
**	Desc: Insert Data into table TcssDonorTest
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorTest
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	TcssListTestTypeId,
	TestDateTime,
	Interpretation
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@TcssListTestTypeId,
	@TestDateTime,
	@Interpretation
)

-- Return the new identity value
SET @TcssDonorTestId = @@Identity

GO

GRANT EXEC ON TcssDonorTestInsert TO PUBLIC
GO
