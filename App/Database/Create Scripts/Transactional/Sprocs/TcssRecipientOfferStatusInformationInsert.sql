IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientOfferStatusInformationInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientOfferStatusInformationInsert'
		DROP Procedure TcssRecipientOfferStatusInformationInsert
	END
GO

PRINT 'Creating Procedure TcssRecipientOfferStatusInformationInsert'
GO

CREATE PROCEDURE dbo.TcssRecipientOfferStatusInformationInsert
(
	@TcssRecipientOfferStatusInformationId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateStatEmployeeName varchar(100),
	@LastUpdateDate datetime = null,
	@TcssRecipientId int,
	@CoordinatorId int = null,
	@CoordinatorName varchar(100),
	@TcssListStatusId int = null,
	@Comment varchar(200) = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientOfferStatusInformationInsert
**	Desc: Insert Data into table TcssRecipientOfferStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssRecipientOfferStatusInformation
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssRecipientId,
	CoordinatorId,
	TcssListStatusId,
	Comment
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssRecipientId,
	@CoordinatorId,
	@TcssListStatusId,
	@Comment
)

-- Return the new identity value
SET @TcssRecipientOfferStatusInformationId = @@Identity

GO

GRANT EXEC ON TcssRecipientOfferStatusInformationInsert TO PUBLIC
GO
