IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientCandidateDetailUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientCandidateDetailUpdate'
		DROP Procedure TcssRecipientCandidateDetailUpdate
	END
GO

PRINT 'Creating Procedure TcssRecipientCandidateDetailUpdate'
GO

CREATE PROCEDURE dbo.TcssRecipientCandidateDetailUpdate
(
	@TcssRecipientCandidateDetailId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssRecipientId int,
	@SequenceNumber int = null,
	@CandidateFirstName varchar(50) = null,
	@CandidateLastName varchar(50) = null,
	@EvaluatedBy varchar(50) = null,
	@TcssListOfferStatusId int = null,
	@PrimaryTcssListRefusalReasonId int = null,
	@SecondaryTcssListRefusalReasonId int = null,
	@PrimaryTcssListRefusalReasonComment varchar(100) = null,
	@SecondaryTcssListRefusalReasonComment varchar(100) = null,
	@RefusalComment varchar(250) = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientCandidateDetailUpdate
**	Desc: Update Data in table TcssRecipientCandidateDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssRecipientCandidateDetail
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssRecipientId = @TcssRecipientId,
	SequenceNumber = @SequenceNumber,
	CandidateFirstName = @CandidateFirstName,
	CandidateLastName = @CandidateLastName,
	EvaluatedBy = @EvaluatedBy,
	TcssListOfferStatusId = @TcssListOfferStatusId,
	PrimaryTcssListRefusalReasonId = @PrimaryTcssListRefusalReasonId,
	SecondaryTcssListRefusalReasonId = @SecondaryTcssListRefusalReasonId,
	PrimaryTcssListRefusalReasonComment = @PrimaryTcssListRefusalReasonComment,
	SecondaryTcssListRefusalReasonComment = @SecondaryTcssListRefusalReasonComment,
	RefusalComment = @RefusalComment
WHERE
	TcssRecipientCandidateDetailId = @TcssRecipientCandidateDetailId
GO

GRANT EXEC ON TcssRecipientCandidateDetailUpdate TO PUBLIC
GO
