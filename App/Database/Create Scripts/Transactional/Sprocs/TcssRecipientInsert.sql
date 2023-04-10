IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientInsert'
		DROP Procedure TcssRecipientInsert
	END
GO

PRINT 'Creating Procedure TcssRecipientInsert'
GO

CREATE PROCEDURE dbo.TcssRecipientInsert
(
	@TcssRecipientId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientInsert
**	Desc: Insert Data into table TcssRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssRecipient
(
	LastUpdateStatEmployeeId,
	LastUpdateDate
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate())
)

-- Return the new identity value
SET @TcssRecipientId = @@Identity

GO

GRANT EXEC ON TcssRecipientInsert TO PUBLIC
GO
