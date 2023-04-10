IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientContactInformationInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientContactInformationInsert'
		DROP Procedure TcssRecipientContactInformationInsert
	END
GO

PRINT 'Creating Procedure TcssRecipientContactInformationInsert'
GO

CREATE PROCEDURE dbo.TcssRecipientContactInformationInsert
(
	@TcssRecipientContactInformationId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssRecipientId int = null,
	@OpoContact varchar(50) = null,
	@TransplantSurgeonContact varchar(50) = null,
	@ClinicalCoordinator varchar(50) = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientContactInformationInsert
**	Desc: Insert Data into table TcssRecipientContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

INSERT INTO dbo.TcssRecipientContactInformation
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssRecipientId,
	OpoContact,
	TransplantSurgeonContact,
	ClinicalCoordinator
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssRecipientId,
	@OpoContact,
	@TransplantSurgeonContact,
	@ClinicalCoordinator
)

-- Return the new identity value
SET @TcssRecipientContactInformationId = @@Identity

GO

GRANT EXEC ON TcssRecipientContactInformationInsert TO PUBLIC
GO
