IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientContactInformationSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientContactInformationSelect'
		DROP Procedure TcssRecipientContactInformationSelect
	END
GO

PRINT 'Creating Procedure TcssRecipientContactInformationSelect'
GO

CREATE PROCEDURE dbo.TcssRecipientContactInformationSelect
(
	@TcssRecipientId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientContactInformationSelect
**	Desc: Update Data in table TcssRecipientContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	trci.TcssRecipientContactInformationId,
	trci.LastUpdateStatEmployeeId,
	trci.LastUpdateDate,
	trci.TcssRecipientId,
	trci.OpoContact,
	trci.TransplantSurgeonContact,
	trci.ClinicalCoordinator
FROM dbo.TcssRecipientContactInformation trci
WHERE
	trci.TcssRecipientId = @TcssRecipientId

GO

GRANT EXEC ON TcssRecipientContactInformationSelect TO PUBLIC
GO
