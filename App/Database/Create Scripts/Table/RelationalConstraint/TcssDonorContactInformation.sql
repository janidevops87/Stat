/***************************************************************************************************
**	Name: TcssDonorContactInformation
**	Desc: Add Foreign keys to TcssDonorContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
**	7/13/2010	Bret Knoll		Resaving to readd Person Relation
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorContactInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorContactInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorContactInformation ADD CONSTRAINT FK_TcssDonorContactInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorContactInformation_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorContactInformation_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorContactInformation ADD CONSTRAINT FK_TcssDonorContactInformation_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorContactInformation_TcssListTimeZoneId_TcssListTimeZone_TcssListTimeZoneId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorContactInformation_TcssListTimeZoneId_TcssListTimeZone_TcssListTimeZoneId'
		ALTER TABLE dbo.TcssDonorContactInformation ADD CONSTRAINT FK_TcssDonorContactInformation_TcssListTimeZoneId_TcssListTimeZone_TcssListTimeZoneId
			FOREIGN KEY(TcssListTimeZoneId) REFERENCES dbo.TcssListTimeZone(TcssListTimeZoneId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorContactInformation_TcssListDaylightSavingsObservedId_TcssListDaylightSavingsObserved_TcssListDaylightSavingsObserved')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorContactInformation_TcssListDaylightSavingsObservedId_TcssListDaylightSavingsObserved_TcssListDaylightSavingsObserved'
		ALTER TABLE dbo.TcssDonorContactInformation ADD CONSTRAINT FK_TcssDonorContactInformation_TcssListDaylightSavingsObservedId_TcssListDaylightSavingsObserved_TcssListDaylightSavingsObserved
			FOREIGN KEY(TcssListDaylightSavingsObservedId) REFERENCES dbo.TcssListDaylightSavingsObserved(TcssListDaylightSavingsObservedId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorContactInformation_TransplantSurgeonContactId_Person_PersonId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorContactInformation_TransplantSurgeonContactId_Person_PersonId'
		ALTER TABLE dbo.TcssDonorContactInformation ADD CONSTRAINT FK_TcssDonorContactInformation_TransplantSurgeonContactId_Person_PersonId
			FOREIGN KEY(TransplantSurgeonContactId) REFERENCES dbo.Person(PersonId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorContactInformation_ClinicalCoordinatorId_Person_PersonId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorContactInformation_ClinicalCoordinatorId_Person_PersonId'
		ALTER TABLE dbo.TcssDonorContactInformation ADD CONSTRAINT FK_TcssDonorContactInformation_ClinicalCoordinatorId_Person_PersonId
			FOREIGN KEY(ClinicalCoordinatorId) REFERENCES dbo.Person(PersonId) 
	END
GO
