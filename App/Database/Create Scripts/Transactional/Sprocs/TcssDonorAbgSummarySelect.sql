IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorAbgSummarySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorAbgSummarySelect'
		DROP Procedure TcssDonorAbgSummarySelect
	END
GO

PRINT 'Creating Procedure TcssDonorAbgSummarySelect'
GO

CREATE PROCEDURE dbo.TcssDonorAbgSummarySelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorAbgSummarySelect
**	Desc: Update Data in table TcssDonorAbgSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	tda.TcssDonorAbgSummaryId,
	tda.LastUpdateStatEmployeeId,
	tda.LastUpdateDate,
	tda.TcssDonorId,
	tda.HowManyDaysVented
FROM dbo.TcssDonorAbgSummary tda
WHERE
	tda.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorAbgSummarySelect TO PUBLIC
GO
