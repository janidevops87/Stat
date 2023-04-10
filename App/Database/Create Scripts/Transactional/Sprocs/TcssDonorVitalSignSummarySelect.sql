 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorVitalSignSummarySelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorVitalSignSummarySelect'
		DROP Procedure TcssDonorVitalSignSummarySelect
	END
GO

PRINT 'Creating Procedure TcssDonorVitalSignSummarySelect'
GO

CREATE PROCEDURE dbo.TcssDonorVitalSignSummarySelect
(
	@TcssDonorId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorVitalSignSummarySelect
**	Desc: Update Data in table TcssDonorVitalSignSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	tdvss.TcssDonorVitalSignSummaryId,
	tdvss.LastUpdateStatEmployeeId,
	tdvss.LastUpdateDate,
	tdvss.TcssDonorId,
	tdvss.Sao2Initial,
	tdvss.Sao2Peak,
	tdvss.Sao2Current,
	tdvss.Sao2InitialFromDate,
	tdvss.Sao2InitialToDate,
	tdvss.Sao2PeakFromDate,
	tdvss.Sao2PeakToDate,
	tdvss.Sao2CurrentFromDate,
	tdvss.Sao2CurrentToDate
FROM dbo.TcssDonorVitalSignSummary tdvss
WHERE
	tdvss.TcssDonorId = @TcssDonorId

GO

GRANT EXEC ON TcssDonorVitalSignSummarySelect TO PUBLIC
GO
