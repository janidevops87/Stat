IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientCandidateDetailInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientCandidateDetailInsert'
		DROP Procedure TcssRecipientCandidateDetailInsert
	END
GO

PRINT 'Creating Procedure TcssRecipientCandidateDetailInsert'
GO

CREATE PROCEDURE dbo.TcssRecipientCandidateDetailInsert
(
	@TcssRecipientCandidateDetailId int output,
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
**	Name: TcssRecipientCandidateDetailInsert
**	Desc: Insert Data into table TcssRecipientCandidateDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssRecipientCandidateDetail
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssRecipientId,
	SequenceNumber,
	CandidateFirstName,
	CandidateLastName,
	EvaluatedBy,
	TcssListOfferStatusId,
	PrimaryTcssListRefusalReasonId,
	SecondaryTcssListRefusalReasonId,
	PrimaryTcssListRefusalReasonComment,
	SecondaryTcssListRefusalReasonComment,
	RefusalComment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssRecipientId,
	@SequenceNumber,
	@CandidateFirstName,
	@CandidateLastName,
	@EvaluatedBy,
	@TcssListOfferStatusId,
	@PrimaryTcssListRefusalReasonId,
	@SecondaryTcssListRefusalReasonId,
	@PrimaryTcssListRefusalReasonComment,
	@SecondaryTcssListRefusalReasonComment,
	@RefusalComment
)

-- Return the new identity value
SET @TcssRecipientCandidateDetailId = @@Identity

GO

GRANT EXEC ON TcssRecipientCandidateDetailInsert TO PUBLIC
GO
