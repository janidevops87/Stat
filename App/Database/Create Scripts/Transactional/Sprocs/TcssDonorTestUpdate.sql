IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorTestUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorTestUpdate'
		DROP Procedure TcssDonorTestUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorTestUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorTestUpdate
(
	@TcssDonorTestId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@TcssListTestTypeId int = null,
	@TestDateTime smalldatetime = null,
	@Interpretation varchar(5000) = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorTestUpdate
**	Desc: Update Data in table TcssDonorTest
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorTest
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	TcssListTestTypeId = @TcssListTestTypeId,
	TestDateTime = @TestDateTime,
	Interpretation = @Interpretation
WHERE
	TcssDonorTestId = @TcssDonorTestId
GO

GRANT EXEC ON TcssDonorTestUpdate TO PUBLIC
GO
