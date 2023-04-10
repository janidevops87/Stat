IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientCandidateInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientCandidateInsert'
		DROP Procedure TcssRecipientCandidateInsert
	END
GO

PRINT 'Creating Procedure TcssRecipientCandidateInsert'
GO

CREATE PROCEDURE dbo.TcssRecipientCandidateInsert
(
	@TcssRecipientCandidateId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssRecipientId int,
	@TcssListRefusedByOtherCenterId int,
	@Why varchar(100) = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientCandidateInsert
**	Desc: Insert Data into table TcssRecipientCandidate
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssRecipientCandidate
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssRecipientId,
	TcssListRefusedByOtherCenterId,
	Why
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssRecipientId,
	@TcssListRefusedByOtherCenterId,
	@Why
)

-- Return the new identity value
SET @TcssRecipientCandidateId = @@Identity

GO

GRANT EXEC ON TcssRecipientCandidateInsert TO PUBLIC
GO
