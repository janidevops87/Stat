IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientOfferInformationInsert')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientOfferInformationInsert'
		DROP Procedure TcssRecipientOfferInformationInsert
	END
GO

PRINT 'Creating Procedure TcssRecipientOfferInformationInsert'
GO

CREATE PROCEDURE dbo.TcssRecipientOfferInformationInsert
(
	@TcssRecipientOfferInformationId int output,
	@LastUpdateStatEmployeeId int,
	@LastUpdateDate datetime = null,
	@TcssRecipientId int,
	@CallId int,
	@StatEmployeeId int = null,
	@TcssListCallTypeId int = null,
	@ImportOfferNumber varchar(50) = null,
	@ClientId int = null,
	@ClientName varchar(80),
	@ReferralNumber int = null,
	@MatchId varchar(50) = null,
	@TcssListOrganTypeId int = null,
	@IsMultiOrganLiver bit = null,
	@IsMultiOrganKidney bit = null,
	@IsMultiOrganHeart bit = null,
	@IsMultiOrganLung bit = null,
	@IsMultiOrganIntestine bit = null,
	@IsMultiOrganPancreas bit = null,
	@IsMultiOrganOther bit = null,
	@TcssListKidneyTypeId int = null,
	@TcssListLiverTypeId int = null,
	@TcssListLungTypeId int = null,
	@OtherOtherOrganDetailOrgan varchar(100) = null,
	@TcssListStatusOfImportDataId int = null,
	@StatusSetByStatEmployeeId int = null,
	@StatusSetByStatEmployeeName varchar(100) = null,
	@StatusSetDateTime datetime = null,
	@TcssListCloseReason1Id int = null,
	@CloseByStatEmployee1Id int,
	@CloseByStatEmployee1Name varchar(100) = null,
	@CloseDate1 datetime = null,
	@TcssListCloseReason2Id int = null,
	@CloseByStatEmployee2Id int,
	@CloseByStatEmployee2Name varchar(100) = null,
	@CloseDate2 datetime = null,
	@CloseByStatEmployee1UserName varchar(100) = null
)
AS
/***************************************************************************************************
**	Name: TcssRecipientOfferInformationInsert
**	Desc: Insert Data into table TcssRecipientOfferInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
**  04/5/2011   jth				removed default alert and greeting
***************************************************************************************************/

INSERT INTO dbo.TcssRecipientOfferInformation
(
	LastUpdateStatEmployeeId,
	LastUpdateDate,
	TcssRecipientId,
	CallId,
	StatEmployeeId,
	TcssListCallTypeId,
	ImportOfferNumber,
	ClientId,
	ReferralNumber,
	MatchId,
	TcssListOrganTypeId,
	IsMultiOrganLiver,
	IsMultiOrganKidney,
	IsMultiOrganHeart,
	IsMultiOrganLung,
	IsMultiOrganIntestine,
	IsMultiOrganPancreas,
	IsMultiOrganOther,
	TcssListKidneyTypeId,
	TcssListLiverTypeId,
	TcssListLungTypeId,
	OtherOtherOrganDetailOrgan,
	TcssListStatusOfImportDataId,
	StatusSetByStatEmployeeId,
	StatusSetDateTime,
	TcssListCloseReason1Id,
	CloseByStatEmployee1Id,
	CloseDate1,
	TcssListCloseReason2Id,
	CloseByStatEmployee2Id,
	CloseDate2
)
VALUES
(
	@LastUpdateStatEmployeeId,
	IsNull(@LastUpdateDate, GetUtcDate()),
	@TcssRecipientId,
	@CallId,
	@StatEmployeeId,
	@TcssListCallTypeId,
	@ImportOfferNumber,
	@ClientId,
	@ReferralNumber,
	@MatchId,
	@TcssListOrganTypeId,
	IsNull(@IsMultiOrganLiver, 0),
	IsNull(@IsMultiOrganKidney, 0),
	IsNull(@IsMultiOrganHeart, 0),
	IsNull(@IsMultiOrganLung, 0),
	IsNull(@IsMultiOrganIntestine, 0),
	IsNull(@IsMultiOrganPancreas, 0),
	IsNull(@IsMultiOrganOther, 0),
	@TcssListKidneyTypeId,
	@TcssListLiverTypeId,
	@TcssListLungTypeId,
	@OtherOtherOrganDetailOrgan,
	@TcssListStatusOfImportDataId,
	@StatusSetByStatEmployeeId,
	@StatusSetDateTime,
	@TcssListCloseReason1Id,
	@CloseByStatEmployee1Id,
	IsNull(@CloseDate1, GetUtcDate()),
	@TcssListCloseReason2Id,
	@CloseByStatEmployee2Id,
	IsNull(@CloseDate2, GetUtcDate())
)

-- Return the new identity value
SET @TcssRecipientOfferInformationId = @@Identity

GO

GRANT EXEC ON TcssRecipientOfferInformationInsert TO PUBLIC
GO
