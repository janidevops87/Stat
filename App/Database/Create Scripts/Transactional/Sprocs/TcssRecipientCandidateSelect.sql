IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientCandidateSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientCandidateSelect'
		DROP Procedure TcssRecipientCandidateSelect
	END
GO

PRINT 'Creating Procedure TcssRecipientCandidateSelect'
GO

CREATE PROCEDURE dbo.TcssRecipientCandidateSelect
(
	@TcssRecipientId int = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientCandidateSelect
**	Desc: Update Data in table TcssRecipientCandidate
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	trc.TcssRecipientCandidateId,
	trc.LastUpdateStatEmployeeId,
	trc.LastUpdateDate,
	trc.TcssRecipientId,
	trc.TcssListRefusedByOtherCenterId,
	trc.Why
FROM dbo.TcssRecipientCandidate trc
WHERE
	trc.TcssRecipientId = @TcssRecipientId
GO

GRANT EXEC ON TcssRecipientCandidateSelect TO PUBLIC
GO
