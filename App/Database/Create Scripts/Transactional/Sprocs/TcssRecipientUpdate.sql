IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientUpdate'
		DROP Procedure TcssRecipientUpdate
	END
GO

PRINT 'Creating Procedure TcssRecipientUpdate'
GO

CREATE PROCEDURE dbo.TcssRecipientUpdate
(
	@TcssRecipientId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientUpdate
**	Desc: Update Data in table TcssRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssRecipient
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate())
WHERE
	TcssRecipientId = @TcssRecipientId
GO

GRANT EXEC ON TcssRecipientUpdate TO PUBLIC
GO
