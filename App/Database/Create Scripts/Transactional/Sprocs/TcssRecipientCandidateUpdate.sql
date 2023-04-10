IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientCandidateUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientCandidateUpdate'
		DROP Procedure TcssRecipientCandidateUpdate
	END
GO

PRINT 'Creating Procedure TcssRecipientCandidateUpdate'
GO

CREATE PROCEDURE dbo.TcssRecipientCandidateUpdate
(
	@TcssRecipientCandidateId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssRecipientId int,
	@TcssListRefusedByOtherCenterId int,
	@Why varchar(100) = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientCandidateUpdate
**	Desc: Update Data in table TcssRecipientCandidate
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssRecipientCandidate
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssRecipientId = @TcssRecipientId,
	TcssListRefusedByOtherCenterId = @TcssListRefusedByOtherCenterId,
	Why = @Why
WHERE
	TcssRecipientCandidateId = @TcssRecipientCandidateId
GO

GRANT EXEC ON TcssRecipientCandidateUpdate TO PUBLIC
GO
