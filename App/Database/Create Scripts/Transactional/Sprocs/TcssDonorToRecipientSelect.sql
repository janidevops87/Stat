IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssDonorToRecipientSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssDonorToRecipientSelect'
		DROP Procedure TcssDonorToRecipientSelect
	END
GO

PRINT 'Creating Procedure TcssDonorToRecipientSelect'
GO

CREATE PROCEDURE dbo.TcssDonorToRecipientSelect
(
	@TcssDonorId int,
	@TcssRecipientId int
)
AS
/***************************************************************************************************
**	Name: TcssDonorToRecipientSelect
**	Desc: Update Data in table TcssDonorToRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/01/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	tdr.TcssDonorToRecipientId,
	tdr.LastUpdateStatEmployeeId,
	tdr.LastUpdateDate,
	tdr.TcssDonorId,
	tdr.TcssRecipientId,
	troi.CallId,
	Client.OrganizationName AS ClientName,
	TcssListOrganType.FieldValue AS TcssListOrganType
FROM TcssDonorToRecipient tdr
	INNER JOIN TcssRecipientOfferInformation troi ON troi.TcssRecipientId = tdr.TcssRecipientId
	LEFT JOIN TcssListOrganType ON troi.TcssListOrganTypeId = TcssListOrganType.TcssListOrganTypeId
	LEFT JOIN dbo.Organization Client ON troi.ClientId = Client.OrganizationId
WHERE
	tdr.TcssDonorId = @TcssDonorId
--	AND tdr.TcssRecipientId != @TcssRecipientId
GO

GRANT EXEC ON TcssDonorToRecipientSelect TO PUBLIC
GO
