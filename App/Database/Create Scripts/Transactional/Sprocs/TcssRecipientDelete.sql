IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientDelete'
		DROP Procedure TcssRecipientDelete
	END
GO

PRINT 'Creating Procedure TcssRecipientDelete'
GO

CREATE PROCEDURE dbo.TcssRecipientDelete
(
	@TcssRecipientId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientDelete
**	Desc: Delete Data from table TcssRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssRecipient
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssRecipientId = @TcssRecipientId

-- Delete The Record
DELETE FROM dbo.TcssRecipient
WHERE TcssRecipientId = @TcssRecipientId
GO

GRANT EXEC ON TcssRecipientDelete TO PUBLIC
GO
