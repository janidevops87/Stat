IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientOfferStatusInformationSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientOfferStatusInformationSelect'
		DROP Procedure TcssRecipientOfferStatusInformationSelect
	END
GO

PRINT 'Creating Procedure TcssRecipientOfferStatusInformationSelect'
GO

CREATE PROCEDURE dbo.TcssRecipientOfferStatusInformationSelect
(
	@TcssRecipientId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientOfferStatusInformationSelect
**	Desc: Update Data in table TcssRecipientOfferStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Sproc Creation 
***************************************************************************************************/

SELECT 
	trosi.TcssRecipientOfferStatusInformationId,
	trosi.LastUpdateStatEmployeeId,
	IsNull(LastUpdateStatEmployee.StatEmployeeFirstName + ' ', '') + isnull(LastUpdateStatEmployee.StatEmployeeLastName, '') AS LastUpdateStatEmployeeName,
	trosi.LastUpdateDate,
	trosi.TcssRecipientId,
	trosi.CoordinatorId,
	IsNull(Coordinator.StatEmployeeFirstName + ' ', '') + isnull(Coordinator.StatEmployeeLastName, '') AS CoordinatorName,
	trosi.TcssListStatusId,
	trosi.Comment
FROM dbo.TcssRecipientOfferStatusInformation trosi
	LEFT JOIN dbo.StatEmployee LastUpdateStatEmployee ON trosi.LastUpdateStatEmployeeId = LastUpdateStatEmployee.StatEmployeeId
	LEFT JOIN dbo.StatEmployee Coordinator ON trosi.CoordinatorId = Coordinator.StatEmployeeId
WHERE
	trosi.TcssRecipientId = @TcssRecipientId
ORDER BY trosi.LastUpdateDate DESC
GO

GRANT EXEC ON TcssRecipientOfferStatusInformationSelect TO PUBLIC
GO
