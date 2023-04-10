IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'TcssRecipientOfferInformationUpdate')
	BEGIN
		PRINT 'Dropping Procedure TcssRecipientOfferInformationUpdate'
		DROP Procedure TcssRecipientOfferInformationUpdate
	END
GO

PRINT 'Creating Procedure TcssRecipientOfferInformationUpdate'
GO

CREATE PROCEDURE dbo.TcssRecipientOfferInformationUpdate
(
	@TcssRecipientOfferInformationId int,
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
**	Name: TcssRecipientOfferInformationUpdate
**	Desc: Update Data in table TcssRecipientOfferInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Sproc Creation 
**  04/5/2011	jth				removed greeting and default alert parms	
**  05/31/2011  jth             added CloseByStatEmployee1UserName
***************************************************************************************************/

UPDATE dbo.TcssRecipientOfferInformation
SET
	LastUpdateStatEmployeeId = @LastUpdateStatEmployeeId,
	LastUpdateDate = IsNull(@LastUpdateDate, GetUtcDate()),
	TcssRecipientId = @TcssRecipientId,
	CallId = @CallId,
	StatEmployeeId = @StatEmployeeId,
	TcssListCallTypeId = @TcssListCallTypeId,
	ImportOfferNumber = @ImportOfferNumber,
	ClientId = @ClientId,
	ReferralNumber = @ReferralNumber,
	MatchId = @MatchId,
	TcssListOrganTypeId = @TcssListOrganTypeId,
	IsMultiOrganLiver = @IsMultiOrganLiver,
	IsMultiOrganKidney = @IsMultiOrganKidney,
	IsMultiOrganHeart = @IsMultiOrganHeart,
	IsMultiOrganLung = @IsMultiOrganLung,
	IsMultiOrganIntestine = @IsMultiOrganIntestine,
	IsMultiOrganPancreas = @IsMultiOrganPancreas,
	IsMultiOrganOther = @IsMultiOrganOther,
	TcssListKidneyTypeId = @TcssListKidneyTypeId,
	TcssListLiverTypeId = @TcssListLiverTypeId,
	TcssListLungTypeId = @TcssListLungTypeId,
	OtherOtherOrganDetailOrgan = @OtherOtherOrganDetailOrgan,
	TcssListStatusOfImportDataId = @TcssListStatusOfImportDataId,
	StatusSetByStatEmployeeId = @StatusSetByStatEmployeeId,
	StatusSetDateTime = @StatusSetDateTime,
	TcssListCloseReason1Id = @TcssListCloseReason1Id,
	CloseByStatEmployee1Id = @CloseByStatEmployee1Id,
	CloseDate1 = IsNull(@CloseDate1, GetUtcDate()),
	TcssListCloseReason2Id = @TcssListCloseReason2Id,
	CloseByStatEmployee2Id = @CloseByStatEmployee2Id,
	CloseDate2 = IsNull(@CloseDate2, GetUtcDate())
WHERE
	TcssRecipientOfferInformationId = @TcssRecipientOfferInformationId
GO

GRANT EXEC ON TcssRecipientOfferInformationUpdate TO PUBLIC
GO
