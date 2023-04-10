IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorAbgSummaryDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorAbgSummaryDelete'
		DROP Procedure TcssDonorAbgSummaryDelete
	END
GO

PRINT 'Creating Procedure TcssDonorAbgSummaryDelete'
GO

CREATE PROCEDURE dbo.TcssDonorAbgSummaryDelete
(
	@TcssDonorAbgSummaryId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorAbgSummaryDelete
**	Desc: Delete Data from table TcssDonorAbgSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssDonorAbgSummary
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssDonorAbgSummaryId = @TcssDonorAbgSummaryId

-- Delete The Record
DELETE FROM dbo.TcssDonorAbgSummary
WHERE TcssDonorAbgSummaryId = @TcssDonorAbgSummaryId
GO

GRANT EXEC ON TcssDonorAbgSummaryDelete TO PUBLIC
GO
