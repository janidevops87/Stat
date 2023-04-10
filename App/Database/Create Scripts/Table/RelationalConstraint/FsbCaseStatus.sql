/***************************************************************************************************
**	Name: FsbCaseStatus
**	Desc: Add Foreign keys to FsbCaseStatus
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Tanvir Ather	Initial Key Creation 
**	7/13/2010	Bret Knoll		Resaving to readd Person Relation
**  2/7/11      jth             comment out call id constraint, since recycle program doesn't delete it
***************************************************************************************************/

--IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_FsbCaseStatus_CallId_Call_CallId')
--	BEGIN
--		PRINT 'Adding Foreign Key FK_FsbCaseStatus_CallId_Call_CallId'
--		ALTER TABLE dbo.FsbCaseStatus ADD CONSTRAINT FK_FsbCaseStatus_CallId_Call_CallId
--			FOREIGN KEY(CallId) REFERENCES dbo.Call(CallId) 
--	END
--GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_FsbCaseStatus_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_FsbCaseStatus_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.FsbCaseStatus ADD CONSTRAINT FK_FsbCaseStatus_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_FsbCaseStatus_FamilyServicesCoordinatorId_Person_PersonId')
	BEGIN
		PRINT 'Adding Foreign Key FK_FsbCaseStatus_FamilyServicesCoordinatorId_Person_PersonId'
		ALTER TABLE dbo.FsbCaseStatus ADD CONSTRAINT FK_FsbCaseStatus_FamilyServicesCoordinatorId_Person_PersonId
			FOREIGN KEY(FamilyServicesCoordinatorId) REFERENCES dbo.Person(PersonId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_FsbCaseStatus_ListFsbStatusId_ListFsbStatus_ListFsbStatusId')
	BEGIN
		PRINT 'Adding Foreign Key FK_FsbCaseStatus_ListFsbStatusId_ListFsbStatus_ListFsbStatusId'
		ALTER TABLE dbo.FsbCaseStatus ADD CONSTRAINT FK_FsbCaseStatus_ListFsbStatusId_ListFsbStatus_ListFsbStatusId
			FOREIGN KEY(ListFsbStatusId) REFERENCES dbo.ListFsbStatus(ListFsbStatusId) 
	END
GO
