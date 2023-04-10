 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorLabProfileSummaryInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorLabProfileSummaryInsert'
		DROP Procedure TcssDonorLabProfileSummaryInsert
	END
GO

PRINT 'Creating Procedure TcssDonorLabProfileSummaryInsert'
GO

CREATE PROCEDURE dbo.TcssDonorLabProfileSummaryInsert
(
	@TcssDonorLabProfileSummaryId int output,
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
**	Name: TcssDonorLabProfileSummaryInsert
**	Desc: Insert Data into table TcssDonorLabProfileSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
**  04/04/2011  jth				added from and to datetime 3 fields
***************************************************************************************************/

INSERT INTO dbo.TcssDonorLabProfileSummary
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	AlcHbalcInitial,
	AlcHbalcPeak,
	AlcHbalcCurrent,
	AlcHbalcInitialFromDate,
	AlcHbalcInitialToDate,
	AlcHbalcPeakFromDate,
	AlcHbalcPeakToDate,
	AlcHbalcCurrentFromDate,
	AlcHbalcCurrentToDate
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@AlcHbalcInitial,
	@AlcHbalcPeak,
	@AlcHbalcCurrent,
	@AlcHbalcInitialFromDate,
	@AlcHbalcInitialToDate,
	@AlcHbalcPeakFromDate,
	@AlcHbalcPeakToDate,
	@AlcHbalcCurrentFromDate,
	@AlcHbalcCurrentToDate
)

-- Return the new identity value
SET @TcssDonorLabProfileSummaryId = @@Identity

GO

GRANT EXEC ON TcssDonorLabProfileSummaryInsert TO PUBLIC
GO
 