IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientContactInformationDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientContactInformationDelete'
		DROP Procedure TcssRecipientContactInformationDelete
	END
GO

PRINT 'Creating Procedure TcssRecipientContactInformationDelete'
GO

CREATE PROCEDURE dbo.TcssRecipientContactInformationDelete
(
	@TcssRecipientContactInformationId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientContactInformationDelete
**	Desc: Delete Data from table TcssRecipientContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/16/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssRecipientContactInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssRecipientContactInformationId = @TcssRecipientContactInformationId

-- Delete The Record
DELETE FROM dbo.TcssRecipientContactInformation
WHERE TcssRecipientContactInformationId = @TcssRecipientContactInformationId
GO

GRANT EXEC ON TcssRecipientContactInformationDelete TO PUBLIC
GO
