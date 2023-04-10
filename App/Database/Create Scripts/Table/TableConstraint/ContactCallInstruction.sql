
		/******************************************************************************
		**	File: ContactCallInstruction(Constraint).sql 
		**	Name: ContactCallInstruction
		**	Desc: Creates the table ContactCallInstruction
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	10/6/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table ContactCallInstruction'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_ContactCallInstruction')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_ContactCallInstruction'
			ALTER TABLE dbo.ContactCallInstruction ADD CONSTRAINT PK_ContactCallInstruction PRIMARY KEY Clustered (ContactCallInstructionId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_ContactCallInstruction_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_ContactCallInstruction_LastModified'
			ALTER TABLE dbo.ContactCallInstruction ADD CONSTRAINT DF_ContactCallInstruction_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE ContactCallInstruction SET (LOCK_ESCALATION = TABLE)
		END

