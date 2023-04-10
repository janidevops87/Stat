IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientOfferStatusInformationDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientOfferStatusInformationDelete'
		DROP Procedure TcssRecipientOfferStatusInformationDelete
	END
GO

PRINT 'Creating Procedure TcssRecipientOfferStatusInformationDelete'
GO

CREATE PROCEDURE dbo.TcssRecipientOfferStatusInformationDelete
(
	@TcssRecipientOfferStatusInformationId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientOfferStatusInformationDelete
**	Desc: Delete Data from table TcssRecipientOfferStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssRecipientOfferStatusInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssRecipientOfferStatusInformationId = @TcssRecipientOfferStatusInformationId

-- Delete The Record
DELETE FROM dbo.TcssRecipientOfferStatusInformation
WHERE TcssRecipientOfferStatusInformationId = @TcssRecipientOfferStatusInformationId
GO

GRANT EXEC ON TcssRecipientOfferStatusInformationDelete TO PUBLIC
GO
