IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientContactInformationUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientContactInformationUpdate'
		DROP Procedure TcssRecipientContactInformationUpdate
	END
GO

PRINT 'Creating Procedure TcssRecipientContactInformationUpdate'
GO

CREATE PROCEDURE dbo.TcssRecipientContactInformationUpdate
(
	@TcssRecipientContactInformationId int,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssRecipientId int = null,
	@OpoContact varchar(50) = null,
	@TransplantSurgeonContact varchar(50) = null,
	@ClinicalCoordinator varchar(50) = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientContactInformationUpdate
**	Desc: Update Data in table TcssRecipientContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

UPDATE dbo.TcssRecipientContactInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssRecipientId = @TcssRecipientId,
	OpoContact = @OpoContact,
	TransplantSurgeonContact = @TransplantSurgeonContact,
	ClinicalCoordinator = @ClinicalCoordinator
WHERE
	TcssRecipientContactInformationId = @TcssRecipientContactInformationId
GO

GRANT EXEC ON TcssRecipientContactInformationUpdate TO PUBLIC
GO
