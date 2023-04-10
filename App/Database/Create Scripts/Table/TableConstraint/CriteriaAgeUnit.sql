
		/******************************************************************************
		**	File: CriteriaAgeUnit(Constraint).sql 
		**	Name: CriteriaAgeUnit
		**	Desc: Creates the table CriteriaAgeUnit
		**	Auth: ccarroll
		**	Date: 12/16/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	12/16/2009		ccarroll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table CriteriaAgeUnit'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_CriteriaAgeUnit')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_CriteriaAgeUnit'
			ALTER TABLE dbo.CriteriaAgeUnit ADD CONSTRAINT PK_CriteriaAgeUnit PRIMARY KEY Clustered (CriteriaAgeUnitId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_CriteriaAgeUnit_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_CriteriaAgeUnit_LastModified'
			ALTER TABLE dbo.CriteriaAgeUnit ADD CONSTRAINT DF_CriteriaAgeUnit_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE CriteriaAgeUnit SET (LOCK_ESCALATION = TABLE)
		END

