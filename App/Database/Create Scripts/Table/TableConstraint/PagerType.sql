
		/******************************************************************************
		**	File: PagerType(Constraint).sql 
		**	Name: PagerType
		**	Desc: Creates the table PagerType
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
		PRINT 'Add Primary Keys, Indexes and Defaults for Table PagerType'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_PagerType')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_PagerType'
			ALTER TABLE dbo.PagerType ADD CONSTRAINT PK_PagerType PRIMARY KEY Clustered (PagerTypeId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_PagerType_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_PagerType_LastModified'
			ALTER TABLE dbo.PagerType ADD CONSTRAINT DF_PagerType_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE PagerType SET (LOCK_ESCALATION = TABLE)
		END

