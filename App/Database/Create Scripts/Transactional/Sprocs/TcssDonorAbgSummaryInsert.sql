IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorAbgSummaryInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorAbgSummaryInsert'
		DROP Procedure TcssDonorAbgSummaryInsert
	END
GO

PRINT 'Creating Procedure TcssDonorAbgSummaryInsert'
GO

CREATE PROCEDURE dbo.TcssDonorAbgSummaryInsert
(
	@TcssDonorAbgSummaryId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@HowManyDaysVented int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorAbgSummaryInsert
**	Desc: Insert Data into table TcssDonorAbgSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorAbgSummary
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	HowManyDaysVented
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@HowManyDaysVented
)

-- Return the new identity value
SET @TcssDonorAbgSummaryId = @@Identity

GO

GRANT EXEC ON TcssDonorAbgSummaryInsert TO PUBLIC
GO
