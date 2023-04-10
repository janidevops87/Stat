IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientCandidateDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientCandidateDelete'
		DROP Procedure TcssRecipientCandidateDelete
	END
GO

PRINT 'Creating Procedure TcssRecipientCandidateDelete'
GO

CREATE PROCEDURE dbo.TcssRecipientCandidateDelete
(
	@TcssRecipientCandidateId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientCandidateDelete
**	Desc: Delete Data from table TcssRecipientCandidate
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssRecipientCandidate
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssRecipientCandidateId = @TcssRecipientCandidateId

-- Delete The Record
DELETE FROM dbo.TcssRecipientCandidate
WHERE TcssRecipientCandidateId = @TcssRecipientCandidateId
GO

GRANT EXEC ON TcssRecipientCandidateDelete TO PUBLIC
GO
