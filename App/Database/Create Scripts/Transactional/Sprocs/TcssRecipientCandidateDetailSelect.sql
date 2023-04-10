IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientCandidateDetailSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientCandidateDetailSelect'
		DROP Procedure TcssRecipientCandidateDetailSelect
	END
GO

PRINT 'Creating Procedure TcssRecipientCandidateDetailSelect'
GO

CREATE PROCEDURE dbo.TcssRecipientCandidateDetailSelect
(
	@TcssRecipientId int = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientCandidateDetailSelect
**	Desc: Update Data in table TcssRecipientCandidateDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	trcd.TcssRecipientCandidateDetailId,
	trcd.LastUpdateStatEmployeeId,
	trcd.LastUpdateDate,
	trcd.TcssRecipientId,
	trcd.SequenceNumber,
	trcd.CandidateFirstName,
	trcd.CandidateLastName,
	trcd.EvaluatedBy,
	trcd.TcssListOfferStatusId,
	trcd.PrimaryTcssListRefusalReasonId,
	trcd.SecondaryTcssListRefusalReasonId,
	trcd.PrimaryTcssListRefusalReasonComment,
	trcd.SecondaryTcssListRefusalReasonComment,
	trcd.RefusalComment
FROM dbo.TcssRecipientCandidateDetail trcd
WHERE
	trcd.TcssRecipientId = @TcssRecipientId
ORDER BY trcd.SequenceNumber
GO

GRANT EXEC ON TcssRecipientCandidateDetailSelect TO PUBLIC
GO
