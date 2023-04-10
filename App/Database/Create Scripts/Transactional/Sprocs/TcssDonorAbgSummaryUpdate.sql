IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorAbgSummaryUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorAbgSummaryUpdate'
		DROP Procedure TcssDonorAbgSummaryUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorAbgSummaryUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorAbgSummaryUpdate
(
	@TcssDonorAbgSummaryId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@HowManyDaysVented int = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorAbgSummaryUpdate
**	Desc: Update Data in table TcssDonorAbgSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorAbgSummary
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	HowManyDaysVented = @HowManyDaysVented
WHERE
	TcssDonorAbgSummaryId = @TcssDonorAbgSummaryId
GO

GRANT EXEC ON TcssDonorAbgSummaryUpdate TO PUBLIC
GO
