 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileSummarySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileSummarySelect'
		DROP Procedure TcssDonorLabProfileSummarySelect
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileSummarySelect'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileSummarySelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileSummarySelect
**	Desc: Update Data in table TcssDonorLabProfileSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
**  04/04/2011  jth				added from and to datetime 3 fields
***************************************************************************************************/

SELECT 
	tdvss.TcssDonorLabProfileSummaryId,
	tdvss.LastUpdateStatEmployeeId,
	tdvss.LastUpdateDate,
	tdvss.TcssDonorId,
	tdvss.AlcHbalcInitial,
	tdvss.AlcHbalcPeak,
	tdvss.AlcHbalcCurrent,
	tdvss.AlcHbalcInitialFromDate,
	tdvss.AlcHbalcInitialToDate,
	tdvss.AlcHbalcPeakFromDate,
	tdvss.AlcHbalcPeakToDate,
	tdvss.AlcHbalcCurrentFromDate,
	tdvss.AlcHbalcCurrentToDate
FROM dbo.TcssDonorLabProfileSummary tdvss
WHERE
	tdvss.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorLabProfileSummarySelect TO PUBLIC
GO
 