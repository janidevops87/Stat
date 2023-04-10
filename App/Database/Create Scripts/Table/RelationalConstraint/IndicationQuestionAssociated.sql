 
		/******************************************************************************
		**	File: IndicationQuestionAssociated(Relation).sql
		**	Name: IndicationQuestionAssociated
		**	Desc: Creates  Foreign Key Relationships for the table IndicationQuestionAssociated
		**	Auth: ccarroll
		**	Date: 12/03/2009
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
	/*
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_IndicationQuestionAssociated_QuestionID_Question_QuestionID')
	BEGIN
		PRINT 'Adding Foreign Key FK_IndicationQuestionAssociated_QuestionID_Question_QuestionID'
		ALTER TABLE dbo.IndicationQuestionAssociated
			ADD CONSTRAINT FK_IndicationQuestionAssociated_QuestionID_Question_QuestionID FOREIGN KEY(QuestionID) REFERENCES dbo.Question(QuestionID)
	END
	

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_IndicationQuestionAssociated_ChildQuestionID_Question_QuestionID')
	BEGIN
		PRINT 'Adding Foreign Key FK_IndicationQuestionAssociated_ChildQuestionID_Question_QuestionID'
		ALTER TABLE dbo.IndicationQuestionAssociated
			ADD CONSTRAINT FK_IndicationQuestionAssociated_ChildQuestionID_Question_QuestionID FOREIGN KEY(ChildQuestionID) REFERENCES dbo.Question(QuestionID)
	END
	

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_IndicationQuestionAssociated_LastStatEmployeeID_StatEmployee_StatEmployeeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_IndicationQuestionAssociated_LastStatEmployeeID_StatEmployee_StatEmployeeID'
		ALTER TABLE dbo.IndicationQuestionAssociated
			ADD CONSTRAINT FK_IndicationQuestionAssociated_LastStatEmployeeID_StatEmployee_StatEmployeeID FOREIGN KEY(LastStatEmployeeID) REFERENCES dbo.StatEmployee(StatEmployeeID)
	END
	

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_IndicationQuestionAssociated_AuditLogTypeID_AuditLogType_AuditLogTypeID')
	BEGIN
		PRINT 'Adding Foreign Key FK_IndicationQuestionAssociated_AuditLogTypeID_AuditLogType_AuditLogTypeID'
		ALTER TABLE dbo.IndicationQuestionAssociated
			ADD CONSTRAINT FK_IndicationQuestionAssociated_AuditLogTypeID_AuditLogType_AuditLogTypeID FOREIGN KEY(AuditLogTypeID) REFERENCES dbo.AuditLogType(AuditLogTypeID)
	END
	

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE IndicationQuestionAssociated SET (LOCK_ESCALATION = TABLE)
		END
	*/