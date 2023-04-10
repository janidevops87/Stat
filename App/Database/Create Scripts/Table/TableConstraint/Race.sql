
		/******************************************************************************
		**	File: Race(Constraint).sql 
		**	Name: Race
		**	Desc: Creates the table Race
		**	Auth: Bret Knoll
		**	Date: 9/14/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	9/14/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table Race'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Race')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_Race'
			ALTER TABLE dbo.Race ADD CONSTRAINT PK_Race PRIMARY KEY Clustered (RaceId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Race_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_Race_LastModified'
			ALTER TABLE dbo.Race ADD CONSTRAINT DF_Race_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Race SET (LOCK_ESCALATION = TABLE)
		END

