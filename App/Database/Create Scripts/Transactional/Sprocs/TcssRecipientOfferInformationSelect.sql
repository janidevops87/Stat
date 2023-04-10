IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientOfferInformationSelect')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientOfferInformationSelect'
		DROP Procedure TcssRecipientOfferInformationSelect
	END
GO

PRINT 'Creating Procedure TcssRecipientOfferInformationSelect'
GO

CREATE PROCEDURE dbo.TcssRecipientOfferInformationSelect
(
	@TcssRecipientId int
)
AS
/***************************************************************************************************
**	Name: TcssRecipientOfferInformationSelect
**	Desc: Update Data in table TcssRecipientOfferInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
**  04/5/2011   jth				removed default alert and greeting
**  05/31/2011  jth				added user name from first closer
***************************************************************************************************/
SET NOCOUNT ON;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
SELECT 
	troi.TcssRecipientOfferInformationId,
	troi.LastUpdateStatEmployeeId,
	troi.LastUpdateDate,
	troi.TcssRecipientId,
	troi.CallId,
	troi.StatEmployeeId,
	troi.TcssListCallTypeId,
	troi.ImportOfferNumber,
	troi.ClientId,
	Client.OrganizationName AS ClientName,
	troi.ReferralNumber,
	troi.MatchId,
	troi.TcssListOrganTypeId,
	troi.IsMultiOrganLiver,
	troi.IsMultiOrganKidney,
	troi.IsMultiOrganHeart,
	troi.IsMultiOrganLung,
	troi.IsMultiOrganIntestine,
	troi.IsMultiOrganPancreas,
	troi.IsMultiOrganOther,
	troi.TcssListKidneyTypeId,
	troi.TcssListLiverTypeId,
	troi.TcssListLungTypeId,
	troi.OtherOtherOrganDetailOrgan,
	troi.TcssListStatusOfImportDataId,
	troi.StatusSetByStatEmployeeId,
	StatusSetByStatEmployee.StatEmployeeUserID AS StatusSetByStatEmployeeName,
	troi.StatusSetDateTime,
	troi.TcssListCloseReason1Id,
	troi.CloseByStatEmployee1Id,
	IsNull(CloseByStatEmployee1.StatEmployeeFirstName + ' ', '') + IsNull(CloseByStatEmployee1.StatEmployeeLastName, '') AS CloseByStatEmployee1Name,
	troi.CloseDate1,
	troi.TcssListCloseReason2Id,
	IsNull(CloseByStatEmployee2.StatEmployeeFirstName + ' ', '') + IsNull(CloseByStatEmployee2.StatEmployeeLastName, '') AS CloseByStatEmployee2Name,
	troi.CloseByStatEmployee2Id,
	troi.CloseDate2,
	CloseByStatEmployee1.StatEmployeeUserID as CloseByStatEmployee1UserName
FROM dbo.TcssRecipientOfferInformation troi
	LEFT JOIN dbo.StatEmployee StatusSetByStatEmployee ON troi.StatusSetByStatEmployeeId = StatusSetByStatEmployee.StatEmployeeId
	LEFT JOIN dbo.StatEmployee CloseByStatEmployee1 ON troi.CloseByStatEmployee1Id = CloseByStatEmployee1.StatEmployeeId
	LEFT JOIN dbo.StatEmployee CloseByStatEmployee2 ON troi.CloseByStatEmployee2Id = CloseByStatEmployee2.StatEmployeeId
	LEFT JOIN dbo.Organization Client ON troi.ClientId = Client.OrganizationId
WHERE
	troi.TcssRecipientId = @TcssRecipientId
GO

GRANT EXEC ON TcssRecipientOfferInformationSelect TO PUBLIC
GO
