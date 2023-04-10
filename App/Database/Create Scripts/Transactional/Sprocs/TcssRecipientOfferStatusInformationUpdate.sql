IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientOfferStatusInformationUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientOfferStatusInformationUpdate'
		DROP Procedure TcssRecipientOfferStatusInformationUpdate
	END
GO

PRINT 'Creating Procedure TcssRecipientOfferStatusInformationUpdate'
GO

CREATE PROCEDURE dbo.TcssRecipientOfferStatusInformationUpdate
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
**	Name: TcssRecipientOfferStatusInformationUpdate
**	Desc: Update Data in table TcssRecipientOfferStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssRecipientOfferStatusInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssRecipientId = @TcssRecipientId,
	CoordinatorId = @CoordinatorId,
	TcssListStatusId = @TcssListStatusId,
	Comment = @Comment
WHERE
	TcssRecipientOfferStatusInformationId = @TcssRecipientOfferStatusInformationId
GO

GRANT EXEC ON TcssRecipientOfferStatusInformationUpdate TO PUBLIC
GO
