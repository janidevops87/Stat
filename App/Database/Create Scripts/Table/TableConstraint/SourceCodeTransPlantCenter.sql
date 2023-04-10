
		/******************************************************************************
		**	File: SourceCodeTransplantCenter(Constraint).sql 
		**	Name: SourceCodeTransplantCenter
		**	Desc: Creates the table SourceCodeTransplantCenter
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
		PRINT 'Add Primary Keys, Indexes and Defaults for Table SourceCodeTransplantCenter'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_SourceCodeTransplantCenter')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_SourceCodeTransplantCenter'
			ALTER TABLE dbo.SourceCodeTransplantCenter ADD CONSTRAINT PK_SourceCodeTransplantCenter PRIMARY KEY Clustered (SourceCodeTransplantCenterId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_SourceCodeTransplantCenter_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_SourceCodeTransplantCenter_LastModified'
			ALTER TABLE dbo.SourceCodeTransplantCenter ADD CONSTRAINT DF_SourceCodeTransplantCenter_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SourceCodeTransplantCenter SET (LOCK_ESCALATION = TABLE)
		END

