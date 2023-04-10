
		/******************************************************************************
		**	File: SourceCode(Constraint).sql 
		**	Name: SourceCode
		**	Desc: Creates the table SourceCode
		**	Auth: ccarroll
		**	Date: 10/23/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	10/23/2009		ccarroll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table SourceCode'
/*
		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_SourceCode')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_SourceCode'
			ALTER TABLE dbo.SourceCode ADD CONSTRAINT PK_SourceCode PRIMARY KEY Clustered (SourceCodeId) 
		END
*/
		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_SourceCode_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_SourceCode_LastModified'
			ALTER TABLE dbo.SourceCode ADD CONSTRAINT DF_SourceCode_LastModified DEFAULT(GetDate()) FOR LastModified
		END
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SourceCode SET (LOCK_ESCALATION = TABLE)
		END

