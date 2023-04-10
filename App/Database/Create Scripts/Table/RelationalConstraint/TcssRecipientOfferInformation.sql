/***************************************************************************************************
**	Name: TcssRecipientOfferInformation
**	Desc: Add Foreign keys to TcssRecipientOfferInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
**	7/13/2010	Bret Knoll		Resaving to readd Person Relation
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssRecipientId_TcssRecipient_TcssRecipientId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssRecipientId_TcssRecipient_TcssRecipientId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssRecipientId_TcssRecipient_TcssRecipientId
			FOREIGN KEY(TcssRecipientId) REFERENCES dbo.TcssRecipient(TcssRecipientId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_CallId_Call_CallId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_CallId_Call_CallId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_CallId_Call_CallId
			FOREIGN KEY(CallId) REFERENCES dbo.Call(CallId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListCallTypeId_TcssListCallType_TcssListCallTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssListCallTypeId_TcssListCallType_TcssListCallTypeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssListCallTypeId_TcssListCallType_TcssListCallTypeId
			FOREIGN KEY(TcssListCallTypeId) REFERENCES dbo.TcssListCallType(TcssListCallTypeId) 
	END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_ClientId_Organization_OrganizationId')
	BEGIN
		UPDATE TcssRecipientOfferInformation SET ClientId = NULL WHERE ClientId = 0 -- Set the 0 to null

		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_ClientId_Organization_OrganizationId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_ClientId_Organization_OrganizationId
			FOREIGN KEY(ClientId) REFERENCES dbo.Organization(OrganizationId) 
	END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListOrganTypeId_TcssListOrganType_TcssListOrganTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssListOrganTypeId_TcssListOrganType_TcssListOrganTypeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssListOrganTypeId_TcssListOrganType_TcssListOrganTypeId
			FOREIGN KEY(TcssListOrganTypeId) REFERENCES dbo.TcssListOrganType(TcssListOrganTypeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListKidneyTypeId_TcssListKidneyType_TcssListKidneyTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssListKidneyTypeId_TcssListKidneyType_TcssListKidneyTypeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssListKidneyTypeId_TcssListKidneyType_TcssListKidneyTypeId
			FOREIGN KEY(TcssListKidneyTypeId) REFERENCES dbo.TcssListKidneyType(TcssListKidneyTypeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListLiverTypeId_TcssListLiverType_TcssListLiverTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssListLiverTypeId_TcssListLiverType_TcssListLiverTypeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssListLiverTypeId_TcssListLiverType_TcssListLiverTypeId
			FOREIGN KEY(TcssListLiverTypeId) REFERENCES dbo.TcssListLiverType(TcssListLiverTypeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListLungTypeId_TcssListLungType_TcssListLungTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssListLungTypeId_TcssListLungType_TcssListLungTypeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssListLungTypeId_TcssListLungType_TcssListLungTypeId
			FOREIGN KEY(TcssListLungTypeId) REFERENCES dbo.TcssListLungType(TcssListLungTypeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_TcssListStatusOfImportData_TcssListStatusOfImportDataId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_TcssListStatusOfImportData_TcssListStatusOfImportDataId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssListStatusOfImportDataId_TcssListStatusOfImportData_TcssListStatusOfImportDataId
			FOREIGN KEY(TcssListStatusOfImportDataId) REFERENCES dbo.TcssListStatusOfImportData(TcssListStatusOfImportDataId) 
	END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListOfferStatusId_TcssListOfferStatus_TcssListOfferStatusId')
	BEGIN
		PRINT 'Dropping Foreign Key FK_TcssRecipientOfferInformation_TcssListOfferStatusId_TcssListOfferStatus_TcssListOfferStatusId'
		ALTER TABLE dbo.TcssRecipientOfferInformation DROP CONSTRAINT FK_TcssRecipientOfferInformation_TcssListOfferStatusId_TcssListOfferStatus_TcssListOfferStatusId
	END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId')
	BEGIN
		PRINT 'Dropping Foreign Key FK_TcssRecipientOfferInformation_TcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId'
		ALTER TABLE dbo.TcssRecipientOfferInformation DROP CONSTRAINT FK_TcssRecipientOfferInformation_TcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_StatusSetByStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_StatusSetByStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_StatusSetByStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(StatusSetByStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListCloseReason1Id_TcssListCloseReason_TcssListCloseReasonId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssListCloseReason1Id_TcssListCloseReason_TcssListCloseReasonId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssListCloseReason1Id_TcssListCloseReason_TcssListCloseReasonId
			FOREIGN KEY(TcssListCloseReason1Id) REFERENCES dbo.TcssListCloseReason(TcssListCloseReasonId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_CloseByStatEmployee1Id_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_CloseByStatEmployee1Id_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_CloseByStatEmployee1Id_StatEmployee_StatEmployeeId
			FOREIGN KEY(CloseByStatEmployee1Id) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_TcssListCloseReason2Id_TcssListCloseReason_TcssListCloseReasonId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_TcssListCloseReason2Id_TcssListCloseReason_TcssListCloseReasonId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_TcssListCloseReason2Id_TcssListCloseReason_TcssListCloseReasonId
			FOREIGN KEY(TcssListCloseReason2Id) REFERENCES dbo.TcssListCloseReason(TcssListCloseReasonId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferInformation_CloseByStatEmployee2Id_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferInformation_CloseByStatEmployee2Id_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT FK_TcssRecipientOfferInformation_CloseByStatEmployee2Id_StatEmployee_StatEmployeeId
			FOREIGN KEY(CloseByStatEmployee2Id) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
