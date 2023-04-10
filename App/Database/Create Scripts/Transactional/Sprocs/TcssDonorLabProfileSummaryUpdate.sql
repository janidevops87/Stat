 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileSummaryUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileSummaryUpdate'
		DROP Procedure TcssDonorLabProfileSummaryUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileSummaryUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileSummaryUpdate
(
	@TcssDonorLabProfileSummaryId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@AlcHbalcInitial varchar(50) = null,
	@AlcHbalcPeak varchar(50) = null,
	@AlcHbalcCurrent varchar(50) = null,
	@AlcHbalcInitialFromDate datetime = null,
	@AlcHbalcInitialToDate datetime = null,
	@AlcHbalcPeakFromDate datetime = null,
	@AlcHbalcPeakToDate datetime = null,
	@AlcHbalcCurrentFromDate datetime = null,
	@AlcHbalcCurrentToDate datetime = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorLabProfileSummaryUpdate
**	Desc: Update Data in table TcssDonorLabProfileSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
**  04/04/2011  jth				added from and to datetime 3 fields
***************************************************************************************************/

UPDATE dbo.TcssDonorLabProfileSummary
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	AlcHbalcInitial = @AlcHbalcInitial,
	AlcHbalcPeak = @AlcHbalcPeak,
	AlcHbalcCurrent = @AlcHbalcCurrent,
	AlcHbalcInitialFromDate=@AlcHbalcInitialFromDate,
	AlcHbalcInitialToDate=@AlcHbalcInitialToDate ,
	AlcHbalcPeakFromDate=@AlcHbalcPeakFromDate ,
	AlcHbalcPeakToDate=@AlcHbalcPeakToDate ,
	AlcHbalcCurrentFromDate=@AlcHbalcCurrentFromDate ,
	AlcHbalcCurrentToDate=@AlcHbalcCurrentToDate 
WHERE
	TcssDonorLabProfileSummaryId = @TcssDonorLabProfileSummaryId
GO

GRANT EXEC ON TcssDonorLabProfileSummaryUpdate TO PUBLIC
GO
 