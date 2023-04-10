IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignSummaryInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignSummaryInsert'
		DROP Procedure TcssDonorVitalSignSummaryInsert
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignSummaryInsert'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignSummaryInsert
(
	@TcssDonorVitalSignSummaryId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssDonorId int,
	@Sao2Initial varchar(50) = null,
	@Sao2Peak varchar(50) = null,
	@Sao2Current varchar(50) = null,
	@Sao2InitialFromDate datetime = null,
	@Sao2InitialToDate datetime = null,
	@Sao2PeakFromDate datetime = null,
	@Sao2PeakToDate datetime = null,
	@Sao2CurrentFromDate datetime = null,
	@Sao2CurrentToDate datetime = null
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignSummaryInsert
**	Desc: Insert Data into table TcssDonorVitalSignSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssDonorVitalSignSummary
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssDonorId,
	Sao2Initial,
	Sao2Peak,
	Sao2Current,
	Sao2InitialFromDate,
	Sao2InitialToDate,
	Sao2PeakFromDate,
	Sao2PeakToDate,
	Sao2CurrentFromDate,
	Sao2CurrentToDate
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssDonorId,
	@Sao2Initial,
	@Sao2Peak,
	@Sao2Current,
	@Sao2InitialFromDate,
	@Sao2InitialToDate,
	@Sao2PeakFromDate,
	@Sao2PeakToDate,
	@Sao2CurrentFromDate,
	@Sao2CurrentToDate
)

-- Return the new identity value
SET @TcssDonorVitalSignSummaryId = @@Identity

GO

GRANT EXEC ON TcssDonorVitalSignSummaryInsert TO PUBLIC
GO
 