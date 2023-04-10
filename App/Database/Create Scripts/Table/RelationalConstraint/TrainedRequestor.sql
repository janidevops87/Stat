
		/******************************************************************************
		**	File: TrainedRequestor(Relation).sql
		**	Name: AlterTrainedRequestor
		**	Desc: Creates all the Foreign Key Relationships for the table TrainedRequestor
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:		Author:			Description:
		**	--------	--------		----------------------------------
		**  07/14/10	Bret Knoll		Adding to release 
		*******************************************************************************/		
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TrainedRequestor_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_TrainedRequestor_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.TrainedRequestor
			ADD CONSTRAINT FK_TrainedRequestor_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	GO

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TrainedRequestor_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_TrainedRequestor_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.TrainedRequestor
			ADD CONSTRAINT FK_TrainedRequestor_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE TrainedRequestor SET (LOCK_ESCALATION = TABLE)
		END
