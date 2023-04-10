IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignSummaryUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignSummaryUpdate'
		DROP Procedure TcssDonorVitalSignSummaryUpdate
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignSummaryUpdate'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignSummaryUpdate
(
	@TcssDonorVitalSignSummaryId int,
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
**	Name: TcssDonorVitalSignSummaryUpdate
**	Desc: Update Data in table TcssDonorVitalSignSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssDonorVitalSignSummary
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssDonorId = @TcssDonorId,
	Sao2Initial = @Sao2Initial,
	Sao2Peak = @Sao2Peak,
	Sao2Current = @Sao2Current,
	Sao2InitialFromDate=@Sao2InitialFromDate,
	Sao2InitialToDate=@Sao2InitialToDate ,
	Sao2PeakFromDate=@Sao2PeakFromDate ,
	Sao2PeakToDate=@Sao2PeakToDate ,
	Sao2CurrentFromDate=@Sao2CurrentFromDate ,
	Sao2CurrentToDate=@Sao2CurrentToDate 
WHERE
	TcssDonorVitalSignSummaryId = @TcssDonorVitalSignSummaryId
GO

GRANT EXEC ON TcssDonorVitalSignSummaryUpdate TO PUBLIC
GO
 