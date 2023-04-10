/***************************************************************************************************
**	Name: TcssRecipientOfferInformation
**	Desc: Creates new table TcssRecipientOfferInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssRecipientOfferInformation')
BEGIN
	-- DROP TABLE dbo.TcssRecipientOfferInformation
	PRINT 'Creating table TcssRecipientOfferInformation'
	CREATE TABLE dbo.TcssRecipientOfferInformation
	(
		TcssRecipientOfferInformationId int NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssRecipientId int NULL,
		CallId int NULL,
		StatEmployeeId int NULL,
		SourceCodeId int NULL,
		TcssListCallTypeId int NULL,
		ImportOfferNumber varchar(50) NULL,
		ClientId int NULL,
		ReferralNumber int NULL,
		MatchId varchar(50) NULL,
		TcssListOrganTypeId int NULL,
		IsMultiOrganLiver int NULL,
		IsMultiOrganKidney int NULL,
		IsMultiOrganHeart int NULL,
		IsMultiOrganLung int NULL,
		IsMultiOrganIntestine int NULL,
		IsMultiOrganPancreas int NULL,
		IsMultiOrganOther int NULL,
		TcssListKidneyTypeId int NULL,
		TcssListLiverTypeId int NULL,
		TcssListLungTypeId int NULL,
		OtherOtherOrganDetailOrgan varchar(100) NULL,
		TcssListStatusOfImportDataId int NULL,
		TcssListOfferStatusId int NULL,
		TcssListRefusalReasonId int NULL,
		Comment varchar(50) NULL,
		TcssListCloseReason1Id int NULL,
		CloseByStatEmployee1Id int NULL,
		CloseDate1 datetime NULL,
		TcssListCloseReason2Id int NULL,
		CloseByStatEmployee2Id int NULL,
		CloseDate2 datetime NULL
	)
END
GO


-- Drop column SourceCodeId since 
IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssRecipientOfferInformation') AND name = 'SourceCodeId')
BEGIN
	ALTER TABLE dbo.TcssRecipientOfferInformation DROP COLUMN SourceCodeId
END
GO

-- Drop column SourceCodeId since 
IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssRecipientOfferInformation') AND name = 'TcssListOfferStatusId')
BEGIN
	
	IF EXISTS(SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListOfferStatusId_TcssListOfferStatus_TcssListOfferStatusId')
	BEGIN
		ALTER TABLE dbo.TcssRecipientOfferInformation
			DROP CONSTRAINT FK_TcssRecipientOfferInformation_TcssListOfferStatusId_TcssListOfferStatus_TcssListOfferStatusId
			
		ALTER TABLE dbo.TcssListOfferStatus SET (LOCK_ESCALATION = TABLE)			
	END
		

	
	ALTER TABLE dbo.TcssRecipientOfferInformation DROP COLUMN TcssListOfferStatusId
END
GO

IF EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssRecipientOfferInformation') AND name = 'TcssListRefusalReasonId')
BEGIN
	ALTER TABLE TcssRecipientOfferInformation ALTER COLUMN Comment datetime
	EXECUTE sp_rename N'dbo.TcssRecipientOfferInformation.TcssListRefusalReasonId', N'StatusSetByStatEmployeeId', 'COLUMN' 
	EXECUTE sp_rename N'dbo.TcssRecipientOfferInformation.Comment', N'StatusSetDateTime', 'COLUMN' 
END
GO



GRANT SELECT ON TcssRecipientOfferInformation TO PUBLIC
GO
