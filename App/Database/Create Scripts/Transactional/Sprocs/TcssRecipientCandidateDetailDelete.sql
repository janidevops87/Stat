IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientCandidateDetailDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientCandidateDetailDelete'
		DROP Procedure TcssRecipientCandidateDetailDelete
	END
GO

PRINT 'Creating Procedure TcssRecipientCandidateDetailDelete'
GO

CREATE PROCEDURE dbo.TcssRecipientCandidateDetailDelete
(
	@TcssRecipientCandidateDetailId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientCandidateDetailDelete
**	Desc: Delete Data from table TcssRecipientCandidateDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssRecipientCandidateDetail
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssRecipientCandidateDetailId = @TcssRecipientCandidateDetailId

-- Delete The Record
DELETE FROM dbo.TcssRecipientCandidateDetail
WHERE TcssRecipientCandidateDetailId = @TcssRecipientCandidateDetailId
GO

GRANT EXEC ON TcssRecipientCandidateDetailDelete TO PUBLIC
GO
