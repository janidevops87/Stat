IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientSelect'
		DROP Procedure TcssRecipientSelect
	END
GO

PRINT 'Creating Procedure TcssRecipientSelect'
GO

CREATE PROCEDURE dbo.TcssRecipientSelect
(
	@TcssRecipientId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientSelect
**	Desc: Update Data in table TcssRecipient
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
	tr.TcssRecipientId,
	tr.LastUpdateStatEmployeeId,
	tr.LastUpdateDate
FROM dbo.TcssRecipient tr
WHERE
	tr.TcssRecipientId = @TcssRecipientId
GO

GRANT EXEC ON TcssRecipientSelect TO PUBLIC
GO
