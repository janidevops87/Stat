IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientOfferInformationDelete')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientOfferInformationDelete'
		DROP Procedure TcssRecipientOfferInformationDelete
	END
GO

PRINT 'Creating Procedure TcssRecipientOfferInformationDelete'
GO

CREATE PROCEDURE dbo.TcssRecipientOfferInformationDelete
(
	@TcssRecipientOfferInformationId int,
	@LastUpdateStatEmployeeId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientOfferInformationDelete
**	Desc: Delete Data from table TcssRecipientOfferInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

-- Flag the User and time the record is being delete
UPDATE dbo.TcssRecipientOfferInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = GetUtcDate()
WHERE TcssRecipientOfferInformationId = @TcssRecipientOfferInformationId

-- Delete The Record
DELETE FROM dbo.TcssRecipientOfferInformation
WHERE TcssRecipientOfferInformationId = @TcssRecipientOfferInformationId
GO

GRANT EXEC ON TcssRecipientOfferInformationDelete TO PUBLIC
GO
